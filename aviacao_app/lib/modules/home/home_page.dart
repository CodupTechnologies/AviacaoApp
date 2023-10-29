import 'package:aviacao_app/modules/historico/historico_page.dart';
import 'package:aviacao_app/modules/home/principal_page.dart';
import 'package:aviacao_app/modules/perfil/perfil_page.dart';
import 'package:aviacao_app/shared/themes/app_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser!;
  int paginaAtual = 0;
  late PageController paginaController;
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    paginaController = PageController(initialPage: paginaAtual);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: paginaController,
        //Code to the page right here.
        children: [
          PrincipalPage(),
          HistoricoPage(),
          //   PerfilPage(),
        ],
        onPageChanged: (page) {
          setState(() {
            selectedIndex = page;
          });
        },
      ),
      bottomNavigationBar: Container(
        child: Padding(
          padding:
              const EdgeInsets.only(top: 5, right: 30, bottom: 5, left: 30),
          child: GNav(
            padding: EdgeInsets.symmetric(horizontal: 45, vertical: 15),
            gap: 5,
            color: AppColors.grey,
            activeColor: AppColors.grey,
            tabBackgroundColor: AppColors.primary.withOpacity(0.3),
            iconSize: 24,
            tabs: [
              GButton(
                icon: Icons.home,
                text: 'Home',
              ),
              GButton(icon: Icons.search, text: 'Busca'),
              //    GButton(icon: Icons.person, text: 'Perfil'),
            ],
            selectedIndex: selectedIndex,
            onTabChange: (index) {
              setState(() {
                selectedIndex = index;
              });
              paginaController.jumpToPage(index);
            },
          ),
        ),
      ),
    );
  }
}
