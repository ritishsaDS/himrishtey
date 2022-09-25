import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';
import 'package:rishtey/controller/get_profile_controller.dart';
import 'package:rishtey/presentation/membership/my_plans.dart';
import 'package:rishtey/presentation/membership/plains_screen.dart';
import 'package:rishtey/utils/app_button.dart';
import 'package:rishtey/utils/app_config.dart';

import '../../controller/ImagePickerController.dart';
import '../../utils/app_snack_bar.dart';

class MemberShipScreen extends StatefulWidget {
  @override
  State<MemberShipScreen> createState() => _MemberShipScreenState();
}

class _MemberShipScreenState extends State<MemberShipScreen> {
  ImagePickerController?imagePickerController;
  GetProfileController?getProfileController;
  Timer? _timer;
  int _start = 60;
  String?otp;
  Timer? countdownTimer;
  Duration myDuration = Duration(minutes: 10);
  void startTimer() {
    countdownTimer =
        Timer.periodic(Duration(seconds: 1), (_) => setCountDown());
  }
  // Step 4
  void stopTimer() {
    setState(() => countdownTimer!.cancel());
  }
  // Step 5
  void resetTimer() {
    stopTimer();
    setState(() => myDuration = Duration(minutes: 10));
  }
  // Step 6
  void setCountDown() {
    final reduceSecondsBy = 1;
    setState(() {
      final seconds = myDuration.inSeconds - reduceSecondsBy;
      if (seconds < 0) {
        countdownTimer!.cancel();
      } else {
        myDuration = Duration(seconds: seconds);
      }
    });
  }
  @override
  void initState() {
    Future.delayed(Duration(milliseconds: 100), () {
      imagePickerController =
          Provider.of<ImagePickerController>(context, listen: false);
      getProfileController =
          Provider.of<GetProfileController>(context, listen: false);
      imagePickerController?.getMemberships(context);
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    String strDigits(int n) => n.toString().padLeft(2, '0');

    final days = strDigits(myDuration.inDays); // <-- SEE HERE
    final hours = strDigits(myDuration.inHours.remainder(24));
    final minutes = strDigits(myDuration.inMinutes.remainder(60));
    final seconds = strDigits(myDuration.inSeconds.remainder(60));
    return Scaffold(
      appBar: AppBar(
        title: const Text("Memberships"),
      ),
      body: Consumer<ImagePickerController>(
        builder: (context,controller,child) {
          return controller.isLoading?Center(child: CircularProgressIndicator(),):Container(
            height: AppConfig.height,
            padding: const EdgeInsets.all(15),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Text(
                  //       "50% off",
                  //       style: TextStyle(
                  //           fontWeight: FontWeight.w600,
                  //           fontSize: 18,
                  //           color: AppConfig.theme.primaryColor),
                  //     ),
                  //     const Text(
                  //       "Offer valid Till",
                  //       style: TextStyle(fontSize: 14, color: Colors.black),
                  //     )
                  //   ],
                  // ),
                  SizedBox(height: AppConfig.height*0.1,),
                  Center(
                    child: ListView.builder(
                      shrinkWrap: true,


                        itemBuilder: (context,index){
                      return Container(child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 10,),
                          Center(
                            child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>ActivationDesign(id:controller.getMembershipsModel!.memberships![index].id!,
                                  firstLine: controller.getMembershipsModel?.memberships?[index].tagLine1,
                                  secondLine: controller.getMembershipsModel?.memberships?[index].tagLine2,
                                  thirdLine: controller.getMembershipsModel?.memberships?[index].tagLine3,
                                  fourthLine: controller.getMembershipsModel?.memberships?[index].tagLine4,
                                  fifthLine: controller.getMembershipsModel?.memberships?[index].tagLine5,
                                    //terms:controller.getMembershipsModel?.memberships?[index].t
                                    memebershipName:controller.getMembershipsModel?.memberships?[index].membershipName
                                  )));

                                },
                                child:  Text(
                                  controller.getMembershipsModel?.memberships?[index].membershipName??"",
                                  style:
                                  TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                                )),
                          ),
                          SizedBox(height: 10,),
                         // Text(controller.getMembershipsModel?.memberships?[index].planDescription??"",maxLines: 2,overflow: TextOverflow.ellipsis,)
                         ReadMoreText(
                            controller.getMembershipsModel?.memberships?[index].planDescription ?? "",
                          trimLines: 3,
                          style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600),
                          colorClickableText: AppConfig.theme.primaryColor,
                          trimMode: TrimMode.Line,
                          trimCollapsedText: '...Read More',
                          trimExpandedText: ' Read less ',
                        )
                         , SizedBox(height: 10,),
                        Divider(thickness: 1.5,height: 10,)
                        ],
                      ),);
                    },itemCount: 2,),
                  ),
                  SizedBox(height: AppConfig.height*0.15,),
                  AppButton(

                    onClick: (){
                      if(myDuration.inMinutes==10){
                        startTimer();
                        imagePickerController?.getCallbackNumber(context,getProfileController?.getProfileModel?.data?.user?.fullName);

                      }
                      else{
                        appSnackBar(content:"Please wait we will assign a caller to you",context:context);
                      }
                       },
                    textWidet: myDuration.inMinutes==10?Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("Request a Callback",style: TextStyle(color: Colors.white),),
                        Text("Want a discussion",style: TextStyle(color: Colors.white,fontSize: 12),),
                      ],
                    ):Text("Please Wait",style: TextStyle(color: Colors.white)),),

                  Icon(Icons.watch_later_outlined,size: 60,color: AppConfig.theme.primaryColor.withOpacity(0.6),)
                  ,

                  Text(
                    '$minutes:$seconds',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 50),
                  ),],
              ),
            ),
          );
        }
      ),
    );
  }
}
