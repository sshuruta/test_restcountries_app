import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_restcountries_app/countries/bloc/countries_bloc.dart';
import 'package:test_restcountries_app/countries/bloc/countries_event.dart';
import 'package:test_restcountries_app/countries/repository/model/country_model.dart';
import 'package:test_restcountries_app/countries/view/c_search.dart';
import 'package:test_restcountries_app/countries/view/country_list.dart';

class CountryCard extends StatelessWidget {

  final String search;
  final Set<CountryModel>? countries;
  final Function(String search) onChanged;
  final TextEditingController controller = TextEditingController();

  CountryCard(this.search, this.countries, {
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) => Column(
    children: [
      CSearch(search,
        hint: "Country name",
        onChanged: (search) => this.search != search ? onChanged(search) : null,
      ),
      Expanded(
        child: countries == null
            ? Center(child: CircularProgressIndicator(color: Colors.amber))
            : countries!.isNotEmpty
            ? CountryList(countries!, onRemove: (model) => context.read<CountriesBloc>().add(CountriesRemoveEvent(model)))
            : Center(child: Text("Not found")),
      ),
    ],
  );
}