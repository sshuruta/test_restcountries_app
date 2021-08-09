
class CountryModel {

  static const String _PARAM_NAME = 'name';
  static const String _PARAM_SUBREGION = 'subregion';
  static const String _PARAM_ALPHA2CODE = 'alpha2Code';
  static const String _PARAM_FLAG = 'flag';

  final String name;
  final String subregion;
  final String alpha2Code;
  final String flag;

  CountryModel._(this.name, this.subregion, this.alpha2Code, this.flag);

  CountryModel.fromJson(Map<String, dynamic> json) : this._(
    json[_PARAM_NAME],
    json[_PARAM_SUBREGION],
    json[_PARAM_ALPHA2CODE],
    json[_PARAM_FLAG],
  );
}