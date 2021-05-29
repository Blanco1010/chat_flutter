import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Center(
      child: Container(
        margin: EdgeInsets.only(
          top: screenSize.height * 0.09,
        ),
        child: Column(
          children: <Widget>[
            Image(
              image: AssetImage('assets/img/tag-logo.png'),
              width: screenSize.width * 0.40,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Messenger',
              style: TextStyle(fontSize: screenSize.width * 0.077),
            ),
          ],
        ),
      ),
    );
  }
}
