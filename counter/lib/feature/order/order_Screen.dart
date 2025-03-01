import 'package:counter/core/constants/app_color.dart';
import 'package:counter/feature/order/select_address.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import '../cart/data/model/product_cart_model.dart';
import '../payment/payment.dart';

class OrderScreen extends StatefulWidget {
  final List<ProductCartModel> cartProducts;

  OrderScreen({required this.cartProducts});

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  GoogleMapController? mapController;
  LatLng _selectedLocation = LatLng(37.7749, -122.4194); // Default location
  String _selectedAddress = "Select your delivery address";

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  // ✅ Get Current Location
  Future<void> _getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _selectedLocation = LatLng(position.latitude, position.longitude);
    });
  }

  // ✅ Open Address Selection Screen
  Future<void> _selectAddress() async {
    final selectedAddress = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SelectAddressScreen()),
    );

    if (selectedAddress != null) {
      setState(() {
        _selectedAddress = selectedAddress;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double shippingCost = 8.0;
    double totalPrice = widget.cartProducts.fold(0.0, (sum, item) => sum + (item.price ?? 0) * item.quantity!) + shippingCost;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Order Summary", style: TextStyle(color: Colors.black)),
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
                    Text("Delivery Address", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    Text(_selectedAddress, style: TextStyle(fontSize: 16, color: Colors.grey)),
                  ],
                ),
                TextButton(
                  onPressed: _selectAddress, // Open Address Selection
                  child: Text("Change", style: TextStyle(color: Colors.blue)),
                ),
              ],
            ),
            Divider(),
            SizedBox(height: 15),

            // **Google Map**
            Container(
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: GoogleMap(
                  initialCameraPosition: CameraPosition(target: _selectedLocation, zoom: 14),
                  markers: {
                    Marker(markerId: MarkerId("selected-location"), position: _selectedLocation),
                  },
                  onMapCreated: (controller) => mapController = controller,
                ),
              ),
            ),

            SizedBox(height: 20),

            // **Product List**
            Column(
              children: widget.cartProducts.map((product) {
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
                              Text("\$${(product.price! * product.quantity!).toStringAsFixed(2)}",
                                  style: TextStyle(fontSize: 16, color: Colors.blue)),
                              Text("Quantity: ${product.quantity}", style: TextStyle(color: Colors.grey)),
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

            // **Continue to Payment Button**
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.buttonColor,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  padding: EdgeInsets.symmetric(horizontal: 100, vertical: 12),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PaymentScreen(totalPrice: totalPrice)),
                  );
                },
                child: Text(
                  "Continue to Payment",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget _paymentRow(String label, String value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontSize: 16, fontWeight: isBold ? FontWeight.bold : FontWeight.normal)),
          Text(value, style: TextStyle(fontSize: 16, fontWeight: isBold ? FontWeight.bold : FontWeight.normal)),
        ],
      ),
    );
  }
}
