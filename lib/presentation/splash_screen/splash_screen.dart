import 'package:flutter/material.dart';
import 'package:rishtey/presentation/bottom_navigation_bar.dart';
import 'package:rishtey/presentation/login/login_2.dart';

import '../../utils/shared_pref.dart';

class SplashScreen extends StatefulWidget{
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var id;
  getId() async {
    id = await SharedPref().getString(key: "user_id");
  }
  @override
  void initState() {
    getId();
    Future.delayed(const Duration(seconds: 3), () {

// Here you can write your code

      id==null?Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginPage2())):Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MyHomePage()));

    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
   return Scaffold(body: Container(
     decoration: const BoxDecoration(
         image: DecorationImage(
             image: AssetImage("assets/pngIcons/Purple Login Screen.png"),
             fit: BoxFit.fill)
     ),
     height: MediaQuery.of(context).size.height,
     child: Center(child: Image.asset("assets/pngIcons/Group 24.png")),
   ),);
  }
}