import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class RelogioPontoController extends ChangeNotifier {
  double latitude = 0.0;
  double longitude = 0.0;
  String erro = '';

  RelogioPontoController() {
    getPosicao();
  }

  getPosicao() async {
    try {
      Position posicao = await _posicaoAtual();

      latitude = posicao.latitude;
      longitude = posicao.longitude;
    } catch (e) {
      erro = e.toString();
    }
    notifyListeners();
  }

  Future<Position> _posicaoAtual() async {
    LocationPermission permissao;
    bool ativado = await Geolocator.isLocationServiceEnabled();
    if (!ativado) {
      return Future.error("Habilite o GPS");
    }

    permissao = await Geolocator.checkPermission();
    if (permissao == LocationPermission.denied) {
      permissao = await Geolocator.requestPermission();
      if (permissao == LocationPermission.denied) {
        return Future.error("É necessário autorizar o uso de GPS");
      }
    }
    if (permissao == LocationPermission.deniedForever) {
      return Future.error("É necessário autorizar o uso de GPS");
    }

    return await Geolocator.getCurrentPosition();
  }
}

Future setTurno(String codUser, DateTime dataHora, double posLatitude,
    double posLongitude, String tipoLancamento) async {
  final String codCollectionTurno =
      'avpTurnoCol_${dataHora.day}-${dataHora.month}-${dataHora.year}';
  await FirebaseFirestore.instance
      .collection('AVP_ControlePonto')
      .doc(codUser.toString())
      .collection(codCollectionTurno)
      .add({
    'codUser': codUser,
    'dataHoraPonto': dataHora,
    'turnoLatitude': posLatitude,
    'turnoLongitude': posLongitude,
    'tipoPonto': tipoLancamento
  }).then((res) => print("Ponto registrado com sucesso"),
          onError: (e) => print("Erro no Lançamento"));
}
