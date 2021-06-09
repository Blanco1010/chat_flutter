import 'dart:convert';
import 'package:chat/models/usuarios.dart';
import 'package:http/http.dart' as http;

import 'package:chat/global/environment.dart';
import 'package:chat/models/login_response.dart';
import 'package:flutter/material.dart';

class AuthSerive with ChangeNotifier {
  Usuario usuario;
  bool _autenticando = false;

  bool get autenticando => this._autenticando;
  set autenticando(bool valor) {
    this._autenticando = valor;
    notifyListeners();
  }

  Future login(String email, String password) async {
    this.autenticando = true;

    final data = {'email': email, 'password': password};

    final url = Uri.parse('${Enviroment.apiUrl}/login');

    final resp = await http.post(
      url,
      body: jsonEncode(data),
      headers: {'Content-Type': 'application/json'},
    );

    print(resp.body);
    if (resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson(resp.body);
      this.usuario = loginResponse.usuario;
    }
    this._autenticando = false;
    notifyListeners();
  }
}
