import 'package:aviacao_app/shared/widgets/cardRelogioPontoController.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core_platform_interface/firebase_core_platform_interface.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../themes/app_colors.dart';
import '../themes/style_guidelines.dart';

class CardControle extends StatefulWidget {
  final String tipoPonto;
  final String horaInicio;
  final String horaFim;
  final DateTime dateRegister;

  final bool loading;

  const CardControle(
      {Key? key,
      required this.tipoPonto,
      required this.horaInicio,
      required this.horaFim,
      required this.dateRegister,
      required this.loading})
      : super(key: key);

  @override
  State<CardControle> createState() => _CardControleState();
}

class _CardControleState extends State<CardControle> {
  final String veiculoUser = 'DKE- 8269F';

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;

    final sizeT = MediaQuery.of(context).size;
    bool loading = false;
    double bordacampos = 20;
    final agora = DateTime.now();

    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Container(
        width: sizeT.width * 0.90,
        height: 210,
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
                        overflow: TextOverflow.ellipsis,
                        'Tipo Ponto: ',
                        style: TextStyle(
                            color: AppColors.vermelho2,
                            fontSize: 12,
                            fontWeight: FontWeight.w500),
                      ),
                      Flexible(
                          child: Text(
                        widget.tipoPonto,
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w500),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        softWrap: false,
                      )),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'Veículo: ',
                        style: TextStyle(
                            color: AppColors.grey,
                            fontSize: 12,
                            fontWeight: FontWeight.w500),
                      ),
                      Flexible(
                          child: Text(
                        veiculoUser,
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w500),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        softWrap: false,
                      )),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Intervalo das: ',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w500),
                      ),
                      Text(widget.horaInicio,
                          style: TextStyle(
                              color: AppColors.letraExame,
                              fontSize: 14,
                              fontWeight: FontWeight.w600),
                          overflow: TextOverflow.ellipsis),
                      Text(
                        ' Até: ',
                        style: TextStyle(
                            overflow: TextOverflow.ellipsis,
                            fontSize: 12,
                            fontWeight: FontWeight.w500),
                      ),
                      Text(widget.horaFim,
                          style: TextStyle(
                              color: AppColors.letraExame,
                              fontSize: 14,
                              fontWeight: FontWeight.w600),
                          overflow: TextOverflow.ellipsis),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Entrada: ',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      Text(widget.horaInicio,
                          style: TextStyle(
                              color: AppColors.letraExame,
                              fontSize: 18,
                              fontWeight: FontWeight.w600),
                          overflow: TextOverflow.ellipsis),
                      Text(
                        ' Saída: ',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      Text(widget.horaFim,
                          style: TextStyle(
                              color: AppColors.letraExame,
                              fontSize: 18,
                              fontWeight: FontWeight.w600),
                          overflow: TextOverflow.ellipsis),
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
                          size: 18,
                        ),
                        style: timerButtonStyle,
                        label: Text('Adicionar'),
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(25.0))),
                                    title: Text('Registrar ponto'),
                                    content: SizedBox(
                                      height: 190,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Ao pressionar o botão de registrar, sua localização de GPS será adicionada ao registro.',
                                            style: TextStyle(
                                                color: AppColors.vermelho2),
                                          ),
                                          SizedBox(height: 10),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Column(
                                                children: [
                                                  Icon(Icons.location_on)
                                                ],
                                              ),
                                              SizedBox(width: 15),
                                              ChangeNotifierProvider<
                                                  RelogioPontoController>(
                                                create: (context) =>
                                                    RelogioPontoController(),
                                                child: Builder(
                                                  builder: (context) {
                                                    final local = context.watch<
                                                        RelogioPontoController>();
                                                    return Column(children: [
                                                      Text(
                                                          'Latitude: ${local.latitude}'),
                                                      Text(
                                                          'Longitude: ${local.longitude}'),
                                                    ]);
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 15, bottom: 10),
                                            child:
                                                Text('Horário do registro: '),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                DateTime.now().hour.toString() +
                                                    ' : ' +
                                                    DateTime.now()
                                                        .minute
                                                        .toString() +
                                                    ' : ' +
                                                    DateTime.now()
                                                        .second
                                                        .toString(),
                                                style: TextStyle(
                                                    color: AppColors.primary,
                                                    fontSize: 28,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    actions: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 15, right: 15),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Text(
                                                  'Cancelar',
                                                  style: TextStyle(
                                                      color:
                                                          AppColors.vermelho2,
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )),
                                            TextButton(
                                                onPressed: () async {
                                                  setTurno(
                                                      user.uid.toString(),
                                                      agora,
                                                      14515,
                                                      123151,
                                                      'Entrada');

                                                  print('aqui');
                                                },
                                                child: Text(
                                                  "Registrar ponto",
                                                  style: TextStyle(
                                                      color: AppColors.primary,
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ));
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
