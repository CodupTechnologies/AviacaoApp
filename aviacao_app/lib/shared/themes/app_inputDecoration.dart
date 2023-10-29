import 'package:aviacao_app/shared/themes/app_colors.dart';
import 'package:flutter/material.dart';

class AppInputDecoration {
  static final mainDecorator = InputDecoration(
    filled: true,
    fillColor: AppColors.fundoCard,
    contentPadding: const EdgeInsets.only(left: 20, right: 10),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white),
      borderRadius: BorderRadius.circular(30),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white),
      borderRadius: BorderRadius.circular(30),
    ),
    disabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white),
      borderRadius: BorderRadius.circular(30),
    ),
  );
}

