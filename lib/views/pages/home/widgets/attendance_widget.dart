import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
import 'package:wassl/helpers/constants/print_ln.dart';
import 'package:wassl/helpers/exceptions/no_internet.dart';

import '../../../../getx_controllers/home/home_controller.dart';
import '../../../../helpers/constants/app_colors.dart';
import '../../../../helpers/exceptions/location_exceptions.dart';
import '../../../consts_widgets/loading_widgets.dart';
import '../../../reusable_widgets/circular_widget.dart';
import '../../../reusable_widgets/snack_bars.dart';

class AttendanceWidget extends StatefulWidget {

  AttendanceWidget({Key? key}) : super(key: key);

  @override
  State<AttendanceWidget> createState() => _AttendanceWidgetState();
}

class _AttendanceWidgetState extends State<AttendanceWidget> {



  final HomeController controller = Get.find();

  final LocalAuthentication auth = LocalAuthentication();
  _SupportState _supportState = _SupportState.unknown;
  bool? _canCheckBiometrics;
  List<BiometricType>? _availableBiometrics;
  String _authorized = 'Not Authorized';
  bool _isAuthenticating = false;

  @override
  void initState() {
    super.initState();
    auth.isDeviceSupported().then(
          (bool isSupported) => setState(() => _supportState = isSupported
          ? _SupportState.supported
          : _SupportState.unsupported),
    );
  }



  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Obx(() => IgnorePointer(
                // ignoring: controller.attendanceStatus.value == 3 ||
                //     controller.sendingAttendance.value,
                ignoring: false,
                child: InkWell(
                  onTap: () async {
                    controller.sendingAttendance.value = true;
                    try {
                      LocationPermission permission =
                          await controller.appController.determinePosition();
                      if (permission == LocationPermission.whileInUse) {
                        Get.defaultDialog(
                          title: controller.attendanceStatus.value == 1
                              ? 'reg_attend'.tr
                              : 'reg_leaving'.tr,
                          middleText: controller.attendanceStatus.value == 1
                              ? 'sure_to_attend?'.tr
                              : 'sure_to_leave?'.tr,
                          cancel: InkWell(
                            onTap: () {
                              Get.back();
                              controller.sendingAttendance.value = false;
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(16)),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 4, horizontal: 30),
                                  child: Text(
                                    'cancel'.tr,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                )),
                          ),
                          confirm: InkWell(
                            onTap: () async {
                              // await attend();
                              _authenticateWithBiometrics();
                              // _checkBiometrics();
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                    color: AppColors.mainGreenColor,
                                    borderRadius: BorderRadius.circular(16)),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 4, horizontal: 30),
                                  child: Text(
                                    controller.attendanceStatus.value == 1
                                        ? 'attendance'.tr
                                        : 'leaving'.tr,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                )),
                          ),
                        );
                      }
                    } on LocationDeniedException {
                      SnackBars.showErrorSnackBar('error'.tr, 'LocationDeniedException');
                    } catch (e) {
                      Get.defaultDialog(
                        title: 'location_error'.tr,
                        middleText: 'must_enable_location'.tr,
                        cancel: InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(16)),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 4, horizontal: 30),
                                child: Text(
                                  'cancel'.tr,
                                  style: const TextStyle(color: Colors.white),
                                ),
                              )),
                        ),
                        confirm: InkWell(
                          onTap: () async {
                            Get.back();
                            AppSettings.openAppSettings();
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                  color: AppColors.mainGreenColor,
                                  borderRadius: BorderRadius.circular(16)),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 4, horizontal: 30),
                                child: Text(
                                  'settings'.tr,
                                  style: const TextStyle(color: Colors.white),
                                ),
                              )),
                        ),
                      );
                    } finally {
                      controller.sendingAttendance.value = false;
                    }
                  },
                  child: controller.sendingAttendance.value
                      ? const Padding(
                          padding: EdgeInsets.all(20.0),
                          child: SendingLoadingWidget(),
                        )
                      : Row(
                          children: [
                            const SizedBox(
                              width: 16,
                            ),
                            Container(
                              child: CircularWidget(
                                  size: 50,
                                  borderWidth: 0,
                                  padding: 0,
                                  borderColor: Colors.transparent,
                                  child: Image.asset(
                                      'assets/images/profile/1.png')),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(50),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    offset: const Offset(0, 1),
                                    blurRadius: 1,
                                    spreadRadius: 0,
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    controller.attendanceStatusValue,
                                    style: const TextStyle(
                                        color: AppColors.darkGreyTextColor,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  // SizedBox(height: 10,),
                                  Text(
                                    controller.currentTime,
                                    style: const TextStyle(
                                        color: AppColors.darkGreyTextColor,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 20, left: 20, right: 20),
                              child: SizedBox(
                                width: 50,
                                child: ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(20),
                                      bottomRight: Radius.circular(20),
                                    ),
                                    child: Image.asset(
                                        'assets/images/attend_print_ic.png')),
                              ),
                            )
                          ],
                        ),
                ),
              )),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                offset: const Offset(0, 1),
                blurRadius: 5,
                spreadRadius: 0,
              )
            ],
          ),
        ),
      ],
    );
  }

  Future<void> attend() async {
    Get.back();
    try {
      var attendanceDone =
          await controller.registerAttendance();
      SnackBars.showConfirmedSnackBar(
          'success'.tr, attendanceDone);
    } on NoInternetException catch (e) {
      SnackBars.showErrorSnackBar(
          'error'.tr, e.errorMessage);
    } catch (exception) {
      var errorMessage =
          'something_wrong_try_again'.tr;
      SnackBars.showErrorSnackBar(
          'error'.tr, exception.toString());
    } finally {
      controller.sendingAttendance.value = false;
    }
  }

  Future<void> _checkBiometrics() async {
    late bool canCheckBiometrics;
    try {
      canCheckBiometrics = await auth.canCheckBiometrics;
      println('can use Biometrics $canCheckBiometrics');
    } on PlatformException catch (e) {
      canCheckBiometrics = false;
      print(e);
    }
    if (!mounted) {
      return;
    }

    setState(() {
      _canCheckBiometrics = canCheckBiometrics;
    });
  }

  Future<void> _getAvailableBiometrics() async {
    late List<BiometricType> availableBiometrics;
    try {
      availableBiometrics = await auth.getAvailableBiometrics();
    } on PlatformException catch (e) {
      availableBiometrics = <BiometricType>[];
      print(e);
    }
    if (!mounted) {
      return;
    }

    setState(() {
      _availableBiometrics = availableBiometrics;
    });
  }

  Future<void> _authenticate() async {
    bool authenticated = false;
    try {
      setState(() {
        _isAuthenticating = true;
        _authorized = 'Authenticating';
      });
      authenticated = await auth.authenticate(
        localizedReason: 'Let OS determine authentication method',
        options: const AuthenticationOptions(
          stickyAuth: true,
        ),
      );
      setState(() {
        _isAuthenticating = false;
      });
    } on PlatformException catch (e) {
      print(e);
      setState(() {
        _isAuthenticating = false;
        _authorized = 'Error - ${e.message}';
      });
      return;
    }
    if (!mounted) {
      return;
    }

    setState(
            () => _authorized = authenticated ? 'Authorized' : 'Not Authorized');
  }

  Future<void> _authenticateWithBiometrics() async {
    bool authenticated = false;
    Get.back();
    try {
      setState(() {
        _isAuthenticating = true;
        _authorized = 'Authenticating';
      });
      authenticated = await auth.authenticate(
        localizedReason:
        'Scan your fingerprint (or face or whatever) to authenticate',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
        ),
      );
      setState(() {
        _isAuthenticating = false;
        _authorized = 'Authenticating';
      });
      println('can auth $authenticated');
      if(authenticated){
        await attend();
      }else{
        SnackBars.showErrorSnackBar('error'.tr, 'try again'.tr);
      }
      // await attend();
    } on PlatformException catch (e) {
      SnackBars.showErrorSnackBar('error'.tr, 'try again'.tr);
      print(e);
      setState(() {
        _isAuthenticating = false;
        _authorized = 'Error - ${e.message}';
      });
      return;
    }
    if (!mounted) {
      return;
    }

    final String message = authenticated ? 'Authorized' : 'Not Authorized';
    setState(() {
      _authorized = message;
    });
  }

  Future<void> _cancelAuthentication() async {
    await auth.stopAuthentication();
    setState(() => _isAuthenticating = false);
  }
}
enum _SupportState {
  unknown,
  supported,
  unsupported,
}