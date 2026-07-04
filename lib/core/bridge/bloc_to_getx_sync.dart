import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:wassl/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:wassl/getx_controllers/app_controller.dart';
import 'package:wassl/models/auth/LoginModel.dart';

class BlocToGetxSync extends StatefulWidget {
  final Widget child;

  const BlocToGetxSync({super.key, required this.child});

  @override
  State<BlocToGetxSync> createState() => _BlocToGetxSyncState();
}

class _BlocToGetxSyncState extends State<BlocToGetxSync> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        final appController = Get.find<AppController>();
        if (state is AuthAuthenticated) {
          final loginResponse = state.loginResponse;
          appController.loginModel.value.fromJson({
            'success': loginResponse.success,
            'token': {
              'access_token': loginResponse.token?.accessToken,
              'token_type': loginResponse.token?.tokenType,
              'expires_in': loginResponse.token?.expiresIn,
            },
            'user': {
              'id': loginResponse.user?.id,
              'code': loginResponse.user?.code,
              'fullName': loginResponse.user?.fullName,
              'name_en': loginResponse.user?.fullNameEn,
              'email': loginResponse.user?.email,
              'salary': loginResponse.user?.salary,
              'is_exempt_fingerprinting':
                  loginResponse.user?.isExemptFingerprinting,
              'schedule': loginResponse.user?.schedule != null
                  ? {
                      'info': {
                        'week_end_days': loginResponse.user?.schedule?.info
                            ?.weekEndDays,
                        'time_in':
                            loginResponse.user?.schedule?.info?.timeIn,
                        'time_out':
                            loginResponse.user?.schedule?.info?.timeOut,
                      },
                    }
                  : null,
              'branch': loginResponse.user?.branch != null
                  ? {
                      'id': loginResponse.user?.branch?.id,
                      'name_ar': loginResponse.user?.branch?.nameAr,
                      'name_en': loginResponse.user?.branch?.nameEn,
                    }
                  : null,
            },
          });
        } else if (state is AuthUnauthenticated) {
          appController.loginModel.value = LoginModel();
        }
      },
      child: widget.child,
    );
  }
}
