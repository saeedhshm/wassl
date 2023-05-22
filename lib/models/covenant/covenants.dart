import 'covenant.dart';

class Covenants {
  bool? success;
  List<Covenant> covenants = <Covenant>[];

  Covenants({this.success, });

  Covenants.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['covenants'] != null) {

      json['covenants'].forEach((v) {
        covenants.add(Covenant.fromJson(v));
      });
    }
  }


}

