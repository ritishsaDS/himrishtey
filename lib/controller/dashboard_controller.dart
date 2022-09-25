import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:rishtey/http/interceptors.dart';
import 'package:rishtey/models/other_profile_detail.dart';
import 'package:rishtey/utils/app_snack_bar.dart';
import 'package:rishtey/utils/endpoints.dart';

import 'package:rishtey/models/dashboard_profile_model.dart';
import 'package:rishtey/models/dashboard_profile_model.dart'as user;

import '../models/pop_up_model.dart';
import '../utils/shared_pref.dart';
class DashBoardController extends ChangeNotifier {
  DashBoardProfilesModel?dashBoardProfilesModel;
  DashBoardProfilesModel?matchingProfilesModel;
  DashBoardProfilesModel?shortlistedProfileModel;
  DashBoardProfilesModel?verifiedProfileModel;
  OtherProfileDetail?otherProfileDetail;
  PopUpData?popUpData;
  String profileId="0";
  bool isLoading = false;
  bool interestLoading = false;
  bool showLotie=false;
  getDashBoardProfiles(context, gender) async {
    isLoading = true;
    notifyListeners();
    var user_id = await SharedPref().getString(key: "user_id");
    var data = {
      "gender": "Male",
      "user_id": user_id
    };
    print(data);

    Response res = await HttpService().postRequest(
        endPoint: "profile/recent_profiles", data: FormData.fromMap(data),context: context);
    print("lkfmf;kfll");
    log(res.data.toString());
    dashBoardProfilesModel = DashBoardProfilesModel.fromJson(res.data);
    isLoading = false;
    notifyListeners();
    return dashBoardProfilesModel;
  }
  getShortlistedProfiles(context) async {
    isLoading = true;
    notifyListeners();
    var user_id = await SharedPref().getString(key: "user_id");
    var data = {

      "user_id": user_id,
    };
    print("res.statusCode");
    print(data);

    Response res = await HttpService().postRequest(
        endPoint: "profile/shortlisted_profiles", data: FormData.fromMap(data),context: context);
    print(res.statusCode);
    print("res.statusCode");
    print(res.data);
    shortlistedProfileModel = DashBoardProfilesModel.fromJson(res.data);
    isLoading = false;
    notifyListeners();
    return shortlistedProfileModel;
  }
  getVerifiedProfiles(context) async {
    isLoading = true;
    notifyListeners();
    var user_id = await SharedPref().getString(key: "user_id");
    var data = {

      "user_id": user_id,
      "gender":"Male"
    };
    print("res.statusCodeasdscf");
    print(data);

    Response res = await HttpService().postRequest(
        endPoint: "profile/verified_profiles", data: FormData.fromMap(data),context: context);

    verifiedProfileModel = DashBoardProfilesModel.fromJson(res.data);
    isLoading = false;
    notifyListeners();
    return verifiedProfileModel;
  }
  getMatchingProfiles(context) async {
    isLoading = true;
    notifyListeners();
    var user_id = await SharedPref().getString(key: "user_id");
    var data = {

      "user_id": user_id
    };
    print(",shydnofjofoihf$data");

   // try{
      Response res = await HttpService().postRequest(
          endPoint: "profile/matching_profiles", data: FormData.fromMap(data),context: context);
      print("=-------------------${res.data}");
      if(res.statusCode==200){
        //print(res.data['user'][0]==null);
        // for(int i=0;i<res.data['user'].length;i++){
        //   if(res.data['user'][i]["id"]!="0"){

         matchingProfilesModel=   DashBoardProfilesModel.fromJson(res.data);
            notifyListeners();
        //  }
      //  }

        isLoading = false;
        notifyListeners();
       // return matchingProfilesModel;
      }
    }
 //    catch(e){
 //      print("Matchong Profile$e");
 //    }
 // }
  Future<bool>sendInterest(context,id,{String?type}) async {
    interestLoading = true;
    profileId=id;
    notifyListeners();
    var user_id = await SharedPref().getString(key: "user_id");
    var data = {
      "profile_id": int.parse(id.toString()),
      "user_id": user_id
    };
    print(data);
    try {
      Response res = await HttpService().postRequest(
          endPoint: Endpoints.sendInterest, data: FormData.fromMap(data), context: context);
print(res.statusCode);
      if(res.statusCode==200){
        interestLoading = false;
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
        interestLoading = false;
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
  showPopUp(context)async{
    Response res = await HttpService().getRequest(
        endPoint: "profile/offers",context: context);

    popUpData = PopUpData.fromJson(res.data);

    notifyListeners();

  }

  changeSendInterest({user.User? data,int?index}){
    data!.interest="Yes";
    notifyListeners();
  }



}