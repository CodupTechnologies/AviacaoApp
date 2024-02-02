import 'package:aviacao_app/shared/themes/app_colors.dart';
import 'package:aviacao_app/shared/themes/app_text_styles.dart';
import 'package:aviacao_app/shared/widgets/usefull_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CardControlePonto extends StatelessWidget {
  final String tipoRegistro;
  final bool almoco; // abertura ou fechamento
  final DateTime dataRegistro; // Data do registro
  final String user;
  final String docId;
  final bool loading;

  CardControlePonto(
      {Key? key,
      required this.tipoRegistro,
      required this.almoco,
      required this.dataRegistro,
      required this.user,
      required this.docId,
      required this.loading})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double bordacampos = 10;
    final agora = DateTime.now();
    final usuario = user;
    final screenSize = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
      child: Container(
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
                                '/' +
                                dataRegistro.month.toString() +
                                '/' +
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
                            style: tipoRegistro == "Abertura"
                                ? AppTextStyles.labelcardTipeRed
                                : AppTextStyles.labelcardTipeGreen,
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
      ),
    );
  }
}
