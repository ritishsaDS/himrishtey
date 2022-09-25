import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rishtey/controller/get_profile_controller.dart';
import 'package:rishtey/presentation/edit_screens/basic_detail.dart';
import 'package:rishtey/presentation/edit_screens/contact_details.dart';
import 'package:rishtey/presentation/edit_screens/educationaldetails.dart';
import 'package:rishtey/presentation/edit_screens/educstion_detail_third.dart';
import 'package:rishtey/presentation/edit_screens/relation_detail_fourth.dart';
import 'package:rishtey/presentation/profile/personal_profile.dart';
import 'package:rishtey/utils/app_config.dart';

import '../../edit_screens/familyDetails.dart';
import '../../edit_screens/kundli_astro.dart';
import '../../edit_screens/lifestyleDetails.dart';
import '../../edit_screens/user_gallery/gallery.dart';

class FormAttributes extends StatelessWidget{
  final String?name;
  final String?photo;
  final String?desc;
  const FormAttributes({Key? key,this.name,this.photo,this.desc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
GetProfileController?getProfileController;
getProfileController=Provider.of<GetProfileController>(context,listen: false);
    return GestureDetector(
      onTap: (){
        if(name=="Basic Info"){
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => BasicDetails()));
        }
        else if(name=="Kundli & Astro"){
          Map<String, dynamic> data = {
            "birth_date_time": getProfileController?.getProfileModel?.data?.user?.birthDateTime,
            "birth_place": getProfileController?.getProfileModel?.data?.user?.birthPlace,
            "horoscope_needed": "${getProfileController?.getProfileModel?.data?.user?.horoscopeNeeded}",
            "manglik": getProfileController?.getProfileModel?.data?.user?.manglik,
            "birth_date_time": getProfileController?.getProfileModel?.data?.user?.birthDateTime
          };
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => EditDetails(
                    data: data,
                    title: "Kundli & Astro",
                  )));
        }
        else if(name=="Contact Details and ads"){
          Map<String,dynamic> data={
            "mobile_number":getProfileController?.getProfileModel?.data?.user?.mobileNumber.toString(),
            "alternate_number":"${getProfileController?.getProfileModel?.data?.user?.alternateNumber.toString()}",
            "email": getProfileController?.getProfileModel?.data?.user?.email.toString(),
            "whatsapp_number":getProfileController?.getProfileModel?.data?.user?.whatsappNumber.toString()};
          Navigator.push(context, MaterialPageRoute(builder: (context)=>ContactDetails(data:data ,title: "Contact Details",)));

        }
        else if(name=="Religion & Background"){
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => RelationDetailsForth()));
        }
        else if(name=="Education Details"){
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => EducationDetails()));
        }
        else if(name=="Career"){
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => EducationDetailsThird()));
        }
        else if(name=="Family Details"){
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => FamilyDetails()));
        }
        else if(name=="Lifestyle"){
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => LifestyleDetails()));
        }
        else if(name=="Gallery"){
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Gallery()));
        }
        else if(name=="Partner Prefrences"){
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => PersonalProfile(tab:1)));
        }
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        width: AppConfig.width*0.6,
        padding: EdgeInsets.only(bottom: 9,left: 7),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0),color: Colors.white,border: Border.all(color: AppConfig.theme.primaryColor)),
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,

          children: [
            Container(width: 50,height: 10,color: AppConfig.theme.primaryColor.withOpacity(0.2),),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
         CircleAvatar(
           backgroundColor: Colors.white,
           radius: 20,
           backgroundImage: AssetImage(photo!),),
          //Container(width: 20,height: 20,color: Colors.green.withOpacity(0.2),)
        ],),
          Text("$name",style: Theme.of(context).textTheme.headline6!.copyWith(fontSize: 14),),
          Text("$desc",textAlign:TextAlign.center,style: Theme.of(context).textTheme.bodyText1,),
      ],) ,),
    );
  }
}