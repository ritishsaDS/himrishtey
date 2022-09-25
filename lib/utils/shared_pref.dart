import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  setString({String ?key,String ?value})async{
    SharedPreferences prefs =await SharedPreferences.getInstance();
    prefs.setString(key!, value!);
  }
  setStringList({String ?key,List<String> ?value})async{
    SharedPreferences prefs =await SharedPreferences.getInstance();
    prefs.setStringList(key!, value!);
  }
  Future<String?>getString({String ?key})async{
    SharedPreferences prefs =await SharedPreferences.getInstance();

    return prefs.getString(key!);
  }
}