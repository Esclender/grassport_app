import 'dart:async';

import 'package:flutter/material.dart';
import 'package:grassport_app/presentation/styles/colors.dart';

class CountdownTimer extends StatefulWidget {
  final int durationInSeconds;
  final Function onFinish;

  CountdownTimer({required this.durationInSeconds, required this.onFinish});

  @override
  _CountdownTimerState createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer> {
  late Timer _timer;
  late int _secondsRemaining;

  @override
  void initState() {
    super.initState();
    _secondsRemaining = widget.durationInSeconds;

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        setState(() {
          _secondsRemaining--;
        });
      } else {
        _timer.cancel();
        widget.onFinish();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      'Codigo expira en $_secondsRemaining segundos',
      style: TextStyle(fontSize: 15, color: c1),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
