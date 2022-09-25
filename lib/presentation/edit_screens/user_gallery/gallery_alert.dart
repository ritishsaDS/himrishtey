import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rishtey/controller/ImagePickerController.dart';
import 'package:rishtey/controller/get_profile_controller.dart';
import 'package:rishtey/utils/app_config.dart';

class GalleryAlert extends StatefulWidget{

  @override
  State<GalleryAlert> createState() => _GalleryState();
}

class _GalleryState extends State<GalleryAlert> {

  int id=1;
  ImagePickerController?imagePickerController;
  GetProfileController?getProfileController;
  @override
  void initState() {
   Future.delayed(Duration(milliseconds: 100),(){
     getProfileController=Provider.of<GetProfileController>(context,listen: false);
     imagePickerController=Provider.of<ImagePickerController>(context,listen: false);});
  id= int.parse(getProfileController?.getProfileModel?.images?[0].privacy??"1");
setState(() {

});
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    print(id);
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      title: Text("Photo Settings"),
      content: Container(
        height: AppConfig.height*0.25,
        child: Consumer<GetProfileController>(
          builder: (context,controller,cjhild) {

            return Column(children: [
              Row(
                  children: [
                    Radio(
                      value: int.parse(controller.getProfileModel?.images?[0].privacy??"1"),
                      groupValue: 1,
                      onChanged: (val) {
                        setState(() {
                          // predominant = 'recessiva_bb';
                          controller.getProfileModel?.images?[0].privacy = "1";
                        });
                      },
                    ),
                    const Text(
                      'Visible to all members\n(Recommended)',
                      style: TextStyle(fontSize: 14.0),
                    ),

                    // more widgets ...
                  ]
              ),
              Row(
                  children: [
                    Radio(
                      value: int.parse(controller.getProfileModel?.images?[0].privacy??"1"),
                      groupValue: 2,
                      onChanged: (val) {
                        setState(() {
                          // predominant = 'recessiva_bb';
                          controller.getProfileModel?.images?[0].privacy = "2";
                        });
                      },
                    ),
                    const Text(
                      'Visible to member I shotlisted \nand to all premium members',
                      style: TextStyle(fontSize: 14.0),
                    ),

                    // more widgets ...
                  ]
              ),


            ],);
          }
        ),),
      actions: [
        TextButton(
          child: Text("Cancel"),
          onPressed:  () {
            Navigator.pop(context);
          },
        ),
        TextButton(
          child: Text("Change Privacy"),
          onPressed:  () async{
           bool ?res=await imagePickerController?.privacyImage(context, id);
           Navigator.pop(context);
          },
        )
      ],
    );
  }

}