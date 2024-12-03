import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // For picking images
import 'dart:io';
import 'package:tflite/tflite.dart'; // TensorFlow Lite for image classification

class TranslationScreen extends StatefulWidget {
  final XFile image;

  TranslationScreen({required this.image});

  @override
  _TranslationScreenState createState() => _TranslationScreenState();
}

class _TranslationScreenState extends State<TranslationScreen> {
  String outputText = 'Output text goes here';
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadModel();
  }

  Future<void> _loadModel() async {
    print('Loading model...');
    try {
      await Tflite.loadModel(
        model: 'assets/isl_model.tflite',
        labels: 'assets/labels.txt',
      );

      print('Model loaded');
      _classifyImage();
    } catch (e) {
      print('Error loading model: $e');
      setState(() {
        outputText = 'Failed to load model';
        isLoading = false;
      });
    }
  }

  Future<void> _classifyImage() async {
    print('Classifying image...');
    try {
      var imageInput = File(widget.image.path);
      var recognitions = await Tflite.runModelOnImage(
        path: imageInput.path,
        numResults: 2,
        threshold: 0.5,
        asynch: true,
      );

      print('Recognition results: $recognitions');

      if (recognitions != null && recognitions.isNotEmpty) {
        setState(() {
          outputText = recognitions[0]['label'];
          isLoading = false;
        });
        print('Prediction: ${recognitions[0]['label']}');
      } else {
        setState(() {
          outputText = 'Unable to recognize gesture';
          isLoading = false;
        });
        print('No recognitions found');
      }
    } catch (e) {
      print('Error classifying image: $e');
      setState(() {
        outputText = 'Error during classification';
        isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    Tflite.close(); // Close the model when done
    super.dispose();
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Image box with rounded corners and white border
              Container(
                margin: EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.file(
                    File(widget.image.path),
                    width: 300, // Width of the image container
                    height: 300, // Height of the image container
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              // Box below the image with white text output or loading spinner
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: isLoading
                    ? CircularProgressIndicator(
                        color: Colors.white) // Show loading spinner
                    : Text(
                        outputText, // Replace with your output text
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
