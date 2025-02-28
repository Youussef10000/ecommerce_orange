import 'package:flutter/material.dart';

class CheckoutScreen extends StatelessWidget {
  final double totalPrice;

  CheckoutScreen({required this.totalPrice});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Checkout"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context); // Go back to Cart
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.check_circle, size: 80, color: Colors.green),
            SizedBox(height: 20),
            Text(
              "Thank you for your purchase!",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              "Your total is \$${totalPrice.toStringAsFixed(2)}",
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
            SizedBox(height: 30),

            // ✅ Confirm Button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              onPressed: () {
                Navigator.pop(context); // Go back to Cart
              },
              child: Text("Back to Cart", style: TextStyle(color: Colors.white, fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }
}
