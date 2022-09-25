import 'dart:async';

import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:provider/provider.dart';
import 'package:rishtey/controller/auth_controller.dart';
import 'package:rishtey/utils/app_config.dart';


class OTPScreen extends StatefulWidget {
  OTPScreen({Key? key, this.title,this.type}) : super(key: key);
  final String? title;
  final String? type;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<OTPScreen> {
  OtpFieldController otpController = OtpFieldController();
  Timer? _timer;
  int _start = 60;
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
  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.cleaning_services),
        onPressed: () {
          print("Floating button was pressed.");
          otpController.clear();
          // otpController.set(['2', '3', '5', '5', '7']);
          // otpController.setValue('3', 0);
          // otpController.setFocus(1);
        },
      ),
      body: Container(
    height: AppConfig.height,
   // decoration: const BoxDecoration(
   //  image: DecorationImage(
   // // image: AssetImage("assets/pngIcons/Purple Login Screen.png"),
   //  fit: BoxFit.fill)),
    child: SingleChildScrollView(
    scrollDirection: Axis.vertical,
    child: Container(
    padding: EdgeInsets.all(20),
    alignment: Alignment.bottomCenter,
    margin: EdgeInsets.only(top: AppConfig.height*0.2),

    //  color: Colors.white,
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [

    // const SizedBox(height: 50,),
    Center(child: Image.asset("assets/pngIcons/Group 24.png"),),
    const SizedBox(
    height: 50,
    ),
    Center(
    child:  Text(
    "Enter 4 Digit Otp sent to xxxxx${widget.title.toString().substring(6,10)} number",
    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
    ),
    ),
    const SizedBox(
    height: 50,
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
      Row(
        children: [
          ElevatedButton(
              onPressed: () {
               // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>OTPScreen(title:";")));

if(widget.type=="Verify"){
  controller?.verifyProfile(context,otp);
}
else{
  controller?.verifyOtp(context,otp);
}
              },

              child:const Text(
                "Verify Otp",
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
      const SizedBox(
        height: 50,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
       _start!=0?Text("send code(${_start.toString()}sec)"): GestureDetector(
           onTap: (){

             if(widget.type=="Verify"){
               controller?.verifyProfileOtp(context, widget.title, "");
             }
             else{
               controller?.getOtp(context,widget.title,"");
               otpController.clear();
             }

           },
           child: Text("Resend Code",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w800),)),
          Icon(Icons.arrow_forward_ios_rounded)
      ],)
      ]),
    ))));
  }
}