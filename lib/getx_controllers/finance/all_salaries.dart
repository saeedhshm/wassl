
import 'package:get/get.dart';
import 'package:wassl/getx_controllers/finance/salary_month_view_model.dart';
import 'package:wassl/models/finance/salaries.dart';

import '../../controllers/salaries_controller.dart';
import '../../web_services_helper/urls.dart';
import '../app_controller.dart';

class AllSalariesViewModel extends GetxController{
  final AppController appController = Get.find();
  var loading = false.obs;

  Salaries? _allSalaries;

  List<SalaryOfMonthViewModel> _salariesViewModelList = [];


  Future<void> _getAllSalaries() async {
    var headers = {
      'Authorization':
      'bearer ${appController.loginModel.value.token?.accessToken}',
      // "x-localization": 'lang_code'.tr,
    };


    loading.value = true;

    final url = '${AppUrls.salaryMonthsApi}/${appController.loginModel.value.user?.id}';

    _allSalaries = await SalariesController().getAllSalaries(url, headers);
    _salariesViewModelList = _allSalaries?.salaries.map((e) => SalaryOfMonthViewModel(e)).toList() ?? [];

    loading.value = false;
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _getAllSalaries();
  }

  String get baseSalary{
    return '${_allSalaries?.employee?.salary} ' + 'SR'.tr;
  }

  List<SalaryOfMonthViewModel> get salaries{
    return _salariesViewModelList;
  }
}