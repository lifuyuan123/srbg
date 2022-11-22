import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

class Log {
  static const bool _debug = kDebugMode;
  static final Logger _logger = Logger(
    printer: PrefixPrinter(PrettyPrinter()),
  );

  static void v(dynamic message) {
    if (_debug) {
      _logger.v(message);
    }
  }

  static void d(dynamic message) {
    if (_debug) {
      _logger.d(message);
    }
  }

  static void i(dynamic message) {
    if (_debug) {
      _logger.i(message);
    }
  }

  static void w(dynamic message) {
    if (_debug) {
      _logger.w(message);
    }
  }

  static void e(dynamic message) {
    if (_debug) {
      _logger.e(message);
    }
  }

  static void wtf(dynamic message) {
    if (_debug) {
      _logger.wtf(message);
    }
  }
}
