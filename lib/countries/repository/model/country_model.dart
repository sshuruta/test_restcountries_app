import 'package:latlong2/latlong.dart' show LatLng;
import 'package:test_restcountries_app/countries/repository/model/currency_model.dart';

class CountryModel {

  static const String _PARAM_NAME         = 'name';
  static const String _PARAM_SUBREGION    = 'subregion';
  static const String _PARAM_ALPHA2CODE   = 'alpha2Code';
  static const String _PARAM_FLAG         = 'flag';
  static const String _PARAM_LAT_LNG      = 'latlng';
  static const String _PARAM_NUMERIC_CODE = 'numericCode';
  static const String _PARAM_BORDERS      = 'borders';
  static const String _PARAM_CURRENCIES   = 'currencies';

  static CountryModel? fromJson(Map<String, dynamic> json) => isValid(json) ? CountryModel._(
    json[_PARAM_NAME],
    json[_PARAM_SUBREGION],
    json[_PARAM_ALPHA2CODE],
    json[_PARAM_FLAG],
    _parseLatLng(json[_PARAM_LAT_LNG]),
    null != json[_PARAM_NUMERIC_CODE] ? int.parse(json[_PARAM_NUMERIC_CODE]) : null,
    json[_PARAM_BORDERS] ?? [],
    _parseCurrencies(json[_PARAM_CURRENCIES]),
  ) : null;

  static bool isValid(Map<String, dynamic> json) => json.containsKey(_PARAM_NAME) && null != json[_PARAM_NAME]
    && json.containsKey(_PARAM_SUBREGION) && null != json[_PARAM_SUBREGION]
    && json.containsKey(_PARAM_ALPHA2CODE) && null != json[_PARAM_ALPHA2CODE];

  static LatLng? _parseLatLng(List<dynamic> latLngList) => latLngList.length == 2
      ? LatLng(latLngList.first, latLngList.last)
      : null;

  static Set<CurrencyModel> _parseCurrencies(List<dynamic>? currenciesJsonList) {
    Set<CurrencyModel> result = {};
    if(currenciesJsonList?.isNotEmpty == true) {
      currenciesJsonList!.forEach((json) {
        CurrencyModel? currencyModel = CurrencyModel.fromJson(json);
        if(null != currencyModel) {
          result.add(currencyModel);
        }
      });
    }
    return result;
  }

  final String name;
  final String subregion;
  final String alpha2Code;
  final String? flag;
  final LatLng? latLng;
  final int? numericCode;
  final List<String> borders;
  final Set<CurrencyModel> currencies;

  CountryModel._(
      this.name,
      this.subregion,
      this.alpha2Code,
      this.flag,
      this.latLng,
      this.numericCode,
      List<dynamic> borders,
      this.currencies): this.borders = borders.map((e) => e.toString()).toList();

  @override
  bool operator ==(Object other) {
    if(other is! CountryModel) return false;
      if (identical(this, other)) return true;
    return this.name == other.name
        && this.subregion == other.subregion
        && this.alpha2Code == other.alpha2Code;
    }

  @override
  int get hashCode => name.hashCode ^ subregion.hashCode ^ alpha2Code.hashCode;
}