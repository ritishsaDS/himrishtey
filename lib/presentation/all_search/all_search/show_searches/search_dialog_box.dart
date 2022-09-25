import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rishtey/controller/auth_controller.dart';
import 'package:rishtey/presentation/all_search/all_search/show_searches/serach_result.dart';
import 'package:rishtey/utils/app_config.dart';

import '../../../../controller/search_controller.dart';
import '../../../dashboard/hide_file_lottie.dart';

Future<void> displayTextInputDialog(BuildContext context) async {
  var searchController =
      Provider.of<SearchController>(context, listen: false);
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Search By ProfileId'),
          content: SizedBox(
            width: AppConfig.width,
            child: TextField(

             controller: searchController.textFieldController,
              decoration:const InputDecoration(hintText: "Please Enter ProfileId to search"
              ),
            ),
          ),
          actions: <Widget>[
            FlatButton(
              color: Colors.white,
              textColor: Colors.red,
              child: Text('CANCEL'),
              onPressed: () {
                // setState(() {
                Navigator.pop(context);
                // });
              },
            ),
            Consumer<SearchController>(
              builder: (context,controller,child) {
                return controller.isLoading?CircularProgressIndicator(color: Colors.white,):FlatButton(
                  color: AppConfig.theme.primaryColor,
                  textColor: Colors.white,
                  child: Text('OK'),
                  onPressed: () async{

                   var res= await searchController.searchByProfileId(context);
                   if(res==true){
                    // Navigator.pop(context);

                   }
                   else{
                     //Navigator.pop(context);
                   }
                    // setState(() {
                    //   codeDialog = valueText;
                    //   Navigator.pop(context);
                    // });
                  },
                );
              }
            ),
          ],
        );
      });
}


Future<void> displayHideProfileDialog(BuildContext context) async {
  var searchController =
  Provider.of<SearchController>(context, listen: false);
  var authController =
  Provider.of<AuthController>(context, listen: false);
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(

          insetPadding: EdgeInsets.symmetric(horizontal: 20),
          title: Text('Hide Profile'),
          content: SizedBox(
            height: AppConfig.height*0.6,
            width: AppConfig.width,
            child: Column(children: [
              GestureDetector(onTap: () async {
                var res=await authController.hideProfile(context, "7");
                if(res==true){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>LottieScreen(days:"30")));

                }
              },
              
              child: Container(
                width: AppConfig.width*0.5,
                height: AppConfig.height*0.07,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: AppConfig.theme.primaryColor),
                child: Center(child: Text("7 Days",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 18,color: Colors.white),)),),),
              SizedBox(height: 20,),
              GestureDetector(onTap: () async {
                var res=await authController.hideProfile(context, "15");
                if(res==true){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>LottieScreen(days:"15")));

                }
              },

                child: Container(
                  width: AppConfig.width*0.5,
                  height: AppConfig.height*0.07,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: AppConfig.theme.primaryColor),
                  child: Center(child: Text("15 Days",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 18,color: Colors.white),)),),),
              SizedBox(height: 20,),

              GestureDetector(onTap: () async {
               var res=await authController.hideProfile(context, "30");
               if(res==true){
                 Navigator.push(context, MaterialPageRoute(builder: (context)=>LottieScreen(days:"30")));

               }
              //  Navigator.pop(context);
              },

                child: Container(
                  width: AppConfig.width*0.5,
                  height: AppConfig.height*0.07,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: AppConfig.theme.primaryColor),
                  child: Center(child: Text("30 Days",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 18,color: Colors.white),)),),),
              SizedBox(height: 20,),

              GestureDetector(onTap: () async {
                var res=await authController.hideProfile(context, "90");
                if(res==true){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>LottieScreen(days:"30")));

                }
              },

                child: Container(
                  width: AppConfig.width*0.5,
                  height: AppConfig.height*0.07,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: AppConfig.theme.primaryColor),
                  child: Center(child: Text("90 Days",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 18,color: Colors.white),)),),)
            ],)
          ),
          actions: <Widget>[
            FlatButton(
              color: Colors.white,
              textColor: Colors.red,
              child: Text('CANCEL'),
              onPressed: () {
                // setState(() {
                Navigator.pop(context);
                // });
              },
            ),
            Consumer<SearchController>(
                builder: (context,controller,child) {
                  return controller.isLoading?CircularProgressIndicator(color: Colors.white,):FlatButton(
                    color: AppConfig.theme.primaryColor,
                    textColor: Colors.white,
                    child: Text('OK'),
                    onPressed: () async{

                      var res= await searchController.searchByProfileId(context);
                      if(res==true){
                        // Navigator.pop(context);

                      }
                      else{
                        Navigator.pop(context);
                      }
                      // setState(() {
                      //   codeDialog = valueText;
                      //   Navigator.pop(context);
                      // });
                    },
                  );
                }
            ),
          ],
        );
      });
}