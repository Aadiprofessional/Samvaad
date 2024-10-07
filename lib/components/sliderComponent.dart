import 'package:flutter/material.dart';

class GameDetailSlider extends StatelessWidget {
  final String gameName;

  const GameDetailSlider({Key? key, required this.gameName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      height: screenHeight * 0.85, // Set to 85% of the screen height
      width: double.infinity, // 100% screen width
      decoration: BoxDecoration(
        color: Color(0xFF2C2C2E), // Background color
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          // Image slider wrapped in a Stack
          Expanded(
            child: Stack(
              children: [
                Container(
                  child: PageView(
                    children: [
                      Image.asset('images/slider1.png', fit: BoxFit.cover),
                      // Add more images as needed
                    ],
                  ),
                ),
                // Close button overlay with arrow
                Positioned(
                  top: 10,
                  left: 10,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context); // Close the slider
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Rounded rectangle for arrow
                        Container(
                          padding: EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(255, 255, 255, 0.48), // Background color for the arrow
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.arrow_drop_down, color: Colors.white, size: 20), // Arrow icon
                            ],
                          ),
                        ),
                        SizedBox(width: 8), // Space between the arrow and text
                        Text(
                          'Close',
                          style: TextStyle(color: Colors.white, fontSize: 14), // Text color
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          // Game name text (Bold)
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                gameName, // Game name passed as a parameter
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
          ),
          SizedBox(height: 5),
          // Description text (Medium white text)
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Your two lines of descriptive text can go here.',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          // Begin button
          ElevatedButton(
            onPressed: () {
              // Perform action on button press
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromRGBO(72, 72, 74, 0.72), // Set background color to a semi-transparent color
              minimumSize: Size(MediaQuery.of(context).size.width * 0.7, 50), // 70% width
            ),
            child: Text(
              'Begin!',
              style: TextStyle(color: Colors.white), // Set text color to white for contrast
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
