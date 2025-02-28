import 'package:counter/core/constants/app_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final IconData? icon; // Optional material icon
  final Widget? iconWidget; // Optional widget for custom icons like SVG
  final Color? color;
  final Color? textColor;

  CustomButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.iconWidget,
    this.color,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        color: color ?? AppColor.buttonColor,
        borderRadius: BorderRadius.circular(30),
      ),
      child: CupertinoButton(
        onPressed: onPressed,
        padding: EdgeInsets.zero,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (iconWidget != null) ...[
              iconWidget!,
              SizedBox(width: 8),
            ] else if (icon != null) ...[
              Icon(icon, color: textColor ?? Colors.white),
              SizedBox(width: 8),
            ],
            Text(
              label,
              style: TextStyle(
                color: textColor ?? Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
