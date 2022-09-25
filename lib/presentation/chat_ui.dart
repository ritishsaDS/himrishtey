// import 'package:flutter/material.dart';
// import 'package:rishtey/utils/firebase/firebase_auth.dart';
//
// import '../utils/firebase/firebase_chats.dart';
// class ChatUi extends StatefulWidget{
//   const ChatUi({Key? key}) : super(key: key);
//
//   @override
//   State<ChatUi> createState() => _ChatUiState();
// }
//
// class _ChatUiState extends State<ChatUi> {
//   TextEditingController flf=TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//    return Scaffold(
//      body: SafeArea(
//        child: Column(children: [
//          TextFormField(controller:flf ,),
//          GestureDetector(
//              onTap: (){
//                print("lkfnlkn0");
//                DatabaseMethods data=DatabaseMethods();
//                data.searchByName(flf.text);
//              },
//              child: Icon(Icons.search))
//        ],),
//      ),
//    );
//   }
// }