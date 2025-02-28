import 'package:flutter/material.dart';
import 'package:counter/feature/auth/presentation/otp_screen.dart';
import '../../../core/constants/app_color.dart';

class ResetPasswordBottomSheet extends StatelessWidget {
  final String email = "Ym1067415446@gmail.com";

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Forget password",
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          SizedBox(height: 10),
          Center(
            child: Text(
              "Select which contact details should we use to reset your password",
              style: TextStyle(fontSize: 18, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 20),

          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade200, width: 2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Icon(Icons.email, color: AppColor.buttonColor, size: 30),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Send via Email", style: TextStyle(color: Colors.grey, fontSize: 14)),
                    Text(email, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 55),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Close Bottom Sheet
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => OTPScreen()), // Navigate to OTP Screen
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
          SizedBox(height: 10,)
        ],
      ),
    );
  }
}
