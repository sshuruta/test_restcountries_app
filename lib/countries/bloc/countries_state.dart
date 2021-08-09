import 'package:test_restcountries_app/countries/repository/model/country_model.dart';

abstract class ICountriesState {}

class CountriesLoadingState extends ICountriesState {}

class CountriesLoadingErrorState extends ICountriesState {}

class CountriesListState extends ICountriesState {

  final List<CountryModel> countries;

  CountriesListState(this.countries);

}