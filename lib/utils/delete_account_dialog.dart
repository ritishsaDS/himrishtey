import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rishtey/utils/app_config.dart';

import '../controller/auth_controller.dart';

class BaseAlertDialog extends StatelessWidget {

  //When creating please recheck 'context' if there is an error!



  String ?_title;
  String ?_content;
  String ?_yes;
  String ?_no;


  BaseAlertDialog({String ?title, String ?content,  String yes = "Yes", String no = "No"}){
    _title = title!;
    _content = content!;

    _yes = yes;
    _no = no;
  }
  @override
  Widget build(BuildContext context) {
    var authController = Provider.of<AuthController>(context, listen: false);

    return AlertDialog(
      title: Text(_title!),
      content: SizedBox(
        height: AppConfig.height*0.15,
        child: Column(
          children: [
            Text(_content!),
            SizedBox(height: 10,),
            Text("By Doing this you will loose your all connections",style: TextStyle(color: Colors.grey.shade400),)
          ],
        ),
      ),
      backgroundColor: Colors.white,
      shape:
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      actions: <Widget>[
        Consumer<AuthController>(
          builder: (context,controller,child) {
            return controller.isLoading?CircularProgressIndicator(color: Colors.white,):FlatButton(
              child: Text(_yes!),
              color: AppConfig.theme.primaryColor,
              textColor: Colors.white,
              onPressed: () {
                authController.deleteProfile(context);
                //_yesOnPressed();
              },
            );
          }
        ),
        FlatButton(
          child: Text(_no!),
          textColor: Colors.redAccent,
          onPressed: () {
            Navigator.pop(context);
            //_noOnPressed();
          },
        ),
      ],
    );
  }
}