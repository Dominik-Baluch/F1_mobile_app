import 'dart:async';
import 'package:flutter/material.dart';

class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  int _days;
  int _hours;
  int _minutes;
  int _seconds;
  Timer _timer;

  void _updateDisplayTimeImpl() {
    DateTime now = DateTime.now();
    DateTime start = DateTime.utc(2023, 3, 5, 15, 0, 0);

    var diff = start.difference(now);

    _days = diff.inDays;
    _hours = diff.inHours % 24;
    _minutes = diff.inMinutes % 60;
    _seconds = diff.inSeconds % 60;
  }

  void _updateDisplayTime() {
    setState(() {
      _updateDisplayTimeImpl();
    });
  }

  String _pad(int num) {
    if (num < 10) {
      return "0" + num.toString();
    }

    return num.toString();
  }

  @override
  void initState() {
    super.initState();

    _updateDisplayTimeImpl();

    _timer = new Timer.periodic(
        Duration(milliseconds: 200), (Timer timer) => _updateDisplayTime());
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(
            child: Column(
      children: [
        Padding(
            padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
            child: Text(
              "The season starts in",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            )),
        Padding(
            padding: EdgeInsets.fromLTRB(0, 14, 0, 0),
            child: Text(
              _pad(_days) +
                  ":" +
                  _pad(_hours) +
                  ":" +
                  _pad(_minutes) +
                  ":" +
                  _pad(_seconds),
              style: TextStyle(
                  fontSize: 37,
                  fontWeight: FontWeight.w700,
                  fontFamily: "monospace"),
            )),
        Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 6),
            child: Row(
              children: [
                Padding(
                    padding: EdgeInsets.fromLTRB(28, 0, 12, 0),
                    child: Text(
                      "DAYS",
                      style: TextStyle(
                          fontSize: 11, color: Color.fromRGBO(50, 50, 50, 1)),
                    )),
                Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 16, 0),
                    child: Text(
                      "HOURS",
                      style: TextStyle(
                          fontSize: 11, color: Color.fromRGBO(70, 70, 70, 1)),
                    )),
                Padding(
                    padding: EdgeInsets.fromLTRB(12, 0, 16, 0),
                    child: Text(
                      "MINUTES",
                      style: TextStyle(
                          fontSize: 11, color: Color.fromRGBO(70, 70, 70, 1)),
                    )),
                Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                    child: Text(
                      "SECONDS",
                      style: TextStyle(
                          fontSize: 11, color: Color.fromRGBO(70, 70, 70, 1)),
                    ))
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            )),
        Padding(
            padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
            child:
                Image.network("https://i.ibb.co/8BcG28Z/f1-2023-calendar.jpg")),
      ],
    )));
  }
}
