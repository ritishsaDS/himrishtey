import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rishtey/controller/auth_controller.dart';
import 'package:rishtey/presentation/login/otp_screen.dart';
import 'package:rishtey/utils/app_config.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController mobile=TextEditingController();
  AuthController?controller;
 @override
  void initState() {
   controller=Provider.of<AuthController>(context,listen: false);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

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
            padding: const EdgeInsets.all(20),
            alignment: Alignment.bottomCenter,
            margin: const EdgeInsets.only(top: 50),

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
                  const Center(
                    child: Text(
                      "Enter Mobile Number to get OTP",
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

                    decoration: const InputDecoration(
                      labelText: "Enter Mobile Number",
                      labelStyle: TextStyle(color: Color(0xff961b20,),fontSize: 16),
                      fillColor: Colors.white,




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
                          onPressed: () async{
print("mobile.text");
print(mobile.text);
                           bool?res=await controller?.getOtp(context,mobile.text,"");
if(res==true){
  Navigator.push(context, MaterialPageRoute(builder: (context)=>OTPScreen(title:mobile.text)));

}
                          },

                          child:Consumer<AuthController>(
                            builder: (context,contrpoller,child) {
                              return contrpoller.isLoading?Center(child: CircularProgressIndicator(),):const Text(
                                "Send OTP",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              );
                            }
                          ),
                          style: ElevatedButton.styleFrom(
                            primary:   const Color(0xffFF5D4B),

                              //button's fill color
                            onPrimary:  const Color(0xff961b20), //specify the color of the button's text and icons as well as the overlay colors used to indicate the hover, focus, and pressed states
                            onSurface: const Color(0xff961b20), //specify the button's disabled text, icon, and fill color
                            shadowColor:
                            const Color(0xff961b20), //specify the button's elevation color
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
                  const SizedBox(height: 100,),
                  Center(
                    child: RichText(
                      text: const TextSpan(
                        text: "Don't have an Account ? ",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontFamily: "Poppins"),
                        children: <TextSpan>[
                          TextSpan(
                              text: 'Create Account',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff961b20),
                                  fontSize: 16,
                                  fontFamily: "Poppins")),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
