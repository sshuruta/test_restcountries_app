import 'package:test_restcountries_app/countries/repository/model/country_model.dart';

abstract class ICountriesEvent {}

class CountriesLoadEvent extends ICountriesEvent {}

class CountriesReLoadEvent extends ICountriesEvent {}

class CountriesFilterStartEvent extends ICountriesEvent {
  final String search;
  CountriesFilterStartEvent(this.search);
}

class CountriesFilterFinishEvent extends ICountriesEvent {
  final String search;
  CountriesFilterFinishEvent(this.search);
}

class CountriesRemoveEvent extends ICountriesEvent {
  CountryModel model;
  CountriesRemoveEvent(this.model);
}