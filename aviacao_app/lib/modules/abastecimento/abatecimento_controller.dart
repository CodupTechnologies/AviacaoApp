import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

final _user = FirebaseAuth.instance.currentUser!.uid.toString();
var message = '';

Future saveAbastecimento(
    DateTime data,
    String hora,
    String tipoAbastecimento,
    String combustivelAbastecimento,
    String odometroInicial,
    String odometroFinal,
    String origem,
    String destino,
    String quantidade,
    context) async {
  await FirebaseFirestore.instance.collection("AVP_Abastecimentos").add({
    'codUser': _user,
    'DataAbastecimento': data,
    'HoraRegistro': hora,
    'tipoAbastecimento': tipoAbastecimento,
    'combustivelAbastecimento': combustivelAbastecimento,
    'odometroInicial': odometroInicial,
    'odomotroFinal': odometroFinal,
    'origemCombustivel': origem,
    'destinoCombustivel': destino,
    'quantidadeCombustivel': quantidade
  }).then((res) => message = 'Dados inseridos com sucesso',
      onError: (e) => message = 'Erro: $e');

  return ScaffoldMessenger.of(context)
      .showSnackBar(SnackBar(content: Text(message)));
}
