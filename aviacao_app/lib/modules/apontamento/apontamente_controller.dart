import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

final _user = FirebaseAuth.instance.currentUser!.uid.toString();
var message = '';
final instance = FirebaseFirestore.instance;

Future atualizarRegistro(
    String collec, String docx, String column, String value) async {
  await instance.collection(collec).doc(docx).update({
    column: value,
  });
}

Future atualizarApontamento(
    DateTime data,
    String codApontamento,
    String odometroFinal,
    String aeronaveApontamento,
    String observacaoApontamento,
    String codVeiculo,
    String codigoAeronave,
    String user,
    context) async {
  String tipoApontamento = '';

  if (odometroFinal == '') {
    tipoApontamento == 'Abertura';
    instance.collection('AVP_Automoveis').doc(codVeiculo).update({
      'condutorVeiculo': user,
      'dataAtualizacao': data,
    });
  } else {
    tipoApontamento == 'Fechamento';
    instance.collection('AVP_Automoveis').doc(codVeiculo).update({
      'condutorVeiculo': '',
      'dataAtualizacao': data,
      'odometroAtual': odometroFinal.toString()
    });
  }

  await FirebaseFirestore.instance
      .collection("AVP_Apontamentos")
      .doc(codApontamento)
      .update({
    'odometroFinal': odometroFinal,
    'regAeronave': aeronaveApontamento,
    'tipoApontamento': tipoApontamento,
    'observacaoApontamento': observacaoApontamento,
    'codAeronave': codigoAeronave,
  });
}

Future salvarApontamento(
    DateTime data,
    DateTime dataRegistro,
    String veiculo,
    String codVeiculo,
    String codAeronave,
    String odometroInicial,
    String odometroFinal,
    String aeronaveApontamento,
    String observacaoApontamento,
    String user,
    String codigoAeronave,
    String placaVeiculo,
    context) async {
  String tipoApontamento = '';

  if (odometroFinal == '') {
    tipoApontamento == 'Abertura';
    instance.collection('AVP_Automoveis').doc(codVeiculo).update({
      'condutorVeiculo': user,
      'dataAtualizacao': data,
    });
  } else {
    tipoApontamento == 'Fechamento';
    instance.collection('AVP_Automoveis').doc(codVeiculo).update({
      'condutorVeiculo': '',
      'dataAtualizacao': data,
      'odometroAtual': odometroFinal.toString()
    });
  }

  await FirebaseFirestore.instance.collection("AVP_Apontamentos").add({
    'codUser': _user,
    'dataRegistro': dataRegistro,
    'dataApontamento': data,
    'veiculoApontamento': veiculo,
    'odometroInicial': odometroInicial,
    'odometroFinal': odometroFinal,
    'regAeronave': aeronaveApontamento,
    'tipoApontamento': tipoApontamento,
    'observacaoApontamento': observacaoApontamento,
    'codAeronave': codigoAeronave,
  }).then((res) => message = 'Dados inseridos com sucesso',
      onError: (e) => message = 'Erro: $e');

  return ScaffoldMessenger.of(context)
      .showSnackBar(SnackBar(content: Text(message)));
}
