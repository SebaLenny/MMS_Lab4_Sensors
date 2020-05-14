import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sensors/sensors.dart';
import 'package:sensors_project/Utility/game_vector.dart';
import 'package:sensors_project/Utility/measure_size.dart';
import 'dart:core';

import 'Utility/strings.dart';

class Game extends StatefulWidget {
  final double ballRadious = 25;
  final GameVector position = GameVector(200, 200);
  final GameVector velocity = GameVector(0, 0);
  final snackBar = SnackBar(content: Text(Strings.gameFailedMessage));
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  Game();

  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> {
  Timer timer;
  List<double> _accelerometerValues;
  List<StreamSubscription<dynamic>> _streamSubscriptions =
      <StreamSubscription<dynamic>>[];
  Size playAreaSize = Size(1000, 1000);

  void updatePossition() {
    if (widget.position.x < 0 ||
        widget.position.x > playAreaSize.width ||
        widget.position.y < 0 ||
        widget.position.y > playAreaSize.height) {
      resetGame();
    }
    var x = _accelerometerValues != null ? -_accelerometerValues[0] / 20 : 0;
    var y = _accelerometerValues != null ? _accelerometerValues[1] / 20 : 0;
    setState(() {
      widget.velocity.x += x;
      widget.velocity.y += y;
      widget.velocity.x = widget.velocity.x.clamp(-10, 10);
      widget.velocity.y = widget.velocity.y.clamp(-10, 10);
      widget.position.x += widget.velocity.x;
      widget.position.y += widget.velocity.y;
    });
  }

  void resetGame() {
    widget.scaffoldKey.currentState.showSnackBar(widget.snackBar);
    widget.position.x = 200;
    widget.position.y = 200;
    widget.velocity.x = 0;
    widget.velocity.y = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: widget.scaffoldKey,
      appBar: AppBar(
        title: Text(Strings.game),
      ),
      body: MeasureSize(
          child: Container(
            child: Stack(
              children: <Widget>[
                Positioned(
                  top: widget.position.y - widget.ballRadious,
                  left: widget.position.x - widget.ballRadious,
                  child: Container(
                    height: widget.ballRadious * 2,
                    width: widget.ballRadious * 2,
                    decoration: new BoxDecoration(
                      color: Theme.of(context).accentColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                )
              ],
            ),
          ),
          onChange: (size) {
            setState(() {
              playAreaSize = size;
            });
          }),
    );
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
    for (StreamSubscription<dynamic> subscription in _streamSubscriptions) {
      subscription.cancel();
    }
  }

  @override
  void initState() {
    timer = Timer.periodic(Duration(milliseconds: 16), (Timer t) {
      updatePossition();
    });
    super.initState();
    _streamSubscriptions
        .add(accelerometerEvents.listen((AccelerometerEvent event) {
      setState(() {
        _accelerometerValues = <double>[event.x, event.y, event.z];
      });
    }));
  }
}
