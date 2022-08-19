import 'package:bus_pedal_conductor/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:bus_pedal_conductor/Screens/Navigation Pages/qr_scanner_page.dart';
import 'package:bus_pedal_conductor/Screens/Navigation Pages/settings_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
      .collection("conductors")
      .doc(user?.uid)
      .get()
      .then ((value){
        this.loggedInUser = UserModel.fromMap(value.data());
        setState(() {});
    });
  }

  int currentIndex = 0;

  final screens = [
    QrScannerPage(),

    SettingsPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      //Bottom navigation bar
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.pinkAccent,
        unselectedItemColor: Colors.black,
        iconSize: 30,
        selectedFontSize: 16,
        showUnselectedLabels: false,
        currentIndex: currentIndex,
        onTap: (index) => setState(() => currentIndex = index),
        items: [
          BottomNavigationBarItem(label: 'QR Scanner',icon: Icon(Icons.qr_code_scanner)),
          BottomNavigationBarItem(label: 'Settings',icon: Icon(Icons.settings_applications_rounded)),
        ],
      ),
    );
  }
}

