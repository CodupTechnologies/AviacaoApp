import 'package:aviacao_app/shared/themes/app_text_styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

var format;

bottomMessage(context, String mensagem, int durationTime) {
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(mensagem),
    duration: Duration(seconds: durationTime),
  ));
}

dataFormatter(DateTime data) {
  initializeDateFormatting('pt_BR', data.toString());
  Intl.defaultLocale = 'pt_BR';
  format = DateFormat('dd/MM/yyyy').format(data);
  return format;
}

Future showDial(context, String titulo, String texto, String textButton) {
  return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(titulo),
          content: Text(texto),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  style: TextButton.styleFrom(
                      alignment: Alignment.centerRight,
                      textStyle: AppTextStyles.textButtonI),
                  child: Text(
                    textButton,
                    style: AppTextStyles.textButtonI,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ],
        );
      });
}
