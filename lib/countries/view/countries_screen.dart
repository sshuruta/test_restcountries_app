import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_restcountries_app/countries/bloc/countries_bloc.dart';
import 'package:test_restcountries_app/countries/bloc/countries_event.dart';
import 'package:test_restcountries_app/countries/bloc/countries_state.dart';
import 'package:test_restcountries_app/countries/repository/countries_repository.dart';
import 'package:test_restcountries_app/countries/view/country_list.dart';

class CountriesScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (BuildContext context) => CountriesBloc(CountriesRepository()),
    child: BlocBuilder<CountriesBloc, ICountriesState>(
      buildWhen: (previous, current) => current is! CountriesFilteringState,
      builder: (context, state) => state is CountriesListState
        ? null != state.countries
          ? CountryList(state.countries!, onSearch: (search) => context.read<CountriesBloc>().add(CountriesFilterEvent(search)))
          : Center(child: _reloadButton(context))
        : Center(child: _loadIndicator()),
    ),
  );

  Widget _reloadButton(BuildContext context) => ElevatedButton(
    style: TextButton.styleFrom(primary: Colors.blue),
    child: Text("Reload", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
    onPressed: () => context.read<CountriesBloc>().add(CountriesLoadEvent())
  );
  Widget _loadIndicator() => CircularProgressIndicator();

}