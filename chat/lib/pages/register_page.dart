import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:chat/services/auth_service.dart';
import 'package:chat/helpers/mostrar_alerta.dart';

import 'package:chat/widgets/boton_azul.dart';
import 'package:chat/widgets/labels.dart';
import 'package:chat/widgets/logo.dart';
import 'package:chat/widgets/custom_input.dart';

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF2F2F2),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Logo(
                titulo: 'Registro',
              ),
              _Form(),
              Labels(
                ruta: 'login',
                titulo: '¿Ya tienes una cuenta?',
                subtitulo: 'Ingresa ahora!',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Form extends StatefulWidget {
  @override
  __FormState createState() => __FormState();
}

class __FormState extends State<_Form> {
  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authSerive = Provider.of<AuthSerive>(context);

    final screenSize = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(top: screenSize.height * 0.01),
      padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.08),
      child: Column(
        children: <Widget>[
          CustomInput(
            icon: Icons.perm_identity,
            placeholder: 'Nombre',
            keyboradType: TextInputType.text,
            textController: nameCtrl,
          ),
          CustomInput(
            icon: Icons.email_outlined,
            placeholder: 'Correo',
            keyboradType: TextInputType.emailAddress,
            textController: emailCtrl,
          ),
          CustomInput(
            icon: Icons.lock_outline,
            placeholder: 'Contraseña',
            textController: passCtrl,
            isPassword: true,
          ),
          BotonAzul(
            text: 'Crear cuenta',
            onPressed: authSerive.autenticando
                ? null
                : () async {
                    print('Nombre: ${nameCtrl.text}');
                    print('Correo: ${emailCtrl.text}');
                    print('Contraseña: ${passCtrl.text}');
                    final registroOk = await authSerive.register(
                      nameCtrl.text.trim(),
                      emailCtrl.text.trim(),
                      passCtrl.text.trim(),
                    );
                    if (registroOk == true) {
                      Navigator.pushReplacementNamed(context, 'usuarios');
                    } else {
                      mostrarAlerta(context, 'Registro incorrecto', registroOk);
                    }
                  },
          )
        ],
      ),
    );
  }
}
