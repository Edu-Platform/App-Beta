import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  HomeScreenState createState() {
    return new HomeScreenState();
  }
}

class HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return new Center(
      child: Column(
          children: <Widget>[
            Expanded(
              child: Image.asset('assets/banner.jpg')
            ),
          ]
        ),
    );
  }
}