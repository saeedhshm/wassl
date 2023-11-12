
import 'dart:convert';

import 'package:wassl/helpers/constants/print_ln.dart';

import '../web_services_helper/api.dart';
import '../web_services_helper/urls.dart';

class WorkTripCostController {

  Future<TripCost?> getAllCountries({
    required String startDate,
    required String endDate,
    required String countryId,
    required String cityId,
    required Map<String,String> header
  }) async {

    var response = await AppApiHandler.getData(url: '${AppUrls.apiVrsion}/city-ajax?start=$startDate&end=$endDate&country=$countryId&city=$cityId',header: header);


    if(response.statusCode == 200){

      var json = jsonDecode(response.body);

      return TripCost.fromJson(json);
    }

    return null;
  }
}


/*

{
  "0": 200,
  "success": true,
  "trip": {
    "id": 1,
    "company_id": 1,
    "country_id": 191,
    "region_id": 1,
    "cost_per_day": 600,
    "created_at": "2023-08-03T08:51:24.000000Z",
    "updated_at": "2023-08-03T08:51:24.000000Z"
  },
  "days": 7,
  "totalCost": 4200
}
 */
class TripCost {

  bool? success;
  Trip? trip;
  int? days;
  int? totalCost;

  TripCost({ this.success, this.trip, this.days, this.totalCost});

  TripCost.fromJson(Map<String, dynamic> json) {

    success = json['success'];
    trip = json['trip'] != null ? Trip.fromJson(json['trip']) : null;
    days = json['days'];
    totalCost = json['totalCost'];
  }

}

class Trip {
  int? id;
  int? companyId;
  int? countryId;
  int? regionId;
  int? costPerDay;
  String? createdAt;
  String? updatedAt;

  Trip(
      {this.id,
        this.companyId,
        this.countryId,
        this.regionId,
        this.costPerDay,
        this.createdAt,
        this.updatedAt});

  Trip.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    companyId = json['company_id'];
    countryId = json['country_id'];
    regionId = json['region_id'];
    costPerDay = json['cost_per_day'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }


}
