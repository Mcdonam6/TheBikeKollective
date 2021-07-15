import 'package:flutter/material.dart';

class largeButton extends StatelessWidget {
  final String buttonText;
  final Widget buttonIcon;
  final Function action;

  const largeButton(
      {Key? key,
      required this.buttonText,
      required this.buttonIcon,
      required this.action})
      : super(key: key);

  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: .8,
      widthFactor: .8,
      child: ElevatedButton(
        style: ButtonStyle(
            minimumSize: MaterialStateProperty.all(
                Size(double.infinity, double.infinity)),
            backgroundColor: MaterialStateProperty.all(Colors.blue[200])),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [buttonIcon],
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Text(buttonText, style: TextStyle(fontSize: 30))]),
          ],
        ),
        onPressed: action(),
      ),
    );
  }
}
