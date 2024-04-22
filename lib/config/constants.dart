import 'dart:io';

import 'package:flutter/material.dart';

const String appName = "Smetter";

_isTest() {
  try {
    return Platform.environment.containsKey('FLUTTER_TEST');
  } catch (e) {
    return false;
  }
}

final isTest = _isTest();

const standardPadding = 16.0;

// bottom navigation bar
const bottomBarIconSize = 32.0; // default 24

// Chat
const matchImageSize = 40.0;

const roundedBorderRadius = Radius.circular(18);

const maxScreenWidth = 800.0;
const imageCompression = 50;
