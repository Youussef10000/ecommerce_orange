import 'package:flutter/material.dart';

class TabBar_widget extends StatelessWidget {
  final String title1;
  final String title2;
  final String title3;

  TabBar_widget ({required this.title1, required this.title2, required this.title3});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TabBar(
        tabs: [
          Tab(text: title1),
          Tab(text: title2),
          Tab(text: title3),
        ],
        indicatorColor: Colors.deepOrangeAccent,
        labelColor: Colors.deepOrangeAccent,
        unselectedLabelColor: Colors.black38,
      ),
    );

  }
}