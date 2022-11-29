
import 'package:flutter/foundation.dart';

void println([dynamic object= '']){
  if (kDebugMode) {
    print(object);
  }
}