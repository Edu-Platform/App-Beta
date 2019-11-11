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

  Widget _detailsBody() {
    return ListView(
      padding: const EdgeInsets.fromLTRB(24.0, 12.0, 24.0, 12.0),
      scrollDirection: Axis.vertical,
      children: <Widget>[
        //Image.network("https://www.youtube.com/redirect?v=6C5qvdUEfNc&event=video_description&q=https%3A%2F%2Fimages.unsplash.com%2Fphoto-1503875154399-95d2b151e3b0%3Fixlib%3Drb-1.2.1%26auto%3Dformat%26fit%3Dcrop%26w%3D500%26q%3D60&redir_token=cAXnWGhz5ucMoGH0fggTQp2Q4WB8MTU3MzU0MDE3NkAxNTczNDUzNzc2"),
        Card1(),
      ],

    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${_place.name}'),
        backgroundColor: Colors.green[700],
        
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: _detailsBody(),
      ),
    );
  }
}

const loremIpsum = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.";

class Card1 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    buildImg(Color color, double height) {
      return SizedBox(
        height: height,
        child: Container(
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.rectangle,
          ),
        )
      );
    }

    buildCollapsed1() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("Expandable",
                  style: Theme.of(context).textTheme.body1,
                ),
              ],
            ),
          ),
        ]
      );
    }

    buildCollapsed2() {
      return buildImg(Colors.lightGreenAccent, 150);
    }

    buildCollapsed3() {
      return Container();
    }

    buildExpanded1() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("Expandable",
                  style: Theme.of(context).textTheme.body1,
                ),
                Text("3 Expandable widgets",
                  style: Theme.of(context).textTheme.caption,
                ),
              ],
            ),
          ),
        ]
      );
    }

    buildExpanded2() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: buildImg(Colors.lightGreenAccent, 100)
              ),
              Expanded(
                child: buildImg(Colors.orange, 100)
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: buildImg(Colors.lightBlue, 100)
              ),
              Expanded(
                child: buildImg(Colors.cyan, 100)
              ),
            ],
          ),
        ],
      );
    }

    buildExpanded3() {
      return Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(loremIpsum, softWrap: true,),
          ],
        ),
      );
    }


    return ExpandableNotifier(
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
        child: ScrollOnExpand(
          child: Card(
            clipBehavior: Clip.antiAlias,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expandable(
                  collapsed: buildCollapsed1(),
                  expanded: buildExpanded1(),
                ),
                Expandable(
                  collapsed: buildCollapsed2(),
                  expanded: buildExpanded2(),
                ),
                Expandable(
                  collapsed: buildCollapsed3(),
                  expanded: buildExpanded3(),
                ),
                Divider(height: 1,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Builder(
                      builder: (context) {
                        var controller = ExpandableController.of(context);
                        return FlatButton(
                          child: Text(controller.expanded ? "COLLAPSE": "EXPAND",
                            style: Theme.of(context).textTheme.button.copyWith(
                              color: Colors.deepPurple
                            ),
                          ),
                          onPressed: () {
                            controller.toggle();
                          },
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      )
    );
  }
}