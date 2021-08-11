import 'package:flutter/material.dart';

class CButton extends StatelessWidget {

  final String name;
  final Function()? onPressed;

  CButton(this.name, {
    this.onPressed
  });

  @override
  Widget build(BuildContext context) => ElevatedButton(
    style: TextButton.styleFrom(primary: Colors.amber),
    child: Text(name, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
    onPressed: onPressed);

}