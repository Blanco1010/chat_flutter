import 'package:flutter/material.dart';

class BotonAzul extends StatelessWidget {
  final String text;
  final Function onPressed;

  const BotonAzul({Key key, this.text, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      elevation: 2.0,
      highlightElevation: 5,
      color: Colors.blue,
      disabledColor: Colors.grey,
      shape: StadiumBorder(),
      child: Container(
        width: double.infinity,
        height: 55,
        child: Center(
          child: Text(
            '$text',
            style: TextStyle(color: Colors.white, fontSize: 17),
          ),
        ),
      ),
      onPressed: this.onPressed,
    );
  }
}
