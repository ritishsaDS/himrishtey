import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:rishtey/presentation/dashboard/hide_file_lottie.dart';

import '../http/interceptors.dart';
import '../presentation/bottom_navigation_bar.dart';
import '../utils/app_snack_bar.dart';
import '../utils/shared_pref.dart';
class RatingController  extends ChangeNotifier {
  int rating=0;
  String?comment;
  TextEditingController textController=TextEditingController();
  updateRatting({double?rating,BuildContext?context}){
    if(rating==1.0){
      comment="Bad";
    }
    else if(rating==2.0){
      comment="Don't Like";
    }
    else if(rating==3.0){
      comment="Average";
    }
    else if(rating==4.0){
      comment="Good";
      showCustomDialog(context!);
      notifyListeners();

    }
    else if(rating==5.0){
      comment="Excellent";showCustomDialog(context!);
      notifyListeners();
    }
    else{
      comment="Please Rate Us";
    }
    notifyListeners();
  }
  sendRatingToserver(context,email,name,profileId) async {
    try{
      //isLoading = true;
      //notifyListeners();
      var user_id = await SharedPref().getString(key: "user_id");
      var data = {

"profile_id":profileId,
    "name":name,
    "email":email,
        "rating":rating.toString(),
        "description":textController.text
      };

      print(data);
      Response response = await HttpService().postRequest(
          endPoint: "profile/rating_us", context: context, data: FormData.fromMap(data));

      if(response.statusCode==200){
        print(response.data);
Navigator.push(context, MaterialPageRoute(builder: (context)=>DoneLottieScreen(days: "Thanks for rating us, It would be \n valuable to us",)));



        appSnackBar(content: "Rating sent Successfully", context: context);

       // notifyListeners();

        return true;
      }
      else{

        notifyListeners();
        return false;
      }
    }
    catch(e){

      notifyListeners();
      return false;
    }
  }
}