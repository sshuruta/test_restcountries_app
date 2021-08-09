import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:test_restcountries_app/countries/repository/model/country_model.dart';

class CountryItem extends StatelessWidget {

  final CountryModel model;

  CountryItem(this.model);

  @override
  Widget build(BuildContext context) => Row(
    mainAxisSize: MainAxisSize.max,
    children: [
      Text(model.alpha2Code),
      Column(
        children: [
          Text(model.name),
          Text(model.subregion),
        ],
      ),
      SizedBox(
        width: 50,
        height: 50,
        child: SvgPicture.network(model.flag),
      ),
    ],
  );

}