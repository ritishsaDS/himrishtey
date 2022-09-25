import 'package:flutter/material.dart';
import 'package:rishtey/models/other_profile_detail.dart';
import 'package:rishtey/utils/app_config.dart';

class OtherProfileGellery extends StatelessWidget{
  final OtherProfileDetail ?profileDetail;
 const OtherProfileGellery({this.profileDetail});
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("Gallery"),),
    body: Container(child: Column(children: [
Container(
  height: AppConfig.height*0.6,
  child:profileDetail?.images?.length==0||profileDetail?.images?.length==null?Center(child: Text("No Images Yet!!!"),): ListView.builder(
      itemCount: profileDetail!.images!.length,
      itemBuilder: (context,index){
  return Image.network(profileDetail?.images?[index].images??"");
}),)

    ],),),
    );
  }
}