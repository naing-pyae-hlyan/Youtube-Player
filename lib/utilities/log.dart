import 'dart:developer';
import 'package:flutter/foundation.dart';

void myLog(String tag, String msg) {
  if (kReleaseMode) {
    return;
  }
  log('$tag: $msg');
}
