import 'package:flutter/material.dart';

// class DropDownMaker extends StatefulWidget {
//   final List<String> optionsList;

//   DropDownMaker({required this.optionsList});

//   @override
//   _DropDownState createState() => _DropDownState(this.optionsList);
// }

// class _DropDownState extends State<DropDownMaker> {
//   DropDownMaker? dropdown;
//   List<String> optionsList;
//   String? currentValue;

//   _DropDownState({optionsList: optionsList, currentValue: optionsList[0]});

//   @override
//   Widget build(BuildContext context) {
//     currentValue = optionsList[0];
//     var list = _PopulateList(optionsList);
//     return DropdownButton(
//       value: currentValue,
//       items: list,
//     );
//   }

//   List<DropdownMenuItem> _PopulateList(List<String> items) {
//     List<DropdownMenuItem> options = [];
//     for (var option in items) {
//       options.add(_ListItem(option));
//     }
//     return options;
//   }

//   DropdownMenuItem _ListItem(String item) {
//     return DropdownMenuItem(
//       child: Text(item),
//       value: item,
//     );
//   }
// }
