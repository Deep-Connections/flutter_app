import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

final logger = Logger(
  printer: PrettyPrinter(methodCount: 1, colors: false, printEmojis: false),
  level: kReleaseMode ? Level.warning : Level.debug,
);
