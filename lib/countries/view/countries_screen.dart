import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_restcountries_app/countries/bloc/countries_bloc.dart';
import 'package:test_restcountries_app/countries/bloc/countries_event.dart';
import 'package:test_restcountries_app/countries/bloc/countries_state.dart';
import 'package:test_restcountries_app/countries/repository/countries_repository.dart';
import 'package:test_restcountries_app/countries/view/c_button.dart';
import 'package:test_restcountries_app/countries/view/country_card.dart';

class CountriesScreen extends StatelessWidget {

  static _load(BuildContext context) => context.read<CountriesBloc>().add(CountriesLoadEvent());
  static _reLoad(BuildContext context) => context.read<CountriesBloc>().add(CountriesReLoadEvent());
  static _search(BuildContext context, String search) => context.read<CountriesBloc>().add(CountriesFilterStartEvent(search));

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (BuildContext context) => CountriesBloc(CountriesRepository()),
    child: BlocBuilder<CountriesBloc, ICountriesState>(
      builder: (context, state) => WillPopScope(
        onWillPop: () async {
          if(state is CountriesDoneDisplayState && state.search.isNotEmpty) {
            _load(context);
            return false;
          }
          return true;
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text("Test app"),
            centerTitle: true,
            backgroundColor: Colors.amber,
            leading: state is CountriesDoneDisplayState && state.search.isNotEmpty ? BackButton() : null,
            actions: [
                IconButton(onPressed: () => _reLoad(context), icon: Icon(Icons.update_rounded))
            ],
          ),
          body: SafeArea(
            child: state is CountriesDoneState
              ? CountryCard(state.search, state.countries, onChanged: (search) => _search(context, search))
              : state is CountriesErrorState
                ? Center(child: CButton("Reload", onPressed: () => _reLoad(context)))
                : Center(child: CircularProgressIndicator(color: Colors.amber)),
          ),
        ),
      ),
    ),
  );
}