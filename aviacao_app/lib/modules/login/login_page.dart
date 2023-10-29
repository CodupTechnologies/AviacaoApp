import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../services/auth_service.dart';
import '../../shared/themes/app_colors.dart';
import '../../shared/themes/app_images.dart';
import '../../shared/widgets/regular_login_button.dart';
import '../cadastroUsuario/cadastrar_usuario_page.dart';
import '../resetarSenha/resetar_senha_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
//text Controllers

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  var _passwordVisible = false;
  bool loading = false;

  @override
  void initState() {
    _passwordVisible = false;
  }

  login() async {
    setState(() => loading = true);
    try {
      await context
          .read<AuthService>()
          .login(_emailController.text, _passwordController.text);
    } on AuthException catch (e) {
      print(e);
      setState(() => loading = false);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message)));
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
            width: size.width,
            height: size.height,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    AppImages.fundoLogin,
                  ),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.65), BlendMode.darken)),
            ),
            child: Stack(children: [
              Form(
                  child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 40, right: 40),
                    child: Container(
                        width: w,
                        height: h * 0.4,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                          image: AssetImage(AppImages.logoFull),
                          scale: 0.8,
                          alignment: Alignment.bottomCenter,
                        ))),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Padding(
                    //Campo de Usuário
                    padding:
                        const EdgeInsets.only(left: 30, right: 30, top: 30),
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
                        hintText: 'Usuário',
                        contentPadding: const EdgeInsets.only(
                            left: 14.0, bottom: 8.0, top: 8.0),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 1.0),
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
                    //Campo de Senha
                    padding:
                        const EdgeInsets.only(left: 30, right: 30, top: 15),
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      controller: _passwordController,
                      autofocus: false,
                      obscureText: !_passwordVisible,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Senha',
                        suffixIcon: IconButton(
                          icon: Icon(
                            _passwordVisible
                                ? Icons.visibility_rounded
                                : Icons.visibility_off_rounded,
                            color: AppColors.grey,
                          ),
                          onPressed: () {
                            setState(() {
                              _passwordVisible = !_passwordVisible;
                            });
                          },
                        ),
                        contentPadding: const EdgeInsets.only(
                            left: 14.0, bottom: 8.0, top: 8.0),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 1.0),
                            borderRadius: BorderRadius.circular(5)),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Informe sua senha!';
                        } else if (value.length < 6) {
                          return 'Sua senha deve ter no minimo 6 caracteres';
                        } else
                          return null;
                      },
                    ),
                  ),
                  Padding(
                      //Botão de email
                      padding: const EdgeInsets.only(
                          left: 30, right: 30, top: 15, bottom: 15),
                      child: LoginButtonRegular(
                          loading: loading,
                          textoBotao: 'Entrar com Email',
                          onTap: () {
                            if (_emailController.text == '') {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text('Insira um email'),
                              ));
                            } else if (_passwordController.text == '') {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text('Insira uma senha'),
                              ));
                            } else if (_passwordController.text == '' &&
                                _emailController.text == '') {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text(
                                    'Insira uma email e senha corretamente'),
                              ));
                            } else {
                              login();
                            }
                          })),
                  Padding(
                    padding: const EdgeInsets.only(left: 30, right: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "Esqueceu sua senha?",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppColors.input,
                          ),
                          textAlign: TextAlign.start,
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return const resetarSenhaPage();
                              }));
                            },
                            child: Text("Lembrar Senha",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.primary,
                                )))
                      ],
                    ),
                  ),
                ],
              )),
              Stack(alignment: Alignment.center, children: [
                Positioned(
                  bottom: size.height * 0.04,
                  child: Row(
                    children: [
                      Text(
                        "Ainda não possui uma conta?",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.input,
                        ),
                        textAlign: TextAlign.start,
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return const CadastrarUsuarioPage();
                            }));
                          },
                          child: Text("Cadastre-se",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: AppColors.amarelo,
                              )))
                    ],
                  ),
                ),
              ]),
            ])),
      ),
    );
  }
}
