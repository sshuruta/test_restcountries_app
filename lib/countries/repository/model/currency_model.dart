
class CurrencyModel {

  static const String _PARAM_CODE   = 'code';
  static const String _PARAM_NAME   = 'name';
  static const String _PARAM_SYMBOL = 'symbol';

  static CurrencyModel? fromJson(Map<String, dynamic> json) => isValid(json) ? CurrencyModel._(
    json[_PARAM_CODE],
    json[_PARAM_NAME],
    json[_PARAM_SYMBOL],
  ) : null;

  static bool isValid(Map<String, dynamic> json) => json.containsKey(_PARAM_CODE) && null != json[_PARAM_CODE]
      && json.containsKey(_PARAM_NAME) && null != json[_PARAM_NAME];

  final String code;
  final String name;
  final String? symbol;

  CurrencyModel._(this.code, this.name, this.symbol);

  @override
  bool operator ==(Object other) {
    if(other is! CurrencyModel) return false;
    if (identical(this, other)) return true;
    return this.code.toLowerCase() == other.code.toLowerCase()
        && this.name.toLowerCase() == other.name.toLowerCase();
  }

  @override
  int get hashCode => code.hashCode ^ name.hashCode;

  @override
  String toString() {
    return '$code $name ${null != symbol ? "($symbol)" : ""}';
  }
}