import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:wassl/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:wassl/helpers/constants/app_colors.dart';
import 'package:wassl/helpers/constants/string_constants.dart';
import 'package:wassl/views/consts_widgets/loading_widgets.dart';
import 'package:wassl/views/pages/main_tabs_page.dart';
import 'package:wassl/views/reusable_widgets/custom_text_form_field.dart';
import 'package:wassl/views/reusable_widgets/localized_text.dart';
import 'package:wassl/views/reusable_widgets/main_button.dart';
import 'package:wassl/views/reusable_widgets/main_title_text.dart';
import 'package:wassl/views/reusable_widgets/svg_widget.dart';

class CubitLoginPage extends StatefulWidget {
  const CubitLoginPage({super.key});

  @override
  State<CubitLoginPage> createState() => _CubitLoginPageState();
}

class _CubitLoginPageState extends State<CubitLoginPage> {
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  bool _securePassword = true;

  @override
  void initState() {
    super.initState();
    _emailCtrl.text = 'test2@waslhr.com';
    _passwordCtrl.text = '1234567';
  }

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  void _login() {
    context.read<AuthCubit>().login(
          email: _emailCtrl.text.trim(),
          password: _passwordCtrl.text,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        width: double.infinity,
        height: double.infinity,
        color: AppColors.mainBackgroundColor,
        child: SingleChildScrollView(
          child: BlocConsumer<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state is AuthAuthenticated) {
                Get.offAll(() => const MainTabsPage(), duration: Duration.zero);
              } else if (state is AuthError) {
                Get.snackbar(
                  'error'.tr,
                  state.failure.message,
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.red.shade100,
                );
              }
            },
            builder: (context, state) {
              final isLoading = state is AuthLoading;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 60),
                  Hero(
                    tag: logoAppHeroTag,
                    child: AnimatedContainer(
                      width: 130,
                      height: 50,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.fastOutSlowIn,
                      child: const SvgWidget("assets/images/wasl.svg"),
                    ),
                  ),
                  const SizedBox(height: 30),
                  const LocalizedText(
                    "welcome_to_wasl",
                    textStyle: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const LocalizedText(
                    "you_can_enter_to_account",
                    textStyle: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                  const SizedBox(height: 50),
                  const SizedBox(
                    width: double.infinity,
                    child: MainTitleText("email_or_job_number"),
                  ),
                  CustomTextFormField(
                    hintText: 'email_address@email.com',
                    labelText: null,
                    controller: _emailCtrl,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 20),
                  const SizedBox(
                    width: double.infinity,
                    child: MainTitleText("password"),
                  ),
                  CustomTextFormField(
                    hintText: '**********',
                    labelText: null,
                    secureText: _securePassword,
                    controller: _passwordCtrl,
                    suffixIcon: InkWell(
                      onTap: () {
                        _securePassword = !_securePassword;
                        setState(() {});
                      },
                      child: Icon(
                        _securePassword
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: AppColors.lightGreyTextColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 120),
                  isLoading
                      ? const Center(child: SendingLoadingWidget())
                      : MainButtonWidget(
                          btnTitle: 'login',
                          onPressed: _login,
                        ),
                  const SizedBox(height: 20),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
