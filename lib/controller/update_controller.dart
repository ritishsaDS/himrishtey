import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:rishtey/http/interceptors.dart';
import 'package:rishtey/utils/app_snack_bar.dart';
import 'package:rishtey/utils/shared_pref.dart';

class UpdateController extends ChangeNotifier{
  bool isLoading = false;
  List<String>setMariatlStatus=[];
  List<String>setMotherTongue=[];
  List<String>setState=[];
  List<String>setdiet=[];
  Map<String,dynamic>selectedMap={};
  List<String>setEducation=[];
  List<String>setOccupation=[];
  String partnerHeightFrom="";
  String partnerHeightTo="";
  List<String>selectedList=[];
  Future<bool>updateBasicDetails(context,data) async {
    try{
      isLoading = true;
      notifyListeners();
      // var user_id = await SharedPref().getString(key: "user_id");
      // var data = {
      //
      //   "user_id": user_id,
      //
      // };

      print(data);
      Response response = await HttpService().postRequest(
          endPoint: "profile/profile_update", context: context, data: FormData.fromMap(data));

      if(response.statusCode==200){
        print(response.data);




        appSnackBar(content: "Profile Updated", context: context);
        isLoading = false;
        notifyListeners();

        return true;
      }
      else{
        isLoading = false;
        notifyListeners();
        return false;
      }
    }
    catch(e){
      isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool>setPrefrences(context,data)async{
    try{
      isLoading = true;
      notifyListeners();
      // var user_id = await SharedPref().getString(key: "user_id");
      // var data = {
      //
      //   "user_id": user_id,
      //
      // };
print(data);

      Response response = await HttpService().postRequest(
          endPoint: "profile/set_partner_preferences", context: context, data: FormData.fromMap(data));

      if(response.statusCode==200){
        print(response.data);


        isLoading = false;

        appSnackBar(content: "Prefrences set", context: context);

        notifyListeners();

        return true;
      }
      else{
        isLoading = false;
        notifyListeners();
        return false;
      }
    }
    catch(e){
      isLoading = false;
      notifyListeners();
      return false;
    }
  }
  emptyList(){
    selectedList=[];
    notifyListeners();
  }
  addInList(
      String?name,String?type,
      String?Apikey
      ){
    if(type=="single"){

      if(selectedList.length!=0){
        selectedList.clear();
        selectedMap.remove(Apikey);

        selectedList.add(name!);
        notifyListeners();
      }
      else{
        selectedList.add(name!);

        notifyListeners();
      }
    }
    else{
      if(!selectedList.contains(name)){
        selectedList.add(name!);
        print(selectedList.length);
        notifyListeners();
      }
      else{
        selectedList.remove(name!);

        notifyListeners();
      }
    }
  }
  addinMap(key,value){
    selectedMap[key]=value;
    notifyListeners();
  }
}