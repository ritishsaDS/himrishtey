import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rishtey/models/dashboard_profile_model.dart';
import 'package:rishtey/presentation/profile/about_me_profile.dart';
import 'package:rishtey/utils/app_config.dart';

import '../../../controller/dashboard_controller.dart';
import '../../other_profile_view/others_profile_view.dart';

class InterestProfile extends StatelessWidget {
  User data;
int ?index;
  InterestProfile({Key? key,required this.data,this.index}) : super(key: key);
  @override
  Widget build(BuildContext context) {
   //  var date; if(data.birthDateTime.toString().length>10){
   //    date = calculateAge(DateTime.parse(DateFormat("yyyy-MM-dd").format(DateTime.parse(data.birthDateTime.toString().split("")[0]))));
   //
   // }
    var age=0;

    var newDate=DateFormat("yyyy-MM-dd").format(DateTime.parse(data.birthDateTime.toString().substring(0,10)));
    age=calculateAge(DateTime.parse(newDate));
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>OtherProfileView(id: (data.profileId),getId:int.parse(data.id??""))));
      },
      child: SizedBox(
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
              const SizedBox(width: 2,),
             !data.photo!.contains("member-photo")?ClipRRect(
                 borderRadius: BorderRadius.circular(8.0),
                 child: Image.network(
                   data.photo!.toString().replaceAll("file:///",""),
                   fit: BoxFit.fitHeight,
                   height:  MediaQuery.of(context).size.height * 0.12,
                   width: MediaQuery.of(context).size.height * 0.12,
                 )): ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  "https://webtechworlds.com/himrishtey/photos/photo/"+data.photo!.toString().replaceAll("file:///",""),
                  fit: BoxFit.fitHeight,
                  height:  MediaQuery.of(context).size.height * 0.16,
                  width: MediaQuery.of(context).size.height * 0.12,
                ),
              ),
              const SizedBox(width: 10,),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: AppConfig.width*0.46,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          data.profileId??"",
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
                        ),
SizedBox(width: AppConfig.width*0.04,),
                        Container(
                            alignment: Alignment.topRight,
                            child: Image.network(data.member_type??"",width: AppConfig.width*0.1,)),

                      ],
                    ),
                  ),
                  Text(
                    "$age | ${data.height??""}",
                    style: const TextStyle(fontSize: 14, ),
                  ),
                  SizedBox(

                    width: AppConfig.width*0.43,
                    child: Text(
                      "${data.religion??""}|| ${data.cast??""}",maxLines: 1,
                      style: const TextStyle(fontSize: 14, ),
                    ),
                  ),
                  SizedBox(

                    width: AppConfig.width*0.43,
                    child: Text(
                      "${data.motherTongue??""}-${data.birthPlace??""}",maxLines: 2,
                      style: const TextStyle(fontSize: 14, ),
                    ),
                  ),
                  Text(
                    data.annualIncome??"",
                  ),
                  Consumer<DashBoardController>(
                      builder: (context,controller,child) {
                        return controller.interestLoading&&data.id==controller.profileId?CircularProgressIndicator():InkWell(

                          onTap: () async {
                            if(data.interest=="No"){
                             bool res=await controller.sendInterest(context,data.id);
                             if(res==true){
                               controller.changeSendInterest(data: data,index: index);
                             }
                            }

                          },
                          child:  Text(
                          data.interest=="Yes"?"Pending":  "Send Interest",
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800,color: Colors.pinkAccent),
                          ),
                        );
                      }
                  ),
                ],
              ),

             // const SizedBox(width: 10,),
            ],
          ),
        ),
      ),
    );
  }
}


class MatchInterestProfile extends StatelessWidget {
  User data;

  MatchInterestProfile({Key? key,required this.data}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>OtherProfileView(id: (data.profileId),getId:int.parse(data.id??""))));
      },
      child: SizedBox(
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
              const SizedBox(width: 10,),
              // ClipRRect(
              //   borderRadius: BorderRadius.circular(8.0),
              //   child: Image.network(
              //     "https://webtechworlds.com/himrishtey/photos/photo/"+data.photo!.toString().replaceAll("file:///","")??"",
              //     fit: BoxFit.fitHeight,
              //     height:  MediaQuery.of(context).size.height * 0.12,
              //     width: MediaQuery.of(context).size.height * 0.15,
              //   ),
              // ),
              const SizedBox(width: 30,),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.profileId??"",
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
                  ),
                  Text(
                    "${data.partnerAgeFrom} | ${data.height}",
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
                      "${data.motherTongue}-${data.birthPlace}",maxLines: 2,
                      style: const TextStyle(fontSize: 14, ),
                    ),
                  ),
                  Text(
                    data.annualIncome??"",
                  ),
                  Consumer<DashBoardController>(
                      builder: (context,controller,child) {
                        return InkWell(

                          onTap: (){
                            if(data.interest=="No"){
                              controller.sendInterest(context,data.id);
                            }

                          },
                          child:  Text(
                            data.interest=="Yes"?"Pending":  "Send Interest",
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800,color: Colors.pinkAccent),
                          ),
                        );
                      }
                  ),
                ],
              ),
// Image.network(src),

              const SizedBox(width: 20,),
            ],
          ),
        ),
      ),
    );
  }
}