import 'package:flutter/material.dart';
import 'package:counter/core/constants/app_color.dart';
import '../cart/data/model/product_cart_model.dart';

class OrderScreen extends StatelessWidget {
  final List<ProductCartModel> cartProducts; // ✅ List of products

  OrderScreen({required this.cartProducts});

  @override
  Widget build(BuildContext context) {
    double shippingCost = 8.0;
    double totalPrice = cartProducts.fold(0.0, (sum, item) => sum + (item.price ?? 0)) + shippingCost;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Order", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // **Address Section**
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Address", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    Text("🏡 Home", style: TextStyle(fontSize: 16)),
                    Text("10th of Ramadan City", style: TextStyle(color: Colors.grey)),
                  ],
                ),
                TextButton(
                  onPressed: () {},
                  child: Text("Edit", style: TextStyle(color: Colors.blue)),
                ),
              ],
            ),
            Divider(),
            SizedBox(height: 15),

            // **Product List Section**
            Column(
              children: cartProducts.map((product) {
                return Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.network(product.image ?? "", width: 80, height: 80),
                        SizedBox(width: 15),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(product.title ?? "No Title", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                              Text("\$${product.price?.toStringAsFixed(2) ?? "0.00"}", style: TextStyle(fontSize: 16, color: Colors.blue)),
                              SizedBox(height: 5),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Divider(),
                  ],
                );
              }).toList(),
            ),
            SizedBox(height: 10),

            // **Shipping Method**
            Text("Shipping", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Row(
                children: [
                  Image.asset("assets/images/Rectangle 14@3x.png", width: 40),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("J&T Express", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      Text("Regular (\$$shippingCost)", style: TextStyle(color: Colors.grey)),
                      Text("Estimate: 01 - 03 November", style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Divider(),

            // **Payment Summary**
            Text("Payment Summary", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            _paymentRow("Price", "\$${(totalPrice - shippingCost).toStringAsFixed(2)}"),
            _paymentRow("Delivery Fee", "\$$shippingCost"),
            _paymentRow("Total Payment", "\$${totalPrice.toStringAsFixed(2)}", isBold: true),

            SizedBox(height: 35),

            // **Pay Button**


            Divider(),
            SizedBox(height: 5),
            Text("Payment Method", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Row(
                children: [
                  Image.asset("assets/images/Icon/payment/mastercard.png", width: 40), // Replace with actual asset
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("MasterCard", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      Text("**** 7873", style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 60,),

            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.buttonColor,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  padding: EdgeInsets.symmetric(horizontal: 100, vertical: 12),
                ),
                onPressed: () {},
                child: Text(
                  "Pay \$${totalPrice.toStringAsFixed(2)}",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 10,),
          ],
        ),
      ),
    );
  }
  Widget _paymentRow(String label, String value, {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(fontSize: 16, fontWeight: isBold ? FontWeight.bold : FontWeight.normal)),
        Text(value, style: TextStyle(fontSize: 16, fontWeight: isBold ? FontWeight.bold : FontWeight.normal)),
      ],
    );
  }
}
