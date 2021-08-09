
abstract class ICountriesEvent {}

class CountriesLoadEvent extends ICountriesEvent {}

class CountriesFilterEvent extends ICountriesEvent {

  final String search;

  CountriesFilterEvent(this.search);
}