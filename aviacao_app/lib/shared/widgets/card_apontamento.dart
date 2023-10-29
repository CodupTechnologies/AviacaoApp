import 'package:flutter/material.dart';

import '../themes/app_colors.dart';

class CardApontamento extends StatefulWidget {
  const CardApontamento({super.key});

  @override
  State<CardApontamento> createState() => _CardApontamentoState();
}

class cardConf {
  final double altura = 240;
}

class _CardApontamentoState extends State<CardApontamento> {
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
      child: Padding(
        padding:
            const EdgeInsets.only(left: 20, top: 20, bottom: 20, right: 12),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Apontamento Diário",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w400),
              ),
              Row(
                children: [
                  Text(
                    'Veiculo atual: ',
                    style: TextStyle(
                        color: AppColors.cinzaDois,
                        fontSize: 20,
                        fontWeight: FontWeight.w400),
                  ),
                  Text(
                    ' HML-1093', // variable
                    style: TextStyle(
                        color: AppColors.secondary,
                        fontSize: 20,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    'Combustivel: ',
                    style: TextStyle(
                        color: AppColors.primary,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                  Flexible(
                    child: Text(
                      overflow: TextOverflow.ellipsis,
                      'Querosene', // variable.
                      style: TextStyle(
                          color: AppColors.cinzaClaro,
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  SizedBox(width: 15),
                  Text(
                    'QTD: ',
                    style: TextStyle(
                        color: AppColors.primary,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                  Flexible(
                    child: Text(
                      overflow: TextOverflow.ellipsis,
                      '1200L', // variable
                      style: TextStyle(
                          color: AppColors.cinzaClaro,
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    'Data registro: ',
                    style: TextStyle(
                        color: AppColors.primary,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                  Flexible(
                    child: Text(
                      '10/02/2023', // Variable
                      style: TextStyle(
                          color: AppColors.cinzaClaro,
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            ]),
      ),
    );
  }
}
