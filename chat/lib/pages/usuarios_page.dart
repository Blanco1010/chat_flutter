import 'package:chat/models/usuarios.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class UsuariosPage extends StatefulWidget {
  @override
  _UsuariosPageState createState() => _UsuariosPageState();
}

class _UsuariosPageState extends State<UsuariosPage> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  final usuarios = [
    Usuario(uid: '1', email: 'test1@gmail.com', nombre: 'Blanco', online: true),
    Usuario(uid: '2', email: 'test2@gmail.com', nombre: 'David', online: true),
    Usuario(uid: '3', email: 'test3@gmail.com', nombre: 'Alejo', online: false),
    Usuario(uid: '4', email: 'test4@gmail.com', nombre: 'María', online: false),
    Usuario(uid: '5', email: 'test5@gmail.com', nombre: 'Camila', online: true),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Mi nombre',
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
            onPressed: () {},
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
              color: usuario.online ? Colors.green[100] : Colors.red,
              borderRadius: BorderRadius.circular(100))),
    );
  }

  _cargarUsuarios() async {
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    _refreshController.refreshCompleted();
  }
}
