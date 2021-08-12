import 'package:test_restcountries_app/countries/repository/model/country_model.dart';

abstract class ICountriesState {}

class CountriesProgressState extends ICountriesState {}

class CountriesErrorState extends ICountriesState {}


abstract class CountriesDoneState extends ICountriesState {
  final Set<CountryModel>? countries;
  final String search;
  CountriesDoneState(this.countries, this.search);
}

class CountriesDoneProgressState extends CountriesDoneState {
  CountriesDoneProgressState([ String search = "" ]): super(null, search);
}

class CountriesDoneDisplayState extends CountriesDoneState {
  CountriesDoneDisplayState(Set<CountryModel> countries, String search): super(countries, search);
}