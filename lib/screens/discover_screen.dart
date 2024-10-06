import 'package:flutter/material.dart';
import 'package:samvaad/components/categories_component.dart';
import 'package:samvaad/components/recent_component.dart';

class DiscoverScreen extends StatelessWidget {
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
        child: Column(
          children: [
            // Text Section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Stack(
                children: [
                  // Text in two lines
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      width: MediaQuery.of(context).size.width - 80, // Allow space for the rectangle on the right
                      child: Text(
                        'What do you want to play today?',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.start,
                        maxLines: 2, // Ensure the text wraps to two lines
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  // Rectangle with diamond image and number
                  Positioned(
                    right: 0, // Position the rectangle on the right
                    top: 0,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                      decoration: BoxDecoration(
                        color: Color(0xFF6A5753), // Rounded rectangle background color
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset('images/diamonds.png', height: 24), // Diamond image
                          SizedBox(width: 8),
                          Text(
                            '5', // Number text
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            // Recent Component
            RecentComponent(),
            SizedBox(height: 16),
            // Categories Component
            CategoriesComponent(),
          ],
        ),
      ),
    );
  }
}
