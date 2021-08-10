
import 'package:test_restcountries_app/countries/repository/model/country_model.dart';

abstract class ICountriesEvent {}

class CountriesLoadEvent extends ICountriesEvent {}

class CountriesFilterEvent extends ICountriesEvent {
  final String search;
  CountriesFilterEvent(this.search);
}

class CountriesRemoveEvent extends ICountriesEvent {
  CountryModel model;
  CountriesRemoveEvent(this.model);
}