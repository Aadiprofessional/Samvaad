import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:samvaad/screens/level.dart';

class ResultScreen extends StatelessWidget {
  final int score; // Pass the score as a parameter
  final int totalQuestions; // Pass the total number of questions
  ResultScreen({required this.score, required this.totalQuestions});

  @override
  Widget build(BuildContext context) {
    double percentage = (score / totalQuestions) * 100;
    double pointsEarned = percentage; // You can scale this if needed
    num starCount =
        (percentage >= 75) ? 2.5 : 2; // Adjust stars based on percentage

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'images/Home.png', // Background image
              fit: BoxFit.cover,
            ),
          ),
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Top-left white cross to navigate back to home screen
                Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    icon: Icon(Icons.close, color: Colors.white),
                    onPressed: () {
                      Navigator.pop(context); // Go back to Home screen
                    },
                  ),
                ),
                Spacer(flex: 1), // Add some space at the top

                // "Nice Work" text
                Text(
                  "Nice Work!",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),

                // Animated Tick mark in the center
                Lottie.asset(
                  'images/Animation - 1728807740602.json', // Path to your animated tick json
                  width: 150,
                  height: 150,
                  repeat: false,
                ),

                // Animated stars based on score
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildStar(percentage >= 50 ? 1.0 : 0.5), // Left star
                    SizedBox(width: 10), // Space between stars
                    _buildStar(1.0, isBig: true), // Center bigger star
                    SizedBox(width: 10), // Space between stars
                    _buildStar(percentage >= 75 ? 1.0 : 0.5), // Right star
                  ],
                ),

                SizedBox(height: 20),

                // Points Earned text
                Text(
                  'You Earned ${pointsEarned.toInt()} pts',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),

                Spacer(flex: 2),

                // Buttons "Next Stage" and "Play Again"
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            // Navigate to the next level screen
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 15),
                            backgroundColor: Color(0xFFFF9051),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ), // Button color
                          ),
                          child: Text(
                            "Next Stage",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white, // Text color
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      LevelScreen()), // Navigate to LevelScreen
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 15),
                            backgroundColor: Color.fromARGB(160, 72, 72, 74),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ), // Play Again button color
                          ),
                          child: Text(
                            "Play Again",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white, // Text color
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                Spacer(flex: 2),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Build star widget
  Widget _buildStar(double fillPercentage, {bool isBig = false}) {
    return Container(
      width: isBig ? 50.0 : 30.0, // Bigger size for the center star
      height: isBig ? 50.0 : 30.0,

      child: Icon(
        Icons.star, // Star icon
        color: const Color.fromARGB(255, 234, 182, 11), // Icon color
        size: isBig ? 40.0 : 25.0, // Bigger icon size for the center star
      ),
    );
  }
}
