import 'package:aviacao_app/modules/login/login_page.dart';
import 'package:aviacao_app/shared/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../services/auth_service.dart';
import '../../shared/themes/app_images.dart';
import '../../shared/widgets/regular_login_button.dart';

class CadastrarUsuarioPage extends StatefulWidget {
  const CadastrarUsuarioPage({Key? key}) : super(key: key);

  @override
  State<CadastrarUsuarioPage> createState() => _CadastrarUsuarioPageState();
}

class _CadastrarUsuarioPageState extends State<CadastrarUsuarioPage> {
  final _emailController = TextEditingController();
  final _passwordController1 = TextEditingController();
  final _passwordController = TextEditingController();
  final _nomeController = TextEditingController();
  var _passwordVisible = false;
  bool loading = false;
  String textSnack = '';

  @override
  void initState() {
    _passwordVisible = false;
  }

  registrar() async {
    setState(() => loading = true);
    try {
      await context.read<AuthService>().registrar(_emailController.text,
          _passwordController1.text, _nomeController.text);
    } on AuthException catch (e) {
      setState(() => loading = false);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message)));
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _passwordController1.dispose();
    _nomeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Cadastro de Usuário'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_rounded, // add custom icons also
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: size.width,
          height: size.height,
          color: AppColors.grey,
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.only(right: 40, left: 40),
              child: Container(
                  width: w,
                  height: h * 0.35,
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
              padding: const EdgeInsets.only(left: 30, right: 30, top: 20),
              child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: _nomeController,
                autofocus: false,
                style: const TextStyle(
                  fontSize: 16,
                  color: Color.fromARGB(255, 84, 85, 85),
                  fontWeight: FontWeight.w500,
                ),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Nome:',
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
              //Campo de Usuário
              padding: const EdgeInsets.only(left: 30, right: 30, top: 15),
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
                  hintText: 'Email:',
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
              //Campo de Senha
              padding: const EdgeInsets.only(left: 30, right: 30, top: 15),
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
                  hintText: 'Senha:',
                  suffixIcon: IconButton(
                    icon: Icon(
                      _passwordVisible
                          ? Icons.visibility_rounded
                          : Icons.visibility_off_rounded,
                      color: AppColors.input,
                    ),
                    onPressed: () {
                      setState(() {
                        _passwordVisible = !_passwordVisible;
                      });
                    },
                  ),
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
                    return 'Informe sua senha!';
                  } else if (value.length < 6) {
                    return 'Sua senha deve ter no minimo 6 caracteres';
                  } else
                    return null;
                },
              ),
            ),
            Padding(
              //Campo de Senha
              padding: const EdgeInsets.only(left: 30, right: 30, top: 15),
              child: TextFormField(
                keyboardType: TextInputType.text,
                controller: _passwordController1,
                autofocus: false,
                obscureText: !_passwordVisible,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Confirme sua senha:',
                  suffixIcon: IconButton(
                    icon: Icon(
                      _passwordVisible
                          ? Icons.visibility_rounded
                          : Icons.visibility_off_rounded,
                      color: AppColors.input,
                    ),
                    onPressed: () {
                      setState(() {
                        _passwordVisible = !_passwordVisible;
                      });
                    },
                  ),
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
                    textoBotao: 'Cadastrar usuário',
                    onTap: () {
                      if (_passwordController.text == '' &&
                          _emailController.text == '') {
                        textSnack = 'Insira um email e senha';
                      } else if (_passwordController.text == '') {
                        textSnack = 'Insira uma senha';
                      } else if (_emailController.text == '') {
                        textSnack = 'Insira um email';
                      } else if (_passwordController.value !=
                          _passwordController1.value) {
                        textSnack = 'As senhas são diferentes';
                      } else {
                        registrar();
                        textSnack = 'Usuário Cadastrado com sucesso';
                      }
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text(textSnack)));
                      Future.delayed(const Duration(milliseconds: 500), () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return const LoginPage();
                        }));
                      });
                    })),
          ]),
        ),
      ),
    );
  }
}
