import 'package:aviacao_app/modules/relogioPonto/relogioPonto_controller.dart';
import 'package:aviacao_app/shared/themes/app_colors.dart';
import 'package:aviacao_app/shared/themes/style_guidelines.dart';
import 'package:aviacao_app/shared/widgets/cardPontoWidget.dart';
import 'package:aviacao_app/shared/widgets/cardRelogioPontoController.dart';
import 'package:aviacao_app/shared/widgets/card_registroPonto.dart';
import 'package:aviacao_app/shared/widgets/usefull_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class RelogioPontoPage extends StatefulWidget {
  const RelogioPontoPage({super.key});

  @override
  State<RelogioPontoPage> createState() => _RelogioPontoPageState();
}

class _RelogioPontoPageState extends State<RelogioPontoPage> {
  String latitude = "";
  String longitude = "";
  bool isChecked = false;
  String hora = "";
  String minuto = "";
  String segundo = "";

  Future<Position> pegarPosicao() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    Position posicao = await Geolocator.getCurrentPosition();
    setState(() {
      latitude = posicao.latitude.toString();
      longitude = posicao.longitude.toString();
    });
    return await Geolocator.getCurrentPosition();
  }

  getTime() {
    setState(() {
      hora = DateTime.now().hour.toString();
      minuto = DateTime.now().minute.toString();
      segundo = DateTime.now().second.toString();
    });
  }

  String setTypeOfTurn(bool type) {
    if (type == true) {
      return 'Almoco';
    }
    return 'Normal';
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    pegarPosicao();
    getTime();
    final _user = FirebaseAuth.instance.currentUser!;

    return Scaffold(
      appBar: AppBar(
        actions: [],
        title: const Text('Registro de ponto'),
        centerTitle: true,
        backgroundColor: AppColors.primary,
      ),
      body: Column(
        children: [
          Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Padding(
              padding: const EdgeInsets.only(
                  top: 15, bottom: 10, right: 20, left: 20),
              child: Text(
                'Ao pressionar o botão de registrar, sua localização de GPS será adicionada ao registro.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.vermelho2,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [Icon(Icons.location_on)],
                ),
                SizedBox(width: 15),
                Column(
                  children: [
                    Row(
                      children: [Text(longitude)],
                    ),
                    Row(
                      children: [Text(latitude)],
                    )
                  ],
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 5),
              child: Text('Horário do registro: '),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  hora + ' : ' + minuto + ' : ' + segundo,
                  style: TextStyle(
                      color: AppColors.primary,
                      fontSize: 28,
                      fontWeight: FontWeight.w700),
                )
              ],
            ),
          ]),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Checkbox(
                checkColor: Colors.white,
                value: isChecked,
                onChanged: (bool? value) {
                  setState(() {
                    isChecked = value!;
                  });
                },
              ),
              Text("Saída/Entrada almoço"),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  try {
                    setTurnos(_user.uid, DateTime.now(), latitude, longitude,
                        isChecked);
                  } on Exception catch (e) {
                    print(e);
                  }

                  bottomMessage(context, "Registro efetuado com sucesso", 4);
                },
                child: Text('Registrar Ponto'),
                style: RegistroPonto,
              ),
            ],
          ),
          const SizedBox(height: 10),
          Expanded(
              child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('AVP_ControlePonto')
                      .orderBy('dataHoraPonto', descending: true)
                      .snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting &&
                        !snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (snapshot.hasData) {
                      return ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            final DocumentSnapshot documentSnapshot =
                                snapshot.data!.docs[index];

                            String tipoR =
                                documentSnapshot['tipoPonto'].toString();
                            DateTime timeR =
                                (documentSnapshot['dataHoraPonto'] as Timestamp)
                                    .toDate();
                            String _usuario = _user.uid.toString();

                            if (_usuario ==
                                documentSnapshot['codUser'].toString()) {
                              return CardControlePonto(
                                tipoRegistro: tipoR,
                                almoco: true,
                                dataRegistro: timeR,
                                user: _user.uid.toString(),
                                docId: documentSnapshot.id,
                                loading: false,
                              );
                            }
                            // chamaWidget() {
                            //   return cardPontoWidget(
                            //       tipoR,
                            //       true,
                            //       timeR,
                            //       _user.uid.toString(),
                            //       documentSnapshot.id,
                            //       false,
                            //       context);
                            // }

                            //chamaWidget()
                            //  chamaCard();
                            //return Text('aaaa');
                            //mudar esquema do banco de dados para se adaptar e nao term collection dentro de collection
                          });
                    } else {
                      return Text("Não encontramos nenhum ponto registrado");
                    }
                  })),
        ],
      ),
    );
  }
}
