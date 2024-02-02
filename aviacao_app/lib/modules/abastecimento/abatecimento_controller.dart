import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

final _user = FirebaseAuth.instance.currentUser!.uid.toString();
var message = '';
final instance = FirebaseFirestore.instance;

Future AtualizarRegistro(
    String collec, String docx, String column, String value) async {
  await instance.collection(collec).doc(docx).update({
    column: value,
  });
}

Future atualizaAbastecimento() async {}

Future saveAbastecimento(
    DateTime data,
    String combustivelAbastecimento,
    String codDropOrigem,
    String codDropDestino,
    String origemCombustivel,
    String destinoCombustivel,
    String odometroInicial,
    String odometroFinal,
    String quantidade,
    String observacao,
    String tipoOrigem,
    String tipoDestino,
    String origemQtda,
    String destinoQtda,
    String nomeCombustivel,
    String nomeOrigem,
    String nomeDestino,
    context) async {
  //print(origemCombustivel);
  String collection = "";
  String coluna = "";
  double origemFinal = double.parse(origemQtda) - double.parse(quantidade);
  double destinoFinal = double.parse(destinoQtda) + double.parse(quantidade);

  if (tipoOrigem == "Veiculo") {
    collection = "AVP_Automoveis";
    coluna = "TanqueAtual";
  } else if (tipoOrigem == "Automovel") {
    collection = "AVP_Automoveis";
    coluna = "TanqueAtual";
  } else if (tipoOrigem == "Estoque") {
    collection = "AVP_estoquesCombustivel";
    coluna = "quantidadeAtual";
  } else if (tipoOrigem == "Posto") {
    collection = "AVP_PostoCombustivel";
    coluna = "Consumido";
  } else if (tipoOrigem == "Tanque") {
    collection = "AVP_estoquesCombustivel";
    coluna = "combustivelTransporteAtual";
  } else {
    collection = 'Não encontrato';
    coluna = "";
  }
  if (collection != '') {
    AtualizarRegistro(
        collection, origemCombustivel, coluna, origemFinal.toString());
    AtualizarRegistro('AVP_dropdownCombustivelOrigem', codDropOrigem,
        'tanqueAtual', origemFinal.toString());
  }
  if (tipoDestino == "Veiculo") {
    collection = "AVP_Automoveis";
    coluna = "TanqueAtual";
  } else if (tipoDestino == "Automovel") {
    collection = "AVP_Automoveis";
    coluna = "TanqueAtual";
  } else if (tipoDestino == "Estoque") {
    collection = "AVP_estoquesCombustivel";
    coluna = "quantidadeAtual";
  } else if (tipoDestino == "Aeronave") {
    collection = "AVP_Aerovanes";
    coluna = "tanqueAtual";
  } else if (tipoDestino == "Tanque") {
    collection = "AVP_Automoveis";
    coluna = "combustivelTransporteAtual";
  } else {
    collection = "";
    coluna = "";
  }
  if (collection != '') {
    AtualizarRegistro(
        collection, destinoCombustivel, coluna, origemFinal.toString());
    AtualizarRegistro('AVP_dropdownCombustivelDestino', codDropDestino,
        'tanqueAtual', destinoFinal.toString());
  }

  await instance.collection("AVP_Abastecimentos").add({
    'codUser': _user,
    'dataAbastecimento': data,
    'combustivelAbastecimento': combustivelAbastecimento,
    'origemCombustivel': origemCombustivel,
    'destinoCombustivel': destinoCombustivel,
    'odometroInicial': odometroInicial,
    'odometroFinal': odometroFinal,
    'quantidadeCombustivel': quantidade,
    'observacaoAbastecimento': observacao,
    'nomeCombustivel': nomeCombustivel,
    'nomeDestino': nomeDestino,
    'nomeOrigem': nomeOrigem,
  }).then((res) => message = 'Dados inseridos com sucesso',
      onError: (e) => message = 'Erro: $e');

  return ScaffoldMessenger.of(context)
      .showSnackBar(SnackBar(content: Text(message)));
}
