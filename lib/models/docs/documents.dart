import 'document.dart';

class Documents {
  bool? success;
  List<Document> documents = <Document>[];

  Documents({this.success, });

  Documents.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['documents'] != null) {

      json['documents'].forEach((v) {
        documents.add(Document.fromJson(v));
      });
    }
  }

}

