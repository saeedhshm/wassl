
import 'dart:developer';

import 'package:flutter/foundation.dart';

void println(dynamic object,[String name = '⁉️⁉️']){
  if (kDebugMode) {
    // print(object);
    log('$object',name:name);
  }
}