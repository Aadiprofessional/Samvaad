import 'package:flutter/material.dart';
import 'sliderComponent.dart'; // Import the new slider component file

class NewGamesComponent extends StatelessWidget {
  final List<Color> gameColors = [
    Color(0xFFFF8C82), // First card color
    Color(0xFFEE719E), // Second card color
    Colors.greenAccent,
    Colors.orangeAccent,
  ];

  final List<String> gameNames = [
    'Word\nmemorization',
    'Memory\ncards',
    'Spot the\nmistakes',
    'Flip the\ncard'
  ];

  final List<String> gameImages = [
    'images/FirstGame.png', // First card image
    'images/SecondGame.png', // Second card image
    'images/SecondGame.png', // Second card image
    'images/SecondGame.png', // Second card image
  ];

  NewGamesComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'NEW GAMES',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 16),
          // Allow the GridView to take dynamic height
          Container(
            child: GridView.builder(
              physics: NeverScrollableScrollPhysics(), // Disable scroll
              shrinkWrap:
                  true, // Allow GridView to take its height based on content
              itemCount: gameNames.length, // Use dynamic length of gameNames
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio:
                    0.8, // Adjusted aspect ratio to make cards shorter
              ),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return GameDetailSlider(gameName: gameNames[index]);
                      },
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: gameColors[index], // Set different colors
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          offset: Offset(0, 4),
                          blurRadius: 10,
                        ),
                      ],
                    ),
                    child: Stack(
                      children: [
                        // Positioned widget for the first text (title)
                        Positioned(
                          left: 8,
                          top: index % 2 == 0
                              ? null
                              : 20, // Position at the top for 2nd and 4th
                          bottom: index % 2 == 0
                              ? 20
                              : null, // Position at the bottom for 1st and 3rd
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                gameNames[index].split('\n')[0],
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                gameNames[index].split('\n')[1],
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Positioned widget for diamonds
                        Positioned(
                          left: 10,
                          bottom:
                              index % 2 == 0 ? null : 10, // Top for 1st and 3rd
                          top: index % 2 == 0
                              ? 10
                              : null, // Bottom for 2nd and 4th
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 5.0),
                            decoration: BoxDecoration(
                              color: Color.fromARGB(88, 255, 255, 255),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.asset('images/diamonds.png',
                                    height: 20), // Reduced diamond image size
                                SizedBox(width: 8),
                                Text(
                                  '5',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18, // Reduced font size
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        // Positioned widget for the game image
                        Positioned(
                          right: 0,
                          bottom:
                              index % 2 == 0 ? 60 : 40, // Alternate positioning
                          child: ClipRect(
                            child: Image.asset(
                              gameImages[index],
                              width: 130, // Increased size for better fit
                              height: 130, // Increased size for better fit
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          // Add a gap for the last pair of cards
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
