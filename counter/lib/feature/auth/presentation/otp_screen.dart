import 'package:flutter/material.dart';
import '../../../core/constants/app_color.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'Reseted_Done.dart';

class OTPScreen extends StatelessWidget {
  void _Congratulation_Done_BottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return ResetedDone();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Center(
          child: Text("OTP", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column( // Removed Expanded from here
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 10),
            SvgPicture.asset("assets/svgs/otp.svg", height: 200, width: 144), // Fixed size
            SizedBox(height: 10),
            Text(
              "Verification code",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              "We have sent the code verification to your\nWhatsApp Number +201067415446",
              style: TextStyle(fontSize: 16, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),


            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(4, (index) {
                return SizedBox(
                  width: 50,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    maxLength: 1,
                    decoration: InputDecoration(
                      counterText: "",
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                );
              }),
            ),
            SizedBox(height: 5),

            // Resend Timer
            Text("Recent code in 32s", style: TextStyle(color: Colors.grey)),

            SizedBox(height: 10),

            // Continue Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  _Congratulation_Done_BottomSheet(context); // Show bottom sheet
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
      ),
    );
  }
}
