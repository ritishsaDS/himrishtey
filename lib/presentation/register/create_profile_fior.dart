import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rishtey/controller/auth_controller.dart';
import 'package:rishtey/presentation/register/sign_up.dart';
import 'package:rishtey/presentation/register/widgets/create_profile_tile.dart';

import '../../models/create_profile_for_model.dart';

class CreateProfileFor extends StatefulWidget{
  @override
  State<CreateProfileFor> createState() => _CreateProfileForState();
}

class _CreateProfileForState extends State<CreateProfileFor> {
  AuthController? controller;
  CreateProfileForModel? data;
@override
  void initState() {
  controller=Provider.of<AuthController>(context,listen: false);
  getData();
    super.initState();
  }
  getData()async{
    data=await controller!.createProfileFor(context);
  }
  @override
  Widget build(BuildContext context) {


   return Scaffold(body: SafeArea(

     child: Column(
       children: [
          Container(

           height: MediaQuery.of(context).size.height*0.07,
           child: const Center(
             child: Text(
               "Create Profile For",
               style: TextStyle(fontSize: 20.0, color: Colors.white, fontWeight: FontWeight.bold),
             ),
           ),
           decoration:const BoxDecoration(
             gradient: LinearGradient(
                 colors: [Color(0xffD67DFF), Color(0xffE3A7FF)],
                 begin:  FractionalOffset(0.0, 0.0),
                 end:  FractionalOffset(0.5, 0.0),
                 stops: [0.0, 1.0],
                 tileMode: TileMode.mirror
             ),
           ),
         ),
         Container(
           height: MediaQuery.of(context).size.height*0.8,
           child: Consumer<AuthController>(builder: (context,controllerData,child){
             return controller!.isLoading?const Center(child:  CircularProgressIndicator()):GridView.builder(
                 gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                     maxCrossAxisExtent: 300,
                     childAspectRatio: 3 / 2.5,
                     crossAxisSpacing: 0,
                     mainAxisSpacing: 0),
                 itemCount: controllerData.createProfileForModel!.user!.length,
                 itemBuilder: (BuildContext ctx, index) {
                   return CreateProfileTile(index: index,
                       name: controllerData.createProfileForModel!.user!.elementAt(index).title!,
                   image: controllerData.createProfileForModel!.user!.elementAt(index).image!,);
                 });
           },),
         ),
         // Consumer<AuthController>(builder: (context,controller,child){
         //   return controller.selectIndex==11?Container(): Center(
         //     child: GestureDetector(
         //       onTap: () {
         //
         //         Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUp()));
         //
         //       },
         //       child: AnimatedContainer(
         //           width: MediaQuery.of(context).size.width*0.9,
         //           alignment: Alignment.center,
         //           duration: const Duration(microseconds: 1000),
         //           height: 60,
         //           decoration: BoxDecoration(
         //               borderRadius: BorderRadius.circular(15.0),
         //               gradient: const LinearGradient(
         //                 begin: Alignment.topRight,
         //                 end: Alignment.topLeft,
         //                 colors: [
         //                   Color(0xffFF5D4B),
         //                   Color(0xffFF7C57),
         //                 ],
         //               )),
         //           child:const Center(
         //             child:  Text(
         //               "Next Step",
         //               style:  TextStyle(
         //                   color: Colors.white,
         //                   fontSize: 16,
         //                   fontWeight: FontWeight.w800),
         //             ),
         //           )),
         //     ),
         //   );
         // },),
       ],
     )
    ,),);
  }
}