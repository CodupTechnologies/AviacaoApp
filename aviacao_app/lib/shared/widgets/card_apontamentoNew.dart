import 'package:aviacao_app/shared/themes/app_colors.dart';
import 'package:flutter/material.dart';

class CardApontamentoNew extends StatefulWidget {
  const CardApontamentoNew({super.key});

  @override
  State<CardApontamentoNew> createState() => _CardApontamentoNewState();
}

class cardConf {
  final double altura = 240;
}

class _CardApontamentoNewState extends State<CardApontamentoNew> {
  @override
  Widget build(BuildContext context) {
    cardConf configuracacao = new cardConf();
    bool loading = false;
    double bordacampos = 20;
    final sizeT = MediaQuery.of(context).size;
    return Container(
      width: sizeT.width * 0.90,
      height: configuracacao.altura,
      decoration: BoxDecoration(
        color: AppColors.fundoCard,
        borderRadius: BorderRadius.circular(bordacampos),
      ),
    );
  }
}
