import 'package:aviacao_app/shared/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:aviacao_app/shared/widgets/auth_check.dart';

class AviacaoApp extends StatelessWidget {
  const AviacaoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Aviação App',
        theme: ThemeData(primaryColor: AppColors.primary),
        initialRoute: '/',
        routes: {
          '/': (context) => AuthCheck(),
        });
  }
}
