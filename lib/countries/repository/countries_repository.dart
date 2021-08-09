import 'dart:convert';
import 'package:test_restcountries_app/countries/repository/model/country_model.dart';
import 'package:http/http.dart' as http;

class CountriesRepository {

  static const String _API_URL = 'https://restcountries.eu/rest/v2/region/europe';

  List<CountryModel>? _data;

  Future<List<CountryModel>?> load() async {
    var _httpClient = http.Client();
    try {
      await Future.delayed(const Duration(seconds: 2));
      http.Response response = await _httpClient.get(Uri.parse(_API_URL));
      List<dynamic> jsonArray = jsonDecode(response.body);
      _data = jsonArray.map((json) => CountryModel.fromJson(json)).toList();
    } catch(e) {} finally {
      _httpClient.close();
    }
    return _data;
  }

  Future<List<CountryModel>?> filter(String search) async {
    await Future.delayed(const Duration(milliseconds: 1500));
    return _data?.where((item) => item.name.toLowerCase().contains(search.toLowerCase())).toList();
  }
}