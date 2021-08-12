import 'package:flutter/material.dart';
import 'package:test_restcountries_app/countries/repository/model/country_model.dart';
import 'package:test_restcountries_app/countries/view/country_item.dart';
import 'package:test_restcountries_app/map/view/map.dart';

class CountryList extends StatefulWidget {

  final Set<CountryModel> countries;
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
        final item = widget.countries.elementAt(index);
        return Dismissible(
          key: Key(item.name),
          onDismissed: (direction) {
            setState(() {
              CountryModel model = widget.countries.elementAt(index);
              widget.countries.remove(model);
              widget.onRemove(model);
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