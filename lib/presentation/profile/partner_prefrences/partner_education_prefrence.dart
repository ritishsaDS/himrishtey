import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rishtey/controller/auth_controller.dart';
import 'package:rishtey/controller/get_profile_controller.dart';
import 'package:rishtey/controller/update_controller.dart';
import 'package:rishtey/presentation/profile/partner_prefrences/prefeence_end_drawer.dart';
import 'package:rishtey/presentation/profile/personal_profile.dart';
import 'package:rishtey/utils/app_config.dart';

import '../../../utils/shared_pref.dart';

class PartnerPrefrence extends StatefulWidget{
  const PartnerPrefrence({Key? key}) : super(key: key);

  @override
  State<PartnerPrefrence> createState() => _ReligionPrefrencesState();
}

class _ReligionPrefrencesState extends State<PartnerPrefrence> {

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  //dynamic apikey="";
  var data=[];
  String?selectedValue = "Hindu";
  String?selectedCaste = "Brahmin";
  String?selectedState = "Himachal Pradesh";
  String?selectedHeight = "4ft 6in / 137 cms";
  String?selectedEducation = "M.A.";
  String?selectedEmployedIn = "Business";
  String?selectedHeightFrom = "4ft 6in / 137 cms";
  String?selectedAnnual = "1 Lakh";
  String?selectedAnnual2 = "1 Lakh";
  String?selectedMotherTongue = "Accounts";
  String ?isManglik="Yes";
  AuthController?authController;
  UpdateController?updateController;
  GetProfileController?getProfileController;
  @override
  void initState() {
    getProfileController = Provider.of<GetProfileController>(context, listen: false);
    authController = Provider.of<AuthController>(context, listen: false);
    Future.delayed(const Duration(milliseconds: 100), () {

      updateController = Provider.of<UpdateController>(context, listen: false);
      authController!.getEducationType(context);
      authController!.getAnnualIncomeType(context);
      authController!.getOccupationType(context);
    });
    super.initState();
  }
  var apikey="";
  var selectionType="single";
  @override
  Widget build(BuildContext context) {
    selectedEducation=getProfileController!.getProfileModel?.data?.user?.partnerEducation!=""?getProfileController!.getProfileModel?.data?.user?.partnerEducation:"";
    selectedMotherTongue=getProfileController!.getProfileModel?.data?.user?.partnerOccupation.toString()!=""?getProfileController!.getProfileModel?.data?.user?.partnerOccupation.toString():"";
    selectedCaste=getProfileController!.getProfileModel?.data?.user?.partnerCast.toString()!=""?getProfileController!.getProfileModel?.data?.user?.partnerCast.toString():"Brahmin";

    return Scaffold(
      key: _scaffoldKey,
      endDrawer: SizedBox(
          width: AppConfig.width*0.7,
          child: PrefrenceEndDrawer(data:data,apiKey: apikey,selectionType:selectionType)),
      appBar:AppBar(title: Text("Partner Education"),),
      body: Container(
        margin: EdgeInsets.all(10),
        child:  Consumer<UpdateController>(
            builder: (context, updateController, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Education ",
                  style: TextStyle(
                      fontWeight: FontWeight.w800, fontSize: 18),
                ),
                Consumer<AuthController>(
                    builder: (context, controller, child) {
                      return controller.isLoading
                          ? const CircularProgressIndicator()
                          : GestureDetector(onTap: (){
                        var v = controller.educationModel!.educations!
                            .map((item) {
                          return item.education;
                        }).toList();
                        data=v;
                        apikey="partner_education";
                        selectionType="multi";
                        setState(() {

                        });

                        _scaffoldKey.currentState!.openEndDrawer();
                      },child:Container(
                          width: AppConfig.width*0.9,
                          alignment: Alignment.centerLeft,
                          height: AppConfig.height*0.07,
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(color: Colors.black)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(updateController.selectedMap["partner_education"]??selectedEducation!,style: const TextStyle(color: Colors.black,fontSize: 18),),
                              const Icon(Icons.arrow_drop_down_circle_outlined)
                            ],
                          ),));
                    }),

                const Text(
                  "Annual Income",
                  style: TextStyle(
                      fontWeight: FontWeight.w800, fontSize: 18),
                ),
                Row(
                  children:[
                    Consumer<AuthController>(
                        builder: (context, controller, child) {
                          return controller.isLoading
                              ? const CircularProgressIndicator()
                              :Container(
                            width: AppConfig.width*0.43,
                            alignment: Alignment.centerLeft,
                            height: AppConfig.height*0.07,
                            padding: const EdgeInsets.all(10),
                            margin: const EdgeInsets.all(10),

                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0),border: Border.all(color: Colors.grey)),
                              child:DropdownButton(
                                borderRadius: BorderRadius.circular(10.0),
                                onChanged: ( newValue){
                                  setState(() {
                                    selectedAnnual = newValue.toString();
                                   // selectedAnnual2=newValue.toString()
                                  });
                                },
                                value: selectedAnnual,
                                items: controller.annualIncomeModel!.annualIncomes!.map((item) {
                                  return  DropdownMenuItem(
                                    child:  Text(item.annualIncome.toString()),
                                    value: item.annualIncome.toString(),
                                  );
                                }).toList(),

                                isExpanded: true, //make true to take width of parent widget
                                underline: Container(), //empty line
                                style: const TextStyle(fontSize: 18, color: Colors.black),
                                dropdownColor: Colors.white,
                                iconEnabledColor: Colors.black,
                                hint: const Text("Select Your Religion"),//Icon color
                              ) );
                        }),
                    Consumer<AuthController>(
                        builder: (context, controller, child) {
                          return controller.isLoading
                              ? const CircularProgressIndicator()
                              :Container(
                              width: AppConfig.width*0.43,
                              alignment: Alignment.centerLeft,
                              height: AppConfig.height*0.07,
                              padding: const EdgeInsets.all(10),
                              margin: const EdgeInsets.all(10),

                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0),border: Border.all(color: Colors.grey)),
                              child:DropdownButton(
                                borderRadius: BorderRadius.circular(10.0),
                                onChanged: ( newValue){
                                  setState(() {
                                    selectedAnnual2 = newValue.toString();
                                  });
                                },
                                value: selectedAnnual2,
                                items: controller.annualIncomeModel!.annualIncomes!.map((item) {
                                  return  DropdownMenuItem(
                                    child:  Text(item.annualIncome.toString()),
                                    value: item.annualIncome.toString(),
                                  );
                                }).toList(),

                                isExpanded: true, //make true to take width of parent widget
                                underline: Container(), //empty line
                                style: const TextStyle(fontSize: 18, color: Colors.black),
                                dropdownColor: Colors.white,
                                iconEnabledColor: Colors.black,
                                hint: const Text("Select Your Religion"),//Icon color
                              ) );
                        }),
                  ]
                ),
                const Text(
                  "Partner Occupation",
                  style: TextStyle(
                      fontWeight: FontWeight.w800, fontSize: 18),
                ),
                Consumer<AuthController>(
                    builder: (context, controller, child) {
                      return controller.isLoading
                          ? const CircularProgressIndicator()
                          : GestureDetector(onTap: (){
                        var v = controller.occupationModel!.occupations!
                            .map((item) {
                          return item.occupation;
                        }).toList();
                        data=v;
                        apikey="partner_occupation";
                        selectionType="multi";
                        setState(() {

                        });

                        _scaffoldKey.currentState!.openEndDrawer();
                      },child:Container(
                          width: AppConfig.width*0.9,
                          alignment: Alignment.centerLeft,
                          height: AppConfig.height*0.07,
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(color: Colors.black)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(updateController.selectedMap["partner_occupation"]??selectedMotherTongue!,style: const TextStyle(color: Colors.black,fontSize: 18),),
                              const Icon(Icons.arrow_drop_down_circle_outlined)
                            ],
                          ),));
                    }),

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
                      updateController.addinMap("user_id", user_id);
                     updateController.addinMap("partner_annual_income_from", selectedAnnual!);
                     updateController.addinMap("partner_annual_income_to", selectedAnnual2!);
                      // updateController!.addinMap( 'partner_age_from',values.start.toString(),);
                      // updateController!.addinMap('partner_age_to',values.end.toString(),);
                      print( updateController.selectedMap);
                      bool res= await updateController.setPrefrences(context, updateController.selectedMap);

                      if(res==true){
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>PersonalProfile(tab: 1,)));
                      }
                      setState(() {



                      });

                    },
                    child: AnimatedContainer(
                        width:  AppConfig.width*0.9,
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
                          child: authController!.isLoading
                              ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                              : const Text(
                            "Update",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w800),
                          ),
                        )),
                  ),
                ),
              ],);
          }
        ),),
    );
  }
}