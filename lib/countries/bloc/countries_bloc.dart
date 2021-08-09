import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_restcountries_app/countries/bloc/countries_event.dart';
import 'package:test_restcountries_app/countries/bloc/countries_state.dart';
import 'package:test_restcountries_app/countries/repository/countries_repository.dart';

class CountriesBloc extends  Bloc<ICountriesEvent, ICountriesState> {

  final CountriesRepository repository;

  CountriesBloc(this.repository) : super(CountriesLoadingState()) {
    add(CountriesLoadEvent());
  }

  @override
  Stream<ICountriesState> mapEventToState(ICountriesEvent event) async* {
    if(event is CountriesLoadEvent) {
      yield CountriesListState(await repository.load());
    }
  }

}