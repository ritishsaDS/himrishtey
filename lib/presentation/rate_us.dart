import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

import '../controller/rating_controller.dart';

class LikeAndDislikeScreen extends StatefulWidget {

  const  LikeAndDislikeScreen({Key? key,}) : super(key: key);

  @override
  State<LikeAndDislikeScreen> createState() => _LikeAndDislikeScreenState();
}

class _LikeAndDislikeScreenState extends State<LikeAndDislikeScreen> {
  TextEditingController textController = TextEditingController();
  double rating = 0;
  ratingUpdate() {
    if (rating == 0) {
      return "please rate us";
    } else if (rating == 1) {
      return "week";
    } else if (rating == 2) {
      return "poor";
    } else if (rating == 3) {
      return "average";
    } else if (rating == 4) {
      return "good";
    } else if (rating == 5) {
      return "excellent";
    }
  }

  Future<void>?postApi(
      {String? id,
        String? name,
        String? email,
        double? rating,
        String? description})async{
    var url=("https://webtechworlds.com/himrishtey/apis/profile/rating_us");

    var mapData = {
      "profile_id" : "HIM10020",
      "name": "Rajesh Choudhary",
      "email": "choudharyrajesh@gmail.com",
      "rating": "3.0",
      "description": "uvygjdwhsd"
    };
    print( json.encode(mapData));
    var response = await Dio().post((url),data: FormData.fromMap(
        mapData
    ));
    print(response.data);
    print("data==>${response.data}");
    if(response.statusCode == 200){

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rate'),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            // Consumer<RatingController>(builder: (context,model,child){
            //   return Text(model.rating.toString());
            // },),
            // Consumer<RatingController>(builder: (context,model,child){
            //   return Text(model.ratingUpdate().toString());
            // },),
            // Consumer<RatingController>(builder: (context, model, child) {
            //   return Text(
            //     model.textController.text,
            //   );
            // }),
            Center(
              child: Consumer<RatingController>(builder: (context,model,child){
                return ElevatedButton(
                    onPressed: () {

                      //model.textController.clear();
                     // showAlertDialog();
                    },
                    child: const Text('Press for rating'));
              },),
            )
          ],
        ),
      ),
    );
  }


}
