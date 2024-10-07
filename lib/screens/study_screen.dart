import 'package:flutter/material.dart';
import 'package:samvaad/components/NewGamesComponent%20.dart';
import 'package:samvaad/components/Recommended.dart';

import 'package:samvaad/components/categories_component.dart';

class StudyScreen extends StatelessWidget {
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
            // Remove padding from ListView
            padding: EdgeInsets.zero,
            children: [
              // Bold Study text
              Padding(
                padding: EdgeInsets.all(16.0), // Padding for the title
                child: Text(
                  'Study',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // Text color
                  ),
                ),
              ),
              SizedBox(height: 16),

              // Search box
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0), // Padding for the search box
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFF48484A), // Background color for search box
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Subjects, tutorials...',
                      hintStyle: TextStyle(color: Colors.white70), // Hint text color
                      prefixIcon: Icon(Icons.search, color: Colors.white), // Search icon
                      border: InputBorder.none, // Remove the default border
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),

              // Categories Component
              CategoriesComponent(),
              SizedBox(height: 16),

              // New Games Component
              RecommendedComponent(),
            ],
          ),
        ),
      ),
    );
  }
}
