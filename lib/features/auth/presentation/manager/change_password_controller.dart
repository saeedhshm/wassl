import 'package:get/get.dart';
import 'package:wassl/features/auth/domain/use_cases/use_cases.dart';

import '../../../../helpers/constants/page_status.dart';

class ChangePasswordController extends GetxController {
  Rx<IPageStatus> pageStatus = Rx(InitialPageStatue());

  final ChangePasswordAuthUseCase useCase;
  ChangePasswordController(this.useCase);

  changePassword(
      String oldPassword, String newPassword, String confirmedPassword) {}

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }
}
