import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'place.dart';
import 'stub_data.dart';
import 'package:expandable/expandable.dart';


class DetailsPage extends StatefulWidget {
  const DetailsPage({
    @required this.place,
    @required this.onChanged,
    Key key,
  })  : assert(place != null),
        assert(onChanged != null),
        super(key: key);

  final Place place;
  final ValueChanged<Place> onChanged;

  @override
  DetailsPageState createState() => DetailsPageState();
}

class DetailsPageState extends State<DetailsPage> {
    Place _place;
  GoogleMapController _mapController;
  final Set<Marker> _markers = {};

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    _place = widget.place;
    _nameController.text = _place.name;
    _descriptionController.text = _place.description;
    return super.initState();
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    setState(() {
      _markers.add(Marker(
        markerId: MarkerId(_place.latLng.toString()),
        position: _place.latLng,
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${_place.name}'),
        backgroundColor: Colors.green[700],
      ),
      body: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                child: Hero(
                  tag: 'imageHero',
                  child: Image.network(
                    "https://images.unsplash.com/photo-1521782462922-9318be1cfd04?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1055&q=80"
                  ),
                ),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return DetailScreen();
                  }));
                },
              ),
            ),
            
            /*
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  height: 260.0,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image: NetworkImage(
                              "https://images.unsplash.com/photo-1521782462922-9318be1cfd04?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1055&q=80")
                      )
                  )
              ),
            ),
            */

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.star,
                      color: Colors.green,
                      size: 30.0,
                    ),
                    Text('4.8',
                      style: TextStyle(color: Colors.blueGrey, fontWeight: FontWeight.bold, fontSize: 25.0),
                    ),
                    Text('   29개 리뷰',
                      style: TextStyle(color: Colors.blueGrey, fontSize: 18.0),
                    ),

                  ],
                )
                /*
                child: Text('4.8 29개 리뷰',
                  style: TextStyle(color: Colors.blueGrey, fontSize: 20.0),),
                */
              ),
            ),
            Divider(color: Colors.blueGrey, height: 10.0,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.center,
                child: Wrap(
                  spacing: 10.0,
                  children: <Widget>[
                    new IconButton(icon: new Icon(Icons.pin_drop)),
                    new IconButton(icon: new Icon(Icons.favorite)),
                    new IconButton(icon: new Icon(Icons.info)),
                    new IconButton(icon: new Icon(Icons.record_voice_over)),
                    //new IconButton(icon: new Icon(Icons.group)),
                  ]
                ),
              )
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "강의 목록",
                style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(8.0),
                color: Colors.white,
                child: ListView(
                  children: <Widget>[
                    Divider(
                      color: Colors.black,
                    ),
                    ListTile(
                      title: Text('중1 수학   월 수 금'),
                      trailing: Icon(Icons.arrow_right),
                    ),
                    Divider(
                      color: Colors.black,
                    ),
                    ListTile(
                      title: Text('고2 수학   화 목'),
                      trailing: Icon(Icons.arrow_right),
                    ),
                    
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      


    );
  }
}




class DetailScreen extends StatelessWidget {
  final List<String> litems = [
  "https://images.unsplash.com/photo-1521782462922-9318be1cfd04?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1055&q=80",
  "https://images.unsplash.com/photo-1574714802271-15a6dbfdff96?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1050&q=80",
  "https://images.unsplash.com/photo-1574643065590-89f6c555687f?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1050&q=80",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Listener(onPointerMove: (opm) {
          print("onPointerMove .. ${opm.position}");
        }, 
        child: ListView.builder(
          itemCount: litems.length,
          itemBuilder: (context, index) {
            return Container(
              padding: EdgeInsets.all(20.0),
              child: Image.network(litems[index]),
            );
          },
        )
      ),
      /*
      body: GestureDetector(
        child: Center(
          child: Hero(
            tag: 'imageHero',
            child: Image.network(
              "https://images.unsplash.com/photo-1521782462922-9318be1cfd04?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1055&q=80"
            ),
          ),
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
      */
    );
  }
}