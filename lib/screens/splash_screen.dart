import 'package:flutter/material.dart';
import 'dart:async';
import 'main_screen.dart'; // Import your main screen

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _logoController;
  late Animation<double> _logoAnimation;

  @override
  void initState() {
    super.initState();

    // Logo animation
    _logoController = AnimationController(
      duration: Duration(milliseconds: 800),
      vsync: this,
    );

    _logoAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.easeOut),
    );

    _logoController.forward(); // Start the animation

    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => MainScreen()));
    });
  }

  @override
  void dispose() {
    _logoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'images/bg.png', // Ensure the file is in your assets directory
              fit: BoxFit.cover, // Cover the entire background
            ),
          ),
          // Gradient Circles with reduced opacity and animation
          Positioned(
            bottom: -200,
            left: -200,
            child: AnimatedGradientCircle(
              colors: [
                Color(0xFFC6F5EA).withOpacity(0.1), // Opacity set to 10%
                Color(0xFF5AE6C6).withOpacity(0.6), // Opacity set to 10%
              ],
              delay: 300,
            ),
          ),
          Positioned(
            top: -200,
            right: -200,
            child: AnimatedGradientCircle(
              colors: [
                Color(0xFFFF9E7E).withOpacity(0.1), // Opacity set to 10%
                Color(0xFFFF5018).withOpacity(0.7), // Opacity set to 10%
              ],
              delay: 600,
            ),
          ),
          // Logo Animation
          Center(
            child: FadeTransition(
              opacity: _logoAnimation,
              child: ScaleTransition(
                scale: _logoAnimation,
                child: Image.asset('images/logo.png', width: 150, height: 150),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AnimatedGradientCircle extends StatefulWidget {
  final List<Color> colors;
  final int delay;

  const AnimatedGradientCircle({required this.colors, required this.delay});

  @override
  _AnimatedGradientCircleState createState() => _AnimatedGradientCircleState();
}

class _AnimatedGradientCircleState extends State<AnimatedGradientCircle>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();

    // Circle Animation Controller
    _controller = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this,
    );

    // Scale Animation
    _scaleAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    // Opacity Animation
    _opacityAnimation = Tween<double>(begin: 0.1, end: 0.1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    // Delay before starting animation
    Future.delayed(Duration(milliseconds: widget.delay), () {
      _controller.repeat(reverse: true); // Continuously animate back and forth
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacityAnimation, // Apply opacity animation here
      child: ScaleTransition(
        scale: _scaleAnimation, // Apply scaling animation here
        child: Container(
          width: 400,
          height: 400,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: widget.colors,
              stops: [0.0, 1.0],
            ),
          ),
        ),
      ),
    );
  }
}
