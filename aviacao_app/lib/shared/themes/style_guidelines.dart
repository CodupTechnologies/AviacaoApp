import 'package:aviacao_app/shared/themes/app_colors.dart';
import 'package:flutter/material.dart';

final ButtonStyle timerButtonStyle = ElevatedButton.styleFrom(
    minimumSize: Size(130, 40),
    backgroundColor: AppColors.vermelho2,
    elevation: 0,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10))));

final ButtonStyle saveButton = ElevatedButton.styleFrom(
    backgroundColor: AppColors.primary,
    elevation: 0,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20))));

final ButtonStyle exluirButton = ElevatedButton.styleFrom(
    backgroundColor: AppColors.vermelho2,
    elevation: 0,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20))));

final ButtonStyle RegistroPonto = ElevatedButton.styleFrom(
    backgroundColor: AppColors.amarelo2,
    elevation: 0,
    padding: EdgeInsets.only(left: 40, right: 40),
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20))));
