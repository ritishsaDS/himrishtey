import 'package:flutter/material.dart';
import 'package:rishtey/presentation/dashboard/dash_board_screen.dart';
import 'package:rishtey/presentation/profile/personal_profile.dart';
import 'package:rishtey/utils/app_config.dart';

import '../bottom_navigation_bar.dart';

class OnboardingFlow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(

          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                height: 150,
                width: 120,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image:
                            AssetImage("assets/pngIcons/Purple Login Screen.png"),
                        fit: BoxFit.fill)),
                child: Image.asset(
                  "assets/pngIcons/logo_icon 1.png",
                  fit: BoxFit.fitWidth,
                ),
              ),
              SizedBox(height: 20,),
              Text(
                "Waiting For Approval",
                style: Theme.of(context).textTheme.headline6,
              ),
              SizedBox(height: 20,),
              Text(
                "Thank You ! For Joining HimRishtey",
                style: Theme.of(context).textTheme.headline6,
              ),
              SizedBox(height: 30,),
              Text(
                "Do You Want To Complete Your Profile",
                style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w800,
                    fontSize: 14),
              ),
              SizedBox(height: 40,),
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>PersonalProfile()));
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(vertical: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black),
                  ),
                  child: Center(child: Text("Continue Editing Profile")),
                ),
              ),
              SizedBox(height: 20,),
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>MyHomePage()));
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(vertical: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black),
                  ),
                  child: Center(child: Text("Go To Dashboard")),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
