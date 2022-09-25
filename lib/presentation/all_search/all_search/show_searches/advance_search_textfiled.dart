import 'package:flutter/material.dart';

class AdvanceSearchTextField extends StatelessWidget{
  final dynamic model;
  final FocusNode ?focusNode;
  final TextEditingController? controller;
  final VoidCallback? onEditingComplete;
  const AdvanceSearchTextField({Key? key,this.model,this.controller,this.focusNode,this.onEditingComplete}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      onEditingComplete: onEditingComplete,
      decoration:const InputDecoration(
        filled: false,
        fillColor: Colors.white70,

        hintText: "Your Mother Tongue",
      ),
      validator: (val){
        // if(motherTongueId==null||motherTongueId==0){
        //   return"Please Choose Mother Tongue From Dropdown";
        // }
      },
    );
  }
}