import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rishtey/controller/auth_controller.dart';
import 'package:rishtey/controller/update_controller.dart';
import 'package:rishtey/presentation/profile/partner_prefrences/prefeence_end_drawer.dart';
import 'package:rishtey/presentation/profile/personal_profile.dart';
import 'package:rishtey/utils/app_config.dart';

import '../../../controller/get_profile_controller.dart';
import '../../../utils/shared_pref.dart';

class ReligionPrefrences extends StatefulWidget{
  const ReligionPrefrences({Key? key}) : super(key: key);

  @override
  State<ReligionPrefrences> createState() => _ReligionPrefrencesState();
}

class _ReligionPrefrencesState extends State<ReligionPrefrences> {

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  //dynamic apikey="";
  var data=[];
  String?selectedValue = "";
  String?selectedCaste = "";
  String?selectedState = "";
  String?selectedHeight = "";
  String?selectedEducation = "";
  String?selectedEmployedIn = "";
  String?selectedHeightFrom = "";
  String?selectedAnnual = "";
  String?selectedMotherTongue = "";
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
      authController!.getMaritalStatus(context);
      authController!.getHeights(context);
    });
    super.initState();
  }
  var apikey="";
  var selectionType="single";
  @override
  Widget build(BuildContext context) {
    selectedMotherTongue=getProfileController!.getProfileModel?.data?.user?.partnerMothertongue!=""?getProfileController!.getProfileModel?.data?.user?.partnerMothertongue:"";
    selectedValue=getProfileController!.getProfileModel?.data?.user?.partnerReligion.toString()!=""?getProfileController!.getProfileModel?.data?.user?.partnerReligion.toString():"";
    selectedCaste=getProfileController!.getProfileModel?.data?.user?.partnerCast.toString()!=""?getProfileController!.getProfileModel?.data?.user?.partnerCast.toString():"";
// isManglik=getProfileController!.getProfileModel?.data?.user?.isPartnerManglik??"NO";
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: SizedBox(
          width: AppConfig.width*0.7,
          child: PrefrenceEndDrawer(data:data,apiKey: apikey,selectionType:selectionType)),
      appBar:AppBar(title: Text("Religion Prefrences"),),
      body: Container(
        margin: EdgeInsets.all(10),
        child: Consumer<UpdateController>(
          builder: (context,updateController,child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Religion",
                  style: TextStyle(
                      fontWeight: FontWeight.w800, fontSize: 18),
                ),
                Consumer<AuthController>(
                    builder: (context, controller, child) {
                      return controller.isLoading
                          ? const CircularProgressIndicator()
                          : GestureDetector(onTap: (){

                        var v = controller.religionModel!.religions!
                            .map((item) {
                          return item.religion;
                        }).toList();
                        data=v;
                        apikey="partner_religion";
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
                              Text(updateController.selectedMap["partner_religion"]??selectedValue!,style: const TextStyle(color: Colors.black,fontSize: 18),),
                              const Icon(Icons.arrow_drop_down_circle_outlined)
                            ],
                          ),));
                    }),
                const Text(
                  "Community",
                  style: TextStyle(
                      fontWeight: FontWeight.w800, fontSize: 18),
                ),
                Consumer<AuthController>(
                    builder: (context, controller, child) {
                      return controller.isLoading
                          ? const CircularProgressIndicator()
                          : GestureDetector(onTap: (){
                        var v = controller.castesModel!.casts!
                            .map((item) {
                          return item.cast;
                        }).toList();
                        data=v;
                        apikey="partner_cast";
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
                              Text(updateController.selectedMap["partner_cast"]??selectedCaste!,style: const TextStyle(color: Colors.black,fontSize: 18),),
                              const Icon(Icons.arrow_drop_down_circle_outlined)
                            ],
                          ),));
                    }),
                const Text(
                  "Mother Tongue",
                  style: TextStyle(
                      fontWeight: FontWeight.w800, fontSize: 18),
                ),
                Consumer<AuthController>(
                    builder: (context, controller, child) {
                      return controller.isLoading
                          ? const CircularProgressIndicator()
                          : GestureDetector(onTap: (){
                        var v = controller.motherTongueModel!.motherTongues!
                            .map((item) {
                          return item.motherTongue;
                        }).toList();
                        data=v;
                        apikey="partner_mothertongue";
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
                              Text(updateController.selectedMap["partner_mothertongue"]??selectedMotherTongue!,style: const TextStyle(color: Colors.black,fontSize: 18),),
                              const Icon(Icons.arrow_drop_down_circle_outlined)
                            ],
                          ),));
                    }),
                SizedBox(height: 20,),
                const Text(
                  "Is Manglik",
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
                    value: isManglik,
                    onChanged: (String ?newValue) {
                      setState(() {
                     isManglik = newValue!;
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
                )
                ,
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
                      updateController.addinMap("is_partner_manglik", isManglik);
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
                        width: AppConfig.width*0.9,
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