import 'package:flutter/material.dart';

class filterWidget extends StatelessWidget {

  RangeValues _values = RangeValues(0.3, 0.7);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("검색 조건"),
      ),
      body: new Container(
        padding: EdgeInsets.all(8.0),
        child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Padding(
                padding: new EdgeInsets.all(8.0),
              ),
              new Text(
                '과목',
                style: new TextStyle(
                    fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              new Divider(height: 5.0, color: Colors.black),
              new Padding(
                padding: new EdgeInsets.all(8.0),
              ),
              new Text(
                '학년',
                style: new TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
              new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Radio(
                    value: 0,
                  ),
                  new Text(
                    'Carnivore',
                    style: new TextStyle(fontSize: 16.0),
                  ),
                  new Radio(
                    value: 1,
                  ),
                  new Text(
                    'Herbivore',
                    style: new TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                  new Radio(
                    value: 2,
                  ),
                  new Text(
                    'Omnivore',
                    style: new TextStyle(fontSize: 16.0),
                  ),
                ],
              ),
              new Divider(height: 5.0, color: Colors.black),
              new Padding(
                padding: new EdgeInsets.all(8.0),
              ),
              new Text(
                '비용',
                style: new TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
              RangeSlider(
                values: _values,
                onChanged: (RangeValues values) {
                  
                },
              ),
            ]
        )
      ),

      /*
      body: Center(
        child: RaisedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Go back!'),
        ),
      ),
      */
    );
  }
}
