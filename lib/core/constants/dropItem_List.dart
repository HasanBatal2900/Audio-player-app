import 'package:flutter/material.dart';

List<DropdownMenuItem<String>> drops = const [
  DropdownMenuItem(
    alignment: Alignment.center,
    value: "0.5",
    child: Text(
      "0.5 X",
      style: TextStyle(color: Colors.white, fontSize: 18),
    ),
  ),
  DropdownMenuItem(
    alignment: Alignment.center,
    value: "1",
    child: Text(
      "1.0 X ",
      style: TextStyle(color: Colors.white, fontSize: 18),
    ),
  ),
  DropdownMenuItem(
    alignment: Alignment.center,
    value: "2",
    child: Text(
      "2.0 X ",
      style: TextStyle(color: Colors.white, fontSize: 18),
    ),
  ),
  DropdownMenuItem(
    alignment: Alignment.center,
    value: "4",
    child: Text(
      "4.0 X ",
      style: TextStyle(color: Colors.white, fontSize: 18),
    ),
  )
];

Map<String, double> speedRate = {"0.5": 0.5, "1": 1.0, "2": 2.0, "4": 4.0};
