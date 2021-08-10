import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_restcountries_app/countries/bloc/countries_event.dart';
import 'package:test_restcountries_app/countries/bloc/countries_state.dart';
import 'package:test_restcountries_app/countries/repository/countries_repository.dart';

class CountriesBloc extends  Bloc<ICountriesEvent, ICountriesState> {

  static const int _MIN_SEARCH_TEXT_LENGTH = 3;

  final CountriesRepository _repository;

  CountriesBloc(this._repository) : super(CountriesProgressState()) {
    add(CountriesLoadEvent());
  }

  @override
  Stream<ICountriesState> mapEventToState(ICountriesEvent event) async* {

    if(event is CountriesLoadEvent) {
      yield CountriesProgressState();
      yield await _repository.getData()
        .then<ICountriesState>((data) => CountriesDisplayState(data))
        .catchError((_) => CountriesErrorState());
    }


    if (event is CountriesFilterEvent) {
      if (event.search.length > _MIN_SEARCH_TEXT_LENGTH) {
        yield CountriesFilteringState();
        await Future.delayed(const Duration(milliseconds: 1500));
        yield CountriesDisplayState(await _repository.getData(event.search), search: event.search);
      } else {
        yield CountriesDisplayState(await _repository.getData());
      }
    }

    if(state is CountriesDisplayState) {
      CountriesDisplayState currentState = state as CountriesDisplayState;
      if (event is CountriesRemoveEvent) {
        _repository.remove(event.model);
        yield CountriesDisplayState(await _repository.getData(currentState.search), search: currentState.search);
      }
    }
  }
}