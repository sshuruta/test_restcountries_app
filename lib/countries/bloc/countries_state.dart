import 'package:test_restcountries_app/countries/repository/model/country_model.dart';

abstract class ICountriesState {}

class CountriesProgressState extends ICountriesState {}

class CountriesErrorState extends ICountriesState {}

abstract class CountriesDoneState extends ICountriesState {}


class CountriesFilteringState extends CountriesDoneState {}

class CountriesDisplayState extends CountriesDoneState {

  final Set<CountryModel> countries;
  final String? search;

  CountriesDisplayState(this.countries, { this.search });

}