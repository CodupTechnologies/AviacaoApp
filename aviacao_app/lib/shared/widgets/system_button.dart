import 'package:aviacao_app/shared/themes/app_colors.dart';
import 'package:flutter/material.dart';

class SystemButton extends StatelessWidget {
  final String textoBotaoOne;
  final VoidCallback onTap;
  final double buttonWidth;

  final bool loading;

  const SystemButton(
      {Key? key,
      required this.textoBotaoOne,
      required this.onTap,
      required this.loading,
      required this.buttonWidth})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        child: Center(
            child: GestureDetector(
      onTap: (onTap),
      child: Container(
        height: 45,
        width: buttonWidth,
        decoration: BoxDecoration(
          color: AppColors.secondary,
          borderRadius: BorderRadius.circular(25),
          // border: Border.fromBorderSide(BorderSide(color: AppColors.stroke))
        ),
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
                        textoBotaoOne,
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
