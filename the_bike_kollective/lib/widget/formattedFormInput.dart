import 'package:flutter/material.dart';
import 'package:the_bike_kollective/objects/bike.dart';

class formattedFormInput extends StatelessWidget {
  final String placeholderTxt;
  final int flexVal;
  var field;

  formattedFormInput(
      {Key? key,
      required this.flexVal,
      required this.placeholderTxt,
      var field})
      : super(key: key);

  Widget build(BuildContext context) {
    return Flexible(
      flex: this.flexVal,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
        child: TextFormField(
          onSaved: (value) {
            field = value;
          },
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please Enter $placeholderTxt';
            }
            return null;
          },
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: this.placeholderTxt,
          ),
        ),
      ),
    );
  }
}
