import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wassl/core/error/failures.dart';
import 'package:wassl/features/auth/domain/entities/auth_entities.dart';
import 'package:wassl/features/auth/domain/usecases/auth_usecases.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final LoginUseCase _loginUseCase;
  final LogoutUseCase _logoutUseCase;
  final ChangePasswordUseCase _changePasswordUseCase;
  final GetCurrentUserUseCase _getCurrentUserUseCase;
  final SaveCredentialsUseCase _saveCredentialsUseCase;

  AuthCubit({
    required LoginUseCase loginUseCase,
    required LogoutUseCase logoutUseCase,
    required ChangePasswordUseCase changePasswordUseCase,
    required GetCurrentUserUseCase getCurrentUserUseCase,
    required SaveCredentialsUseCase saveCredentialsUseCase,
  })  : _loginUseCase = loginUseCase,
        _logoutUseCase = logoutUseCase,
        _changePasswordUseCase = changePasswordUseCase,
        _getCurrentUserUseCase = getCurrentUserUseCase,
        _saveCredentialsUseCase = saveCredentialsUseCase,
        super(AuthInitial());

  Future<void> login({
    required String email,
    required String password,
    bool rememberMe = false,
  }) async {
    emit(AuthLoading());
    final result = await _loginUseCase(email: email, password: password);
    if (result.failure != null) {
      emit(AuthError(result.failure!));
    } else {
      if (rememberMe) {
        _saveCredentialsUseCase(email, password);
      }
      emit(AuthAuthenticated(result.data!));
    }
  }

  Future<void> logout() async {
    emit(AuthLoading());
    final result = await _logoutUseCase();
    if (result.failure != null) {
      emit(AuthError(result.failure!));
    } else {
      emit(AuthUnauthenticated());
    }
  }

  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    emit(AuthLoading());
    final result = await _changePasswordUseCase(
      currentPassword: currentPassword,
      newPassword: newPassword,
      confirmPassword: confirmPassword,
    );
    if (result.failure != null) {
      emit(AuthError(result.failure!));
    } else {
      emit(AuthPasswordChanged());
    }
  }

  Future<void> checkAuth() async {
    emit(AuthLoading());
    final result = await _getCurrentUserUseCase();
    if (result.failure != null) {
      emit(AuthUnauthenticated());
    } else {
      emit(AuthAuthenticated(LoginResponseEntity(user: result.data)));
    }
  }

  void resetState() => emit(AuthInitial());
}
