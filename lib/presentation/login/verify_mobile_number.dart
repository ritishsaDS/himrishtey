import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rishtey/controller/auth_controller.dart';
import 'package:rishtey/presentation/login/otp_screen.dart';
import 'package:rishtey/utils/app_config.dart';

class VerifyMobileNumber extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController mobile=TextEditingController();
    AuthController?controller;
    controller=Provider.of<AuthController>(context,listen: false);
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: AppConfig.height,
          // decoration: const BoxDecoration(
          //     image: DecorationImage(
          //         image: AssetImage("assets/pngIcons/Purple Login Screen.png"),
          //         fit: BoxFit.fill)),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
              padding: EdgeInsets.all(20),
              alignment: Alignment.bottomCenter,
              margin: EdgeInsets.only(top: 50),

              //  color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  // const SizedBox(height: 50,),
                  Center(child: Image.asset("assets/pngIcons/Group 24.png"),),
                  const SizedBox(
                    height: 50,
                  ),
                  Center(
                    child: const Text(
                      "Enter Mobile Number to verify & get OTP",
                      style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  const Text(
                    "Mobile Number ",
                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: mobile,
                    maxLength: 10,

                    decoration: InputDecoration(
                      labelText: "Enter Mobile Number",
                      labelStyle: TextStyle(color: Color(0xff961b20,),fontSize: 16),
                      fillColor: Colors.white,

                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),

                      ),

                      focusedBorder:const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                          borderSide: BorderSide(color: Color(0xff961b20))),
                    ),
                    validator: (val) {},
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(
                    height: 40,
                  ),

                  Row(
                    children: [
                      ElevatedButton(
                          onPressed: () {

                            controller?.verifyProfileOtp(context,mobile.text,"");
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>OTPScreen(title:mobile.text,type:"Verify")));

                          },

                          child:const Text(
                            "Send OTP",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          style: ElevatedButton.styleFrom(
                            primary:   Color(0xffFF5D4B),

                            //button's fill color
                            onPrimary:  Color(0xff961b20), //specify the color of the button's text and icons as well as the overlay colors used to indicate the hover, focus, and pressed states
                            onSurface: Color(0xff961b20), //specify the button's disabled text, icon, and fill color
                            shadowColor:
                            Color(0xff961b20), //specify the button's elevation color
                            elevation: 4.0, //buttons Material shadow

                            padding: const EdgeInsets.only(
                                top: 4.0,
                                bottom: 4.0,
                                right: 8.0,
                                left: 8.0), //specify the button's Padding
                            minimumSize: Size(MediaQuery.of(context).size.width-40,
                                60), //specify the button's first: width and second: height

                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0)),
                          )),

                    ],
                  ),
                  //  const  Expanded(child: SizedBox()),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
