import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_restcountries_app/countries/bloc/countries_bloc.dart';
import 'package:test_restcountries_app/countries/bloc/countries_state.dart';
import 'package:test_restcountries_app/countries/repository/model/country_model.dart';
import 'package:test_restcountries_app/countries/view/country_item.dart';

class CountryList extends StatelessWidget {

  final List<CountryModel> models;
  final Function(String search)? onSearch;

  CountryList(this.models, { this.onSearch });

  @override
  Widget build(BuildContext context) => Column(
    children: [
      TextField(
        maxLines: 1,
        autofocus: false,
        onChanged: onSearch,
      ),
      Expanded(
        child: BlocBuilder<CountriesBloc, ICountriesState>(
          buildWhen: (previous, current) => current is CountriesFilteringState,
          builder: (context, state) => ListView.separated(
            itemCount: models.length,
            itemBuilder: (BuildContext context, int index) => CountryItem(models[index]),
            separatorBuilder: (context, index) => Divider(),
          ),
        ),
      ),
    ],
  );

}