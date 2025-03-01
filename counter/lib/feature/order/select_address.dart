import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class SelectAddressScreen extends StatefulWidget {
  @override
  _SelectAddressScreenState createState() => _SelectAddressScreenState();
}

class _SelectAddressScreenState extends State<SelectAddressScreen> {
  GoogleMapController? mapController;
  LatLng _currentPosition = LatLng(37.7749, -122.4194); // Default to San Francisco
  String _currentAddress = "Move the pin to select your location";

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  // ✅ Get Current Location
  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if GPS is enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return;
    }

    // Check location permissions
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        return;
      }
    }

    // Get current position
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _currentPosition = LatLng(position.latitude, position.longitude);
    });

    // Move map to the new location
    mapController?.animateCamera(CameraUpdate.newLatLng(_currentPosition));

    // Get address from coordinates
    _getAddressFromLatLng(_currentPosition);
  }

  // ✅ Convert LatLng to Address
  Future<void> _getAddressFromLatLng(LatLng position) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
      Placemark place = placemarks.first;

      setState(() {
        _currentAddress = "${place.street}, ${place.locality}, ${place.country}";
      });
    } catch (e) {
      print("Error getting address: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New Address", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          // **Google Maps**
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.5, // Adjust height if needed
            child: GoogleMap(
              initialCameraPosition: CameraPosition(target: _currentPosition, zoom: 14),
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              onMapCreated: (GoogleMapController controller) {
                mapController = controller;
              },
              markers: {
                Marker(
                  markerId: MarkerId("selected-location"),
                  position: _currentPosition,
                  draggable: true,
                  onDragEnd: (LatLng newPosition) {
                    setState(() {
                      _currentPosition = newPosition;
                    });
                    _getAddressFromLatLng(newPosition);
                  },
                ),
              },
              onTap: (LatLng tappedPosition) {
                setState(() {
                  _currentPosition = tappedPosition;
                });
                _getAddressFromLatLng(tappedPosition);
              },
            ),
          ),


          // **Address Field**
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Select your location from the map", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                SizedBox(height: 5),
                Text(_currentAddress, style: TextStyle(fontSize: 16, color: Colors.black54)),
                SizedBox(height: 15),

                // **Confirm Address Button**
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      padding: EdgeInsets.symmetric(horizontal: 100, vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    onPressed: () {
                      Navigator.pop(context, _currentAddress); // Return address to OrderScreen
                    },
                    child: Text(
                      "Confirm Address",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
