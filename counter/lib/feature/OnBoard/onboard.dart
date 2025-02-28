import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../auth/presentation/login_screen.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  double _progressValue = 0.50; // Initial progress
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(_updateProgress);
  }

  void _updateProgress() {
    setState(() {
      _currentIndex = (_pageController.page ?? 0).round();
    });
  }

  void _nextPageOrFinish() {
    if (_currentIndex < 2) {
      setState(() {
        if (_currentIndex == 0) {
          _progressValue = 0.75; // Second board
        } else if (_currentIndex == 1) {
          _progressValue = 1.0; // Third board (Last step)
        }
      });
      _pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(
          children: [
            // Onboarding Pages
            PageView(
              controller: _pageController,
              children: [
                _buildPage(
                  imagePath: "assets/svgs/onboard1.svg",
                  title: "Find the item you've been looking for",
                  body: "Here you'll see rich varieties of goods, carefully classified for a seamless browsing experience.",
                ),
                _buildPage(
                  imagePath: "assets/svgs/onboard2.svg",
                  title: "Get those shopping bags filled",
                  body: "Add any item you want to your cart or save it on your wishlist, so you don't miss it in your future purchase.",
                ),
                _buildPage(
                  imagePath: "assets/svgs/onboard3.svg",
                  title: "Fast & Secure payment",
                  body: "There are many payment options available to speed up and simplify your payment process.",
                ),
              ],
            ),

            // Custom Circular Progress Indicator at Bottom
            Positioned(
              bottom: 40.h,
              left: 0,
              right: 0,
              child: Center(
                child: SizedBox(
                  width: 80,
                  height: 80,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      CircularProgressIndicator(
                        value: _progressValue, // Dynamically updated progress
                        strokeWidth: 6,
                        backgroundColor: Colors.grey.shade300,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: IconButton(
                          icon: SvgPicture.asset(
                            "assets/svgs/arrow.svg",
                            height: 50.h,
                            width: 50.w,
                          ),
                          onPressed: _nextPageOrFinish, // Click to go to next screen or finish
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Custom Skip Button in the Top-Right Corner
            Positioned(
              top: 40.h,
              right: 20.w,
              child: GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                },
                child: const Text(
                  "Skip",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }



  Widget _buildPage({required String imagePath, required String title, required String body}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Image is now above the text
        SvgPicture.asset(imagePath, height: 240.h),
        SizedBox(height: 30.h), // Space between image & text
        Text(
          title,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 20.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.w),
          child: Text(
            body,
            style: TextStyle(fontSize: 16, color: Colors.grey),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
