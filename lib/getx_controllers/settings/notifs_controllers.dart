import 'package:get/get.dart';
import 'package:wassl/helpers/constants/print_ln.dart';
import 'package:wassl/models/notif_model.dart';

class NotifsController extends GetxController{
  var isWorkNotifs = true.obs;

  var loading = false.obs;
  var notifications = <NotifModel>[];
  static NotifsController get createInstance {
    bool test = Get.isRegistered<NotifsController>();
    if(test) {
      return Get.find<NotifsController>();
    }
    return Get.put(NotifsController());
  }

  static deleteInstance(){
    if(Get.isRegistered<NotifsController>()){
      Get.delete<NotifsController>();
    }
  }
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    loading.value = true;
    Future.delayed(Duration(seconds: 1),(){
      notifications.add(NotifModel());
      notifications.add(NotifModel());
      notifications.add(NotifModel());
      notifications.add(NotifModel());
      notifications.add(NotifModel());notifications.add(NotifModel());
      notifications.add(NotifModel());
      notifications.add(NotifModel());
      loading.value = false;
    });

  }
}