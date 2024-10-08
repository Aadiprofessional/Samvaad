import 'package:flutter/material.dart';

class CategoriesComponent extends StatelessWidget {
  // List of category names
  final List<String> categories = [
    'Math',
    'Science',
    'Grammar',
    'Hindi',
    'History',
  ];

  // List of image paths for each category
  final List<String> categoryImages = [
    'images/Math.png',
    'images/Science.png',
    'images/Grammar.png',
    'images/Hindi.png',
    'images/History.png',
  ];

CategoriesComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Row with "CATEGORIES" and "See all ->" texts
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'CATEGORIES',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // Set to white color
                ),
              ),
              TextButton(
                onPressed: () {
                  // Action for 'See All'
                },
                child: Text(
                  'See all ->',
                  style: TextStyle(
                    color: Colors.white, // Set to white color
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          // Horizontally scrollable row with rounded squares for categories
          SizedBox(
            height: 100, // Adjust height as needed
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length, // Number of categories
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: Column(
                    children: [
                      Container(
                        width: 90, // Adjust size as needed
                        height: 100,
                        decoration: BoxDecoration(
                          color: Color(0xFF6A5753), // Background color #6A5753
                          borderRadius: BorderRadius.circular(15), // Rounded square shape
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Image for each category
                            Image.asset(
                              categoryImages[index],
                              width: 50, // Adjust size
                              height: 50, // Adjust size
                            ),
                            SizedBox(height: 8),
                            // Category name text below the image
                            Text(
                              categories[index],
                              style: TextStyle(
                                color: Colors.white, // White text for category name
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
