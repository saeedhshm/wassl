// class LoansTypes {
//   bool? success;
//   List<LoanType>? data;
//   String? message;
//
//   LoansTypes({this.success, this.data, this.message});
//
//   LoansTypes.fromJson(Map<String, dynamic> json) {
//     success = json['success'];
//     if (json['data'] != null) {
//       data = <LoanType>[];
//       json['data'].forEach((v) {
//         data!.add( LoanType.fromJson(v));
//       });
//     }
//     message = json['message'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['success'] = this.success;
//     if (this.data != null) {
//       data['data'] = this.data!.map((v) => v.toJson()).toList();
//     }
//     data['message'] = this.message;
//     return data;
//   }
// }
//
// class LoanType {
//   int? id;
//   String? name;
//   String? createdAt;
//   String? updatedAt;
//
//   LoanType({this.id, this.name, this.createdAt, this.updatedAt});
//
//   LoanType.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     return data;
//   }
// }
