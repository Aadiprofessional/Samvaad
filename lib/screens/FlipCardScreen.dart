import 'dart:math';
import 'package:flutter/material.dart';
import 'result.dart'; // Import the ResultScreen

class FlipCardScreen extends StatefulWidget {
  @override
  _FlipCardScreenState createState() => _FlipCardScreenState();
}

class _FlipCardScreenState extends State<FlipCardScreen> {
  List<bool> flippedCards =
      List.generate(6, (_) => false); // Track the flipped state of cards
  List<String> cardFaces = List.generate(
      6, (_) => 'images/fip.png'); // Initial card images (front side)
  List<String> cardMatches = [
    'images/face1.png',
    'images/face1.png',
    'images/face2.png',
    'images/face2.png',
    'images/face3.png',
    'images/face3.png'
  ]; // Pairs of faces
  int flippedCount = 0; // To track how many cards have been flipped
  int correctMatches = 0; // To track the number of correct matches
  int firstFlippedCard = -1; // To store the index of the first flipped card
  int secondFlippedCard = -1; // To store the index of the second flipped card
  bool gameCompleted = false; // To track if the game is completed

  @override
  void initState() {
    super.initState();
    _shuffleCards(); // Shuffle the cards when the game starts
  }

  // Shuffle the cards at the beginning of the game
  void _shuffleCards() {
    cardMatches.shuffle(Random());
    flippedCards = List.generate(6, (_) => false);
    cardFaces = List.generate(6, (_) => 'images/fip.png');
    correctMatches = 0;
    flippedCount = 0;
    firstFlippedCard = -1;
    secondFlippedCard = -1;
    gameCompleted = false;
  }

  void _flipCard(int index) {
    if (flippedCards[index] || gameCompleted)
      return; // Don't allow flipping if the card is already flipped or game is completed

    setState(() {
      flippedCards[index] = true;
      cardFaces[index] = cardMatches[index]; // Show the back face of the card

      flippedCount++;

      // Check for matches
      if (flippedCount == 2) {
        if (cardMatches[firstFlippedCard] == cardMatches[secondFlippedCard]) {
          correctMatches++; // Increment correct matches
        } else {
          // If cards don't match, flip them back after a delay
          Future.delayed(Duration(seconds: 1), () {
            setState(() {
              flippedCards[firstFlippedCard] = false;
              flippedCards[secondFlippedCard] = false;
              cardFaces[firstFlippedCard] = 'images/fip.png';
              cardFaces[secondFlippedCard] = 'images/fip.png';
            });
          });
        }

        // Reset flipped cards for next round
        flippedCount = 0;
        firstFlippedCard = -1;
        secondFlippedCard = -1;
      } else {
        // Store the first flipped card
        if (firstFlippedCard == -1) {
          firstFlippedCard = index;
        } else {
          secondFlippedCard = index;
        }
      }

      // Check if all cards are flipped
      if (correctMatches == 3) {
        gameCompleted = true; // Game completed
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'images/Home.png', // Background image
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Stage Text instead of Question number
                Container(
                  padding: EdgeInsets.symmetric(vertical: 40, horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Stage 1',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

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
                          backgroundColor: Colors.transparent,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Color(0xFFFF8C82)),
                        ),
                      ),
                      SizedBox(height: 20), // Spacing
                    ],
                  ),
                ), // Spacing to ensure visibility

                // Cards arranged in a grid with height adjustment
                Expanded(
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // 2 cards per row
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: 6,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () => _flipCard(index),
                        child: AnimatedSwitcher(
                          duration: Duration(milliseconds: 300),
                          child: Container(
                            key: ValueKey(index),
                            height: screenHeight *0.55, // Adjusted height to fit 3 cards vertically
                            width: screenWidth * 0.45, // 45% width
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              image: DecorationImage(
                                image: AssetImage(cardFaces[index]),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 20),

                // Display result when all matches are found
                if (gameCompleted)
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ResultScreen(
                              score: correctMatches,
                              totalQuestions: 3,
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFFF8C82),
                        padding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                      ),
                      child: Text(
                        'Submit',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
