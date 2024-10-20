import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:nutri_plant/screens/diagnosis.dart';
import 'package:nutri_plant/screens/camera_screen.dart';
import 'package:nutri_plant/screens/home_page.dart';
// import 'package:nutri_plant/screens/my_plants_screen.dart';
import 'package:nutri_plant/screens/account_screen.dart';
import 'package:url_launcher/url_launcher.dart';

import 'MyPlants.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  List<CameraDescription> cameras = [];

  @override
  void initState() {
    super.initState();
    // Initialize cameras asynchronously
    availableCameras().then((availableCameras) {
      setState(() {
        cameras = availableCameras;
      });
    });
  }

  // Dynamically build the pages list
  List<Widget> get _pages {
    // If cameras are not yet initialized, show a loading indicator for the Camera screen
    if (cameras.isEmpty) {
      return [
        HomePage(),
        DiagnosisScreen(),
        Center(child: CircularProgressIndicator()), // Loading indicator for Camera screen
        MyPlantsScreen(), // Ensure MyPlantsScreen is included
        AccountScreen(),
      ];
    } else {
      return [
        HomePage(),
        DiagnosisScreen(),
        ImageUploadScreen(),
        MyPlantsScreen(), // Ensure MyPlantsScreen is included
        AccountScreen(),
      ];
    }
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex], // Display the current page
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.local_hospital), label: 'Diagnose'),
          BottomNavigationBarItem(icon: Icon(Icons.camera_alt), label: 'Camera'),
          BottomNavigationBarItem(icon: Icon(Icons.local_florist), label: 'My Plants'), // Corresponds to MyPlantsScreen
          BottomNavigationBarItem(icon: Icon(Icons.account_circle), label: 'Account'),
        ],
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}
