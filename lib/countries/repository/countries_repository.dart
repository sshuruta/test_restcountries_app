import 'dart:convert';
import 'package:test_restcountries_app/countries/repository/model/country_model.dart';
import 'package:http/http.dart' as http;

class CountriesRepository {

  static const String _API_URL = 'https://restcountries.eu/rest/v2/region/europe';

  Set<CountryModel>? _data;

  Future<Set<CountryModel>?> getData([ String? search ]) async {
    if(null == _data) {
      _data = await _loadData();
    }
    Set<CountryModel>? data = _data;
    return null != search
        ? data?.where((item) => item.name.toLowerCase().contains(search.toLowerCase())).toSet()
        : data;
  }

  Future<Set<CountryModel>?> reload() async {
    _data = null;
    return await getData();
  }

  remove(CountryModel model) {
    _data?.removeWhere((element) => element == model);
  }

  Future<Set<CountryModel>?> _loadData() async {
    Set<CountryModel>? result;
    var _httpClient = http.Client();
    try {
      await Future.delayed(const Duration(seconds: 1));
      http.Response response = await _httpClient.get(Uri.parse(_API_URL));
      var data = jsonDecode(response.body);
      if(data is List<dynamic>) {
        result = {};
        data.forEach((json) {
          CountryModel? model = CountryModel.fromJson(json);
          if (null != model) {
            result?.add(model);
          }
        });
      }
    } catch(e) {} finally {
      _httpClient.close();
    }
    return result;
  }

}