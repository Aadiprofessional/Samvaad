import 'package:flutter/material.dart';

class CategoriesComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'CATEGORIES',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: () {
                  // Action for 'See All'
                },
                child: Text(
                  'See all ->',
                  style: TextStyle(
                    color: Colors.blue, // Change color as needed
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 5,
              childAspectRatio: 1, // Adjust to make squares
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: 5, // Number of categories
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Card(
                color: Colors.white.withOpacity(0.8),
                child: Center(
                  child: Text('Category ${index + 1}'),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
