import 'package:aviacao_app/modules/abastecimento/abastecimento_page.dart';
import 'package:aviacao_app/modules/apontamento/apontamento_page.dart';
import 'package:aviacao_app/shared/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:aviacao_app/shared/widgets/auth_check.dart';

class AviacaoApp extends StatelessWidget {
  const AviacaoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Aviação App',
        theme: ThemeData(primaryColor: AppColors.primary),
        initialRoute: '/',
        routes: {
          '/': (context) => AuthCheck(),
          '/Apontamento': ((context) => ApontamentoPage()),
          '/Abastecimento': ((context) => AbastecimentoPage()),
        });
  }
}
