import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:rishtey/controller/get_profile_controller.dart';
import 'package:rishtey/http/interceptors.dart';
import 'package:rishtey/models/get_memberships.dart';
import 'package:rishtey/models/get_profile_model.dart';
import 'package:rishtey/presentation/edit_screens/user_gallery/gallery.dart';
import 'package:rishtey/presentation/profile/personal_profile.dart';
import 'package:rishtey/utils/app_snack_bar.dart';

import '../models/plains_model.dart';
import '../models/wallet_offers_model.dart';
import '../presentation/dashboard/dash_board_screen.dart';
import '../presentation/profile/onboarding_flow.dart';
import '../presentation/register/crop_image.dart';
import '../utils/shared_pref.dart';


class ImagePickerController extends ChangeNotifier {
  File? images;
WalletOffers?walletOffers;
  var imagePicker =  ImagePicker();
 bool isLoading=false;
  Future pickImage(context, {api}) async {
    XFile? image = await imagePicker.pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
      preferredCameraDevice: CameraDevice.rear,
    );

    images = File(image!.path);
if(images!.length()!=0){

  print("kjnjodsno");
  if(api!=null){
    sendGalleryImageServer(context);
  }
  else{
    sendImageServer(context);
  }
}
    notifyListeners();
  }

  Future pickGallery(context,{api}) async {
    XFile? image = await imagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
      preferredCameraDevice: CameraDevice.rear,
    );

    images = File(image!.path);
    if(images!.length()!=0){

      print("kjnjodsno");
      if(api!=null){
        sendGalleryImageServer(context);
      }
      else{
        sendImageServer(context);
      }
    }
    notifyListeners();
  }

  sendImageServer(context) async {
    print(images);

    final bytes = images!.readAsBytesSync();
    String base64Image =  base64Encode(bytes);

    var userid;
    userid=await SharedPref().getString(key: "user_id");
    notifyListeners();
    //  request.headers.addAll(headers);

  var data={
    "user_id":userid,
    "profile_completed":50,
    "image":base64Image
  };
    print("response.data$data");
    log("response.data$data");
    Response response=await HttpService().postRequest(endPoint: "user/add_profile_photo",context: context,data: FormData.fromMap(data));
  print(response.data);
  if(response.statusCode==200||response.statusCode==201){
    appSnackBar(content: response.data['message'], context: context);
    Navigator.push(context, MaterialPageRoute(builder: (context)=>CropImages(title: images!,)));
  }
  }
  sendGalleryImageServer(context) async {
    print(images);

    final bytes = images!.readAsBytesSync();
    String base64Image =  base64Encode(bytes);

    var userid;
    userid=await SharedPref().getString(key: "user_id");
    notifyListeners();
    //  request.headers.addAll(headers);

    var data={
      "user_id":userid,

      "image":base64Image
    };
   // print("response.data$data");
    //log("response.data$data");
    Response response=await HttpService().postRequest(endPoint: "profile/add_gallery",context: context,data: FormData.fromMap(data));
    print(response.statusCode);
    if(response.statusCode==200||response.statusCode==201){
      appSnackBar(content: response.data['message'], context: context);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Gallery()));
    }
  }
 Future<bool>privacyImage(context,privacyStatus)async{
   var userid;
   userid=await SharedPref().getString(key: "user_id");
    var data={
      "user_id":userid,
          "privacy_status":privacyStatus
    };
    print(data);
    try{
      Response response=await HttpService().postRequest(context:context,endPoint: "profile/photo_privacy",data:FormData.fromMap(data) );

      print(";jflnc${response.statusCode}");
      if(response.statusCode==200){
  appSnackBar(content: "Privacy Changed", context: context);
  return true;
}
      return true;
   }
        catch(e){

      print(";jflnc$e");
      return false;
        }
 }
 GetMemberships?getMembershipsModel;
  PlainsModel?plainsModel;
getMemberships(context) async {
  isLoading=true;
  notifyListeners();
    try{

      Response response=await HttpService().getRequest(endPoint: "profile/get_memberships", context: context);

      if(response.statusCode==200){
        isLoading=false;
        getMembershipsModel=GetMemberships.fromJson(response.data);
        notifyListeners();
      }
    }
        catch(e){
          isLoading=false;
          notifyListeners();
        }
}
getPlains(context,id) async {
  isLoading=true;
  notifyListeners();
  try{
var data={
  "membership_id":"1"
};
  Response response=await HttpService().postRequest(endPoint: "/profile/get_plans", context: context,data: FormData.fromMap(data));
print(response.data);
  if(response.statusCode==200){
  isLoading=false;
  plainsModel=PlainsModel.fromJson(response.data);
  notifyListeners();
  }
  }
  catch(e){
  isLoading=false;
  
  notifyListeners();
  }
}
GetProfileController?getProfileController;

Future<bool>setProfilePic(context,image) async {
  getProfileController=Provider.of<GetProfileController>(context,listen: false);
  isLoading=true;
  notifyListeners();
  var userid;
  userid=await SharedPref().getString(key: "user_id");

  var data={
    "user_id":userid,
    "image":image
  };
  print(data);

 // try{
    Response response=await HttpService().postRequest(context:context,endPoint: "user/update_profile_photo",data:FormData.fromMap(data) );

    print(";jflnc${response.statusCode}");
    if(response.statusCode==200){
      print(response.data);
      getProfileController?.getProfileModel?.data?.user?.photo=response.data["image"].toString().replaceAll("https://webtechworlds.com/himrishtey/photos/photo/", "");
      //getProfileModel.data.user?.photo=;


     // getProfileController!.getProfile(context);
      Future.delayed(Duration(seconds: 2),(){
        //Navigator.push(context, MaterialPageRoute(builder: (context)=>Gallery()));

        isLoading=false;
        //appSnackBar(content: "Photo Updated", context: context);

        //notifyListeners();
      });

      return true;
    }
    return true;
  //}
  // catch(e){
  //   isLoading=false;
  //   notifyListeners();
  //   print(";jflnc$e");
  //   return false;
  // }
}

getCallbackNumber(context,name) async {
  Response response=await  HttpService().getRequest(endPoint: "profile/callback_number", context: context);
  if(response.statusCode==200){
    print(response.data['number']['number']);
    appSnackBar(content: "We will assign a caller to you \n Please wait for while", context: context,duration: Duration(seconds: 2));
    requestCallbackNumber(context,name,response.data['number']['number']);
  }
}

getWalletOffers(context)async{
  isLoading=true;
  notifyListeners();
 try{ Response response=await  HttpService().getRequest(endPoint: "profile/wallet_offer", context: context);
  if(response.statusCode==200){
    walletOffers=WalletOffers.fromJson(response.data);
    //requestCallbackNumber(context,name,response.data['number']['number']);
    isLoading=false;
    notifyListeners();
  }
}
catch(e){
  isLoading=false;
  notifyListeners();
}
}
  requestCallbackNumber(context,name,number) async {
  try{
    isLoading=true;
    notifyListeners();
    var userId=await SharedPref().getString(key: "user_id");
    var data={
      "user_id":userId,
      "user_name":name,
      "number":number,
    };
    Response response=await  HttpService().postRequest(endPoint: "profile/call_back", context: context,data: FormData.fromMap(data));
    if(response.statusCode==200){
      print("response.data['number']['number']");
      isLoading=false;
      notifyListeners();
    }
  else{
      isLoading=false;
      notifyListeners();
    }
  }
      catch(e){
    isLoading=false;
    notifyListeners();
      }
  }
}
