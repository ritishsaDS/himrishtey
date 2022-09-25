import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rishtey/utils/app_config.dart';

Widget infoTile({required String name,required var data, }){
  return Padding(
    padding: const EdgeInsets.all(8),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      Text(name.toString(),style: const TextStyle(fontSize: 16,),),
      const SizedBox(width: 10,),
      Flexible(
        fit: FlexFit.loose,


          child: Text(data.toString(),style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w800),maxLines: 5,)),
      const Spacer(),

    ],),
  );

}