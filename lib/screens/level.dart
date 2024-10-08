import 'package:flutter/material.dart';
import 'dart:math';
import 'package:lottie/lottie.dart';
import 'package:samvaad/screens/QuizScreen.dart';

class LevelScreen extends StatefulWidget {
  const LevelScreen({super.key});

  @override
  _LevelScreenState createState() => _LevelScreenState();
}

class _LevelScreenState extends State<LevelScreen> {
  int unlockedLevels = 1;
  final ScrollController _scrollController = ScrollController();
  final Color giftColor = Color(0xFFFF8C82);
  List<bool> giftPressedStates = List.filled(5, false);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToUnlockedLevel();
    });
  }

  void _scrollToUnlockedLevel() {
    double position = (unlockedLevels - 1) * 160.0; // Approximate position of the hexagons
    _scrollController.animateTo(
      position,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'images/Home.png',
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 40,
            left: 16,
            right: 16,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                Text(
                  'Game Name',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.more_vert, color: Colors.white),
                  onPressed: () {
                    _openNavBar(context);
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 100),
            child: Center(
              child: SingleChildScrollView(
                controller: _scrollController,
                reverse: true,
                child: Column(
                  children: [
                    for (int i = 9; i >= 1; i--) ...[
                      // if (i % 2 == 0) _buildSideGiftHexagon(i), // Add side hexagon
                      i <= unlockedLevels
                          ? _buildUnlockedHexagon(i)
                          : _buildLockedHexagon(i),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Unlocked hexagon
  Widget _buildUnlockedHexagon(int level) {
    return GestureDetector(
      onTap: () {
        if (unlockedLevels == level) {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => QuizScreen()), // Navigate to Quiz Screen
          );
        }
      },
      child: Column(
        children: [
          CustomPaint(
            size: const Size(80, 80), // Adjusted size
            painter: HexagonPainter(
              bgColor: Color(0xFFFF8C82),
              borderColor: Colors.white,
              textColor: Colors.white,
              text: '$level',
              isLocked: false,
            ),
          ),
        
           _buildLine(), // Remove top line for the last hexagon
        ],
      ),
    );
  }

  // Locked hexagon
  Widget _buildLockedHexagon(int level) {
    return GestureDetector(
      onTap: () {
        if (unlockedLevels + 1 == level) {
          setState(() {
            unlockedLevels++;
            _scrollToUnlockedLevel();
          });
        } else {
          showDialog(
            context: context,
            builder: (context) => Center(
              child: SizedBox(
                width: 100,
                height: 100,
                child: Lottie.asset(
                  'images/Animation - 1728315163769.json',
                  repeat: false,
                  onLoaded: (composition) {
                    Future.delayed(const Duration(seconds: 1), () {
                      Navigator.pop(context);
                    });
                  },
                ),
              ),
            ),
          );
        }
      },
      child: Column(
        children: [
          Container(
            width: 80, // Set the width for the container
            height: 80, // Set the height for the container
            child: CustomPaint(
              painter: HexagonPainter(
                bgColor: Color(0xFFB18CFE),
                borderColor: Colors.white,
                textColor: Colors.white,
                text: '',
                isLocked: true,
              ),
              child: Center(
                child: Image.asset(
                  'images/lock.png',
                  width: 50, // Adjusted width for lock icon
                  height: 50, // Adjusted height for lock icon
                ),
              ),
            ),
          ),
       
          if (level != 1) _buildLine(), // Remove bottom line for the first hexagon
        ],
      ),
    );
  }

  // Vertical connecting line
  Widget _buildLine() {
    return Container(
      width: 2,
      height: 50,
      color: Colors.white,
    );
  }

//  Widget _buildSideGiftHexagon(int level) {
//   bool isLeft = level % 4 == 0; // Determine if hexagon should be on the left or right
//   bool isRight = level % 4 == 2; // Determine if hexagon should be on the right

//   return Row(
//     mainAxisAlignment: isLeft ? MainAxisAlignment.end : MainAxisAlignment.start,
//     children: [
//       if (!isRight) Container(
//         width: 100,
//         height: 2, // Height of the connecting line
//         color: Colors.white,
//         margin: EdgeInsets.only(left: 10), // Space between hexagons
//       ),
    
//       GestureDetector(
//         onTap: () {
//           setState(() {
//             // Check if the adjacent even hexagon is unlocked before changing the state
//             if ((isLeft && (level - 1 <= unlockedLevels)) || (!isLeft && (level + 1 <= unlockedLevels))) {
//               giftPressedStates[level ~/ 2] = !giftPressedStates[level ~/ 2]; // Toggle the state for this gift hexagon
//             }
//           });
//         },
//         child: Container(
//           width: 80, // Set the width for the container
//           height: 80, // Set the height for the container
//           child: CustomPaint(
//             painter: HexagonPainter(
//               bgColor: giftPressedStates[level ~/ 2] ? giftColor : Color(0xFF64FCD9),
//               borderColor: Colors.white,
//               textColor: Colors.white,
//               text: giftPressedStates[level ~/ 2] ? "Great" : "",
//               isLocked: false,
//             ),
//             child: Center(
//               child: giftPressedStates[level ~/ 2]
//                   ? Container() // Hide gift icon when pressed
//                   : Image.asset(
//                       'images/gift.png',
//                       width: 40, // Adjusted width for gift icon
//                       height: 40, // Adjusted height for gift icon
//                     ),
//             ),
//           ),
//         ),
//       ),
//       // Add the connecting line for left
 
//       if (!isLeft) Container(
//         width: 100,
//         height: 2, // Height of the connecting line
//         color: Colors.white,
//         margin: EdgeInsets.only(left: 10), // Space between hexagons
//       ),
//       // Add the connecting line for right
   
//     ],
//   );
// }


  // Open small navbar
  void _openNavBar(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SizedBox(
          height: 200,
          child: Column(
            children: [
              ListTile(
                leading: Icon(Icons.settings),
                title: Text('Settings'),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.info),
                title: Text('Info'),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text('Exit'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

// Custom painter for hexagons with rounded corners and borders
class HexagonPainter extends CustomPainter {
  final Color bgColor;
  final Color borderColor;
  final Color textColor;
  final String text;
  final bool isLocked;

  HexagonPainter({
    required this.bgColor,
    required this.borderColor,
    required this.textColor,
    required this.text,
    this.isLocked = false,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = bgColor
      ..style = PaintingStyle.fill;

    Path hexagonPath = _createHexagonPath(size, 15); // Increased corner radius for rounded edges
    canvas.drawPath(hexagonPath, paint);

    Paint borderPaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;
    canvas.drawPath(hexagonPath, borderPaint);

    TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: isLocked ? '' : text,
        style: TextStyle(
            color: textColor, fontSize: 24, fontWeight: FontWeight.bold),
      ),
      textDirection: TextDirection.ltr,
    );

    textPainter.layout(minWidth: 0, maxWidth: size.width);
    textPainter.paint(
      canvas,
      Offset((size.width - textPainter.width) / 2,
          (size.height - textPainter.height) / 2),
    );
  }

  Path _createHexagonPath(Size size, double cornerRadius) {
    double radius = size.width / 2;
    double angle = pi / 3;
    Offset center = Offset(size.width / 2, size.height / 2);

    Path path = Path();
    for (int i = 0; i < 6; i++) {
      double x = radius * cos(i * angle - pi / 6) + center.dx; // Rotate hexagon
      double y = radius * sin(i * angle - pi / 6) + center.dy; // Rotate hexagon
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();
    return path;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
