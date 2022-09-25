import 'dart:async';

import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:provider/provider.dart';
import 'package:rishtey/controller/auth_controller.dart';
import 'package:rishtey/presentation/login/login_2.dart';
import 'package:rishtey/utils/app_config.dart';

class ForgotPasswordChange extends StatefulWidget{
  const ForgotPasswordChange({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordChange> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ForgotPasswordChange> {
  OtpFieldController otpController = OtpFieldController();
  Timer? _timer;
  int _start = 60;
  double loginWidth=350;
  String?otp;
  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = Timer.periodic(
        oneSec,
            (Timer timer) => setState(() {
          if (_start == 0) {
            timer.cancel();
          } else {
            _start = _start - 1;
          }
        }));
  }
  AuthController?controller;
  @override
  void initState() {
    startTimer();

    controller=Provider.of<AuthController>(context,listen: false);
    super.initState();
  }
  TextEditingController confirmPass = TextEditingController();
  TextEditingController oldPass = TextEditingController();
  TextEditingController password = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    AppConfig.init(context);

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
                  // decoration: const BoxDecoration(
                  //     image: DecorationImage(
                  //         image: AssetImage("assets/pngIcons/Purple Login Screen.png"),
                  //         fit: BoxFit.fill)
                  // ),
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
                            SizedBox(height: 50,),
                            Center(child: Image.asset("assets/pngIcons/Group 24.png"),),
                            SizedBox(height: MediaQuery.of(context).size.height*0.2,),

                            const SizedBox(
                              height: 15,
                            ),
                            const Text(
                              "Please Enter OTP",
                              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
                            ),
                            OTPTextField(
                                controller: otpController,
                                length: 4,
                                width: MediaQuery.of(context).size.width,
                                textFieldAlignment: MainAxisAlignment.spaceAround,
                                fieldWidth: 45,

                                fieldStyle: FieldStyle.underline,
                                outlineBorderRadius: 20,
                                keyboardType: TextInputType.number,

                                isDense: true,
                                style: TextStyle(fontSize: 17,color: AppConfig.theme.primaryColorDark,fontWeight: FontWeight.w800),
                                onChanged: (pin) {
                                  print("Changed: " + pin);
                                },
                                onCompleted: (pin) {
                                  print("Completed: " + pin);
                                  otp=pin;
                                  setState(() {

                                  });
                                }),
                            const SizedBox(
                              height: 30,
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            const Text(
                              "Please Enter New password",
                              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            TextFormField(
                              controller: password,
                              decoration: const InputDecoration(
                                filled: true,
                                hintText: "Enter New Password",
                                hintStyle:  TextStyle(color: Color(0xff961b20,),
                                    fontSize: 16),
                                fillColor: Colors.transparent,

                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Enter a Valid Password';
                                }
                                if (value.length <=5) {
                                  return 'Enter a Valid Password';
                                }
                                return null;
                              },
                              keyboardType: TextInputType.emailAddress,
                            ),
                            SizedBox(height: 20,),
                            const Text(
                              "Confirm New Password",
                              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            TextFormField(
                              controller: confirmPass,
                              decoration: const InputDecoration(
                                filled: true,
                                hintText: "Enter Confirm Password",
                                hintStyle:  TextStyle(color: Color(0xff961b20,),
                                    fontSize: 16),
                                fillColor: Colors.transparent,

                              ),
                              validator: (value) {

                                if (value==null||value.length <=5) {
                                  return 'Enter a Valid Password';
                                }
                                if(value!=password.text){
                                  return 'Confirm password and new password must be same';
                                }
                                return null;
                              },
                              keyboardType: TextInputType.emailAddress,
                            ),
                            SizedBox(height: 20,),
                            Center(
                              child: GestureDetector(
                                onTap: () {
                                  if(_formKey.currentState!.validate()){
                                    setState(() {
                                      loginWidth = 60;

                                      Future.delayed(Duration(microseconds: 500), () async {

                                        // authController.isLoading=true;
                                        bool res=await authController.updatePass(context,password.text,otp);
                                        print("res");
                                        print(res);

                                        if(res==true){
                                          Navigator.push(context,MaterialPageRoute(builder: (context)=>LoginPage2()));
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
                                    duration: Duration(microseconds: 500),
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
                                        ? CircularProgressIndicator(color: Colors.white,)
                                        : Text("Change Password", style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w800),),)),
                              ),


                            ),

                            // SizedBox(
                            //   height: AppConfig.height*0.05,
                            // ),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.center,
                            //   children: [
                            //     const Text("Didn't Remember Password ?", style: TextStyle(
                            //         color: Colors.black,
                            //         fontWeight: FontWeight.w400,
                            //         fontFamily: "Poppins"),),
                            //     GestureDetector(
                            //       onTap: () {
                            //         // Navigator.push(context, MaterialPageRoute(
                            //         //     builder: (context) =>  CreateProfileFor()));
                            //       },
                            //       child: const Text(
                            //           "Forgot Password", style:  TextStyle(
                            //           fontWeight: FontWeight.bold,
                            //           color: Color(0xff961b20),
                            //           fontSize: 16,
                            //           fontFamily: "Poppins")),
                            //     ),
                            //
                            //   ],)
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