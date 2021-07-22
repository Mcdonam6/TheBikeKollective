import 'package:flutter/material.dart';

class formattedFormInput extends StatelessWidget {
  final String placeholderTxt;

  const formattedFormInput({Key? key, required this.placeholderTxt})
      : super(key: key);

  Widget build(BuildContext context) {
    return Flexible(
      flex: 1,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
        child: TextFormField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: this.placeholderTxt,
          ),
        ),
      ),
    );
  }
}
