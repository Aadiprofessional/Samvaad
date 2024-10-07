import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'dart:async';

class TranslatorScreen extends StatefulWidget {
  @override
  _TranslatorScreenState createState() => _TranslatorScreenState();
}

class _TranslatorScreenState extends State<TranslatorScreen> {
  List<CameraDescription> cameras = [];
  CameraController? _controller;
  Future<void>? _initializeControllerFuture;
  bool _isCameraInitialized = false;
  bool _isImageCaptured = false;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    // Get available cameras
    cameras = await availableCameras();
    
    // Check if any cameras are available
    if (cameras.isNotEmpty) {
      _controller = CameraController(cameras[0], ResolutionPreset.high);
      _initializeControllerFuture = _controller?.initialize();

      // Check if the controller is initialized
      _initializeControllerFuture?.then((_) {
        setState(() {
          _isCameraInitialized = true;
        });
      }).catchError((e) {
        // Handle initialization error
        print('Error initializing camera: $e');
      });
    } else {
      // Handle the case when no camera is found
      print('No cameras available.');
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
        // Capture image logic would go here
        setState(() {
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

    return AspectRatio(
      aspectRatio: _controller!.value.aspectRatio,
      child: CameraPreview(_controller!),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/Home.png'), // Background image
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: ListView(
            padding: EdgeInsets.all(16.0),
            children: [
              // Main Text
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

              // Rounded Rectangle with Camera Preview (Increased height)
              Container(
                height: 500, // Increased height
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

              // Capture Button
              if (!_isImageCaptured)
                AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  child: ElevatedButton(
                    onPressed: _captureImage,
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      backgroundColor: Color(0xFF64FCD9), // Changed color to 64FCD9
                    ),
                    child: Text(
                      'Click!',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),

              // Show buttons after image capture
              if (_isImageCaptured)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      width: MediaQuery.of(context).size.width * 0.25, // 25% width
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _isImageCaptured = false; // Reset for retake
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 16.0),
                          backgroundColor: Color(0xFFFF8C82), // Color for Retake button
                        ),
                        child: Text(
                          'Retake',
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    SizedBox(width: 5), // Add space between buttons
                    AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      width: MediaQuery.of(context).size.width * 0.6, // 60% width
                      child: ElevatedButton(
                        onPressed: () {
                          // Handle image submission logic here
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 16.0),
                          backgroundColor: Color(0xFF64FCD9), // Color for Submit button
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
