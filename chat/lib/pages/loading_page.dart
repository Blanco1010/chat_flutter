import 'package:chat/pages/login_page.dart';
import 'package:chat/pages/usuarios_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chat/services/auth_service.dart';

class LoagindPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: chekLoginState(context),
        builder: (BuildContext context, snapshot) {
          return Center(
            child: Text('Espere...'),
          );
        },
      ),
    );
  }
}

Future chekLoginState(BuildContext context) async {
  final authSerive = Provider.of<AuthSerive>(context, listen: false);

  final autenticado = await authSerive.isLoggedIn();

  if (autenticado) {
    //TODO: conectar al socket server

    // Navigator.pushReplacementNamed(context, 'usuarios');
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
          pageBuilder: (_, __, ___) => UsuariosPage(),
          transitionDuration: Duration(milliseconds: 0)),
    );
  } else {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
          pageBuilder: (_, __, ___) => LoginPage(),
          transitionDuration: Duration(milliseconds: 0)),
    );
  }
}
