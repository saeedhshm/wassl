import 'dart:convert';

import 'package:get/get.dart';
import 'package:wassl/models/orders/AllOrders.dart';
import 'package:wassl/web_services_helper/api.dart';
import 'package:wassl/web_services_helper/urls.dart';

import '../../helpers/exceptions/no_internet.dart';
import '../../views/pages/orders/previous_orders/page.dart';
import '../app_controller.dart';

class PreviousRequestsController extends GetxController {
  late final previousRequests = AllOrders(appController).obs;
  late final previousTeamRequests = AllOrders(appController).obs;
  int myOrdersPage = 1;
  int teamOrdersPage = 1;

  List myOrders = <Order>[].obs;
  List teamOrders = <Order>[].obs;

  bool firstRun = true;
  var hasTeamRequests = false.obs;

  List menuItems = [
    ListItem('all_orders', 0, true),
    ListItem('await_status', 1, false),
    ListItem('approved', 2, false),
    ListItem('disapproved', 3, false),
    ListItem('pending', 4, false),
  ];

  final _groupValue = ListItem('all_orders', 0, false).obs;
  final groupValueOfTeamOrders = ListItem('all_orders', 0, false).obs;

  final AppController appController = Get.find();

  var myOrdersSelected = true.obs;

  Future getMyOrders() async {
    var url = '${AppUrls.getAllOrders}?page=$myOrdersPage';

    url =
        '$url&status=${_groupValue.value.status != 0 ? _groupValue.value.status : _groupValue.value.status + 5}';

    // return;
    appController.loading.value = true;
    var response =
        await AppApiHandler.getData(url: url, header: appController.appHeader);
    appController.loading.value = false;
    if (response.statusCode != 200) {
      throw NoDataAvailableException();
    }
    var json = jsonDecode(response.body);
    previousRequests.value = AllOrders.fromJson(json);
    myOrders = previousRequests.value.orders;
  }

  Future getTeamOrders() async {
    var url = '${AppUrls.getTeamOrders}?page=$teamOrdersPage';
    if (groupValueOfTeamOrders.value.status != 0) {
      url = '$url&status=${groupValueOfTeamOrders.value.status}';
    }
    // url = '$url&status=${_groupValue.value.status != 0 ? _groupValue.value.status : _groupValue.value.status + 5 }';

    appController.loading.value = true;
    var response =
        await AppApiHandler.getData(url: url, header: appController.appHeader);
    appController.loading.value = false;

    // println(response.body);
    if (response.statusCode != 200) {
      throw NoDataAvailableException();
    }

    var json = jsonDecode(response.body);
    previousTeamRequests.value = AllOrders.fromJson(json);
    teamOrders = previousTeamRequests.value.orders;

    if (firstRun) {
      hasTeamRequests.value = previousTeamRequests.value.orders.isNotEmpty;

      firstRun = false;
    }
  }

  Future retrieveAllOrders() async {
    Future.delayed(Duration.zero, () async {
      try {
        await getMyOrders();
        var myOrdersUrl = '${AppUrls.getAllOrders}?page=$myOrdersPage';
        myOrdersUrl =
            '$myOrdersUrl&status=${_groupValue.value.status != 0 ? _groupValue.value.status : _groupValue.value.status + 5}';

        appController.loading.value = true;
        previousRequests.value.url = myOrdersUrl;
        previousRequests.value.appController = appController;
        myOrders = await previousRequests.value.getAllOrders();
        appController.loading.value = true;
        await getTeamOrders();
      } on NoDataAvailableException {
        //this is the catch block
      } finally {
        appController.loading.value = false;
      }
    });
  }

  ListItem get groupValue {
    return myOrdersSelected.value
        ? _groupValue.value
        : groupValueOfTeamOrders.value;
  }

  set groupValue(ListItem value) {
    if (myOrdersSelected.value) {
      _groupValue.value = value;
      getMyOrders();
    } else {
      groupValueOfTeamOrders.value = value;
      getTeamOrders();
    }
    Get.back();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _groupValue.value = menuItems[0];
    groupValueOfTeamOrders.value = menuItems[0];
  }
}
