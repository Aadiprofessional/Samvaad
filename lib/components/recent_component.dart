import 'package:flutter/material.dart';

class RecentComponent extends StatefulWidget {
  @override
  _RecentComponentState createState() => _RecentComponentState();
}

class _RecentComponentState extends State<RecentComponent>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;

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
            'Recent',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white, // White color for "Recent" text
            ),
          ),
          SizedBox(height: 8),
          Container(
            height: 250, // Large rectangles to show only two at a time
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 5, // Replace with actual recent items count
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    // Start the loading animation when the rectangle is pressed
                    _controller!.repeat();
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // The concave rectangle with a circular cutout
                      ClipPath(
                        clipper: ConcaveClipper(), // Custom clipper for concave effect
                        child: Container(
                          margin: EdgeInsets.only(right: 16.0),
                          width: MediaQuery.of(context).size.width * 0.7, // Large width
                          height: 200,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.8),
                            borderRadius: BorderRadius.circular(30), // Rounded corners
                          ),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(
                                'Item ${index + 1}',
                                style: TextStyle(
                                  fontSize: 24,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      // The smaller play button placed inside the circular cutout
                      Positioned(
                        bottom: 0,
                        left: 20, // Adjust to position it inside the circular cutout
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.8),
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Text(
                                  'Play',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            // The animated activity indicator moving around the smaller circle
                            AnimatedBuilder(
                              animation: _controller!,
                              builder: (context, child) {
                                return Transform.rotate(
                                  angle: _controller!.value * 6.28, // Full circle rotation
                                  child: child,
                                );
                              },
                              child: SizedBox(
                                width: 70,
                                height: 70,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
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

// Custom clipper to create the concave shape with a circular cutout
// Custom clipper to create the concave shape with a circular cutout
class ConcaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    // Define the rectangle shape with rounded corners
    path.addRRect(RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Radius.circular(30),
    ));

    // Adjust the position of the circular cutout by moving it to the right and bottom
    final circlePath = Path()
      ..addOval(Rect.fromCircle(
        center: Offset(55, size.height - 10), // Adjusted the position: moved right and down
        radius: 40, // Radius of the circular cutout (width = 80)
      ));

    // Subtract the circle from the rectangle
    return Path.combine(PathOperation.difference, path, circlePath);
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
