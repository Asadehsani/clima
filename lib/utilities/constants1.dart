import 'package:flutter/material.dart';

const apikey = 'af3798b95729b0b49a49ee4321692887';

const kLightColor = Colors.white;
const kMidLightColor = Colors.white60;
const kOverlayColor = Colors.white10;
const kDarkColor = Colors.white24;

const kTextFieldStyle = TextStyle(
  fontSize: 16,
  color: kMidLightColor,
);

const kLocationTextStyle = TextStyle(
  fontSize: 20,
  color: kMidLightColor,
);

const kTempTextStyle = TextStyle(
  fontSize: 80,
);

const kDatailsTextStyle = TextStyle(
  fontSize: 20,
  color: kMidLightColor,
  fontWeight: FontWeight.bold,
);

const kDatailsTitleTextStyle = TextStyle(
  fontSize: 16,
  color: kDarkColor,
);

const kTextFieldDecoration = InputDecoration(
  fillColor: kOverlayColor,
  filled: true,
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10)),
    borderSide: BorderSide.none,
  ),
  hintText: 'Enter City Name',
  hintStyle: kTextFieldStyle,
  prefixIcon: Icon(Icons.search),
);