import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:test_restcountries_app/countries/repository/model/country_model.dart';

class MapScreen extends StatelessWidget {

  final CountryModel model;

  MapScreen(this.model);

  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: FlutterMap(
        options: MapOptions(
          center: model.latLng,
          zoom: 4.5,
        ),
        layers: [
          TileLayerOptions(
              urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
              subdomains: ['a', 'b', 'c']
          ),
          MarkerLayerOptions(
            markers: [
              Marker(
                width: 24.0,
                height: 24.0,
                point: model.latLng!,
                builder: (ctx) => SvgPicture.network(model.flag),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}