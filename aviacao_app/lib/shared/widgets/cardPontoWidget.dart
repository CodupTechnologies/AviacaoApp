import 'package:aviacao_app/shared/themes/app_colors.dart';
import 'package:aviacao_app/shared/themes/app_text_styles.dart';
import 'package:aviacao_app/shared/widgets/usefull_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

Widget cardPontoWidget(
    String tipoRegistro,
    bool almoco, // abertura ou fechamento
    DateTime dataRegistro, // Data do registro
    String user,
    String docId,
    bool loading,
    context) {
  double bordacampos = 10;
  final agora = DateTime.now();
  final usuario = user;
  final screenSize = MediaQuery.of(context).size;
  return Container(
    width: screenSize.width * 0.9,
    height: 70,
    decoration: BoxDecoration(
      color: AppColors.fundoCard,
      borderRadius: BorderRadius.circular(bordacampos),
    ),
    child: Stack(
      children: [
        Row(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 5, bottom: 5, left: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Data: ",
                        style: AppTextStyles.labelcardTitle,
                      ),
                      Text(
                        (dataRegistro.day.toString() +
                            ' / ' +
                            dataRegistro.month.toString() +
                            ' / ' +
                            dataRegistro.year.toString()),
                        style: AppTextStyles.labelcardData,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        (dataRegistro.hour.toString() +
                            ':' +
                            dataRegistro.minute.toString()),
                        style: AppTextStyles.labelcardData,
                      )
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Tipo: ",
                        style: AppTextStyles.labelcardTitle,
                      ),
                      Text(
                        tipoRegistro,
                        style: AppTextStyles.labelcardTipeRed,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
        Positioned(
          top: 10,
          right: 10,
          child: IconButton(
              onPressed: () {
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
                                        .collection('AVP_ControlePonto')
                                        .doc(docId)
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
              icon: Icon(Icons.delete,
                  color: AppColors.redDeny,
                  size: 34,
                  semanticLabel: 'Deletar')),
        ),
      ],
    ),
  );
}
