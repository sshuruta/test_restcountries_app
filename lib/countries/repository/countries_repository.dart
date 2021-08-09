import 'dart:convert';
import 'package:test_restcountries_app/countries/repository/model/country_model.dart';
import 'package:http/http.dart' as http;

class CountriesRepository {

  static const String _API_URL = 'https://restcountries.eu/rest/v2/region/europe';

  Future<List<CountryModel>> load() async {
    List<CountryModel> countries = [];
    var _httpClient = http.Client();
    try {
      var uriResponse = await _httpClient.get(Uri.parse(_API_URL));
      jsonDecode(uriResponse.body).forEach((json) {
        countries.add(CountryModel.fromJson(json));
      });
    } finally {
      _httpClient.close();
    }
    return countries;
  }
}