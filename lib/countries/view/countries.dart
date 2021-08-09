import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_restcountries_app/countries/bloc/countries_bloc.dart';
import 'package:test_restcountries_app/countries/bloc/countries_state.dart';
import 'package:test_restcountries_app/countries/repository/countries_repository.dart';
import 'package:test_restcountries_app/countries/view/country_item.dart';

class CountriesScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (BuildContext context) => CountriesBloc(CountriesRepository()),
    child: BlocBuilder<CountriesBloc, ICountriesState>(
      builder: (context, state) => state is CountriesListState
        ? ListView.separated(
          itemCount: state.countries.length,
          itemBuilder: (BuildContext context, int index) => CountryItem(state.countries[index]),
          separatorBuilder: (context, index) => Divider(),
        )
        : Center(child: Text("Loading...")),
    ),
  );

}