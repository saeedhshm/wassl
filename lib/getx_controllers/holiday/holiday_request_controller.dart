import 'dart:convert';

import 'package:get/get.dart';
import 'package:wassl/getx_controllers/app_controller.dart';
import 'package:wassl/helpers/exceptions/custom_exception.dart';
import 'package:wassl/helpers/exceptions/date_exceptions.dart';
import 'package:wassl/helpers/exceptions/no_internet.dart';
import 'package:wassl/models/orders/order_type.dart';
import 'package:wassl/web_services_helper/api.dart';
import 'package:wassl/web_services_helper/urls.dart';

import '../../controllers/countries.dart';
import '../../controllers/work_trip_controller.dart';
import '../../helpers/constants/print_ln.dart';
import '../../models/countries/city.dart';
import '../../models/countries/country.dart';
import '../orders/order_types_controller.dart';

class HolidayRequestController extends GetxController{

  final AppController appController = Get.find();

  DateTime? startDate;
  DateTime? endDate;
  var orderTypes = OrderTypesRetriever().obs;
  OrderType? selectedType;

  String? filePath;
  var loadingHolidayTypes = false.obs;
  var loading = false.obs;


  String? holidayReason;

  var countries = <Country>[].obs;
  Country? selectedCountry;
  var loadingCountries = false.obs;

  var cities = <City>[].obs;
  City? selectedCity;
  var loadingCities = false.obs;
  var tripCost = TripCost().obs;



  var errorsList = <String>[].obs;

 var differenceInDays = ''.obs;



  Future sendHolidayRequest() async {




    if(selectedType == null){
      throw ChooseTypeException();
    }

    if(loadingCountries.value){
      if(selectedCountry == null){
        throw CustomException(errorMessage: 'choose_country_for_trip');
      }

      if(selectedCity == null){
        throw CustomException(errorMessage: 'choose_city_for_trip');
      }

    }


    if(startDate == null){
      throw StartDateException();
    }
    if(endDate == null){
      throw EndDateException();
    }


    if(holidayReason == null || holidayReason?.trim() == ''){
      throw EnterReasonException();
    }

    // body parameters

    var body = {
      'type':'${selectedType?.id}',
      'holiday_start':'${startDate?.year}-${startDate?.month}-${startDate?.day}',
      'holiday_end':'${endDate?.year}-${endDate?.month}-${endDate?.day}',
      'reason':'$holidayReason',
      'country':'${selectedCountry?.id}',
      'city':'${selectedCity?.id}'
    };


  var response = await  AppApiHandler.postDataWithFile(url: '${AppUrls.addHolidayRequest}', body: body,header: appController.appHeader,fileName: filePath);


  if(response.statusCode != 200){
    errorsList.addAll(appController.listOfErrors);
    errorsList.add('body: $body');
    errorsList.add('url: ${AppUrls.addHolidayRequest}d');
    errorsList.add('response.statusCode: ${response.statusCode}');
    errorsList.add('response.body: ${await response.stream.bytesToString()}');
    throw NoDataAvailableException();
  }
  }

  Future updateRequest(String orderId) async{
    if(selectedType == null){
      throw ChooseTypeException();
    }

    if(loadingCountries.value){
      if(selectedCountry == null){
        throw CustomException(errorMessage: 'choose_country_for_trip');
      }

      if(selectedCity == null){
        throw CustomException(errorMessage: 'choose_city_for_trip');
      }

    }

    if(startDate == null){
      throw StartDateException();
    }
    if(endDate == null){
      throw EndDateException();
    }
    if(holidayReason == null || holidayReason?.trim() == ''){
      throw EnterReasonException();
    }

    // body parameters

    var body = {
      'type':'${selectedType?.id}',
      'holiday_start':'${startDate?.year}-${startDate?.month}-${startDate?.day}',
      'holiday_end':'${endDate?.year}-${endDate?.month}-${endDate?.day}',
      'reason':'$holidayReason',
      'country':'${selectedCountry?.id}',
      'city':'${selectedCity?.id}'
    };

    var response = await  AppApiHandler.postDataWithFile(url: '${AppUrls.updateHolidayRequest}/$orderId', body: body,header: appController.appHeader,fileName: filePath);

    println(body);
    println('${AppUrls.updateHolidayRequest}/$orderId');
    println(response.statusCode);
    println(await response.stream.bytesToString());
    if(response.statusCode != 200){
      errorsList.addAll(appController.listOfErrors);
      errorsList.add('body: $body');
      errorsList.add('url: ${AppUrls.updateHolidayRequest}/$orderId');
      errorsList.add('response.statusCode: ${response.statusCode}');
      errorsList.add('response.body: ${await response.stream.bytesToString()}');
      throw NoDataAvailableException();
    }
  }

  Future cancelRequest(String orderId) async{


    var response = await  AppApiHandler.putData(url: '${AppUrls.cancelHolidayRequest}/$orderId',header: appController.appHeader, );

    if(response.statusCode != 200){
      errorsList.addAll(appController.listOfErrors);
      // errorsList.add('body: $body');
      errorsList.add('url: ${AppUrls.addHolidayRequest}d');
      errorsList.add('response.statusCode: ${response.statusCode}');
      errorsList.add('response.body: ${await response.body}');
      throw NoDataAvailableException();
    }
  }

  getHolidaysTypes() async  {

    loadingHolidayTypes.value = true;
    var response = await AppApiHandler.getData(url: AppUrls.getHolidayTypes,header: appController.appHeader);

    if(response.statusCode == 200){
      var json = jsonDecode(response.body);
      orderTypes.value = OrderTypesRetriever.fromJson(json);
    }
    loadingHolidayTypes.value = false;

  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getHolidaysTypes();

  }


  setDifferenceInDays() async {

      String difference = '';

      final days = (endDate!.difference(startDate!).inDays + 1);
      difference = days == 1 ? 'day'.tr : days == 2 ? '2_days'.tr : days > 10 ? days.toString() + ' ' + 'day'.tr : (days.toString() + ' ' + 'days'.tr);
      differenceInDays.value = difference;

      if(selectedCity != null && selectedCountry != null && endDate != null && startDate != null){
        var tc = await WorkTripCostController().getAllCountries(
            startDate: '${startDate?.year}-${startDate?.month}-${startDate?.day}',
            endDate: '${endDate?.year}-${endDate?.month}-${endDate?.day}',
            countryId: '${selectedCountry?.id}',
            header: appController.appHeader,
            cityId: '${selectedCity?.id}');
        if(tc != null){
          tripCost.value = tc;
        }
      }

  }

  getAllCountries() async {

    countries.value = await CountriesController().getAllCountries() ?? [];

  }

  getAllCities(String countryId) async {

    cities.value = await CountriesController().getAllCities(countryId) ?? [];

  }
}