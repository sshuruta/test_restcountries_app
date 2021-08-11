import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:test_restcountries_app/countries/repository/model/country_model.dart';

class MapScreen extends StatelessWidget {

  static const double _ZOOM = 4.5;
  static const double _MARKER_SIZE = 24.0;

  final CountryModel model;

  MapScreen(this.model);

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text(model.name),
      centerTitle: true,
      backgroundColor: Colors.amber,
    ),
    body: SafeArea(
      child: Column(children: [
        Expanded(
          child: FlutterMap(
            options: MapOptions(
              center: model.latLng,
              zoom: _ZOOM,
            ),
            layers: [
              TileLayerOptions(
                  urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                  subdomains: ['a', 'b', 'c']
              ),
              MarkerLayerOptions(
                markers: [
                  Marker(
                    width: _MARKER_SIZE,
                    height: _MARKER_SIZE,
                    point: model.latLng!,
                    builder: (ctx) => null != model.flag
                        ? SvgPicture.network(model.flag!)
                        : Container(
                      width: double.infinity,
                      height: double.infinity,
                      color: Colors.amber,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.all(8.0),
          width: double.infinity,
          color: Colors.amber,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if(null != model.numericCode)
                Text("Code: ${model.numericCode}"),
              if(model.borders.isNotEmpty)
                Text("Borders: ${model.borders.join(", ")}"),
              if(model.currencies.isNotEmpty)
                Text("Currencies: ${model.currencies.join(", ")}"),

            ],
          ),
        ),
      ]),
    ),
  );
}