import 'package:flutter/material.dart';
import 'package:chat/models/usuarios.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:chat/services/auth_service.dart';

class UsuariosPage extends StatefulWidget {
  @override
  _UsuariosPageState createState() => _UsuariosPageState();
}

class _UsuariosPageState extends State<UsuariosPage> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  final usuarios = [
    Usuario(
        uid: '1', email: 'test1@gmail.com', nombre: 'Blanco', isOnline: true),
    Usuario(
        uid: '2', email: 'test2@gmail.com', nombre: 'David', isOnline: true),
    Usuario(
        uid: '3', email: 'test3@gmail.com', nombre: 'Alejo', isOnline: false),
    Usuario(
        uid: '4', email: 'test4@gmail.com', nombre: 'María', isOnline: false),
    Usuario(
        uid: '5', email: 'test5@gmail.com', nombre: 'Camila', isOnline: true),
  ];

  @override
  Widget build(BuildContext context) {
    final authSerive = Provider.of<AuthSerive>(context);
    final usuario = authSerive.usuario;

    return Scaffold(
        appBar: AppBar(
          title: Text(
            usuario.nombre,
            style: TextStyle(color: Colors.black54),
          ),
          elevation: 1,
          centerTitle: true,
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(
              Icons.exit_to_app,
              color: Colors.black54,
            ),
            onPressed: () {
              //TODO: Desconectar el socker server
              AuthSerive.deleteToken();
              Navigator.pushReplacementNamed(context, 'login');
              AuthSerive.deleteToken();
            },
          ),
          actions: <Widget>[
            Container(
              margin: EdgeInsets.only(right: 10),
              child: Icon(Icons.check_circle, color: Colors.blue[400]),
              // Icon(Icons.offline_bolt, color: Colors.red[400]),
            )
          ],
        ),
        body: SmartRefresher(
          controller: _refreshController,
          enablePullDown: true,
          onRefresh: _cargarUsuarios,
          header: WaterDropHeader(
            complete: Icon(
              Icons.check,
              color: Colors.blue[400],
            ),
            waterDropColor: Colors.blue[400],
          ),
          child: _listViewUsuarios(),
        ));
  }

  ListView _listViewUsuarios() {
    return ListView.separated(
      physics:
          BouncingScrollPhysics(), //sin efectos cuando llegue al limite en las verticales
      itemBuilder: (_, i) => _usuarioListTile(usuarios[i]),
      separatorBuilder: (_, i) => Divider(),
      itemCount: usuarios.length,
    );
  }

  ListTile _usuarioListTile(Usuario usuario) {
    return ListTile(
      title: Text(usuario.nombre),
      subtitle: Text(usuario.email),
      leading: CircleAvatar(
        child: Text(usuario.nombre.substring(0, 2)),
        backgroundColor: Colors.blue[100],
      ),
      trailing: Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
              color: usuario.isOnline ? Colors.green[100] : Colors.red,
              borderRadius: BorderRadius.circular(100))),
    );
  }

  _cargarUsuarios() async {
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    _refreshController.refreshCompleted();
  }
}
