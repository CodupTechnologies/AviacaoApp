import 'package:aviacao_app/shared/themes/app_text_styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:aviacao_app/modules/perfil/perfil_controller.dart';
import 'package:aviacao_app/shared/themes/app_images.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../../shared/themes/app_colors.dart';

class PerfilPage extends StatefulWidget {
  PerfilPage({Key? key}) : super(key: key);

  @override
  State<PerfilPage> createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  final _msgController = TextEditingController();

  final user = FirebaseAuth.instance.currentUser!;

  String? msg = '';

  void loadDataFromControllers() {
    setState(() {});
  }

  @override
  void initState() {}

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Central de Mensagens'),
        centerTitle: true,
        backgroundColor: AppColors.primary,
        actions: <Widget>[
          IconButton(
            tooltip: 'Sair',
            icon: const Icon(Icons.logout_rounded),
            color: Colors.white,
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
          )
        ],
      ),
      body: Container(
        width: size.width,
        height: size.height,
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Stack(children: [
            Positioned(
              bottom: 15,
              child: Row(children: [
                SizedBox(
                  width: size.width - 20,
                  child: TextFormField(
                    controller: _msgController,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Color.fromARGB(255, 84, 85, 85),
                      fontWeight: FontWeight.w500,
                    ),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(top: 20),
                      fillColor: AppColors.stroke,
                      isDense: true,
                      hintText: "Enviar mensagem:",
                      filled: true,
                      suffixIcon: IconButton(
                        icon: Icon(
                          Icons.send,
                          size: 25,
                          color: AppColors.cinzaDois,
                        ),
                        onPressed: () {
                          setState(() {});
                        },
                      ),
                      prefixIcon: Padding(
                        padding: EdgeInsets.only(left: 8),
                        child: Icon(
                          Icons.message,
                          size: 25,
                          color: AppColors.cinzaClaro,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onTap: () {},
                  ),
                ),
              ]),
            ),
            SingleChildScrollView(
                child: Padding(
              padding: EdgeInsets.all(10),
              child: Container(),
            )),
          ]),
        ),
      ),
    );
  }
}
