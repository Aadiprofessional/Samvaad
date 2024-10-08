import 'package:flutter/material.dart';

class RecentComponent extends StatefulWidget {
  const RecentComponent({super.key});

  @override
  _RecentComponentState createState() => _RecentComponentState();
}

class _RecentComponentState extends State<RecentComponent>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;

  // List of colors for each item
  final List<Color> colors = [
    const Color(0xFFB18CFE), // Purple color in hex
    const Color(0xFF64FCD9), // Cyan-like color
    const Color(0xFFFF8C82), // Coral-like color
    const Color(0xFFEE719E), // Pinkish color
    Colors.orange,
  ];

  final List<String> itemTexts = [
    'First Line\nSecond Line',
    'Item Two\nAnother Line',
    'Three Items\nMore Lines',
    'Fourth Text\nYet Another Line',
    'Fifth Item\nText Continues',
  ];

  // Simulate the progress percentage for each item
  final List<double> progressValues = [
    0.25,
    0.50,
    0.75,
    1.0,
    0.33
  ]; // Example progress values

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'RECENT',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(
            height: 250,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (context, index) {
                final itemColor = colors[index % colors.length];
                final progressValue =
                    progressValues[index]; // Get the progress for this item
                return GestureDetector(
                  onTap: () {
                    _controller!.repeat();
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Rectangle with regular circular cutout
                      Container(
                        margin: EdgeInsets.only(right: 16.0),
                        width: MediaQuery.of(context).size.width * 0.7,
                        height: 200,
                        decoration: BoxDecoration(
                          color: itemColor.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(
                                itemTexts[index],
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: Image.asset(
                                  'images/recent1.png',
                                  width: 200,
                                  height: 200,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Play button with progress indicator
                      Positioned(
                        bottom: 0,
                        left: 20,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            // Outer circle (behind the Play circle)
                            Container(
                              width: 90,
                              height: 90,
                              decoration: BoxDecoration(
                                color: Color(
                                    0xFF2C2C2E), // Fixed color for the outer circle
                                shape: BoxShape.circle,
                              ),
                            ),
                            // Play button circle
                            Container(
                              width: 70,
                              height: 70,
                              decoration: BoxDecoration(
                                color: itemColor.withOpacity(
                                    0.8), // Dynamic color for each item
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Text(
                                  'Play',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            // Circular progress indicator with percentage
                            Positioned(
                              child: SizedBox(
                                width: 80,
                                height: 80,
                                child: CircularProgressIndicator(
                                  strokeWidth: 5,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      itemColor), // Dynamic color for each item
                                  value: progressValue, // Indicate progress
                                ),
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
