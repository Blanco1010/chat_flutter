import 'dart:convert';

import 'package:chat/global/environment.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthSerive with ChangeNotifier {
  Future login(String email, String password) async {
    final data = {'email': email, 'password': password};

    final url = Uri.parse('${Enviroment.apiUrl}/login');

    final resp = await http.post(
      url,
      body: jsonEncode(data),
      headers: {'Content-Type': 'application/json'},
    );

    print(resp.body);
  }
}
