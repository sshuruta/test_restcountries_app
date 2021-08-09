import 'package:flutter/material.dart';
import 'package:test_restcountries_app/countries/view/countries.dart';

class App extends StatelessWidget {

  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'Test restcountries.eu app',
    //debugShowCheckedModeBanner: false,
    home: Scaffold(
      body: SafeArea(
        child: CountriesScreen(),
      ),
    ),
  );
}