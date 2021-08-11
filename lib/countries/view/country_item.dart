import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:test_restcountries_app/countries/repository/model/country_model.dart';

class CountryItem extends StatelessWidget {

  static const double _ICON_SIZE = 30.0;
  static const double _COLUMN_SPACE = 16.0;

  static const double TITLE_TEXT_SIZE = 16.0;
  static const double SUBTITLE_TEXT_SIZE = 13.0;

  final CountryModel model;

  CountryItem(this.model);

  @override
  Widget build(BuildContext context) => Padding(
    padding: EdgeInsets.symmetric(vertical: _COLUMN_SPACE / 2, horizontal: _COLUMN_SPACE),
    child: Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        SizedBox(
          width: _ICON_SIZE,
          height: _ICON_SIZE,
          child: null != model.flag ? SvgPicture.network(model.flag!) : null,
        ),
        SizedBox(width: _COLUMN_SPACE),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(model.name, style: TextStyle(fontSize: TITLE_TEXT_SIZE)),
              Text(model.subregion, style: TextStyle(fontSize: SUBTITLE_TEXT_SIZE, color: Colors.black54)),
            ],
          ),
        ),
        SizedBox(width: _COLUMN_SPACE),
        Text(model.alpha2Code, style: TextStyle(fontSize: TITLE_TEXT_SIZE, fontWeight: FontWeight.bold)),
      ],
    ),
  );

}