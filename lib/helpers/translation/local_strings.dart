import 'package:get/get.dart';
import 'ar.dart';
import 'en.dart';

class LocalString extends Translations {
  @override
  // TODO: implement keys
  Map<String, Map<String, String>> get keys =>
      {'en': englishString, 'ar': arabicStrings};
}
