import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controller/ImagePickerController.dart';
import '../bottom_navigation_bar.dart';

class AddImageSignup extends StatelessWidget{
  var imagePicker;
  File? images;
  @override
  Widget build(BuildContext context) {
    imagePicker = Provider.of<ImagePickerController>(context);

    return Scaffold(
      body: SafeArea(child: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/pngIcons/Purple Login Screen.png"),
                fit: BoxFit.fill)
        ),
        child: Column(children: [
          const SizedBox(height: 20,),
          GestureDetector(
            onTap: (){
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                  MyHomePage()), (Route<dynamic> route) => false);
            },
            child: Container(

              padding: const EdgeInsets.all(10),
              alignment: Alignment.centerRight,
              child: const Text("Skip Now",style: TextStyle(fontWeight: FontWeight.w800),),),
          ),
          const SizedBox(height: 20,),
          const Text("Great ! Your Profile is Almost Done",style: TextStyle(fontWeight: FontWeight.w800,fontSize: 16),),

        const SizedBox(height: 40,),
          const Text("Upload Your Profile Image",style: TextStyle(fontWeight: FontWeight.w800,fontSize: 16),),
           SizedBox(height: MediaQuery.of(context).size.height*0.15,),

          GestureDetector(
            onTap: (){
              imagePicker.pickGallery(context);
            },
            child: const CircleAvatar(

              radius:50,child: Icon(Icons.image,size: 50,),),
          ),
          const SizedBox(height: 10,),
          const Text("Upload From Gallery",style: TextStyle(fontWeight: FontWeight.w800,fontSize: 16),),
          const SizedBox(height: 20,),
          GestureDetector(
              onTap: (){
                imagePicker.pickImage(context);

              },
              child: const CircleAvatar(  radius:50,child: const Icon(Icons.add_a_photo,size: 50),)),
          const SizedBox(height: 10,),
          const Text("Upload From Camera",style: TextStyle(fontWeight: FontWeight.w800,fontSize: 16),),
        ],),
      ),),
    );
  }

}