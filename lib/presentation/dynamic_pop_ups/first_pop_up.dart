import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rishtey/controller/dashboard_controller.dart';
import 'package:rishtey/utils/app_config.dart';

class FirstPopUp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    DashBoardController?dashBoardController;
    dashBoardController=Provider.of<DashBoardController>(context,listen: false);
    dashBoardController.showPopUp(context);
    return Consumer<DashBoardController>(
      builder: (context,controller,child) {
        return  Stack(
              children: [
                 Positioned(
                      top: 20,
                      right: 30,

                      child: GestureDetector(
                          onTap: (){
                            Navigator.pop(context);
                          },
                          child: CircleAvatar(
                        backgroundColor: AppConfig.theme.primaryColorDark,
                        child: const Icon(Icons.close,color: Colors.white,),)),
                 ),
        Container(

        child: AlertDialog(

          title: const Text("Himrishtey"),
          content: Container(
            height: AppConfig.height*0.45,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
            Text(controller.popUpData?.offers?[0].title??"",style: TextStyle(color: AppConfig.theme.primaryColor,fontWeight: FontWeight.w800,fontSize: 20),),
            SizedBox(height: AppConfig.height*0.02,),
                Image.network(controller.popUpData?.offers?[0].image??""),
                SizedBox(height: AppConfig.height*0.02,),
            Text(controller.popUpData?.offers?[0].description??"",style: TextStyle(color: AppConfig.theme.toggleableActiveColor),),
          ],),),
          actions: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      color: AppConfig.theme.primaryColor,
                      border: Border.all(color: AppConfig.theme.primaryColor),borderRadius: BorderRadius.circular(20)),
                  child: FlatButton(
                    child: const Text("Close",style: TextStyle(color: Colors.white),),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                )
          ],
        )),
              ],
            );
      }
    );
  }
}
