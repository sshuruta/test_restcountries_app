import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:test_restcountries_app/countries/repository/model/country_model.dart';

class CountryItem extends StatelessWidget {

  final CountryModel model;

  CountryItem(this.model);

  @override
  Widget build(BuildContext context) => Padding(
    padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
    child: Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        SizedBox(
          width: 30,
          height: 30,
          child: SvgPicture.network(model.flag),
        ),
        SizedBox(width: 16.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(model.name, style: TextStyle(fontSize: 16.0)),
              Text(model.subregion, style: TextStyle(fontSize: 13.0, color: Colors.black54)),
            ],
          ),
        ),
        Text(model.alpha2Code, style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
      ],
    ),
  );

}