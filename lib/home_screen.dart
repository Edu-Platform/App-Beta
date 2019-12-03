import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:http/http.dart' as http;

import 'details_page.dart';
import 'place.dart';

class HomeScreen extends StatefulWidget {
  @override
  HomeScreenState createState() {
    return new HomeScreenState();
  }
}

class HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    
    return Container(
      color: Color(0xfff2f2f2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Card(
            color: Colors.white,
            elevation: 0.0,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 180.0,
                //width: 400.0,
                width: double.infinity, 
                child: Carousel(
                  images: [
                    ExactAssetImage("assets/banner.jpg"),
                    NetworkImage('https://cdn.pixabay.com/photo/2015/06/02/12/59/narrative-794978_960_720.jpg'),
                    NetworkImage('https://cdn.pixabay.com/photo/2015/07/28/22/05/child-865116_960_720.jpg'),
                  ],
                ),
              ),
            ),
          ),

          Center(
            child: RaisedButton(
              padding: EdgeInsets.all(8.0),
              color: Colors.blue,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Icon(
                      Icons.home,
                      color: Colors.white,
                      size: 35.0,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Text(
                      "학원찾기",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              onPressed: () {
                print('find academy');
              },
            )
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "인기 강의 목록",
              style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(8.0),
              color: Colors.white,
              child: ListView(
                children: <Widget>[
                  ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(
                          "https://pbs.twimg.com/media/EClDvMXU4AAw_lt?format=jpg&name=medium"),
                    ),
                    title: new Row(
                      children: <Widget>[
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "솔루션 수학학원",
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 10.0, right: 10.0),
                          alignment: Alignment.centerRight,
                          child: Text("강의료 30만원"),
                        ),
                      ],
                    ),
                    subtitle: new Row(
                      children: <Widget>[
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text("중1 수학 월 수 금"),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 10.0, right: 10.0),
                          alignment: Alignment.center,
                          child: Text("오후 6시 ~ 8시"),
                        ),
                        Container(
                          alignment: Alignment.centerRight,
                          child: Text("김혜영쌤"),
                        ),
                      ],
                    ),
                    isThreeLine: false,
                    onTap: () => Navigator.push(
                        
                        context,
                        MaterialPageRoute<void>(builder: (BuildContext context) {
                          return DetailsPage();
                        })
                    ),
                            //builder: (context) => StoryPageView())),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
    
  }
}