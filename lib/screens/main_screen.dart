import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'discover_screen.dart';
import 'study_screen.dart';
import 'translator_screen.dart';
import 'exercise_screen.dart';
import 'profile_screen.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  // Define the screens for each navigation item
  static List<Widget> _widgetOptions = <Widget>[ // Removed const keyword
    DiscoverScreen(),
    StudyScreen(),
    TranslatorScreen(),
    ExerciseScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

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
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Color.fromRGBO(72, 72, 74, 0.72),
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'images/icons/Discover.svg',
              color: _selectedIndex == 0 ? Colors.white : Colors.grey,
            ),
            label: 'Discover',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'images/icons/Translator.svg',
              color: _selectedIndex == 1 ? Colors.white : Colors.grey,
            ),
            label: 'Study',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'images/icons/Exercise.svg',
              color: _selectedIndex == 2 ? Colors.white : Colors.grey,
            ),
            label: 'Translator',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'images/icons/Study.svg',
              color: _selectedIndex == 3 ? Colors.white : Colors.grey,
            ),
            label: 'Exercise',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              color: _selectedIndex == 4 ? Colors.white : Colors.grey,
            ),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}
