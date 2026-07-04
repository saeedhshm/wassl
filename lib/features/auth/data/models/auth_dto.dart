class LoginRequestDto {
  final String email;
  final String password;

  const LoginRequestDto({required this.email, required this.password});

  Map<String, dynamic> toJson() => {'email': email, 'password': password};
}

class ChangePasswordRequestDto {
  final String currentPassword;
  final String newPassword;
  final String newConfirmPassword;

  const ChangePasswordRequestDto({
    required this.currentPassword,
    required this.newPassword,
    required this.newConfirmPassword,
  });

  Map<String, dynamic> toJson() => {
    'current_password': currentPassword,
    'new_password': newPassword,
    'new_confirm_password': newConfirmPassword,
  };
}
