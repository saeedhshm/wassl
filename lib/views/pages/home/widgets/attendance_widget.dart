import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
import 'package:wassl/helpers/constants/print_ln.dart';
import 'package:wassl/helpers/exceptions/no_internet.dart';

import '../../../../getx_controllers/app_controller.dart';
import '../../../../getx_controllers/home/home_controller.dart';
import '../../../../helpers/constants/app_colors.dart';
import '../../../../helpers/exceptions/location_exceptions.dart';
import '../../../consts_widgets/loading_widgets.dart';
import '../../../reusable_widgets/circular_widget.dart';
import '../../../reusable_widgets/snack_bars.dart';
import 'attendance_info_widget.dart';

class AttendanceWidget extends StatefulWidget {

  AttendanceWidget({Key? key}) : super(key: key);

  @override
  State<AttendanceWidget> createState() => _AttendanceWidgetState();
}

class _AttendanceWidgetState extends State<AttendanceWidget> {



  final HomeController controller = Get.find();

  final LocalAuthentication auth = LocalAuthentication();
  AppController appController = Get.find<AppController>();

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
          // !appController.isHolidayDay ?
          child:  !appController.isHolidayDay ? Obx(() =>IgnorePointer(
            ignoring: controller.attendanceStatus.value == 3 ||
                controller.sendingAttendance.value,
            // ignoring: false,
            child: InkWell(
              onTap: () async {
                // println(appController.isHolidayDay);
                // return;
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
                         var availableBiometrics = await _getAvailableBiometrics();
                         var canUseBiometric = await _checkBiometrics();
                         if(canUseBiometric){
                           if(availableBiometrics.isEmpty){
                             await attend();
                           }else{
                             _authenticateWithBiometrics();
                           }
                         }else{
                           await attend();
                         }
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
                  : AttendanceInfoWidget(),
            ),
          ) ):
          Center(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Text('today_holiday'.tr,style: const TextStyle(
                  color: AppColors.darkGreyTextColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold)),
            ),
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
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

  Future<bool> _checkBiometrics() async {
    bool canCheckBiometrics = false;
    try {
      canCheckBiometrics = await auth.canCheckBiometrics;
      println('can use Biometrics $canCheckBiometrics');
    } on PlatformException catch (e) {
      canCheckBiometrics = false;
      print(e);
    }
    if (!mounted) {
      return canCheckBiometrics;
    }

    setState(() {
      _canCheckBiometrics = canCheckBiometrics;
    });
    return canCheckBiometrics;
  }

  Future<List<BiometricType>> _getAvailableBiometrics() async {
     List<BiometricType> availableBiometrics = [];
    try {
      availableBiometrics = await auth.getAvailableBiometrics();
    } on PlatformException catch (e) {
      availableBiometrics = <BiometricType>[];
      print(e);
    }
    if (!mounted) {
      return availableBiometrics;
    }

    println(availableBiometrics);

     return availableBiometrics;
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
          biometricOnly: false,
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
        println('=-==-=-= cant authenticated');
        SnackBars.showErrorSnackBar('error'.tr, 'try again'.tr);
      }
      // await attend();
    } on PlatformException catch (e) {
      SnackBars.showErrorSnackBar('error'.tr, 'try again'.tr);
      println('=-==-=-= $e');
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