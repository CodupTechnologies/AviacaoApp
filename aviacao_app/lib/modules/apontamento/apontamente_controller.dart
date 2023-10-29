import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

final _user = FirebaseAuth.instance.currentUser!.uid.toString();
var message = '';

Future salvarApontamento(
    DateTime data,
    DateTime dataRegistro,
    String hora,
    String veiculo,
    String codVeiculo,
    String codAeronave,
    String combustivelApontamento,
    String odometroInicial,
    String odometroFinal,
    String tanqueInicial,
    String tanqueFinal,
    String aeronaveApontamento,
    String tanqueAeronaveInicial,
    String tanqueAeronaveFinal,
    context) async {
  await FirebaseFirestore.instance.collection("AVP_Apontamentos").add({
    'codUser': _user,
    'dataRegistro': dataRegistro,
    'dataApontamento': data,
    'horaApontamento': hora,
    'veiculoApontamento': veiculo,
    'combustivel': combustivelApontamento,
    'odometroInicial': odometroInicial,
    'odometroFinal': odometroFinal,
    'registroTanqueInicial': tanqueInicial,
    'registroTanqueFinal': tanqueFinal,
    'regAeronave': aeronaveApontamento,
    'tanqueAeronaveInicial': tanqueAeronaveInicial,
    'tanqueAeronaveFinal': tanqueAeronaveFinal,
  }).then((res) => message = 'Dados inseridos com sucesso',
      onError: (e) => message = 'Erro: $e');

  if (tanqueFinal.isNotEmpty) {
    await FirebaseFirestore.instance
        .collection("AVP_Automoveis")
        .doc(codVeiculo)
        .update({'combustivelTransporteAtual': tanqueFinal});
  }
  if (odometroFinal.isNotEmpty) {
    await FirebaseFirestore.instance
        .collection("AVP_Automoveis")
        .doc(codVeiculo)
        .update({'odometroAtual': odometroFinal});
  }
  if (tanqueAeronaveFinal.isNotEmpty) {
    await FirebaseFirestore.instance
        .collection("AVP_Aeronaves")
        .doc(codAeronave)
        .update({'tanqueAtual': tanqueAeronaveFinal});
  }

  return ScaffoldMessenger.of(context)
      .showSnackBar(SnackBar(content: Text(message)));
}
