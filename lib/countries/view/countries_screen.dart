import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_restcountries_app/countries/bloc/countries_bloc.dart';
import 'package:test_restcountries_app/countries/bloc/countries_event.dart';
import 'package:test_restcountries_app/countries/bloc/countries_state.dart';
import 'package:test_restcountries_app/countries/repository/countries_repository.dart';
import 'package:test_restcountries_app/countries/view/c_button.dart';
import 'package:test_restcountries_app/countries/view/country_card.dart';

class CountriesScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text("Test app"),
      centerTitle: true,
      backgroundColor: Colors.amber,
    ),
    body: SafeArea(
      child: BlocProvider(
        create: (BuildContext context) => CountriesBloc(CountriesRepository()),
        child: BlocBuilder<CountriesBloc, ICountriesState>(
          builder: (context, state) => state is CountriesDoneState
              ? CountryCard()
              : Center(
            child: state is CountriesErrorState
                ? CButton("Reload", onPressed: () => context.read<CountriesBloc>().add(CountriesLoadEvent()))
                : CircularProgressIndicator(),
          ),
        ),
      ),
    ),
  );
}