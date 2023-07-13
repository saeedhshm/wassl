const String logoAppHeroTag = "logoAppHeroTag";
const String appStorageEmail = "appStorageEmail";
const String appStoragePassword = "appStoragePassword";


Map<String, int> arabicNumbers = {
  "٠": 0,
  "١": 1,
  "٢": 2,
  "٣": 3,
  "٤": 4,
  "٥": 5,
  "٦": 6,
  "٧": 7,
  "٨": 8,
  "٩": 9
};

String replaceArabicNumbers(String text) {
  return text.replaceAllMapped(RegExp(r'\b٠|١|٢|٣|٤|٥|٦|٧|٨|٩\b'), (match) {
    return arabicNumbers[match.group(0)].toString();
  });
}


Map<String, String> englishNumbers = {
  "0": "٠",
  "1": "١",
  "2": "٢",
  "3": "٣",
  "4": "٤",
  "5": "٥",
  "6": "٦",
  "7":  "٧",
  "8": "٨",
  "9": "٩"
};

// String replaceEnglishNumbers(String text) {
//   return text.replaceAllMapped(RegExp(r'\b0|1|2|3|4|5|6|7|8|9\b'), (match) {
//     return englishNumbers[match.group(0)].toString();
//   });
// }

String arabicNumber = "1234567890";
String farsiNumber = arabicNumber.replaceAll("0", "۰")
    .replaceAll("1", "١")
    .replaceAll("2", "٢")
    .replaceAll("3", "٣")
    .replaceAll("4", "٤")
    .replaceAll("5", "٥")
    .replaceAll("6", "٦")
    .replaceAll("7", "٧")
    .replaceAll("8", "٨")
    .replaceAll("9", "٩");
String replaceEnglishNumbers(englishNumber) {
  // TODO: implement print
  return englishNumber.replaceAll("0", "۰")
      .replaceAll("1", "١")
      .replaceAll("2", "٢")
      .replaceAll("3", "٣")
      .replaceAll("4", "٤")
      .replaceAll("5", "٥")
      .replaceAll("6", "٦")
      .replaceAll("7", "٧")
      .replaceAll("8", "٨")
      .replaceAll("9", "٩");
} // Output: ۱۲۳۴۵۶۷۸۹۰

String replaceFarsiNumber(String input) {
  const english = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
  const farsi = ['۰', '۱', '۲', '۳', '۴', '۵', '۶', '۷', '۸', '۹'];

  for (int i = 0; i < english.length; i++) {
    input = input.replaceAll(english[i], farsi[i]);
  }

  return input;
}