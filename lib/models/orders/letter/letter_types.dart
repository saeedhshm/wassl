// class LetterTypes {
//   bool? success;
//   List<LetterType>? data;
//   String? message;
//
//   LetterTypes({this.success, this.data, this.message});
//
//   LetterTypes.fromJson(Map<String, dynamic> json) {
//     success = json['success'];
//     if (json['data'] != null) {
//       data = <LetterType>[];
//       json['data'].forEach((v) {
//         data!.add(LetterType.fromJson(v));
//       });
//     }
//     message = json['message'];
//   }
//
//
//
//
// }
//
// class LetterType {
//   int? id;
//   String? name;
//   String? createdAt;
//   String? updatedAt;
//
//   LetterType({this.id, this.name, this.createdAt, this.updatedAt});
//
//   LetterType.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//   }
//
//
// }
