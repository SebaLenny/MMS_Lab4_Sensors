import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sensors/sensors.dart';
import 'package:sensors_project/Utility/dimens.dart';

import 'Utility/dimens.dart';
import 'Utility/strings.dart';

import 'menu_drawer.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Strings.mainTitle,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: Strings.mainTitle),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<double> _accelerometerValues;
  List<double> _userAccelerometerValues;
  List<double> _gyroscopeValues;
  List<StreamSubscription<dynamic>> _streamSubscriptions =
      <StreamSubscription<dynamic>>[];

  @override
  Widget build(BuildContext context) {
    final List<String> accelerometer =
        _accelerometerValues?.map((double v) => v.toStringAsFixed(1))?.toList();
    final List<String> gyroscope =
        _gyroscopeValues?.map((double v) => v.toStringAsFixed(1))?.toList();
    final List<String> userAccelerometer = _userAccelerometerValues
        ?.map((double v) => v.toStringAsFixed(1))
        ?.toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      drawer: MenuDrawer(),
      body: Center(
          child: Column(
        children: <Widget>[
          Padding(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  Strings.sensorsList,
                  style: TextStyle(
                    fontSize: Dimens.fontPrimary,
                  ),
                ),
              ],
            ),
            padding: EdgeInsets.all(Dimens.standardDistance),
          ),
          Padding(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(Strings.accelerometer + ': $accelerometer'),
              ],
            ),
            padding: EdgeInsets.all(Dimens.standardDistance),
          ),
          Padding(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(Strings.userAccelerometer + ': $userAccelerometer'),
              ],
            ),
            padding: EdgeInsets.all(Dimens.standardDistance),
          ),
          Padding(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(Strings.gyroscope + ': $gyroscope'),
              ],
            ),
            padding: EdgeInsets.all(Dimens.standardDistance),
          ),
        ],
      )),
    );
  }

  @override
  void dispose() {
    super.dispose();
    for (StreamSubscription<dynamic> subscription in _streamSubscriptions) {
      subscription.cancel();
    }
  }

  @override
  void initState() {
    super.initState();
    _streamSubscriptions
        .add(accelerometerEvents.listen((AccelerometerEvent event) {
      setState(() {
        _accelerometerValues = <double>[event.x, event.y, event.z];
      });
    }));
    _streamSubscriptions.add(gyroscopeEvents.listen((GyroscopeEvent event) {
      setState(() {
        _gyroscopeValues = <double>[event.x, event.y, event.z];
      });
    }));
    _streamSubscriptions
        .add(userAccelerometerEvents.listen((UserAccelerometerEvent event) {
      setState(() {
        _userAccelerometerValues = <double>[event.x, event.y, event.z];
      });
    }));
  }
}
