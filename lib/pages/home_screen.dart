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
      child: new Text(
        "Calls",
        style: new TextStyle(fontSize: 20.0),
      ),
    );
  }
}