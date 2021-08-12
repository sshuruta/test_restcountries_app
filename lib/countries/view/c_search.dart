import 'package:flutter/material.dart';

class CSearch extends StatelessWidget {

  final String value;
  final Function(String value) onChanged;
  final String? hint;

  final TextEditingController _controller;

  CSearch(this.value, {
    required this.onChanged,
    this.hint,
  }): _controller = TextEditingController(text: value)..selection = TextSelection.fromPosition(TextPosition(offset: value.length));

  @override
  Widget build(BuildContext context) => TextFormField(
    maxLines: 1,
    decoration: new InputDecoration(
      contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      hintText: hint,
    ),
    autofocus: false,
    controller: _controller,
    onChanged: (search) => onChanged(search),
  );
}