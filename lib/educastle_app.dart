import 'package:flutter/material.dart';

import 'home_screen.dart';
import 'map_screen.dart';

import 'app_model.dart';
import 'place.dart';
import 'stub_data.dart';

enum PlaceTrackerViewType {
  map,
  list,
}

class EduCastleApp extends StatefulWidget {

@override
  _EduCastleState createState() => _EduCastleState();

}

class _EduCastleState extends State<EduCastleApp> {
  AppState appState = AppState();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Educastle',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      builder: (context, child) {
        return AppModel<AppState>(
          initialState: AppState(),
          child: child,
        );
      },
      home: EduCastleHome(title: 'Edu'),
    );
  }

}


class EduCastleHome extends StatefulWidget {
  EduCastleHome({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _EduCastleHomeState createState() => _EduCastleHomeState();
}

class _EduCastleHomeState extends State<EduCastleHome>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, initialIndex: 0, length: 2);
    _tabController.addListener(() {
      setState(() {});
    });
  }
  
  @override
  Widget build(BuildContext context) {
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          tabs: <Widget>[
            Tab(
              text: "홈화면",
            ),
            Tab(
              text: "찾기",
            ),
          ],
        ),
        actions: <Widget>[
          Icon(Icons.search),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
          ),
          Icon(Icons.notifications),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
          ),
          Icon(Icons.more_vert)
        ],
      ),
      body: TabBarView(
        physics: NeverScrollableScrollPhysics(),
        controller: _tabController,
        children: <Widget>[
          HomeScreen(),
          MapScreen(),
        ],
      ),

    );
  }
}


class AppState {
  const AppState({
    this.places = StubData.places,
    this.selectedCategory = PlaceCategory.favorite,
    this.viewType = PlaceTrackerViewType.map,
  })  : assert(places != null),
        assert(selectedCategory != null);

  final List<Place> places;
  final PlaceCategory selectedCategory;
  final PlaceTrackerViewType viewType;

  AppState copyWith({
    List<Place> places,
    PlaceCategory selectedCategory,
    PlaceTrackerViewType viewType,
  }) {
    return AppState(
      places: places ?? this.places,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      viewType: viewType ?? this.viewType,
    );
  }

  static AppState of(BuildContext context) => AppModel.of<AppState>(context);

  static void update(BuildContext context, AppState newState) {
    AppModel.update<AppState>(context, newState);
  }

  static void updateWith(
    BuildContext context, {
    List<Place> places,
    PlaceCategory selectedCategory,
    PlaceTrackerViewType viewType,
  }) {
    update(
      context,
      AppState.of(context).copyWith(
        places: places,
        selectedCategory: selectedCategory,
        viewType: viewType,
      ),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    return other is AppState &&
        other.places == places &&
        other.selectedCategory == selectedCategory &&
        other.viewType == viewType;
  }

  @override
  int get hashCode => hashValues(places, selectedCategory, viewType);
}

