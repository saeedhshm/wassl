import 'package:wassl/helpers/extensions/strings_extensions.dart';
import 'package:wassl/models/auth/user.dart';

class LoginModel {
  bool? success;
  Token? token;
  User? user;

  LoginModel({this.success, this.token, this.user});

  fromJson(Map<String, dynamic> json) {
    success = json['success'];
    token = json['token'] != null ? new Token.fromJson(json['token']) : null;
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.token != null) {
      data['token'] = this.token!.toJson();
    }
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }

  String get timeIn {
    return (user?.schedule?.info?.timeIn ?? '').formatedTime();
  }

  String get timeOut {
    return (user?.schedule?.info?.timeOut ?? '').formatedTime();
  }
}

class Token {
  String? accessToken;
  String? tokenType;
  int? expiresIn;

  Token({this.accessToken, this.tokenType, this.expiresIn});

  Token.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    tokenType = json['token_type'];
    expiresIn = json['expires_in'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['access_token'] = this.accessToken;
    data['token_type'] = this.tokenType;
    data['expires_in'] = this.expiresIn;
    return data;
  }
}








