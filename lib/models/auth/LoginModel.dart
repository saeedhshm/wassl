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



  String get timeIn {
    return (user?.schedule?.info?.timeIn ?? '').formattedTime() ?? '---';
  }

  String get timeOut {
    return (user?.schedule?.info?.timeOut ?? '').formattedTime() ?? '---';
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

}








