import 'package:flutter/material.dart';

class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int currentQuestionIndex = 0;
  int totalQuestions = 5;
  List<String> questions = [
    'Question 1?',
    'Question 2?',
    'Question 3?',
    'Question 4?',
    'Question 5?',
  ];

  List<List<String>> options = [
    ['Option A', 'Option B', 'Option C'],
    ['Option A', 'Option B', 'Option C'],
    ['Option A', 'Option B', 'Option C'],
    ['Option A', 'Option B', 'Option C'],
    ['Option A', 'Option B', 'Option C'],
  ];

  List<String> correctAnswers = [
    'Option A', // Assume this is the correct answer for each question
    'Option B',
    'Option C',
    'Option A',
    'Option B',
  ];

  Color buttonColor = Color(0xFFFF8C82);
  Color inactiveColor = Color(0xFFFFFFFF);
  Color buttonTextColor = Colors.black;
  List<Color> optionColors = [Color(0xFFFFFFFF), Color(0xFFFFFFFF), Color(0xFFFFFFFF)];

  void _selectOption(String selectedOption, int index) {
    setState(() {
      if (selectedOption == correctAnswers[currentQuestionIndex]) {
        // Correct answer logic (can be extended)
      }
      // Change the color of the selected option
      optionColors = List.generate(options[currentQuestionIndex].length, (i) {
        return i == index ? buttonColor : inactiveColor;
      });
      if (currentQuestionIndex < totalQuestions - 1) {
        currentQuestionIndex++;
      }
    });
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
          Column(
            children: [
              // Header
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
                      'Quiz',
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
                        valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFFF8C82)),
                      ),
                    ),
                    SizedBox(height: 20), // Spacing
                  ],
                ),
              ),

              // Question Container
              Expanded(
                child: Container(
                  margin: EdgeInsets.all(16),
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(255, 255, 255, 0.48),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Stack(
                    children: [
                      // Question Text
                      Positioned(
                        top: 80, // Adjust this value for positioning
                        left: 0,
                        right: 0,
                        child: Text(
                          questions[currentQuestionIndex],
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                      ),
                      // Image Container
                      Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          height: 100, // Adjust height as needed
                          child: ClipRRect(
                            borderRadius: BorderRadius.vertical(bottom: Radius.circular(15)),
                            child: Image.asset(
                              'images/question_image_${currentQuestionIndex + 1}.png', // Image for the current question
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      // Options
                      Column(
                        children: List.generate(options[currentQuestionIndex].length, (index) {
                          return GestureDetector(
                            onTap: () => _selectOption(options[currentQuestionIndex][index], index),
                            child: Container(
                              margin: EdgeInsets.only(bottom: 10),
                              width: MediaQuery.of(context).size.width * 0.8,
                              padding: EdgeInsets.symmetric(vertical: 15),
                              decoration: BoxDecoration(
                                color: optionColors[index],
                                border: Border.all(color: Colors.white),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Text(
                                  options[currentQuestionIndex][index],
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                    ],
                  ),
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
