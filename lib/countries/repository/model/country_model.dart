import 'package:latlong2/latlong.dart';

class CountryModel {

  static const String _PARAM_NAME = 'name';
  static const String _PARAM_SUBREGION = 'subregion';
  static const String _PARAM_ALPHA2CODE = 'alpha2Code';
  static const String _PARAM_FLAG = 'flag';
  static const String _PARAM_LAT_LNG = 'latlng';

  static LatLng? _parseLatLng(List<dynamic> latLngList) => latLngList.length == 2
      ? LatLng(latLngList.first, latLngList.last)
      : null;

  final String name;
  final String subregion;
  final String alpha2Code;
  final String flag;
  final LatLng? latLng;

  CountryModel._(this.name, this.subregion, this.alpha2Code, this.flag, this.latLng);

  CountryModel.fromJson(Map<String, dynamic> json) : this._(
    json[_PARAM_NAME],
    json[_PARAM_SUBREGION],
    json[_PARAM_ALPHA2CODE],
    json[_PARAM_FLAG],
    _parseLatLng(json[_PARAM_LAT_LNG]),
  );

  @override
  bool operator ==(Object other) {
    if(other is! CountryModel) return false;
      if (identical(this, other)) return true;
      return this.alpha2Code.toLowerCase() == other.alpha2Code.toLowerCase();
    }
}