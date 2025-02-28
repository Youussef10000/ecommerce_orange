import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../core/constants/app_color.dart';
import '../../Bottom_navigation/Bottom_navigation_Bar.dart';
import '../../home/presentation/home_screen.dart';

class ResetedDone extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 40),
          SvgPicture.asset("assets/svgs/Congurate.svg", height: 300, width: 144),
          SizedBox(height: 40),
          Text(
            "Congratulations!",
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          Text(
            "Your account is ready to use. You will be redirected to the Homepage in a few seconds.",
            style: TextStyle(fontSize: 16, color: Colors.grey),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),

          // Done Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) =>   Bottom_Navigation_Bar(title1:"Home",title2: "Browse",title3: "Wishlist",title4: "Cart",title5: "profile",)),
                      (Route<dynamic> route) => false,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColor.buttonColor,
                padding: EdgeInsets.symmetric(vertical: 15),
              ),
              child: Text(
                "Continue",
                style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
