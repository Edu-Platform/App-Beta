import 'package:flutter/material.dart';
import 'package:flutter_range_slider/flutter_range_slider.dart' as frs;

class FilterWidget extends StatefulWidget {

  @override
  _FilterWidgetState createState() => _FilterWidgetState();
}

class _FilterWidgetState extends State<FilterWidget> {

  int valueIndicatorMaxDecimals = 1;
  double _lowerValue = 20.0;
  double _upperValue = 80.0;
  String get lowerValueText =>
      _lowerValue.toStringAsFixed(valueIndicatorMaxDecimals);
  String get upperValueText =>
      _upperValue.toStringAsFixed(valueIndicatorMaxDecimals);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("검색 조건"),
        actions: <Widget>[
          FlatButton(
              child: Text('초기화', style: TextStyle(fontSize: 14)),
              onPressed: () => print('FlatButton'),
              color: Colors.transparent,
              textColor: Colors.white,
          ),
        ],
      ),
      body: new Container(
        padding: EdgeInsets.all(8.0),
        child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: _titleContainer("과목"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left:8.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    child: Wrap(
                      spacing: 5.0,
                      runSpacing: 3.0,
                      children: <Widget>[
                        filterChipWidget(chipName: '수학'),
                        filterChipWidget(chipName: '영어'),

                      ],
                    )
                  ),
                ),
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
                  new Checkbox(
                    value: false,
                    onChanged: (bool value) {
                      setState(() {
                        print("checkbox");
                      });
                    },
                  ),
                  new Text(
                    '초등',
                    style: new TextStyle(fontSize: 16.0),
                  ),
                  new Checkbox(
                    value: false,
                    onChanged: (bool value) {
                      setState(() {
                        print("checkbox");
                      });
                    },
                  ),
                  new Text(
                    '중등',
                    style: new TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                  new Checkbox(
                    value: true,
                    onChanged: (bool value) {
                      setState(() {
                        print("checkbox");
                      });
                    },
                  ),
                  new Text(
                    '고등',
                    style: new TextStyle(fontSize: 16.0),
                  ),
                ],
              ),
              new Divider(height: 5.0, color: Colors.black),
              new Padding(
                padding: new EdgeInsets.all(8.0),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: _titleContainer("비용"),
                ),
              ),
              Row(
                children: <Widget>[
                  Container(
                    constraints: BoxConstraints(
                      minWidth: 40.0,
                      maxWidth: 40.0,
                    ),
                    child: Text(lowerValueText),
                  ),
                  Expanded(
                    child: frs.RangeSlider(
                      min: 0.0,
                      max: 100.0,
                      lowerValue: _lowerValue,
                      upperValue: _upperValue,
                      divisions: 100,
                      showValueIndicator: true,
                      valueIndicatorMaxDecimals: 1,
                      onChanged: (double newLowerValue, double newUpperValue) {
                        setState(() {
                          _lowerValue = newLowerValue;
                          _upperValue = newUpperValue;
                        });
                      },
                      onChangeStart:
                          (double startLowerValue, double startUpperValue) {
                        print(
                            'Started with values: $startLowerValue and $startUpperValue');
                      },
                      onChangeEnd: (double newLowerValue, double newUpperValue) {
                        print(
                            'Ended with values: $newLowerValue and $newUpperValue');
                      },
                    ),
                  ),
                  Container(
                    constraints: BoxConstraints(
                      minWidth: 40.0,
                      maxWidth: 40.0,
                    ),
                    child: Text(upperValueText),
                  ),
                ],
              ),
              new Divider(height: 5.0, color: Colors.black),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: _titleContainer("시간"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left:8.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    child: Wrap(
                      spacing: 5.0,
                      runSpacing: 3.0,
                      children: <Widget>[
                        filterChipWidget(chipName: '월'),
                        filterChipWidget(chipName: '화'),
                        filterChipWidget(chipName: '수'),
                        filterChipWidget(chipName: '목'),
                        filterChipWidget(chipName: '금'),
                        filterChipWidget(chipName: '토'),
                        filterChipWidget(chipName: '일'),
                      ],
                    )
                  ),
                ),
              ),
              new Divider(height: 5.0, color: Colors.black),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: _titleContainer("횟수"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left:8.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    child: Wrap(
                      spacing: 5.0,
                      runSpacing: 3.0,
                      children: <Widget>[
                        filterChipWidget(chipName: '주1회'),
                        filterChipWidget(chipName: '주2회'),
                        filterChipWidget(chipName: '주3회'),
                        filterChipWidget(chipName: '매일'),
                      ],
                    )
                  ),
                ),
              ),
              new Divider(height: 5.0, color: Colors.black),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: _titleContainer("정원"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left:8.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    child: Wrap(
                      spacing: 5.0,
                      runSpacing: 3.0,
                      children: <Widget>[
                        filterChipWidget(chipName: '~3명'),
                        filterChipWidget(chipName: '~10명'),
                        filterChipWidget(chipName: '~20명'),
                        filterChipWidget(chipName: '~40명'),
                      ],
                    )
                  ),
                ),
              ),
            ]
        )
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(8.0),
        child: RaisedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          color: Colors.blue,
          textColor: Colors.white,
          child: Text('필터 적용'),
        ),
      ),

    );
  }
}


Widget _titleContainer(String myTitle) {
  return Text(
    myTitle,
    style: TextStyle(
        color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.bold),
  );
}
class filterChipWidget extends StatefulWidget {
  final String chipName;

  filterChipWidget({Key key, this.chipName}) : super(key: key);

  @override
  _filterChipWidgetState createState() => _filterChipWidgetState();
}

class _filterChipWidgetState extends State<filterChipWidget> {
  var _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(widget.chipName),
      labelStyle: TextStyle(color: Colors.grey,fontSize: 16.0,fontWeight: FontWeight.bold),
      selected: _isSelected,
      shape:RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
            30.0),),
      backgroundColor: Color(0xffededed),
      onSelected: (isSelected) {
        setState(() {
          _isSelected = isSelected;
        });
      },
      selectedColor: Color(0xffeadffd),);
  }
}


