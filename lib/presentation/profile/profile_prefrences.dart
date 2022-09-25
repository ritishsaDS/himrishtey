import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:rishtey/presentation/profile/partner_prefrences/basic_prefrences.dart';
import 'package:rishtey/presentation/profile/partner_prefrences/partner_education_prefrence.dart';
import 'package:rishtey/presentation/profile/partner_prefrences/partner_lifestyle.dart';
import 'package:rishtey/presentation/profile/partner_prefrences/partner_location_prefrence.dart';
import 'package:rishtey/presentation/profile/partner_prefrences/religion_prefrences.dart';
import 'package:rishtey/presentation/profile/widgets/info_tile.dart';
import 'package:rishtey/utils/app_config.dart';
import 'package:rishtey/utils/shared_pref.dart';

import '../../controller/update_controller.dart';
import '../../models/get_profile_model.dart';


class Prefrences extends StatefulWidget{
  User? userModel;
  Prefrences({Key? key, required this.userModel}) : super(key: key);


  @override
  State<Prefrences> createState() => _PrefrencesState();
}


class _PrefrencesState extends State<Prefrences> {
 TextEditingController aboutPartner=TextEditingController();
 UpdateController?updateController;
 //aboutPartner=TextEditingController(text: widget.userModel?.aboutMe);

  @override
  Widget build(BuildContext context) {
    updateController=Provider.of<UpdateController>(context,listen: false);
    //aboutPartner=TextEditingController(text:widget.userModel?.a)
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),border: Border.all(color: Colors.black)),
          child: ExpansionTile(title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Basic Info"),
              GestureDetector(
                onTap: () {
                   Navigator.push(
                       context,
                       MaterialPageRoute(
                           builder: (context) => BasicPrefrences()));
                },
                child: Container(
                  padding:
                  EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(color: Colors.grey)),
                  child: Text(
                    "Edit",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w800),
                  ),
                ),
              )
            ],
          ),
            children: [
              Container(

                child: Column(children: [
                  infoTile(name: "Age: ",data: widget.userModel!.partnerAgeFrom.toString()+"-"+widget.userModel!.partnerAgeTo.toString()??""),
                  infoTile(name: "Marital Status: ",data: widget.userModel!.lookingFor.toString()),
                  infoTile(name: "Height: ",data: widget.userModel!.partnerHeightFrom.toString()+"-"+widget.userModel!.partnerHeightTo.toString()),


                ],),
              )
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),border: Border.all(color: Colors.black)),
          child: ExpansionTile(title:Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Religion & Community"),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ReligionPrefrences()));
                },
                child: Container(
                  padding:
                  EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(color: Colors.grey)),
                  child: Text(
                    "Edit",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w800),
                  ),
                ),
              )
            ],
          ),
            children: [
              Container(

                child: Column(children: [
                  infoTile(name: "Religion: ",data: widget.userModel!.partnerReligion.toString()),
                  infoTile(name: "Mother Tongue: ",data: widget.userModel!.partnerMothertongue.toString()),
                  infoTile(name: "Community: ",data: widget.userModel!.partnerCast.toString()),
                  infoTile(name: "Manglik: ",data:  widget.userModel!.isPartnerManglik.toString()),

                ],),
              )
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),border: Border.all(color: Colors.black)),
          child: ExpansionTile(title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Partner Education & \nOccupation",),
              GestureDetector(
                onTap: () {
                   Navigator.push(
                       context,
                       MaterialPageRoute(
                           builder: (context) => PartnerPrefrence()));
                },
                child: Container(
                  padding:
                  EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(color: Colors.grey)),
                  child: Text(
                    "Edit",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w800),
                  ),
                ),
              )
            ],
          ),
            children: [
              Container(

                child: Column(children: [

                  infoTile(name: "Highest Education: ",data: widget.userModel!.partnerEducation.toString()),
                  infoTile(name: "Occupation: ",data: widget.userModel!.partnerOccupation.toString()),

                  infoTile(name: "Annual Income: ",data:widget.userModel!.partnerAnnualIncomeFrom.toString()+" - "+widget.userModel!.partnerAnnualIncomeTo.toString()),

                ],),
              )
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),border: Border.all(color: Colors.black)),
          child: ExpansionTile(title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Partner Location"),
              GestureDetector(
                onTap: () {
                   Navigator.push(
                       context,
                       MaterialPageRoute(
                           builder: (context) => PartnerLocation()));
                },
                child: Container(
                  padding:
                  EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(color: Colors.grey)),
                  child: Text(
                    "Edit",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w800),
                  ),
                ),
              )
            ],
          ),
            children: [
              Container(

                child: Column(children: [
                  infoTile(name: "Country: ",data: widget.userModel!.partnerCountry.toString()),
                  infoTile(name: "State: ",data: widget.userModel!.partnerState.toString()),
                  infoTile(name: "City: ",data: widget.userModel!.partnerCity.toString()),

                ],),
              )
            ],
          ),
        ),



        Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),border: Border.all(color: Colors.black)),
          child: ExpansionTile(title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Partner's LifeStyle & \nAppearances"),
              GestureDetector(
                onTap: () {
                   Navigator.push(
                       context,
                       MaterialPageRoute(
                           builder: (context) => PartnerLifestyle()));
                },
                child: Container(
                  padding:
                  EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(color: Colors.grey)),
                  child: Text(
                    "Edit",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w800),
                  ),
                ),
              )
            ],
          ),
            children: [
              Container(

                child: Column(children: [
                  infoTile(name: "Diet: ",data: widget.userModel!.partnerDiet.toString()),
                  infoTile(name: "Is Drinking: ",data:  widget.userModel!.isPartnerDrinking.toString()),
                  infoTile(name: "Is Smoking: ",data:  widget.userModel!.isPartnerSmoking.toString()),


                ],),
              )
            ],
          ),
        ),
        TextFormField(
          maxLines: 5,
          inputFormatters: [
            //LengthLimitingTextInputFormatter(10),
            FilteringTextInputFormatter.allow(RegExp('[a-zA-Z ]')),
          ],
          controller: aboutPartner,
          decoration:  InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            suffixIcon: GestureDetector(
              onTap: () async {
                var userId=await SharedPref().getString(key: "user_id");
                updateController?.addinMap("user_id", userId);
                updateController?.addinMap('about_my_partner',aboutPartner.text);
                bool ?res= await updateController?.setPrefrences(context,updateController?.selectedMap );
                if(res==true){

                }
              },
              child: Container(
                alignment: Alignment.center,
width: AppConfig.width*0.2,
                  height: AppConfig.height*0.05,
                  decoration: BoxDecoration(borderRadius:BorderRadius.circular(10),color: Colors.blue),
                  child:Text("Save",style: TextStyle(fontSize: 18,color: Colors.white),)),
            ),
            filled: true,
            hintText: "About My Partner",
            labelStyle: TextStyle(
                color: Color(
                  0xff961b20,
                ),
                fontSize: 16),
            fillColor: Colors.transparent,
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter about your partner';
            }

            return null;
          },
          keyboardType: TextInputType.name,
        ),
      ],),
    );
  }
}