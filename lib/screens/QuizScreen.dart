import 'package:flutter/material.dart';

class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int currentQuestionIndex = 0;
  int totalQuestions = 5;
  List<String> questions = [
    'What is this letter?',
    'What is this letter?',
    'What is this letter?',
    'What is this letter?',
    'What is this letter?',
  ];

  List<List<String>> options = [
    ['A', 'B', 'C'],
    ['A', 'B', 'C'],
    ['A', 'B', 'C'],
    ['A', 'B', 'C'],
    ['A', 'B', 'C'],
  ];

  List<String> correctAnswers = [
    'Option A', // Assume this is the correct answer for each question
    'Option B',
    'Option C',
    'Option A',
    'Option B',
  ];

  Color buttonColor = Color(0xFFFF8C82);
  Color inactiveColor = Color.fromARGB(0, 255, 255, 255);
  Color buttonTextColor = Color(0xFFFFFFFF);
  List<Color> optionColors = [
   Color.fromARGB(0, 255, 255, 255),
   Color.fromARGB(0, 255, 255, 255),
   Color.fromARGB(0, 255, 255, 255)
  ];

  void _selectOption(String selectedOption, int index) {
    setState(() {
      if (selectedOption == correctAnswers[currentQuestionIndex]) {
        // Correct answer logic (can be extended)
      }
      // Change the color of the selected option
      optionColors = List.generate(options[currentQuestionIndex].length, (i) {
        return i == index ? buttonColor : inactiveColor;
      });

      // Move to next question after a short delay and reset button colors
      Future.delayed(Duration(seconds: 1), () {
        setState(() {
          if (currentQuestionIndex < totalQuestions - 1) {
            currentQuestionIndex++;
            // Reset the button colors
            optionColors = [inactiveColor, inactiveColor, inactiveColor];
          }
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'images/Home.png',
              fit: BoxFit.cover,
            ),
          ),
          Column(
            children: [
              // Header with Question number
              Container(
                padding: EdgeInsets.symmetric(vertical: 40, horizontal: 16),
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
                      'Question ${currentQuestionIndex + 1} / $totalQuestions',
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

              // Progress Indicator
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    Container(
                      height: 5,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(255, 255, 255, 0.48),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: LinearProgressIndicator(
                        value: (currentQuestionIndex + 1) / totalQuestions,
                        backgroundColor: Colors.transparent,
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Color(0xFFFF8C82)),
                      ),
                    ),
                    SizedBox(height: 20), // Spacing
                  ],
                ),
              ),

              // White Box with Image and Question
              Expanded(
                child: Center(
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        width: screenWidth * 0.9,
                        margin: EdgeInsets.symmetric(vertical: 20),
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 10,
                              offset: Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(height: 100),
                            Text(
                              questions[currentQuestionIndex],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),

                      // Image pop-out style above the container
                      Positioned(
                        top: -50, // Moves the image out of the container
                        left:
                            (screenWidth * 0.9 - 150) / 2, // Centers the image
                        child: Container(
                          height: 150, // Adjust height as needed
                          width: 150, // Adjust width if needed
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 10,
                                offset: Offset(0, 5),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.asset(
                              'images/game1.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Buttons for options
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: List.generate(options[currentQuestionIndex].length,
                      (index) {
                    return GestureDetector(
                      onTap: () => _selectOption(
                          options[currentQuestionIndex][index], index),
                      child: Container(
                        margin: EdgeInsets.only(bottom: 10),
                        padding: EdgeInsets.symmetric(vertical: 15),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: optionColors[index],
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            options[currentQuestionIndex][index],
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

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
