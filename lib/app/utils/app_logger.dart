import 'dart:io';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'dart:developer' as developer;

class AppLogger {
  static Future<void> error(Object error, StackTrace stack) async {
    developer.log('LOG ERROR | error: $error');
    developer.log('LOG ERROR | stack: $stack');
    if (Platform.isAndroid || Platform.isIOS) {
      await FirebaseCrashlytics.instance.recordError(error, stack);
    }
  }

  static Future<void> log(String message) async {
    developer.log('LOG | $message');
    if (Platform.isAndroid || Platform.isIOS) {
      await FirebaseCrashlytics.instance.log(message);
    }
  }
}
