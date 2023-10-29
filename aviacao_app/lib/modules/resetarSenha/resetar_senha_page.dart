import 'dart:async';

import 'package:aviacao_app/shared/widgets/regular_login_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../shared/themes/app_colors.dart';

class resetarSenhaPage extends StatefulWidget {
  const resetarSenhaPage({Key? key}) : super(key: key);

  @override
  State<resetarSenhaPage> createState() => _resetarSenhaPageState();
}

class _resetarSenhaPageState extends State<resetarSenhaPage> {
  @override
  final _emailController = TextEditingController();
  bool loading = false;
  String mensagem = '';

  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future passwordReset() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _emailController.text.trim());
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content:
            Text('Email de recuperação enviado, verifique sua caixa de span'),
      ));

      Timer(Duration(seconds: 3), () {
        Navigator.pop(context);
      });
    } on FirebaseAuthException catch (e) {
      print(e);
      if (e.code == 'user-not-found')
        mensagem = 'O usuário não foi encontrado.';
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text(mensagem),
            );
          });
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 230, 230, 230),
      appBar: AppBar(
        title: const Text('Resetar senha'),
        centerTitle: true,
        backgroundColor: AppColors.primary,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Esqueceu sua senha? ',
            style: TextStyle(fontSize: 28),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 40, right: 30, top: 30),
            child: Text(
              'Entre seu e-mail e nós enviaremos um link para recuperar o seu email.',
              style: TextStyle(fontSize: 16),
            ),
          ),
          Padding(
            //Campo de Usuário
            padding: const EdgeInsets.only(left: 30, right: 30, top: 30),
            child: TextFormField(
              keyboardType: TextInputType.emailAddress,
              controller: _emailController,
              autofocus: false,
              style: const TextStyle(
                fontSize: 16,
                color: Color.fromARGB(255, 84, 85, 85),
                fontWeight: FontWeight.w500,
              ),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: 'Email da conta',
                contentPadding:
                    const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(5),
                ),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 1.0),
                    borderRadius: BorderRadius.circular(5)),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Informe o email corretamente!';
                } else
                  return null;
              },
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 30, right: 30, top: 15, bottom: 15),
            child: LoginButtonRegular(
                textoBotao: 'Resetar senha',
                onTap: () {
                  passwordReset();
                },
                loading: loading),
          )
        ],
      ),
    );
  }
}
