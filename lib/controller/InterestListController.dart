import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../http/interceptors.dart';
import '../models/interest_model.dart';
import '../utils/endpoints.dart';
import '../utils/shared_pref.dart';

class InterestListController extends ChangeNotifier {
  bool isLoading = false;
  InterestListModel? interestListModel;

  Future<dynamic> sentInvitationList(context) async {
    isLoading = true;
    notifyListeners();
    var userId = await SharedPref().getString(key: "user_id");
    var data = FormData.fromMap({
      "user_id": userId,
    });
    try {
      Response response = await HttpService().postRequest(
          endPoint:"profile/sent_interest_list", context: context, data: data);

      print("response.statusCode");
      print(response.statusCode);
      if (response.statusCode == 200) {
        isLoading = false;

        interestListModel = InterestListModel.fromJson(response.data);
        print("fdfdfdfdfd");

        notifyListeners();
        return interestListModel!;
      } else {
        print("response.data");
        print(response.data);
        interestListModel = InterestListModel();
        interestListModel!.user = [];
        isLoading = false;
        notifyListeners();
        return response.data;
      }
    } catch (e) {
      print("e.toString()");
      print(e.toString());
      interestListModel = InterestListModel();
      interestListModel!.user = [];
      isLoading = false;
      notifyListeners();
    }
  }

  Future<dynamic> recievedInvitationList(context) async {
    isLoading = true;
    notifyListeners();
    var userId = await SharedPref().getString(key: "user_id");
    var data = FormData.fromMap({
      "user_id": userId,
    });

    try {
      Response response = await HttpService().postRequest(
          endPoint:
              "profile/received_interest",
          context: context,
          data: data);

      print("response.statusCode");
      print(response.statusCode);
      if (response.statusCode == 200) {
        isLoading = false;

        interestListModel = InterestListModel.fromJson(response.data);
        print("fdfdfdfdfd");
        print(interestListModel!.user!.length);
        notifyListeners();
        return interestListModel!;
      } else {
        print("response.data");
        print(response.data);
        interestListModel = InterestListModel();
        interestListModel!.user = [];
        isLoading = false;
        notifyListeners();
        return response.data;
      }
    } catch (e) {
      print("e.toString()");
      print(e.toString());
      interestListModel = InterestListModel();
      interestListModel!.user = [];
      isLoading = false;
      notifyListeners();
    }
  }

  Future<dynamic> acceptedInvitationList(context) async {
    isLoading = true;
    notifyListeners();
    var userId = await SharedPref().getString(key: "user_id");
    var data = FormData.fromMap({
      "user_id": userId,
    });

    try {
      Response response = await HttpService().postRequest(
          endPoint:
              "profile/accepted_interests",
          context: context,
          data: data);

      print("response.statusCode");
      print(response.statusCode);
      if (response.statusCode == 200) {
        isLoading = false;

        interestListModel = InterestListModel.fromJson(response.data);
        print("fdfdfdfdfd");

        notifyListeners();
        return interestListModel!;
      } else {
        print("response.data");
        print(response.data);
        interestListModel = InterestListModel();
        interestListModel!.user = [];
        isLoading = false;
        notifyListeners();
        return response.data;
      }
    } catch (e) {
      print("e.toString()");
      print(e.toString());
      interestListModel = InterestListModel();
      interestListModel!.user = [];
      isLoading = false;
      notifyListeners();
    }
  }

  Future<dynamic> rejectedInvitationList(context) async {
    isLoading = true;
    notifyListeners();
    var userId = await SharedPref().getString(key: "user_id");
    var data = FormData.fromMap({
      "user_id": userId,
    });

    try {
      Response response = await HttpService().postRequest(
          endPoint:
              "profile/rejected_interests",
          context: context,
          data: data);

      print("response.statusCode");
      print(response.statusCode);
      if (response.statusCode == 200) {
        isLoading = false;

        interestListModel = InterestListModel.fromJson(response.data);
        print("fdfdfdfdfd");

        notifyListeners();
        return interestListModel!;
      } else {
        print("response.data");
        print(response.data);
        interestListModel = InterestListModel();
        interestListModel!.user = [];
        isLoading = false;
        notifyListeners();
        return response.data;
      }
    } catch (e) {
      print("e.toString()");
      print(e.toString());
      interestListModel = InterestListModel();
      interestListModel!.user = [];
      isLoading = false;
      notifyListeners();
    }
  }

  Future<dynamic> pendingInvitationList(context) async {
    isLoading = true;
    notifyListeners();
    var userId = await SharedPref().getString(key: "user_id");
    var data = FormData.fromMap({
      "user_id": userId,
    });

    try {
      Response response = await HttpService().postRequest(
          endPoint:
              "profile/received_interest",
          context: context,
          data: data);

      print("response.statusCode");
      print(response.statusCode);
      if (response.statusCode == 200) {
        isLoading = false;

        interestListModel = InterestListModel.fromJson(response.data);
        print("fdfdfdfdfd");

        notifyListeners();
        return interestListModel!;
      } else {
        print("response.data");
        print(response.data);
        interestListModel = InterestListModel();
        interestListModel!.user = [];
        isLoading = false;
        notifyListeners();
        return response.data;
      }
    } catch (e) {
      print("e.toString()");
      print(e.toString());
      interestListModel = InterestListModel();
      interestListModel!.user = [];
      isLoading = false;
      notifyListeners();
    }
  }
  Future<dynamic> rejectedmeInvitationList(context) async {
    isLoading = true;
    notifyListeners();
    var userId = await SharedPref().getString(key: "user_id");
    var data = FormData.fromMap({
      "user_id": userId,
    });

    try {
      Response response = await HttpService().postRequest(
          endPoint:
          "profile/rejected_sent_interest_list",
          context: context,
          data: data);

      print("response.statusCode");
      print(response.statusCode);
      if (response.statusCode == 200) {
        isLoading = false;

        interestListModel = InterestListModel.fromJson(response.data);
        print("fdfdfdfdfd");

        notifyListeners();
        return interestListModel!;
      } else {
        print("response.data");
        print(response.data);
        interestListModel = InterestListModel();
        interestListModel!.user = [];
        isLoading = false;
        notifyListeners();
        return response.data;
      }
    } catch (e) {
      print("e.toString()");
      print(e.toString());
      interestListModel = InterestListModel();
      interestListModel!.user = [];
      isLoading = false;
      notifyListeners();
    }
  }
  Future<bool> action(context,profileId,status,index) async {
    isLoading = true;
    notifyListeners();
    var userId = await SharedPref().getString(key: "user_id");
    var data = {
      "user_id": userId,
      "profile_id":int.parse(profileId.toString()),
      "status":status
    };
    print("response.statusCode$data");
//    try {
      Response response = await HttpService().postRequest(
          endPoint:
          "profile/interest_action",
          context: context,
          data: FormData.fromMap(data));

      print("response.statusCode");
      print(response.statusCode);
      if (response.statusCode == 200) {
        isLoading = false;

         interestListModel!.user!.removeAt(index);
        print("fdfdfdfdfd");

        notifyListeners();
        return true;
      } else {
        print("response.data");
        print(response.data);
        interestListModel = InterestListModel();
        interestListModel!.user = [];
        isLoading = false;
       // notifyListeners();
        return response.data;
      }
    // } catch (e) {
    //   print("e.toString()");
    //   print(e.toString());
    //   interestListModel = InterestListModel();
    //   interestListModel!.user = [];
    //   isLoading = false;
    //   notifyListeners();
    // }
  }
}
