import 'package:flutter/material.dart';
import 'package:rishtey/models/dashboard_profile_model.dart';
import 'package:rishtey/presentation/dashboard/widget/interest_profile.dart';
import 'package:rishtey/utils/app_config.dart';

class ViewProfiles extends StatelessWidget{
  DashBoardProfilesModel?user;
  String?title;
  ViewProfiles({this.user,this.title});
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar:AppBar(title: Text(title!),
     actions: [
       Center(child: Icon(Icons.search,size: 30,),)
     ],
     ) ,


     body: SafeArea(child: Container(
       height: AppConfig.height*1,
       child: ListView.builder(
       itemCount: user?.user?.length,
       itemBuilder: (context,index){
     return InterestProfile(data: user!.user![index]);
   }),),),);
  }

}