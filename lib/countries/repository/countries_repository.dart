import 'dart:convert';
import 'package:test_restcountries_app/countries/repository/model/country_model.dart';
import 'package:http/http.dart' as http;

class CountriesRepository {

  static const String _API_URL = 'https://restcountries.eu/rest/v2/region/europe';

  List<CountryModel>? _data;

  Future<List<CountryModel>> getData([ String? search ]) async {
    if(null == _data) {
      _data = await _loadData();
    }
    List<CountryModel> data = _data ?? [];
    return null != search
        ? data.where((item) => item.name.toLowerCase().contains(search.toLowerCase())).toList()
        : data;
  }

  remove(CountryModel model) {
    _data?.removeWhere((element) => element == model);
  }

  Future<List<CountryModel>?> _loadData() async {
    List<CountryModel>? data;
    var _httpClient = http.Client();
    try {
      await Future.delayed(const Duration(seconds: 2));
      http.Response response = await _httpClient.get(Uri.parse(_API_URL));
      List<dynamic> jsonArray = jsonDecode(response.body);
      data = jsonArray.map((json) => CountryModel.fromJson(json)).toList();
    } catch (e) {
      throw(e.toString());
    } finally {
      _httpClient.close();
    }
    return data;
  }

}