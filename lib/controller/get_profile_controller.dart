import 'dart:developer';

import 'package:crop_image/crop_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:rishtey/models/get_profile_model.dart';
import 'package:rishtey/models/other_profile_detail.dart';
import 'package:rishtey/presentation/bottom_navigation_bar.dart';
import 'package:rishtey/presentation/dashboard/hide_file_lottie.dart';
import 'package:rishtey/presentation/other_profile_view/others_profile_view.dart';
import 'package:rishtey/utils/app_snack_bar.dart';
import 'package:rishtey/utils/endpoints.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../http/interceptors.dart';
import '../utils/shared_pref.dart';

class GetProfileController extends ChangeNotifier{
  GetProfileModel? getProfileModel;
  OtherProfileDetail?otherProfileDetail;
  //Data? getProfileData;
  bool isLoading=false;
  Future<void>getProfile(context) async {
    isLoading = true;
    notifyListeners();
  var id=await  SharedPref().getString(key: "user_id" );
   try{
      Response res = await HttpService().getRequest(
          endPoint: "profile/user/${id??42}",

          context: context);
      print("res.statusCode==============");
      print(res.statusCode);
      getProfileModel=GetProfileModel.fromJson(res.data);

print(getProfileModel!.data!.user!.email);
      isLoading = false;

      notifyListeners();

   }
   catch(e){
     print("jndsdxl$e");
     isLoading = false;

     notifyListeners();

   }

}
  Future<void>otherProfile(context,Profileid) async {
    isLoading = true;
    notifyListeners();
    var id=await  SharedPref().getString(key: "user_id" );
    var data={
      "user_id":id,
      "profile_id":Profileid
    };
    print(";ouhkk");
    print(data);
    try{
      Response res = await HttpService().postRequest(
          endPoint: "/profile/view",data: FormData.fromMap(data),

          context: context);
print(res.statusCode);
log(res.data.toString());
     if(res.statusCode==200){
       otherProfileDetail=OtherProfileDetail.fromJson(res.data);

       isLoading = false;

       notifyListeners();
     }
      // return getProfileData;
   }
   catch(e){
      print("jndsdxl$e");
      isLoading = false;
      notifyListeners();
    }
    // return getProfileModel!;
  }
  bool showLotie=false;

  Future<bool>updatePaymentStatus(context,plainId,date,amount,txnId,remark) async {
isLoading=true;
notifyListeners();
var user_id = await SharedPref().getString(key: "user_id");
var data = {
"user_id": user_id.toString(),
"payment_status": "1",
  "plan_id":plainId,
  "payment_date":date,
  "amount":amount,
  "txn_id":txnId,
  "remark":remark};

try{
  Response res = await HttpService().postRequest(
      endPoint: "profile/update_payment_status",data:FormData.fromMap(data) ,

      context: context);
  print("hekkgkgk${res.statusCode}");
  if(res.statusCode==200){
    isLoading=false;
    notifyListeners();
    Navigator.push(context, MaterialPageRoute(builder: (context)=>DoneLottieScreen()));
    return true;
  }
  else{
    isLoading=false;
    notifyListeners();
    Navigator.push(context, MaterialPageRoute(builder: (context)=>MyHomePage()));
    return false;
  }

}
    catch(e){
  isLoading=false;
  notifyListeners();
  return false;
    }

}
  Future<bool>addMoneyInWallet(profileId,context,amount,txnId,remark,{type}) async {
    isLoading=true;
    notifyListeners();
    var user_id = await SharedPref().getString(key: "user_id");
    var data = {
      "user_id": user_id.toString(),

      "amount":amount,
      "txn_id":txnId,
      "remark":remark};
print(data);
    try{
      Response res = await HttpService().postRequest(
          endPoint: "profile/update_wallet_balance",data:FormData.fromMap(data) ,

          context: context);
      print("hekkgkgk${res.statusCode}");
      if(res.statusCode==200){
        isLoading=false;
        notifyListeners();
if(type!="wallet"){
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>OtherProfileView(getId: int.parse(profileId),)));

}
else{
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>DoneLottieScreen()));

}
        return true;
      }
      else{
        isLoading=false;
        notifyListeners();
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>OtherProfileView(getId:int.parse(profileId))));
        return false;
      }

    }
    catch(e){
      isLoading=false;
      notifyListeners();
      return false;
    }

  }
  Future<bool>sendInterest(context,id,{String?type}) async {
    isLoading = true;
    notifyListeners();
    var user_id = await SharedPref().getString(key: "user_id");
    var data = {
      "profile_id": id,
      "user_id": user_id
    };
    print("jjlklmk;");
    print(data);
    try {
      Response res = await HttpService().postRequest(
          endPoint: Endpoints.sendInterest, data: FormData.fromMap(data), context: context);
      print(res.statusCode);
      if(res.statusCode==200){
        isLoading = false;
        showLotie=true;
        Future.delayed(const Duration(milliseconds: 2000),(){
          showLotie=false;
          notifyListeners();
        });
        if(type=="other"){
          otherProfileDetail?.data?.user?.interest=1;
          notifyListeners();
        }
        notifyListeners();
        return true;
      }
      else{
        isLoading = false;
        notifyListeners();
        appSnackBar(content: "Something Went Wrong", context: context);
        return false;
      }
    }
    catch(e){
      appSnackBar(content: e.toString(), context: context);
      isLoading = false;
      notifyListeners();
      return false;
    }

  }
  Future<bool>shortlistProfile(context,id,) async {
    isLoading = true;
    notifyListeners();
    var user_id = await SharedPref().getString(key: "user_id");
    var data = {
      "profile_id": id,
      "user_id": user_id
    };
    print("jjlklmk;");
    print(data);
    try {
      Response res = await HttpService().postRequest(
          endPoint: "profile/add_to_shortlist", data: FormData.fromMap(data), context: context);
      print(res.statusCode);
      if(res.statusCode==200){
        isLoading = false;
        // showLotie=true;
        // Future.delayed(const Duration(milliseconds: 2000),(){
        //   showLotie=false;
        //   notifyListeners();
        // });
        //
          otherProfileDetail?.data?.user?.shortlisted="Yes";
          notifyListeners();
       // }
       // notifyListeners();
        return true;
      }
      else{
        isLoading = false;
        notifyListeners();
        appSnackBar(content: "Something Went Wrong", context: context);
        return false;
      }
    }
    catch(e){
      appSnackBar(content: e.toString(), context: context);
      isLoading = false;
      notifyListeners();
      return false;
    }

  }
  Future<bool>removeShortlistProfile(context,id,) async {
    isLoading = true;
    notifyListeners();
    var user_id = await SharedPref().getString(key: "user_id");
    var data = {
      "profile_id": id,
      "user_id": user_id
    };
    print("jjlklmk;");
    print(data);
    try {
      Response res = await HttpService().postRequest(
          endPoint: "profile/remove_from_shortlist", data: FormData.fromMap(data), context: context);
      print(res.statusCode);
      if(res.statusCode==200){
        isLoading = false;
        // showLotie=true;
        // Future.delayed(const Duration(milliseconds: 2000),(){
        //   showLotie=false;
        //   notifyListeners();
        // });
        //
        otherProfileDetail?.data?.user?.shortlisted="No";
        notifyListeners();
        // }
        // notifyListeners();
        return true;
      }
      else{
        isLoading = false;
        notifyListeners();
        appSnackBar(content: "Something Went Wrong", context: context);
        return false;
      }
    }
    catch(e){
      appSnackBar(content: e.toString(), context: context);
      isLoading = false;
      notifyListeners();
      return false;
    }

  }
  Future<bool>deductMoney(context,id,profile_amount) async {
    isLoading = true;
    notifyListeners();
    var user_id = await SharedPref().getString(key: "user_id");
    var data = {
      "profile_id": id,
      "user_id": user_id,
      "profile_amount":profile_amount
    };

    print(data);
    try {
      Response res = await HttpService().postRequest(
          endPoint: "profile/view_contact", data: FormData.fromMap(data), context: context);
      print(res.statusCode);print("jjlklmk;");

      if(res.statusCode==200){
        isLoading = false;
        // showLotie=true;
        // Future.delayed(const Duration(milliseconds: 2000),(){
        //   showLotie=false;
        //   notifyListeners();
        // });
        //
        otherProfileDetail?.data?.user?.profileViewed="Yes";
        notifyListeners();
        // }
        // notifyListeners();
        return true;
      }
      else{
        isLoading = false;
        notifyListeners();
        appSnackBar(content: "Something Went Wrong", context: context);
        return false;
      }
    }
    catch(e){
      appSnackBar(content: e.toString(), context: context);
      isLoading = false;
      notifyListeners();
      return false;
    }

  }
  CropController controller=CropController();
  Future<bool>setProfilePic(context,image) async {
controller.dispose();
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
      getProfileModel?.data?.user?.photo=response.data["image"].toString().replaceAll("https://webtechworlds.com/himrishtey/photos/photo/", "");
      //getProfileModel.data.user?.photo=;
      isLoading=false;
notifyListeners();
   print("getProfileModel?.data?.user?.photo");
   print(getProfileModel?.data?.user?.photo);
      // getProfileController!.getProfile(context);
      // Future.delayed(Duration(seconds: 2),(){
      //   //Navigator.push(context, MaterialPageRoute(builder: (context)=>Gallery()));
      //
      //
      //   //appSnackBar(content: "Photo Updated", context: context);
      //
      //   //notifyListeners();
      // });

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
}