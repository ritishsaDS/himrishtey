import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rishtey/controller/update_controller.dart';
import 'package:rishtey/presentation/profile/personal_profile.dart';
import 'package:rishtey/utils/app_config.dart';
import 'package:rishtey/utils/shared_pref.dart';

class PartnerLifestyle extends StatefulWidget{
  @override
  State<PartnerLifestyle> createState() => _PartnerLifestyleState();
}

class _PartnerLifestyleState extends State<PartnerLifestyle> {
  String?drinking="Yes";
  String?diet="Pure Veg";
  String?smoking="Yes";
  UpdateController?updateController;
  @override
  void initState() {

    super.initState();
    updateController=Provider.of<UpdateController>(context,listen: false);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar:AppBar(title: Text("Partner's Lifestyle"),),
      body: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Diet",
              style:
              TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
            ),
            const SizedBox(height: 5),
            Container(
              width: MediaQuery.of(context).size.width,
              child: DropdownButton<String>(
                underline: Container(height: 1,
                  color: Colors.black,
                ),
                icon: Container(),
                value: diet,
                onChanged: (String ?newValue) {
                  setState(() {
                    // authController!.dropdownValue = newValue!;
                    diet=newValue;
                  });
                },
                items: <String>["Pure Veg", 'Veg & NonVeg', ]
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            )
            ,
            const Text(
              "Is Drinking",
              style:
              TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
            ),
            const SizedBox(height: 5),
            Container(
              width: MediaQuery.of(context).size.width,
              child: DropdownButton<String>(
                underline: Container(height: 1,
                  color: Colors.black,
                ),
                icon: Container(),
                value: drinking,
                onChanged: (String ?newValue) {
                  setState(() {
                    //authController!.dropdownValue = newValue!;
                    drinking=newValue;
                  });
                },
                items: <String>['Yes', 'No', ]
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            const Text(
              "Is Smoking",
              style:
              TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
            ),
            const SizedBox(height: 5),
            Container(
              width: MediaQuery.of(context).size.width,
              child: DropdownButton<String>(
                underline: Container(height: 1,
                  color: Colors.black,
                ),
                icon: Container(),
                value: smoking,
                onChanged: (String ?newValue) {
                  setState(() {
                    // authController!.dropdownValue = newValue!;
                    smoking
                    =newValue;
                  });
                },
                items: <String>['Yes', 'No', ]
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 40),
            Center(
              child: GestureDetector(
                onTap: () async{



                  var user_id = await SharedPref().getString(key: "user_id");
                  // Map<String, dynamic> data ={
                  //   "user_id":user_id,
                  //   'partner_height_from':updateController!.partnerHeightFrom,
                  //       'partner_height_to':updateController!.partnerHeightTo,
                  //       'partner_age_from':values.start.toString(),
                  //       'partner_age_to':values.end.toString(),
                  //   'looking_for':updateController!.setMariatlStatus
                  // };
                  updateController!.addinMap("user_id", user_id);
                  updateController!.addinMap("is_partner_drinking", drinking);
                  updateController!.addinMap( 'partner_diet',diet,);
                  updateController!.addinMap('is_partner_smoking',smoking.toString(),);
                  print( updateController!.selectedMap);
                  bool res= await updateController!.setPrefrences(context, updateController!.selectedMap);

                  if(res==true){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>PersonalProfile(tab: 1,)));
                     }
                  setState(() {



                  });

                },
                child: AnimatedContainer(
                    width:AppConfig.width*0.8,
                    alignment: Alignment.center,
                    duration: const Duration(microseconds: 500),
                    height: 60,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        gradient: const LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.topLeft,
                          colors: [
                            Color(0xffFF5D4B),
                            Color(0xffFF7C57),
                          ],
                        )),
                    child: Center(
                      child:   Text(
                        "Update",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w800),
                      ),
                    )),
              ),
            ),
          ],),),
    );
  }
}