import 'dart:convert';

import 'package:wassl/helpers/constants/print_ln.dart';
import 'package:wassl/models/countries/country.dart';

import '../models/countries/city.dart';
import '../web_services_helper/api.dart';
import '../web_services_helper/urls.dart';

class CountriesController {



  CountriesController();

  Future<List<Country>?> getAllCountries() async {

    var response = await AppApiHandler.getData(url: '${AppUrls.apiVrsion}/country-all',);

    if(response.statusCode == 200){

      var json = jsonDecode(response.body);

      if (json['0'] != null) {
        var countries = <Country>[];
        json['0'].forEach((v) { countries.add(Country.fromJson(v)); });

        return countries;

      }

    }

    return null;
  }

  Future<List<City>?> getAllCities(String countryId) async {

    var response = await AppApiHandler.getData(url: '${AppUrls.apiVrsion}/country-ajax?type=$countryId',);

    if(response.statusCode == 200){

      var json = jsonDecode(response.body);

      if (json['0'] != null) {
        var cities = <City>[];
        json['0'].forEach((v) { cities.add(City.fromJson(v)); });

        return cities;

      }

    }

    return null;
  }


}


