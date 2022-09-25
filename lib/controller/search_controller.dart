import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rishtey/models/advance_search_post_model.dart';
import 'package:rishtey/presentation/other_profile_view/others_profile_view.dart';
import 'package:rishtey/utils/endpoints.dart';

import '../http/interceptors.dart';
import '../models/searched_profiles.dart';
import '../presentation/all_search/all_search/show_searches/serach_result.dart';
import '../utils/shared_pref.dart';

class SearchController extends ChangeNotifier {
  SearchedProfiles?searchedProfiles;
  List<String> selectedList=[];
  Map<String,dynamic>advanceData={};
  bool isLoading = false;
  final TextEditingController textFieldController=TextEditingController();
  Future<bool> quickSearch(context, ageFrom, ageTo, religion, cast,maritalStatus) async {
    isLoading = true;
    notifyListeners();
    var user_id = await SharedPref().getString(key: "user_id");
    var data = {
      "user_id": user_id.toString(),
      "gender":"Male",
      "age_from": ageFrom.toString(),
      "age_to": ageTo.toString(),
      "cast": cast.toString(),
      "religion": religion.toString(),
      'marital_status':maritalStatus
    };
    try {
      Response response = await HttpService().postRequest(
          endPoint: Endpoints.quickSearch, context: context, data: FormData.fromMap(data));

      if (response.statusCode == 200) {
        isLoading = false;

        searchedProfiles=SearchedProfiles.fromJson(response.data);
        notifyListeners();
        print(searchedProfiles!.user);
        Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchResult()));
        return true;
      } else {
        isLoading = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      isLoading = false;
      notifyListeners();
      return false;
    }
  }
addValue(key,value){
    advanceData[key]=value;
    notifyListeners();
}
  Future<bool> searchByProfileId(context) async {
    isLoading = true;
    notifyListeners();
    var user_id = await SharedPref().getString(key: "user_id");
    var data = {
      "user_id": user_id.toString(),
      "profile_id":textFieldController.text
    };
    print(data);

    try {
      Response response = await HttpService().postRequest(
          endPoint: Endpoints.searchById, context: context, data: FormData.fromMap(data));
print(response.data);
print(data);
      if (response.statusCode == 200) {
        isLoading = false;

        //searchedProfiles=SearchedProfiles.fromJson(response.data);
        notifyListeners();
        Navigator.push(context, MaterialPageRoute(builder: (context)=>OtherProfileView(getId:int.parse(response.data['user']["id"]) ,)));
        return true;
      } else {
        isLoading = false;
        notifyListeners();
        return false;
      }
    } catch (e) {

      isLoading = false;
      notifyListeners();
      return false;
    }
  }
  Future<bool> advanceSearch(context,data) async{
    isLoading = true;
    //notifyListeners();
   // var user_id = await SharedPref().getString(key: "user_id");

    //   "employed_in":advanceSearchPostModel.employed_in??"",
    //   "age_from":advanceSearchPostModel.age_from??"",
    //   "age_to":advanceSearchPostModel.age_to??"",
    //   "height_from":advanceSearchPostModel.height_from??"",
    //   "height_to":advanceSearchPostModel.height_to??"",
    //   "religion":advanceSearchPostModel.religion??"",
    //   "mother_tongue":advanceSearchPostModel.mother_tongue??"",
    //   "cast":advanceSearchPostModel.cast??"",
    //   "manglik":advanceSearchPostModel.manglik??"",
    //   "marital_status":advanceSearchPostModel.marital_status??"",
    //   "education":advanceSearchPostModel.education??"",
    //   "annual_income":advanceSearchPostModel.annual_income??"",
    //   "family_status":advanceSearchPostModel.family_status??"",
    //   "family_type":advanceSearchPostModel.family_type??"",
    // };
    // var stringParams = <String, String>{};
    // stringParams=data;
    // notifyListeners();
//Map<String,String> datas=json.decode(json.encode(data));
    print(data);
  //  print(datas);


    try {
      Response response = await HttpService().postRequest(
          endPoint: Endpoints.advanceSearch, context: context, data:   FormData.fromMap(data));
      print(response.statusCode);
      if (response.statusCode == 200) {
        isLoading = false;
print(response.data);
       searchedProfiles=SearchedProfiles.fromJson(response.data);
        notifyListeners();

        Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchResult()));
        return true;
      } else {
        isLoading = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      print(e);
      isLoading = false;
      notifyListeners();
      return false;
    }
}

emptyList(){
    selectedList=[];

    notifyListeners();
}
clearData(){
  selectedList.clear();
  advanceData.clear();
  notifyListeners();
}
emptyData(){
  advanceData={};

  notifyListeners();
}
addInList(
    String?name,String?type
    ){
    if(type=="single"){
      print(selectedList.length);
      if(selectedList.length==1){
        if(selectedList.contains(name)){
          print("kpfnd;l");
          selectedList.clear();
        }
       else{
          selectedList.clear();
          selectedList.add(name!);
        }


        notifyListeners();
      }
      else{
        if(selectedList.contains(name)){
          print("kpfnd;l");
          selectedList.clear();
        }
        else{
          selectedList.clear();
          selectedList.add(name!);
        }

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
}
