import 'dart:async';
import 'package:flutter/material.dart';
import '../OnBoard/onboard.dart';
import '../auth/presentation/login_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => OnboardingScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Stack(
              alignment: Alignment.center,
              children: [
                IconButton(
                  icon: Image.asset("assets/images/bg.png", width: 72, height: 72),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Image.asset("assets/images/shopping-bag.png",
                      width: 42, height: 42),
                  onPressed: () {},
                ),
              ]),
          SizedBox(height: 20),
          Text(
            "Zalada",
            style: TextStyle(
                fontSize: 35,
                color: Colors.black,
                fontWeight: FontWeight.bold),
          ),
        ]),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home Screen")),
      body: Center(child: Text("Welcome to Home Screen!")),
    );
  }
}
