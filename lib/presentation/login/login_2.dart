import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:rishtey/login.dart';
import 'package:rishtey/presentation/register/create_profile_fior.dart';
import 'package:rishtey/presentation/register/forgot_password.dart';
import 'package:rishtey/presentation/register/sign_up.dart';
import 'package:rishtey/utils/app_config.dart';

import '../../controller/auth_controller.dart';
import '../bottom_navigation_bar.dart';

class LoginPage2 extends StatefulWidget {
  @override
  State<LoginPage2> createState() => _LoginPage2State();
}

class _LoginPage2State extends State<LoginPage2> {
  AuthController? authController;
  double loginWidth = 350
  ;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
AppConfig.init(context);
    authController=Provider.of<AuthController>(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
        body: Consumer<AuthController>(
        builder: (context, authController, _)
    {
      return SafeArea(
        child: Container(
          height: MediaQuery
              .of(context)
              .size
              .height,
          decoration:  BoxDecoration(
              // image: DecorationImage(
              //     image: AssetImage("assets/pngIcons/Purple Login Screen.png"),
              //     fit: BoxFit.fill)
            color: Color(0xFFFF0000).withOpacity(0.04)
          ),
          child:SingleChildScrollView(
            child: Container(
            padding: const EdgeInsets.all(20),
            alignment: Alignment.bottomCenter,


            child: Form(
              key: _formKey,
              child:  Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    //const SizedBox(height: 50,),
                   Center(child: Image.asset("assets/pngIcons/Group 24.png"),),
                    SizedBox(height: MediaQuery.of(context).size.height*0.15,),

                    const Text(
                      "Profile ID / Mobile Number / Email",
                      style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
controller: email,
                      decoration: const InputDecoration(
                        filled: true,
                        hintText: "Enter Profile ID / Mobile Number / Email",
                        hintStyle:  TextStyle(color: Color(0xff961b20,),
                            fontSize: 16),
                        fillColor: Colors.transparent,

                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter a Valid Email address';
                        }

                        return null;
                      },
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "Password",
                      style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      controller: password,
                      decoration: const InputDecoration(
                        filled: true,

                        hintText: "Enter Password",
                        hintStyle: TextStyle(
                            color: Color(0xff961b20,), fontSize: 16),
                        fillColor: Colors.transparent,

                        //fillColor: Colors.green
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter Password';
                        }
                        if (value.length <=5) {
                          return 'Enter a Valid Password';
                        }
                        return null;
                      },                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          if(_formKey.currentState!.validate()){
                            setState(() {
                              loginWidth = 60;

                              Future.delayed(const Duration(microseconds: 500), () async {

                                  // authController.isLoading=true;
                                  bool res=await authController.login(context,email.text,password.text);
                                  print("res");
                                  print(res);

if(res==true){
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => const MyHomePage()));
}
                                  setState(() {
                                    loginWidth=350;
                                  });
                                });
                              });

                          }

                        },
                        child: AnimatedContainer(
                            width: loginWidth,
                            alignment: Alignment.center,
                            duration: const Duration(microseconds: 500),
                            height: 60,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                gradient: const LinearGradient(
                                  begin: Alignment.topRight,
                                  end: Alignment.topLeft,
                                  colors: [
                                    Color(0xffFF5D4B),
                                    Color(0xffFF7C57),

                                  ],
                                )),
                            child: Center(child: authController.isLoading
                                ? const CircularProgressIndicator(color: Colors.white,)
                                : const Text("Login", style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w800),),)),
                      ),


                    ),
                    SizedBox(
                      height: AppConfig.height*0.02,
                    ),
                     Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         GestureDetector(
                           onTap: () {
                             Navigator.push(context, MaterialPageRoute(
                                 builder: (context) =>   LoginPage()));
                           },
                           child: const Text(
                               "Login with OTP", style:  TextStyle(
                               fontWeight: FontWeight.bold,
                               color: Color(0xff961b20),
                               fontSize: 16,
                               fontFamily: "Poppins")),
                         ),
                       GestureDetector(
                         onTap: () {
                           Navigator.push(context, MaterialPageRoute(
                               builder: (context) =>  const ForgotPassWord()));
                         },
                         child: const Text(
                             "Forgot Password", style:  TextStyle(
                             fontWeight: FontWeight.bold,
                             color: Color(0xff961b20),
                             fontSize: 16,
                             fontFamily: "Poppins")),
                       ),
                     ],),
                     SizedBox(
                       height: AppConfig.height*0.03,
                     ),
                    Row(
                      children: [

                        Container(height: 1,width: AppConfig.width*0.4,color:Colors.grey.shade500,),
                        Text("  OR  "),
                        Container(height: 1,width: AppConfig.width*0.4,color:Colors.grey.shade500,),],
                    ),
                    SizedBox(
                      height: AppConfig.height*0.04,
                    ),
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) =>  CreateProfileFor()));

                        },
                        child: AnimatedContainer(
                            width: 350,
                            alignment: Alignment.center,
                            duration: const Duration(microseconds: 500),
                            height: 60,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                gradient: const LinearGradient(
                                  begin: Alignment.topRight,
                                  end: Alignment.topLeft,
                                  colors: [
                                    Color(0xffFF5D4B),
                                    Color(0xffFF7C57),

                                  ],
                                )),
                            child: Center(child:
                                 const Text("Signup Free", style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w800),),)),
                      ),


                    ),
                    SizedBox(
                      height: AppConfig.height*0.04,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don't have an account ? ", style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontFamily: "Poppins"),),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context) =>  CreateProfileFor()));
                          },
                          child: const Text(
                              "Create Account", style:  TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xff961b20),
                              fontSize: 16,
                              fontFamily: "Poppins")),
                        ),

                      ],),

                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }));
  }
}
