import 'package:flutter/material.dart';

import 'app_config.dart';


class AppButton extends StatelessWidget {
  Widget? textWidet;
  VoidCallback? onClick;
  double? width;

  AppButton({this.textWidet, this.onClick, this.width});

  @override
  Widget build(BuildContext context) {
    AppConfig.init(context);
    return GestureDetector(
      onTap: onClick,
      child: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(bottom: 10, right: 50, left: 50),
          height: 50,
          width: width == null ? AppConfig.width * 0.7 : width,
          decoration: BoxDecoration(
            color: AppConfig.theme.primaryColor,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: AppConfig.theme.primaryColor.withOpacity(0.4),
                spreadRadius: 2,
                blurRadius: 8,
              ),
            ],
          ),
          child: textWidet),
    );
  }
}
