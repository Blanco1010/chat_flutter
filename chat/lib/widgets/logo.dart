import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  final String titulo;

  const Logo({
    Key key,
    @required this.titulo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Center(
      child: Container(
        margin: EdgeInsets.only(
          top: screenSize.height * 0.09,
          bottom: screenSize.height * 0.1,
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
              this.titulo,
              style: TextStyle(fontSize: screenSize.width * 0.077),
            ),
          ],
        ),
      ),
    );
  }
}
