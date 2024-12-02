import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'dart:async';
import 'dart:io';

import 'package:samvaad/screens/translation_screen.dart';

class TranslatorScreen extends StatefulWidget {
  const TranslatorScreen({super.key});

  @override
  _TranslatorScreenState createState() => _TranslatorScreenState();
}

class _TranslatorScreenState extends State<TranslatorScreen> {
  List<CameraDescription> cameras = [];
  CameraController? _controller;
  Future<void>? _initializeControllerFuture;
  bool _isCameraInitialized = false;
  bool _isImageCaptured = false;
  XFile? _image;
  int _selectedCameraIndex = 0; // Index of the currently selected camera

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    cameras = await availableCameras();
    if (cameras.isNotEmpty) {
      // Use the front camera if available; else fallback to back camera
      _selectedCameraIndex = cameras.indexWhere((camera) => camera.lensDirection == CameraLensDirection.front);
      if (_selectedCameraIndex == -1) {
        _selectedCameraIndex = 0; // Default to the back camera
      }
      _setupCamera();
    } else {
      print('No cameras available.');
    }
  }

  Future<void> _setupCamera() async {
    _controller = CameraController(cameras[_selectedCameraIndex], ResolutionPreset.high);
    _initializeControllerFuture = _controller?.initialize();
    _initializeControllerFuture?.then((_) {
      setState(() {
        _isCameraInitialized = true;
      });
    }).catchError((e) {
      print('Error initializing camera: $e');
    });
  }

  Future<void> _switchCamera() async {
    if (cameras.length > 1) {
      _selectedCameraIndex = (_selectedCameraIndex + 1) % cameras.length;
      await _setupCamera();
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  Future<void> _captureImage() async {
    if (_controller != null && _isCameraInitialized) {
      try {
        await _initializeControllerFuture;
        final image = await _controller!.takePicture();
        setState(() {
          _image = image;
          _isImageCaptured = true;
        });
      } catch (e) {
        print('Error capturing image: $e');
      }
    }
  }
Widget _buildCameraPreview() {
  if (!_isCameraInitialized) {
    return Center(child: CircularProgressIndicator());
  }
  if (_isImageCaptured && _image != null) {
    return Transform(
      alignment: Alignment.center,
      transform: _selectedCameraIndex == cameras.indexWhere((camera) => camera.lensDirection == CameraLensDirection.front)
          ? Matrix4.rotationY(3.14159) // Flip the captured image for the front camera
          : Matrix4.identity(),
      child: Image.file(
        File(_image!.path),
        fit: BoxFit.cover,
      ),
    );
  }

  return AspectRatio(
    aspectRatio: _controller!.value.aspectRatio, // Maintain camera aspect ratio
    child: Stack(
      children: [
        // Camera Preview with BoxFit.cover to fill the container and crop excess
        Positioned.fill(
          child: Transform(
            alignment: Alignment.center,
            transform: _selectedCameraIndex == cameras.indexWhere((camera) => camera.lensDirection == CameraLensDirection.front)
                ? Matrix4.rotationY(0) // Flip the preview for the front camera
                : Matrix4.identity(),
            child: CameraPreview(_controller!),
          ),
        ),
        // Rotate Button
        Positioned(
          top: 10,
          right: 10,
          child: GestureDetector(
            onTap: _switchCamera,
            child: Image.asset(
              'images/rotate.png',
              width: 40,
              height: 40,
            ),
          ),
        ),
      ],
    ),
  );
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/Home.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: ListView(
            padding: EdgeInsets.all(16.0),
            children: [
              Text(
                'Raise your hand!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                textAlign: TextAlign.left,
              ),
              SizedBox(height: 8),
              Text(
                'Orient yourself to the camera and keep to the outline.',
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.left,
              ),
              SizedBox(height: 16),
              Container(
                height: 500,
                margin: EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: _buildCameraPreview(),
                ),
              ),
              if (!_isImageCaptured)
                ElevatedButton(
                  onPressed: _captureImage,
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    backgroundColor: Color(0xFF64FCD9),
                  ),
                  child: Text(
                    'Click!',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              if (_isImageCaptured)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.35,
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _isImageCaptured = false;
                            _image = null;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 16.0),
                          backgroundColor: Color(0xFFFF8C82),
                        ),
                        child: Text(
                          'Retake',
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.55,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TranslationScreen(image: _image!),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 16.0),
                          backgroundColor: Color(0xFF64FCD9),
                        ),
                        child: Text(
                          'Submit',
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
