import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_restcountries_app/countries/bloc/countries_event.dart';
import 'package:test_restcountries_app/countries/bloc/countries_state.dart';
import 'package:test_restcountries_app/countries/repository/countries_repository.dart';
import 'package:test_restcountries_app/countries/repository/model/country_model.dart';

class CountriesBloc extends  Bloc<ICountriesEvent, ICountriesState> {

  static const int _MIN_SEARCH_TEXT_LENGTH = 3;
  static const int _SEARCH_DURATION = 1500;

  final CountriesRepository _repository;
  Timer? _timer;

  CountriesBloc(this._repository) : super(CountriesProgressState()) {
    add(CountriesReLoadEvent());
  }

  @override
  Stream<ICountriesState> mapEventToState(ICountriesEvent event) async* {

    if(event is CountriesReLoadEvent) {
      yield CountriesProgressState();
      yield _display(await _repository.reload());
    }

    if(event is CountriesLoadEvent) {
      yield CountriesDoneProgressState();
      yield _display(await _repository.getData());
    }

    if (event is CountriesFilterStartEvent) {
      _timer?.cancel();
      if (event.search.length >= _MIN_SEARCH_TEXT_LENGTH) {
        yield CountriesDoneProgressState(event.search);
        _timer = Timer(Duration(milliseconds: _SEARCH_DURATION), () {
          add(CountriesFilterFinishEvent(event.search));
        });
      }
      if (event.search.length == 0) {
        yield _display(await _repository.getData());
      }
    }


    if (event is CountriesFilterFinishEvent) {
      yield _display(await _repository.getData(event.search), event.search);
    }

    if(event is CountriesRemoveEvent) {
      _repository.remove(event.model);
      if(state is CountriesDoneDisplayState) {
        String search = (state as CountriesDoneDisplayState).search;
        yield _display(await _repository.getData(search), search);
      }
    }
  }

  ICountriesState _display(Set<CountryModel>? models, [ String search = "" ]) => null != models
    ? CountriesDoneDisplayState(models, search)
    : CountriesErrorState();
}