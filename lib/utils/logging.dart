import 'package:deep_connections/config/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

getLevel() {
  if (isTest) {
    return Level.off;
  }
  if (kReleaseMode) {
    return Level.warning;
  } else {
    return Level.debug;
  }
}

final logger = Logger(
  printer: PrettyPrinter(methodCount: 1, colors: false, printEmojis: false),
  level: getLevel(),
);
