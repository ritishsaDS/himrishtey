import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rishtey/controller/auth_controller.dart';
import 'package:rishtey/controller/get_profile_controller.dart';
import 'package:rishtey/controller/update_controller.dart';
import 'package:rishtey/presentation/profile/partner_prefrences/prefeence_end_drawer.dart';
import 'package:rishtey/presentation/profile/personal_profile.dart';
import 'package:rishtey/utils/app_config.dart';

import '../../../utils/shared_pref.dart';

class PartnerLocation extends StatefulWidget{
  const PartnerLocation({Key? key}) : super(key: key);

  @override
  State<PartnerLocation> createState() => _ReligionPrefrencesState();
}

class _ReligionPrefrencesState extends State<PartnerLocation> {

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
  String?selectedAnnual = "Not Disclosed";
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
      authController!.getStates(context);
      authController!.getCountries(context);
      authController!.getCities(context);
    });
    super.initState();
  }
  var apikey="";
  var selectionType="single";
  @override
  Widget build(BuildContext context) {
   // selectedEducation=getProfileController!.getProfileModel?.data?.user?.partnerEducation!=""?getProfileController!.getProfileModel?.data?.user?.partnerEducation:"M.A.";
   // selected=getProfileController!.getProfileModel?.data?.user?.partnerOccupation.toString()!=""?getProfileController!.getProfileModel?.data?.user?.partnerOccupation.toString():"Accounts";
    selectedAnnual=getProfileController!.getProfileModel?.data?.user?.partnerState.toString()!=""?getProfileController!.getProfileModel?.data?.user?.partnerState.toString():"Please Select State";
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: SizedBox(
          width: AppConfig.width*0.7,
          child: PrefrenceEndDrawer(data:data,apiKey: apikey,selectionType:selectionType)),
      appBar:AppBar(title: Text("Partner Location"),),
      body: Container(
        margin: EdgeInsets.all(10),
        child: Consumer<UpdateController>(
            builder: (context, updateController, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Country ",
                  style: TextStyle(
                      fontWeight: FontWeight.w800, fontSize: 18),
                ),
                Consumer<AuthController>(
                    builder: (context, controller, child) {
                      return controller.isLoading
                          ? const CircularProgressIndicator()
                          : GestureDetector(onTap: (){
                        var v = controller.countryModel!.countries!
                            .map((item) {
                          return item.name;
                        }).toList();
                        data=v;
                        apikey="partner_country";
                        selectionType="single";
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
                              Text(updateController.selectedMap['partner_country']??"India",style: const TextStyle(color: Colors.black,fontSize: 18),),
                              const Icon(Icons.arrow_drop_down_circle_outlined)
                            ],
                          ),));
                    }),

                const Text(
                  "State",
                  style: TextStyle(
                      fontWeight: FontWeight.w800, fontSize: 18),
                ),
                Consumer<AuthController>(
                    builder: (context, controller, child) {
                      return controller.isLoading
                          ? const CircularProgressIndicator()
                          : GestureDetector(onTap: (){
                        var v = controller.statesModel!.states!
                            .map((item) {
                          return item.name;
                        }).toList();
                        data=v;
                        apikey="partner_state";
                        selectionType="single";
                        setState(() {

                        });

                        _scaffoldKey.currentState!.openEndDrawer();
                        // authController!.getCities(context,);
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
                              Text(updateController.selectedMap['partner_state']??selectedAnnual!,style: const TextStyle(color: Colors.black,fontSize: 18),),
                              const Icon(Icons.arrow_drop_down_circle_outlined)
                            ],
                          ),));
                    }),
                const Text(
                  "City",
                  style: TextStyle(
                      fontWeight: FontWeight.w800, fontSize: 18),
                ),
                Consumer<AuthController>(
                    builder: (context, controller, child) {
                      return controller.isLoading
                          ? const CircularProgressIndicator()
                          : GestureDetector(onTap: (){
                        var v = controller.cityModel!.states!
                            .map((item) {
                          return item.name;
                        }).toList();
                        data=v;
                        apikey="partner_city";
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
                              Text(updateController.selectedMap['partner_city']??"Arki",style: const TextStyle(color: Colors.black,fontSize: 18),),
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
                      // updateController!.addinMap("is_partner_manglik", isManglik);
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
                        width: authController!.loginWidth,
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