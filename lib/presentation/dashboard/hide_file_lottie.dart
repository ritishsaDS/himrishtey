import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:rishtey/presentation/bottom_navigation_bar.dart';
import 'package:rishtey/utils/app_config.dart';

class LottieScreen extends StatefulWidget {
 final String ?days;
  const LottieScreen({Key? key,this.days}) : super(key: key);

  @override
  State<LottieScreen> createState() => _LottieScreenState();
}

class _LottieScreenState extends State<LottieScreen> {
  @override
  void initState() {
    super.initState();

    Timer(
        const Duration(seconds: 5),
            () => Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const MyHomePage())));

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          const SizedBox(height: 150,),
          Container(
            height: 300,
            width: 400,
            color: Colors.transparent,
            child: Lottie.asset(
              'assets/jsons/hide_profile.json',
              height: 250,
              width: 250,
              fit: BoxFit.fill,

            ),
          ),
          const SizedBox(height: 50,),
          Row(
            children: [
              const  SizedBox(width: 50),
              Text("Thanks for joining with us\n Hope we fulfill your needs your \nprofile hidden for ${widget.days} days\n We Will ",
                style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold,
                    color: Colors.indigoAccent),),
            ],
          )
        ],
      ),
    );
  }
}


class DoneLottieScreen extends StatefulWidget {
  final String ?days;
  const DoneLottieScreen({Key? key,this.days}) : super(key: key);

  @override
  _DoneLottieScreenState createState() => _DoneLottieScreenState();
}

class _DoneLottieScreenState extends State<DoneLottieScreen> {
  @override
  void initState() {
    super.initState();

    Timer(
        const Duration(seconds: 3),
            () => Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const MyHomePage())));

  }

  @override
  Widget build(BuildContext context) {
    AppConfig.init(context);

    return Scaffold(
      backgroundColor:Colors.blueAccent ,
      body: ListView(
        children: [
          const SizedBox(height: 100,),
          Container(
            height: 500,
            width: 400,
            color: Colors.transparent,
            child: Lottie.asset(
              'assets/jsons/done.json',
              height: 500,
              width: 400,
              fit: BoxFit.fill,

            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Text(widget.days??"Thanks for joining with us\n Payment Confirmed",
                textAlign: TextAlign.center,
                style:  TextStyle(fontSize: 20,fontWeight: FontWeight.bold,
                    color: Colors.white),),
            ],
          )
        ],
      ),
    );
  }
}