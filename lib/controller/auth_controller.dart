import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rishtey/http/interceptors.dart';
import 'package:rishtey/models/castes_model.dart';
import 'package:rishtey/models/country_model.dart';
import 'package:rishtey/models/mother_tongue_model.dart';
import 'package:rishtey/models/religion_model.dart';
import 'package:rishtey/presentation/login/login_2.dart';
import 'package:rishtey/presentation/profile/delete_account_reason.dart';
import 'package:rishtey/utils/app_snack_bar.dart';
import 'package:rishtey/utils/shared_pref.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/AnnualIncomeModel.dart';
import '../models/EducationModel.dart';
import '../models/EmployerModel.dart';
import '../models/OccupationModel.dart';
import '../models/city_model.dart';
import '../models/create_profile_for_model.dart';
import '../models/family_status.dart';
import '../models/height_model.dart';
import '../models/login_model.dart';
import '../models/marital_status_model.dart';
import '../models/states_model.dart';
import '../presentation/bottom_navigation_bar.dart';
import '../presentation/dashboard/hide_file_lottie.dart';
import '../utils/endpoints.dart';
import '../utils/firebase/firebase_auth.dart';
import '../utils/firebase/firebase_chats.dart';

class AuthController extends ChangeNotifier {
  bool isLoading = false;
  LoginModel? loginModel;
  double loginWidth = 350;
 // AuthService authService =  AuthService();
 // DatabaseMethods databaseMethods =  DatabaseMethods();
  TextEditingController timeinput = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController fullName = TextEditingController();
  TextEditingController dateinput = TextEditingController();
  TextEditingController countryName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController occupation = TextEditingController();
  TextEditingController height = TextEditingController();
  TextEditingController cityLiving = TextEditingController();
  String? cityId;
  familyStatus?familystatus;
  TextEditingController annualIncome = TextEditingController();
  TextEditingController birthPlace = TextEditingController();
  TextEditingController birthTime = TextEditingController();
  TextEditingController employed = TextEditingController();
  TextEditingController religion = TextEditingController();
  TextEditingController maritalStatus = TextEditingController();
  TextEditingController motherTongue = TextEditingController();
  TextEditingController numberOfChild = TextEditingController();
  TextEditingController castes = TextEditingController();
  TextEditingController educationController = TextEditingController();
  TextEditingController annualIcomController = TextEditingController();
  TextEditingController occupationController = TextEditingController();
  TextEditingController employeeTypeController = TextEditingController();
  String dropdownValue = 'Yes';
  String numberChild = '1';
  String haveChild = 'No';
  String isManglik = 'Yes';
  CreateProfileForModel? createProfileForModel;
  bool select = false;
  int selectIndex = 11;
  String genderValue = 'Male';
  CountryModel? countryModel;
  StatesModel? statesModel;
  int? countryId;
  var stateId;
  CityModel? cityModel;
  EmployerModel? employerModel;
  AnnualIncomeModel? annualIncomeModel;
  EducationModel? educationModel;
  OccupationModel? occupationModel;
  MaritalStatusModel? maritalStatusModel;
  ReligionModel? religionModel;
  MotherTongueModel? motherTongueModel;
  HeightModel? heightModel;
  CastesModel? castesModel;
  signup(context, endPoint) async {
    isLoading = true;
    Map<String, dynamic> data = {};
    notifyListeners();
    var token="";
    FirebaseMessaging.instance.getToken().then((String? fcm) {

      token=fcm!;
    });
    data = {
      // "fullname": fullName.text,
      // "gender": "Male",
      // "marital_status": email.text,
      // "email": email.text,
      // "password": password.text,
      // "phone_number": phoneNumber.text,
      // "employed_in": employed.text,
      // "occupation": occupation.text,
      // "designation": "annualIncome",
      // "annual_income": annualIncome.text,
      // "date_of_birth": dateinput.text,
      // "time_of_birth": timeinput.text,
      // "birth_place": birthPlace.text,
      // "height": height.text,
      // "city_living_in": cityLiving.text,
      "full_name": fullName.text,
      "profile_created_for": createProfileForModel?.user?[selectIndex].title,
      "email": email.text,
      "phone_number": phoneNumber.text,
      "password": password.text,
      "profile_completed": 15,
      "username": username.text,
      //"gender": "Male",
      "date_of_birth": dateinput.text,
      "time_of_birth": timeinput.text,
      "height": height.text,
      "gender": genderValue.toString(),
      "country": countryName.text,
      "state": birthPlace.text,
      "city": cityLiving.text,
"google_token":token,
      "google_id":email.text,
      "profile_completed": 15
    };

    print(data);
    try {
      Response res = await HttpService().postRequest(
          endPoint: endPoint, data: FormData.fromMap(data), context: context);
      print("res.data");

      print(res.data['user']);
      isLoading = false;
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.remove("user_id");
      SharedPref()
          .setString(key: "user_id", value: res.data['user'].toString());
      notifyListeners();
      //firebaseSignUp();
      return res;
    } catch (e) {
      print("jndsdxl$e");
      isLoading = false;
      loginWidth = 350;

      notifyListeners();
    }
  }

  Future<Response> signup2(context, endPoint) async {
    isLoading = true;
    String? userId;

    userId = await SharedPref().getString(key: "user_id");
    notifyListeners();
    Map<String, dynamic> data = {
      "full_name": fullName.text,
      "profile_created_for":createProfileForModel!.user!.elementAt(selectIndex).title!,
      "email": email.text,
      "phone_number": phoneNumber.text,
      "password": password.text,
      "profile_completed": 15,
      "username": username.text,
      "gender": genderValue.toString(),
      "date_of_birth": dateinput.text,
      "time_of_birth": birthTime.text,
      "height": height.text,
      "country": countryName.text,
      "state": birthPlace.text,
      "city": cityLiving.text,
      "user_id": userId,
      "profile_completed": 30
    };

    Response res = await HttpService().postRequest(
        endPoint: endPoint, data: FormData.fromMap(data), context: context);

    isLoading = false;
    notifyListeners();
    return res;
  }
Future<bool>hideProfile(context,days)async{
    
    try{
      String? userId;

      userId = await SharedPref().getString(key: "user_id");

      notifyListeners();
      var data={
        "user_id":userId,
        "days":days
      };
      Response res=await HttpService().postRequest(endPoint: "profile/hide_profile",context: context,data:FormData.fromMap(data) );
   if(res.statusCode==200){
     appSnackBar(context: context,content: "App Hides for $days Days . Please Contact with us for any queries");
     Navigator.push(context, MaterialPageRoute(builder: (context)=>LottieScreen(days:days)));
     return true;
   }
   else{
     return false;
   }
    }catch(e){
      print(e);
      return false;
    }
}
  Future<Response> signup4(context, endPoint) async {
    isLoading = true;
    Map<String, dynamic> data = {};
    String? userId;

    userId = await SharedPref().getString(key: "user_id");

    notifyListeners();
    data = {
      // "fullname": fullName.text,
      // "gender": "Male",
      // "marital_status": email.text,
      // "email": email.text,
      // "password": password.text,
      // "phone_number": phoneNumber.text,
      // "employed_in": employed.text,
      // "occupation": occupation.text,
      // "designation": "annualIncome",
      // "annual_income": annualIncome.text,
      // "date_of_birth": dateinput.text,
      // "time_of_birth": timeinput.text,
      // "birth_place": birthPlace.text,
      // "height": height.text,
      // "city_living_in": cityLiving.text,
      "cast": castes.text,
      "mother_tongue": motherTongue.text,
      "marital_status": maritalStatus.text,
      "no_of_child": numberChild,
      "religion": religion.text,
      "is_manglik": isManglik,
      "horoscope_needed": dropdownValue,
      "user_id": userId,
      "profile_completed": 35
    };
    print(data);
    print(":jwojdklmcpid");

    Response res = await HttpService().postRequest(
        endPoint: endPoint, data: FormData.fromMap(data), context: context);
    print("res.data");

    print(res.data['user']);
    isLoading = false;
    notifyListeners();
    return res;
  }

  Future<Response> signup3(context, endPoint) async {
    isLoading = true;
    Map<String, dynamic> data = {};
    notifyListeners();
    String? userId;

    userId = await SharedPref().getString(key: "user_id");

    notifyListeners();
    data = {
      "education": educationController.text,
      "employed_in": employeeTypeController.text,
      "occupation": occupationController.text,
      "annual_income": annualIcomController.text,
      "user_id": userId,
      "profile_completed": 25
    };

    Response res = await HttpService().postRequest(
        endPoint: endPoint, data: FormData.fromMap(data), context: context);

    isLoading = false;

    notifyListeners();
    return res;
  }
  Future<bool> resetPass(context, password) async{
    try{
      isLoading = true;
      notifyListeners();
      var user_id = await SharedPref().getString(key: "user_id");
      var data = {

        "user_id": user_id,
        "password":password
      };

      print(data);
      Response response = await HttpService().postRequest(
          endPoint: "user/reset_password", context: context, data: FormData.fromMap(data));

      if(response.statusCode==200){
        print(response.data);




        appSnackBar(content: "Password Changed Successfully", context: context);
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
  Future<bool> updatePass(context, password,otp) async{
    try{
      isLoading = true;
      notifyListeners();
      var user_id = await SharedPref().getString(key: "user_id");
      var data = {

        "otp": otp,
        "password":password
      };

      print(data);
      Response response = await HttpService().postRequest(
          endPoint: "user/update_password", context: context, data: FormData.fromMap(data));

      if(response.statusCode==200){
        print(response.data);




        appSnackBar(content: "Password Changed Successfully", context: context);
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

  Future<bool> login(context, username, password) async {
    try{
      isLoading = true;
      notifyListeners();
      var data = {"username": username, "password": password};
      print(data);
      Response response = await HttpService().postRequest(
          endPoint: "user/login", context: context, data: FormData.fromMap(data));

      if(response.statusCode==200){
        print(response.data);


        loginModel = LoginModel.fromJson(response.data);
       // firebaseLogin(context,username,password);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => MyHomePage()));
        SharedPref().setString(
            key: "user_id", value: loginModel!.user!.id.toString());
        appSnackBar(content: "Login Successfully", context: context);
        isLoading = false;
        notifyListeners();

        return true;
      }
      else{  print("fdv f");
        isLoading = false;
        notifyListeners();
        return false;
      }
   }
     catch(e){
       isLoading = false;
       print("fdv f$e");
       notifyListeners();
       return false;
     }
  }
  Future<bool> getOtp(context, username, password) async {
    try{
      isLoading = true;
      notifyListeners();
      var data = {"mobile_number": username};
      print(data);
      Response response = await HttpService().postRequest(
          endPoint: "user/otp_login", context: context, data: FormData.fromMap(data));

      if(response.statusCode==200){
        print(response.data);


       // loginModel = LoginModel.fromJson(response.data);
        //firebaseLogin(context,username,password);
        // Navigator.pushReplacement(
        //     context, MaterialPageRoute(builder: (context) => MyHomePage()));
        // SharedPref().setString(
        //     key: "user_id", value: loginModel!.user!.id.toString());
        appSnackBar(content: "Otp sent Successfully", context: context);
        isLoading = false;
        notifyListeners();

        return true;
      }
      else{  print("fdv f");
      isLoading = false;
      notifyListeners();
      return false;
      }
    }
    catch(e){
      isLoading = false;
      print("fdv f$e");
      notifyListeners();
      return false;
    }
  }
  Future<bool> verifyProfileOtp(context, username, password) async {
    try{
      isLoading = true;
      notifyListeners();
      var data = {"mobile_number": username};
      print(data);
      Response response = await HttpService().postRequest(
          endPoint: "user/verify_mobile_otp", context: context, data: FormData.fromMap(data));

      if(response.statusCode==200){
        print(response.data);


        // loginModel = LoginModel.fromJson(response.data);
        //firebaseLogin(context,username,password);
        // Navigator.pushReplacement(
        //     context, MaterialPageRoute(builder: (context) => MyHomePage()));
        // SharedPref().setString(
        //     key: "user_id", value: loginModel!.user!.id.toString());
        appSnackBar(content: "Otp sent Successfully", context: context);
        isLoading = false;
        notifyListeners();

        return true;
      }
      else{  print("fdv f");
      isLoading = false;
      notifyListeners();
      return false;
      }
    }
    catch(e){
      isLoading = false;
      print("fdv f$e");
      notifyListeners();
      return false;
    }
  }
  Future<bool> verifyOtp(context, OTP) async {
    try{
      isLoading = true;
      notifyListeners();
      var data = {"otp": OTP};
      print(data);
      Response response = await HttpService().postRequest(
          endPoint: "user/get_user_data_from_otp", context: context, data: FormData.fromMap(data));

      if(response.statusCode==200){
        print(response.data);


         loginModel = LoginModel.fromJson(response.data);
        //firebaseLogin(context,username,password);
         Navigator.pushReplacement(
             context, MaterialPageRoute(builder: (context) => MyHomePage()));
         SharedPref().setString(
             key: "user_id", value: loginModel!.user!.id.toString());
        appSnackBar(content: "Login Successfully", context: context);
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
      print("fdv f$e");
      notifyListeners();
      return false;
    }
  }
  Future<bool> verifyProfile(context, OTP) async {
    try{
      isLoading = true;
      notifyListeners();
      var data = {"otp": OTP};
      print(data);
      Response response = await HttpService().postRequest(
          endPoint: "user/verify_mobile", context: context, data: FormData.fromMap(data));

      if(response.statusCode==200){
        print(response.data);


       // loginModel = LoginModel.fromJson(response.data);
        //firebaseLogin(context,username,password);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => MyHomePage()));
        // SharedPref().setString(
        //     key: "user_id", value: loginModel!.user!.id.toString());
        appSnackBar(content: "Verified Successfully", context: context);
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
      print("fdv f$e");
      notifyListeners();
      return false;
    }
  }
  Future<CreateProfileForModel> createProfileFor(context) async {
    isLoading = true;
    notifyListeners();
    Response response = await HttpService().getRequest(
      endPoint: "user/profile_created_for",
      context: context,
    );

    isLoading = false;

    createProfileForModel = CreateProfileForModel.fromJson(response.data);
    notifyListeners();
    return createProfileForModel!;
  }

  selectValue(index) {
    selectIndex = index;
    select = true;
    notifyListeners();
  }

  Future<CountryModel> getCountries(context) async {
    Response response = await HttpService().getRequest(
      endPoint: "user/countries",
      context: context,
    );

    countryModel = CountryModel.fromJson(response.data);
    getHeights(context);
    notifyListeners();
    return countryModel!;
  }

  Future<StatesModel> getStates(context) async {
    Map<String, dynamic> data = {"country_id": countryId ?? 1};
    print(data);
    Response response = await HttpService().postRequest(
        endPoint: "user/states",
        context: context,
        data: FormData.fromMap(data));

    statesModel = StatesModel.fromJson(response.data);
    // getCities(context);
    notifyListeners();
    return statesModel!;
  }

  Future<HeightModel> getHeights(context) async {
    Response response = await HttpService()
        .getRequest(endPoint: "user/heights", context: context);

    isLoading = false;

    heightModel = HeightModel.fromJson(response.data);
    notifyListeners();
    return heightModel!;
  }

  Future<MotherTongueModel> getMotherTongue(context) async {
    Response response = await HttpService()
        .getRequest(endPoint: "user/mother_tongues", context: context);

    isLoading = false;

    motherTongueModel = MotherTongueModel.fromJson(response.data);
    getCastes(context);
    notifyListeners();
    return motherTongueModel!;
  }

  Future<MaritalStatusModel> getMaritalStatus(context) async {
    Response response = await HttpService()
        .getRequest(endPoint: "user/marital_status", context: context);

    isLoading = false;

    maritalStatusModel = MaritalStatusModel.fromJson(response.data);
    notifyListeners();
    getMotherTongue(context);
    return maritalStatusModel!;
  }

  Future<ReligionModel> getReligion(context) async {
    Response response = await HttpService()
        .getRequest(endPoint: "user/religions", context: context);

    isLoading = false;

    religionModel = ReligionModel.fromJson(response.data);
    getMaritalStatus(context);
    notifyListeners();
    return religionModel!;
  }

  Future<CastesModel> getCastes(context) async {
    Response response = await HttpService()
        .getRequest(endPoint: "user/casts", context: context);

    isLoading = false;

    castesModel = CastesModel.fromJson(response.data);

    notifyListeners();
    return castesModel!;
  }

  Future<EmployerModel> getEmployeType(context) async {
    Response response = await HttpService()
        .getRequest(endPoint: "user/employer", context: context);

    isLoading = false;

    employerModel = EmployerModel.fromJson(response.data);
    notifyListeners();
    return employerModel!;
  }

  Future<AnnualIncomeModel> getAnnualIncomeType(context) async {
    Response response = await HttpService()
        .getRequest(endPoint: "user/annual_incomes", context: context);

    isLoading = false;

    annualIncomeModel = AnnualIncomeModel.fromJson(response.data);
    notifyListeners();
    return annualIncomeModel!;
  }

  Future<EducationModel> getEducationType(context) async {
    Response response = await HttpService()
        .getRequest(endPoint: "user/educations", context: context);

    isLoading = false;

    educationModel = EducationModel.fromJson(response.data);
    notifyListeners();
    return educationModel!;
  }

  Future<OccupationModel> getOccupationType(context) async {
    Response response = await HttpService()
        .getRequest(endPoint: "user/occupations", context: context);

    isLoading = false;

    occupationModel = OccupationModel.fromJson(response.data);
    notifyListeners();
    return occupationModel!;
  }
  Future<familyStatus> getFamilyStatus(context) async {
    Response response = await HttpService()
        .getRequest(endPoint: "user/family_status", context: context);

    isLoading = false;

    familystatus = familyStatus.fromJson(response.data);
    notifyListeners();
    return familystatus!;
  }
  Future<CityModel> getCities(context) async {
    var data = {"state_id": stateId??1};

    Response response = await HttpService().postRequest(
        endPoint: "user/cities",
        context: context,
        data: FormData.fromMap(data));

    isLoading = false;

    cityModel = CityModel.fromJson(response.data);
    notifyListeners();
    return cityModel!;
  }

  Future<Response> addOccupation(context) async {
    var data = {"occ_name": occupationController.text};
    print("=============$data");
    Response response = await HttpService().postRequest(
        endPoint: "user/add_occupation",
        context: context,
        data: FormData.fromMap(data));

    isLoading = false;

    return response;
  }

  Future<Response> addCities(context) async {
    var data = {"city_name": cityLiving.text, "state_id": stateId};
    print("=============$data");
    Response response = await HttpService().postRequest(
        endPoint: "user/add_city",
        context: context,
        data: FormData.fromMap(data));

    isLoading = false;

    return response;
  }

  Future<bool> deleteProfile(context) async {
    isLoading = true;
    notifyListeners();
    var userId = await SharedPref().getString(key: "user_id");
    var data = {"user_id": userId, "reason": reason};

    try {
      Response response = await HttpService().postRequest(
          endPoint: Endpoints.deleteProfile,
          context: context,
          data: FormData.fromMap(data));
      print(response.data);
      print(data);
      if (response.statusCode == 200) {
        isLoading = false;

        appSnackBar(content: "Your Account Deleted", context: context);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.clear();
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginPage2()));
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
  Future<bool> reportProfile(context,profileId) async {
    isLoading = true;
    notifyListeners();
    var userId = await SharedPref().getString(key: "user_id");
    var data = {"user_id": userId, "reason": reason,"profile_id":profileId};

    try {
      Response response = await HttpService().postRequest(
          endPoint: Endpoints.deleteProfile,
          context: context,
          data: FormData.fromMap(data));
      print(response.data);
      print(data);
      if (response.statusCode == 200) {
        isLoading = false;

        appSnackBar(content: "Account Reported our team has been look into it", context: context);

        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => MyHomePage()));
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
//   firebaseSignUp() async {
//     await authService.signUpWithEmailAndPassword(
//         email.text,
//         password.text).then((result){
//       if(result != null){
//
//         Map<String,String> userDataMap = {
//           "userName" : fullName.text,
//           "userEmail" : email.text
//         };
//
//        // databaseMethods.addUserInfo(userDataMap);
//
//   }
// });
//         }
//   firebaseLogin(context,username,pass) async {
//     print("knreknlkn}");
//     await authService.signInWithEmailAndPassword(
//         username,
//         pass).then((result){
// print("knreknlkn${result}");
//       // if(result != null){
//       //
//       //  SharedPref().setString(key: "firebaseId",value: result.)
//       //
//       // }
//     });
//   }
  Future<bool>postPhoneNumberApi({String?mobile,BuildContext ?context})async{
    var url=("https://webtechworlds.com/himrishtey/apis/user/forget_password");
isLoading=true;
notifyListeners();
    var mapData = {
      "mobile_number":mobile,
    };
try{
    var response = await HttpService().postRequest(
        endPoint: "/user/forget_password",
        context: context,
        data: FormData.fromMap(
        mapData
    ));
    print(response.statusMessage);
    print("data==>${response.data}");
    if(response.statusCode == 200){
      isLoading=false;
      notifyListeners();
      return true;
    }
    else {
      isLoading=false;
      notifyListeners();
      return false;

    }
  }catch(e){
  isLoading=false;
  notifyListeners();
  return false;
}}

}