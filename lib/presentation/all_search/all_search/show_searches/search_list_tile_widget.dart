import 'package:flutter/material.dart';
import 'package:rishtey/utils/app_config.dart';

import '../../../../models/searched_profiles.dart';
import '../../../other_profile_view/others_profile_view.dart';


class SearchList extends StatelessWidget {
  User data;

  SearchList({Key? key,required this.data}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>OtherProfileView(id: (data.profileId),getId:int.parse(data.id??""))));

      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5),
        width: MediaQuery.of(context).size.width,
        child: Card(

          shadowColor: Colors.grey,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0)),
          elevation: 4,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              !data.photo!.contains("member-photo")?ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    data.photo!.toString().replaceAll("file:///",""),
                    fit: BoxFit.fitHeight,
                    height:  MediaQuery.of(context).size.height * 0.12,
                    width: MediaQuery.of(context).size.height * 0.15,
                  )): ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  "https://webtechworlds.com/himrishtey/photos/photo/"+data.photo!.toString().replaceAll("file:///","")??"",
                  fit: BoxFit.fitHeight,
                  height:  MediaQuery.of(context).size.height * 0.12,
                  width: MediaQuery.of(context).size.height * 0.15,
                ),
              ),
              const SizedBox(width: 30,),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${data.profileId}",
                    style: const TextStyle(fontSize: 14,fontWeight: FontWeight.w800 ),
                  ),
                  Text(
                    "Height - ${data.height}",
                    style: const TextStyle(fontSize: 14, ),
                  ),
                  SizedBox(

                    width: AppConfig.width*0.43,
                    child: Text(
                      "${data.religion}: ${data.cast}",maxLines: 1,
                      style: const TextStyle(fontSize: 14, ),
                    ),
                  ),
                  SizedBox(

                    width: AppConfig.width*0.43,
                    child: Text(
                      "${data.motherTongue}",maxLines: 2,
                      style: const TextStyle(fontSize: 14, ),
                    ),
                  ),
                  Text(
                    data.education.toString(),
                  ),
                  GestureDetector(
                    child: const Text(
                      "Send Interest",
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800,color: Colors.pinkAccent),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 20,),
            ],
          ),
        ),
      ),
    );
  }
}
