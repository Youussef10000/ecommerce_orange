import 'package:flutter/material.dart';
import 'Product.dart';
import 'Product_grid_view.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // Number of tabs
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            // Header with Location, Profile & Offers
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xffFD6C8A),
                    Color(0xffFDA56C),
                    Colors.white,
                  ],
                  stops: [0.0, 0.5, 1.0],
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.white70.withOpacity(0.3),
                            child: Icon(Icons.location_on, color: Colors.white),
                          ),
                          SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Location",
                                  style: TextStyle(
                                      color: Colors.white, fontWeight: FontWeight.bold)),
                              Text("Condong Catur",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15)),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.white70.withOpacity(0.3),
                            child: Icon(Icons.add_alert_rounded, color: Colors.white),
                          ),
                          SizedBox(width: 10),
                          CircleAvatar(
                            backgroundImage: AssetImage("assets/images/Profile@2x.png"),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 15),

                  Text(
                    "Find the best device for \nYour setup!",
                    style: TextStyle(
                        fontSize: 35, color: Colors.white, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 10),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Stack(
                      children: [
                        Container(
                          height: 200,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/images/Background.png"),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "New Bing\nWireless \nEarphone",
                                style: TextStyle(
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  Text(
                                    "See Offer",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Icon(Icons.arrow_forward_ios, color: Colors.white70),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          right: 20,
                          bottom: 45,
                          child: Image.asset(
                            "assets/images/image 1.png",
                            width: 100,fit: BoxFit.fitHeight,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 1),
              child: Row(mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Hot deals 🔥",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),

            ProductList(scrollDirection: Axis.horizontal),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(children: [Text("Categories",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),),],

              ),
            ),

            Container(
              child: TabBar(
                tabs: [
                  Tab(text: "All"),
                  Tab(text: "Mens"),
                  Tab(text: "Womman"),
                ],
                indicatorColor: Colors.deepOrangeAccent,
                labelColor: Colors.deepOrangeAccent,
                unselectedLabelColor: Colors.black38,
              ),
            ),

            Expanded(
              child: TabBarView(
                physics: BouncingScrollPhysics(),
                children: [
                  ProductGrid(category: "",),
                  ProductGrid(category:  "men's clothing",),
                  ProductGrid(category: "women's clothing",),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
