import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/src/era_mode.dart';
import 'package:flutter_rounded_date_picker/src/flutter_cupertino_rounded_date_picker_widget.dart';

class CupertinoRoundedDatePickers {
  static show(
      BuildContext context, {
        Locale? locale,
        DateTime? initialDate,
        DateTime? minimumDate,
        DateTime? maximumDate,
        int? minimumYear,
        int? maximumYear,
        Function(DateTime)? onDateTimeChanged,
        int minuteInterval = 1,
        bool use24hFormat = false,
        CupertinoDatePickerMode initialDatePickerMode =
            CupertinoDatePickerMode.date,
        EraMode era = EraMode.CHRIST_YEAR,
        double borderRadius = 16,
        String? fontFamily,
        Color background = Colors.white,
        Color textColor = Colors.black54,
      }) async {
    initialDate ??= DateTime.now();
    minimumDate ??= DateTime.now().subtract(Duration(days: 7));
    maximumDate ??= DateTime.now().add(Duration(days: 7));
    minimumYear ??= DateTime.now().year - 100;
    maximumYear ??= DateTime.now().year ;

    return await showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.width*0.90,
              child: FlutterRoundedCupertinoDatePickerWidget(
                use24hFormat: use24hFormat,
                onDateTimeChanged: (dateTime) {
                  if (onDateTimeChanged != null) {
                    onDateTimeChanged(dateTime);
                  }
                },
                era: era,
                background: background,
                textColor: textColor,
                borderRadius: borderRadius,
                fontFamily: fontFamily,
                initialDateTime: initialDate,
                mode: initialDatePickerMode,
                minuteInterval: minuteInterval,
                minimumDate: minimumDate,
                maximumDate: maximumDate,
                maximumYear: maximumYear,
                minimumYear: minimumYear!,
              ),
            ),
            Container(
                color: Colors.black,
                width: MediaQuery.of(context).size.width,
                height:100,
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(20),
                child: RaisedButton(onPressed: (){
                  Navigator.pop(context);
                },
                  color: Colors.white,
                  child: Text("Submit"),)
            )
          ],
        );
      },
    );
  }
}
