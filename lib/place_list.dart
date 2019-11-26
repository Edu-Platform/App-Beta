import 'package:flutter/material.dart';

import 'place.dart';
import 'place_details.dart';
import 'details_page.dart';
import 'educastle_app.dart';
import 'filter_widget.dart';

class PlaceList extends StatefulWidget {
  const PlaceList({Key key}) : super(key: key);

  @override
  PlaceListState createState() => PlaceListState();
}

class PlaceListState extends State<PlaceList> {
  ScrollController _scrollController = ScrollController();

  void _onCategoryChanged(PlaceCategory newCategory) {
    _scrollController.jumpTo(0.0);
    AppState.updateWith(context, selectedCategory: newCategory);
  }

  void _onPlaceChanged(Place value) {
    // Replace the place with the modified version.
    final newPlaces = List<Place>.from(AppState.of(context).places);
    final index = newPlaces.indexWhere((place) => place.id == value.id);
    newPlaces[index] = value;

    AppState.updateWith(context, places: newPlaces);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        
        _ListCategoryButtonBar(
          selectedCategory: AppState.of(context).selectedCategory,
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 8.0),
            controller: _scrollController,
            shrinkWrap: true,
            children: AppState.of(context)
                .places
                .where((place) =>
                    place.category == AppState.of(context).selectedCategory)
                .map((place) => _PlaceListTile(
                      place: place,
                      onPlaceChanged: (value) => _onPlaceChanged(value),
                    ))
                .toList(),
          ),
        ),
      ],
    );
  }
}

class _PlaceListTile extends StatelessWidget {
  const _PlaceListTile({
    Key key,
    @required this.place,
    @required this.onPlaceChanged,
  })  : assert(place != null),
        assert(onPlaceChanged != null),
        super(key: key);

  final Place place;
  final ValueChanged<Place> onPlaceChanged;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push<void>(
        context,
        MaterialPageRoute(builder: (context) {
          return DetailsPage(
            place: place,
            onChanged: (value) => onPlaceChanged(value),
          );
          /*
          return PlaceDetails(
            place: place,
            onChanged: (value) => onPlaceChanged(value),
          );
          */
        }),
      ),
      child: Container(
        padding: EdgeInsets.only(top: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              place.name,
              textAlign: TextAlign.left,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
              maxLines: 3,
            ),
            Row(
              children: List.generate(5, (index) {
                return Icon(
                  Icons.star,
                  size: 28.0,
                  color: place.starRating > index
                      ? Colors.amber
                      : Colors.grey[400],
                );
              }).toList(),
            ),
            Text(
              place.description != null ? place.description : '',
              style: Theme.of(context).textTheme.subhead,
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 16.0),
            Divider(
              height: 2.0,
              color: Colors.grey[700],
            ),
          ],
        ),
      ),
    );
  }
}

class _ListCategoryButtonBar extends StatelessWidget {
  const _ListCategoryButtonBar({
    Key key,
    @required this.selectedCategory,
  })  : assert(selectedCategory != null),
        super(key: key);

  final PlaceCategory selectedCategory;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        new IconButton(
          color: Colors.blue,
          icon: new Icon(Icons.filter_list, size: 40), 
          onPressed: () => {
            Navigator.push(context, MaterialPageRoute<Null>(
              builder: (BuildContext context) {
                return FilterWidget();
              },
              fullscreenDialog: true,
            ))
          },
        ),
        new IconButton(
          color: Colors.blue,
          icon: new Icon(Icons.map, size: 40), 
          onPressed: () => {
            AppState.updateWith(
              context,
              viewType:
                  AppState.of(context).viewType == PlaceTrackerViewType.map
                      ? PlaceTrackerViewType.list
                      : PlaceTrackerViewType.map,
            )
          },
        ),
      ],
      
    );
  }
}
