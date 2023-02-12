import 'package:aviacao_app/shared/themes/app_colors.dart';
import 'package:flutter/material.dart';

class LoginButtonRegular extends StatelessWidget {
  final String textoBotao;
  final bool loading;
  final VoidCallback onTap;
  const LoginButtonRegular(
      {Key? key,
      required this.textoBotao,
      required this.onTap,
      required this.loading})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        child: Center(
            child: GestureDetector(
      onTap: (onTap),
      child: Container(
        height: 45,
        decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(25),
            border: Border.fromBorderSide(BorderSide(color: AppColors.stroke))),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: (loading)
                ? [
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: SizedBox(
                        height: 24,
                        width: 24,
                        child: CircularProgressIndicator(color: Colors.white),
                      ),
                    )
                  ]
                : [
                    Expanded(
                      flex: 4,
                      child: Text(
                        textoBotao,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: AppColors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    )
                  ]),
      ),
    )));
  }
}
