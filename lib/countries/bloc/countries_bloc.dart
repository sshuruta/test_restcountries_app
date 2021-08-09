import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_restcountries_app/countries/bloc/countries_event.dart';
import 'package:test_restcountries_app/countries/bloc/countries_state.dart';
import 'package:test_restcountries_app/countries/repository/countries_repository.dart';
import 'package:test_restcountries_app/countries/repository/model/country_model.dart';

class CountriesBloc extends  Bloc<ICountriesEvent, ICountriesState> {

  static const int _MIN_SEARCH_TEXT_LENGTH = 3;

  final CountriesRepository repository;

  CountriesBloc(this.repository) : super(CountriesLoadingState()) {
    add(CountriesLoadEvent());
  }

  @override
  Stream<ICountriesState> mapEventToState(ICountriesEvent event) async* {
    if(event is CountriesLoadEvent) {
      yield CountriesLoadingState();
      yield CountriesListState(await repository.load());
    }
    if(event is CountriesFilterEvent && event.search.length > _MIN_SEARCH_TEXT_LENGTH) {
      yield CountriesFilteringState();
      yield CountriesListState(await repository.filter(event.search));
    }
  }

}