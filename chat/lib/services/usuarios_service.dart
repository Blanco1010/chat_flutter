import 'package:http/http.dart' as http;

import 'package:chat/models/usuarios_responde.dart';
import 'package:chat/models/usuarios.dart';

import 'package:chat/global/environment.dart';

import 'package:chat/services/auth_service.dart';

class UsuariosService {
  Future<List<Usuario>> getUsuarios() async {
    final url = Uri.parse('${Enviroment.apiUrl}/usuarios');
    try {
      final resp = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'x-token': await AuthSerive.getToken()
        },
      );

      final usuarioResponse = usuarioResponseFromJson(resp.body);

      return usuarioResponse.usuarios;
    } catch (e) {
      return [];
    }
  }
}
