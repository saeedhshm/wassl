import 'package:wassl/helpers/extensions/strings_extensions.dart';

extension DateTimeInString on DateTime{

  String get timeIn12Hours{

    return getTimeFormatOf12hours(of: this) ?? '';
  }
}