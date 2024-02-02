import 'package:aviacao_app/shared/widgets/card_apontamento.dart';
import 'package:aviacao_app/shared/widgets/card_relogioPonto.dart';
import 'package:aviacao_app/shared/widgets/fab_flow_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../shared/themes/app_colors.dart';

class PrincipalPage extends StatefulWidget {
  PrincipalPage({Key? key}) : super(key: key);

  @override
  State<PrincipalPage> createState() => _PrincipalPageState();
}

class _PrincipalPageState extends State<PrincipalPage> {
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    final agoraTime = DateTime.now();
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Principal'),
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
        elevation: 0,
      ),
      body: Container(
        width: size.width,
        height: size.height,
        child: Stack(
          children: [
            Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 10),
                  child: CardControle(),
                ),
                CardApontamento(),
              ],
            ),
            Positioned(
                bottom: 20,
                child: (FabFlowButton(
                    textoBotaoOne: 'Abastecimento',
                    textoBotaoTwo: 'Apontamento',
                    display: size.width,
                    onTapTwo: () {
                      Navigator.of(context).pushNamed('/Apontamento');
                    },
                    onTapOne: () {
                      Navigator.of(context).pushNamed('/Abastecimento');
                    },
                    buttonWidth: size.width * 0.40,
                    loading: false)))
          ],
        ),
      ),
    );
  }
}
