import 'package:aviacao_app/shared/themes/app_colors.dart';
import 'package:flutter/material.dart';

class FabFlowButton extends StatelessWidget {
  final String textoBotaoOne;
  final String textoBotaoTwo;
  final bool loading;
  final VoidCallback onTapOne;
  final VoidCallback onTapTwo;
  final double display;
  final double buttonWidth;

  const FabFlowButton(
      {Key? key,
      required this.textoBotaoOne,
      required this.textoBotaoTwo,
      required this.onTapTwo,
      required this.onTapOne,
      required this.display,
      required this.buttonWidth,
      required this.loading})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final actionButtonCollor = AppColors.primary;

    return SizedBox(
      width: display,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
              child: Center(
                  child: GestureDetector(
            onTap: (onTapOne),
            child: Container(
              height: 45,
              width: buttonWidth,
              decoration: BoxDecoration(
                color: AppColors.amarelo2,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Row(
                  children: (loading)
                      ? [
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: SizedBox(
                              height: 24,
                              width: 24,
                              child: CircularProgressIndicator(
                                  color: Colors.white),
                            ),
                          )
                        ]
                      : [
                          Expanded(
                            flex: 4,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.add,
                                  size: 24,
                                  color: Colors.white,
                                ),
                                Text(
                                  textoBotaoOne,
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.white,
                                      overflow: TextOverflow.ellipsis),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          )
                        ]),
            ),
          ))),
          InkWell(
              child: Center(
                  child: GestureDetector(
            onTap: (onTapTwo),
            child: Container(
              height: 45,
              width: buttonWidth,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(25),
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
                              child: CircularProgressIndicator(
                                  color: Colors.white),
                            ),
                          )
                        ]
                      : [
                          Expanded(
                            flex: 4,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.add,
                                  size: 24,
                                  color: Colors.white,
                                ),
                                Text(
                                  textoBotaoTwo,
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.white,
                                      overflow: TextOverflow.ellipsis),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          )
                        ]),
            ),
          ))),
        ],
      ),
    );
  }
}
