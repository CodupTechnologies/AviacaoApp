import 'package:aviacao_app/shared/widgets/cardRelogioPontoController.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../themes/app_colors.dart';
import '../themes/style_guidelines.dart';

class CardControle extends StatefulWidget {
  final bool loading = false;

  const CardControle({
    Key? key,
  }) : super(key: key);

  @override
  State<CardControle> createState() => _CardControleState();
}

class _CardControleState extends State<CardControle> {
  final user = FirebaseAuth.instance.currentUser!;
  String especiePontos = '';

  void loadData() async {
    int counterPonts = 0;
    var dados = Map();
    DateTime dataPonto;
    final agoraa = DateTime.now();

    await FirebaseFirestore.instance
        .collection('AVP_ControlePonto')
        .where('codUser', isEqualTo: user.uid.toString())
        .get()
        .then((QuerySnapshot) {
      for (var docSnapshot in QuerySnapshot.docs) {
        dados = docSnapshot.data() as Map<String, dynamic>;
        dataPonto = (dados['dataHoraPonto'] as Timestamp).toDate();
        if (dataPonto.day == agoraa.day &&
            dataPonto.month == agoraa.month &&
            dataPonto.year == agoraa.year) {
          counterPonts++;
        }
      }
      if (counterPonts == 0) {
        setState(() {
          especiePontos = 'Fechado';
        });
      } else if (counterPonts.isEven) {
        setState(() {
          especiePontos = 'Fechado';
        });
      } else if (counterPonts.isOdd) {
        setState(() {
          especiePontos = 'Aberto';
        });
      }
    });
  }

  @override
  void initState() {
    loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    final sizeT = MediaQuery.of(context).size;
    bool loading = false;
    double bordacampos = 20;
    final agora = DateTime.now();
    loadData();
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Container(
        width: sizeT.width * 0.90,
        height: 140,
        decoration: BoxDecoration(
          color: AppColors.fundoCard,
          borderRadius: BorderRadius.circular(bordacampos),
        ),
        child: Stack(children: [
          Container(
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 20, top: 20, bottom: 20, right: 12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        'Controle de Ponto',
                        style: TextStyle(
                            color: AppColors.primary,
                            fontSize: 20,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'Dia: ',
                        style: TextStyle(
                            color: AppColors.secondary,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                      Flexible(
                        child: Text(
                          '${agora.day}/${agora.month}/${agora.year}',
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
                        'Status: ',
                        style: TextStyle(
                            color: AppColors.secondary,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                      Flexible(
                        child: Text(
                          especiePontos,
                          style: TextStyle(
                              color: especiePontos == 'Aberto'
                                  ? AppColors.vermelho2
                                  : AppColors.letraExame,
                              fontSize: 20,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            right: 10,
            top: 10,
            child: Column(
              children: [
                Container(
                  width: 120,
                  height: 70,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 8, bottom: 10, right: 8, left: 8),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            '${agora.hour} : ${agora.minute}',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 26,
                                fontWeight: FontWeight.w700),
                          ),
                          Text(
                            'Registro ponto',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                          ),
                        ]),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: SizedBox(
                      width: 120,
                      child: ElevatedButton.icon(
                        icon: Icon(
                          Icons.add,
                          size: 20,
                        ),
                        style: timerButtonStyle,
                        label: Text('Registrar'),
                        onPressed: () {
                          Navigator.of(context).pushNamed('/RegistroPonto');
                          // showDialog(
                          //     context: context,
                          //     builder: (context) => AlertDialog(
                          //           shape: RoundedRectangleBorder(
                          //               borderRadius: BorderRadius.all(
                          //                   Radius.circular(25.0))),
                          //           title: Text('Registrar ponto'),
                          //           content: SizedBox(
                          //             height: 250,
                          //             child: Column(
                          //               crossAxisAlignment:
                          //                   CrossAxisAlignment.center,
                          //               children: [
                          //                 Text(
                          //                   'Ao pressionar o botão de registrar, sua localização de GPS será adicionada ao registro.',
                          //                   style: TextStyle(
                          //                       color: AppColors.vermelho2),
                          //                 ),
                          //                 SizedBox(height: 10),
                          //                 Row(
                          //                   mainAxisAlignment:
                          //                       MainAxisAlignment.center,
                          //                   children: [
                          //                     Column(
                          //                       children: [
                          //                         Icon(Icons.location_on)
                          //                       ],
                          //                     ),
                          //                     SizedBox(width: 15),
                          //                     ChangeNotifierProvider<
                          //                         RelogioPontoController>(
                          //                       create: (context) =>
                          //                           RelogioPontoController(),
                          //                       child: Builder(
                          //                         builder: (context) {
                          //                           final local = context.watch<
                          //                               RelogioPontoController>();
                          //                           return Column(children: [
                          //                             Text(
                          //                                 'Latitude: ${local.latitude}'),
                          //                             Text(
                          //                                 'Longitude: ${local.longitude}'),
                          //                           ]);
                          //                         },
                          //                       ),
                          //                     ),
                          //                   ],
                          //                 ),
                          //                 Padding(
                          //                   padding: const EdgeInsets.only(
                          //                       top: 15, bottom: 10),
                          //                   child:
                          //                       Text('Horário do registro: '),
                          //                 ),
                          //                 Row(
                          //                   mainAxisAlignment:
                          //                       MainAxisAlignment.center,
                          //                   children: [
                          //                     Text(
                          //                       DateTime.now().hour.toString() +
                          //                           ' : ' +
                          //                           DateTime.now()
                          //                               .minute
                          //                               .toString() +
                          //                           ' : ' +
                          //                           DateTime.now()
                          //                               .second
                          //                               .toString(),
                          //                       style: TextStyle(
                          //                           color: AppColors.primary,
                          //                           fontSize: 28,
                          //                           fontWeight:
                          //                               FontWeight.w700),
                          //                     )
                          //                   ],
                          //                 ),
                          //                 Padding(
                          //                   padding:
                          //                       const EdgeInsets.only(top: 10),
                          //                   child: Row(
                          //                     mainAxisAlignment:
                          //                         MainAxisAlignment.center,
                          //                     children: [
                          //                       Text(
                          //                           'Saída/Entrada do almoço: '),
                          //                       Checkbox(
                          //                           value: isChecked,
                          //                           onChanged: (bool? value) {
                          //                             setState(() {
                          //                               isChecked = value!;
                          //                             });
                          //                           })
                          //                     ],
                          //                   ),
                          //                 ),
                          //               ],
                          //             ),
                          //           ),
                          //           actions: [
                          //             Padding(
                          //               padding: const EdgeInsets.only(
                          //                   left: 15, right: 15),
                          //               child: Row(
                          //                 mainAxisAlignment:
                          //                     MainAxisAlignment.spaceBetween,
                          //                 children: [
                          //                   TextButton(
                          //                       onPressed: () {
                          //                         Navigator.pop(context);
                          //                       },
                          //                       child: Text(
                          //                         'Cancelar',
                          //                         style: TextStyle(
                          //                             color:
                          //                                 AppColors.vermelho2,
                          //                             fontSize: 18,
                          //                             fontWeight:
                          //                                 FontWeight.w500),
                          //                       )),
                          //                   TextButton(
                          //                       onPressed: () async {
                          //                         setTurno(
                          //                             user.uid.toString(),
                          //                             agora,
                          //                             14515,
                          //                             123151,
                          //                             'Entrada');

                          //                         print('aqui');
                          //                       },
                          //                       child: Text(
                          //                         "Registrar ponto",
                          //                         style: TextStyle(
                          //                             color: AppColors.primary,
                          //                             fontSize: 18,
                          //                             fontWeight:
                          //                                 FontWeight.w500),
                          //                       )),
                          //                 ],
                          //               ),
                          //             ),
                          //           ],
                          //         ));
                        },
                      )),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
