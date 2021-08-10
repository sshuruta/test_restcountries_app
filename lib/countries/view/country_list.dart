import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_restcountries_app/countries/bloc/countries_bloc.dart';
import 'package:test_restcountries_app/countries/bloc/countries_event.dart';
import 'package:test_restcountries_app/countries/bloc/countries_state.dart';
import 'package:test_restcountries_app/countries/repository/model/country_model.dart';
import 'package:test_restcountries_app/countries/view/country_item.dart';
import 'package:test_restcountries_app/map/view/map.dart';


class CountryCard extends StatelessWidget {

  @override
  Widget build(BuildContext context) => Column(
    children: [
      TextField(
        maxLines: 1,
        autofocus: false,
        onChanged: (search) => context.read<CountriesBloc>().add(CountriesFilterEvent(search)),
      ),
      Expanded(
        child: BlocBuilder<CountriesBloc, ICountriesState>(
          buildWhen: (previous, current) => current is CountriesDoneState,
          builder: (context, state) => state is CountriesDisplayState
              ? state.countries.isNotEmpty
              ? CountryList(state.countries, onRemove: (model) => context.read<CountriesBloc>().add(CountriesRemoveEvent(model)))
              : Center(child: Text("Не найдено"))
              : Center(child: CircularProgressIndicator()),
        ),
      ),
    ],
  );
}


class CountryList extends StatefulWidget {

  final List<CountryModel> countries;
  final Function(CountryModel model) onRemove;

  CountryList(this.countries, { required this.onRemove });

  @override
  State<StatefulWidget> createState() => CountryListState();
}

class CountryListState extends State<CountryList> {

  @override
  Widget build(BuildContext context) => ListView.separated(
      itemCount: widget.countries.length,
      itemBuilder: (BuildContext context, int index) {
        final item = widget.countries[index];
        return Dismissible(
          key: Key(item.name),
          onDismissed: (direction) {
            setState(() {
              widget.onRemove(widget.countries.removeAt(index));
            });
          },
          child: InkWell(
            onTap: null != item.latLng ? () => Navigator.push(context,
              MaterialPageRoute(
                builder: (context) => MapScreen(item),
              ),
            ) : null,
            child: CountryItem(item),
          ),
        );
      },
      separatorBuilder: (context, index) => Divider());

}