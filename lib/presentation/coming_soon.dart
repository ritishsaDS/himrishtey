import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:rishtey/utils/app_config.dart';


class FrostedDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          ConstrainedBox(
              constraints: const BoxConstraints.expand(),
              child: Image.asset("assets/pngIcons/Group 24.png")
          ),
          Center(
            child: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
                child: Container(
                  alignment: Alignment.center,
                  width: AppConfig.width,
                  height:  AppConfig.height,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade200.withOpacity(0.5)
                  ),
                  child: Image.asset("assets/pngIcons/coming-soon.png"),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}