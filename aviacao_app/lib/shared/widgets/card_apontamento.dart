import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../themes/app_colors.dart';

class CardApontamento extends StatefulWidget {
  const CardApontamento({super.key});

  @override
  State<CardApontamento> createState() => _CardApontamentoState();
}

final instance = FirebaseFirestore.instance;

class cardConf {
  final double altura = 170;
}

class _CardApontamentoState extends State<CardApontamento> {
  final user = FirebaseAuth.instance.currentUser!.uid.toString();
  String veiculoApontamento = '';
  String dataApontamento = '';
  String kmInicialApontamento = '';
  bool possuiObservacaoApontamento = false;
  Map<String, dynamic> mapa = Map();
  String dia = '', mes = '', ano = '', hora = '', minuto = '', segundo = '';

  carregaDadosCard() async {
    await FirebaseFirestore.instance
        .collection('AVP_Automoveis')
        .where('condutorVeiculo', isEqualTo: user)
        .get()
        .then((QuerySnapshot snapshot) {
      for (var docSnapshot in snapshot.docs) {
        Timestamp timestam = docSnapshot['dataAtualizacao'] as Timestamp;
        DateTime data = converterTempo(timestam);
        setState(() {
          veiculoApontamento = docSnapshot['placa'].toString();
          kmInicialApontamento = docSnapshot['odometroAtual'].toString();
          dataApontamento =
              ('${data.day}/${data.month}/${data.year}  ${data.hour}:${data.minute}');
        });
      }
    });
    if (dataApontamento == '' ||
        kmInicialApontamento == '' ||
        veiculoApontamento == '') {
      setState(() {
        veiculoApontamento = 'Sem veículo';
      });
    }
    // Navigator.of(context).pop;
  }

  converterTempo(Timestamp time) {
    DateTime ti = time.toDate();
    return ti;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    carregaDadosCard();
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
                "Apontamento Atual",
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
                    veiculoApontamento, // variable
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
                    'KM Inicial: ',
                    style: TextStyle(
                        color: AppColors.primary,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                  Flexible(
                    child: Text(
                      overflow: TextOverflow.ellipsis,
                      kmInicialApontamento, // variable.
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
                    'Data: ',
                    style: TextStyle(
                        color: AppColors.primary,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                  Flexible(
                    child: Text(
                      dataApontamento, // Variable
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
