import 'package:aviacao_app/modules/abastecimento/atualizar_abastecimento_page.dart';
import 'package:aviacao_app/shared/themes/app_colors.dart';
import 'package:aviacao_app/shared/themes/app_text_styles.dart';
import 'package:aviacao_app/shared/widgets/doubleButtons.dart';
import 'package:aviacao_app/shared/widgets/fab_flow_button.dart';
import 'package:aviacao_app/shared/widgets/usefull_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class cardConf {
  final double altura = 170;
  final double bordaCard = 20;
}

Widget CardHistoricoAbastecimento(
    context, String user, DocumentSnapshot documentAbastecimento) {
  cardConf configuracacao = new cardConf();
  final screenSize = MediaQuery.of(context).size;

  Map<String, dynamic> mapa =
      documentAbastecimento.data() as Map<String, dynamic>;
  Timestamp timestamper = mapa['dataAbastecimento'] as Timestamp;

  DateTime dataOb = timestamper.toDate();

  return Padding(
    padding: const EdgeInsets.only(top: 8.0, right: 10, left: 10),
    child: Container(
      decoration: BoxDecoration(
        color: AppColors.fundoCard,
        borderRadius: BorderRadius.circular(configuracacao.bordaCard),
      ),
      child: Padding(
        padding: const EdgeInsets.only(right: 10.0, left: 10.0),
        child: Column(children: [
          SizedBox(
            height: 8,
          ),
          Row(
            children: [
              Expanded(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(style: AppTextStyles.cardTitleStyle, 'Abastecimento'),
                ],
              ))
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10, left: 10),
            child: Row(
              children: [
                Text(
                  'Data: ',
                  style: AppTextStyles.cardLegendStyle,
                ),
                Text(
                  dataOb.day.toString() +
                      '/' +
                      dataOb.month.toString() +
                      '/' +
                      dataOb.year.toString(),
                  style: AppTextStyles.cardDataStyle,
                ) // Inserir os dados
              ],
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10, left: 10),
            child: Row(
              children: [
                Text(
                  'Combustível ',
                  style: AppTextStyles.cardLegendStyle,
                ),
                Text(
                  mapa['nomeCombustivel'],
                  style: AppTextStyles.cardDataStyle,
                ) // Inserir os dados
              ],
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10, left: 10),
            child: Row(
              children: [
                Text(
                  'Origem: ',
                  style: AppTextStyles.cardLegendStyle,
                ),
                Text(
                  mapa['nomeOrigem'],
                  style: AppTextStyles.cardDataStyle,
                  overflow: TextOverflow.ellipsis,
                ), // Inserir os dados
                Text(
                  '  Destino: ',
                  style: AppTextStyles.cardLegendStyle,
                ),
                Text(
                  mapa['nomeDestino'],
                  style: AppTextStyles.cardDataStyle,
                  overflow: TextOverflow.ellipsis,
                )
              ],
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10, left: 10),
            child: Row(
              children: [
                Text(
                  'Odometro: ',
                  style: AppTextStyles.cardLegendStyle,
                ),
                Text(
                  mapa['odometroInicial'],
                  style: AppTextStyles.cardDataStyle,
                  overflow: TextOverflow.ellipsis,
                ), // Inserir os dados
                Text(
                  '  Final: ',
                  style: AppTextStyles.cardLegendStyle,
                ),
                Text(
                  mapa['odometroFinal'],
                  style: AppTextStyles.cardDataStyle,
                  overflow: TextOverflow.ellipsis,
                )
              ],
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10, left: 10),
            child: Row(
              children: [
                Text(
                  'Quantidade: ',
                  style: AppTextStyles.cardLegendStyle,
                ),
                Text(
                  mapa['quantidadeCombustivel'].toString() + ' L',
                  style: AppTextStyles.cardDataStyle,
                  overflow: TextOverflow.ellipsis,
                ), // Inserir os dados
              ],
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10, left: 10),
            child: Text(
              'Observações: ',
              style: AppTextStyles.cardLegendStyle,
            ),
          ),
          SizedBox(height: 5),
          Text(
            mapa['observacaoAbastecimento'].isNotEmpty
                ? mapa['observacaoAbastecimento'].toString()
                : 'Sem Observações',
            textAlign: TextAlign.start,
            style: AppTextStyles.cardDataStyle,
            overflow: TextOverflow.clip,
          ),
          SizedBox(height: 15),
          DoubleButton(
              textoBotaoOne: 'Deletar',
              textoBotaoTwo: 'Editar',
              onTapTwo: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            AtualizarAbastecimentoPage(documentAbastecimento)));

                print('aqui');
              },
              onTapOne: () {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          title: Text("Tem certeza? "),
                          content: Text(
                              "Você realmente deseja excluir este registro, após excluí-lo não será possível recuperar"),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text('Cancelar')),
                            TextButton(
                                onPressed: () async {
                                  try {
                                    await FirebaseFirestore.instance
                                        .collection('AVP_Apontamentos')
                                        .doc(documentAbastecimento.id)
                                        .delete();
                                    bottomMessage(
                                        context, "Registro excluído", 3);
                                    Navigator.pop(context);
                                  } on Exception catch (e) {
                                    print(e);
                                  }
                                },
                                child: Text("Excluir registro")),
                          ],
                        ));
              },
              display: screenSize.width,
              buttonWidth: screenSize.width * 0.40,
              loading: false),
          SizedBox(
            height: 10,
          ),
        ]),
      ),
    ),
  );
}
