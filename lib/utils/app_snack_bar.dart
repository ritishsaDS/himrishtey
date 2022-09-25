
import 'package:flash/flash.dart';
import 'package:flutter/material.dart';

void appSnackBar({
  @required String? content,
  @required BuildContext ?context,
  Color ?background,
  Color ?textColor,
  Duration ?duration,
  flashStyle = FlashBehavior.floating,
}) {
  showFlash(
    context: context!,
    duration: Duration(seconds: 2),
    builder: (context, controller) {
      return Flash(
        backgroundColor:background?? Colors.blueAccent,
        controller: controller,
        behavior: flashStyle ?? FlashBehavior.floating,
        position: FlashPosition.bottom,
        boxShadows: kElevationToShadow[4],
        // barrierBlur: 2.0,
        forwardAnimationCurve: Curves.elasticInOut,
        reverseAnimationCurve: Curves.elasticOut,
        horizontalDismissDirection: HorizontalDismissDirection.horizontal,
        child: FlashBar(

          content: Text(
            "$content",
            style: TextStyle(
              color: textColor ?? Colors.white,
              // fontFamily: AppFonts.notoSansTCMedium,
            ),
          ),
        ),
      );
    },
  );
}
