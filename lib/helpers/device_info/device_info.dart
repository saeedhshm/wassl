class DeviceInfo {
  String? deviceName;
  String? systemName;
  String? deviceModel;
  String? identifierForVendor;
  bool? isPhysicalDevice;
  String? utsnameMachine;
  String? versionSdkInt;
  String? systemVersion;
  // String? board;
  // String? brand;
  String? id;
  String? manufacturer;
  String? product;

  DeviceInfo(
      {this.deviceName,
      this.systemName,
      this.deviceModel,
      this.identifierForVendor,
      this.isPhysicalDevice,
      this.utsnameMachine,
      this.versionSdkInt,
      this.systemVersion,
      // this.board,
      // this.brand,
      this.id,
      this.manufacturer,
      this.product});

  DeviceInfo.fromMap(Map<String?, dynamic> info) {
    // iPhone
    deviceModel = info['model'];
    deviceName = info['name'];
    systemName = info['systemName'];
    isPhysicalDevice = info['isPhysicalDevice'];
    utsnameMachine = info['utsname.machine'];
    systemVersion = info['systemVersion'];
    identifierForVendor = info['identifierForVendor'];
    // android
    deviceModel = info['brand'];
    manufacturer = info['manufacturer'];
    id = info['id'];
    product = info['product'];
  }

  bool get isHuaweiPhone {
    return deviceModel?.contains('HUAWEI') ?? false;
  }
}
