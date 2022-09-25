import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rishtey/controller/auth_controller.dart';
import 'package:rishtey/controller/get_profile_controller.dart';
import 'package:rishtey/controller/update_controller.dart';
import 'package:rishtey/presentation/profile/partner_prefrences/prefeence_end_drawer.dart';
import 'package:rishtey/presentation/profile/personal_profile.dart';
import 'package:rishtey/utils/app_config.dart';

import '../../../utils/shared_pref.dart';

class BasicPrefrences extends StatefulWidget{
  const BasicPrefrences({Key? key}) : super(key: key);

  @override
  State<BasicPrefrences> createState() => _BasicPrefrencesState();
}

class _BasicPrefrencesState extends State<BasicPrefrences> {
  RangeValues values = const RangeValues(18, 70);
  RangeValues Tovalues = const RangeValues(18, 70);
  RangeLabels labels =const RangeLabels('18', "70");

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  //dynamic apikey="";
  var data=[];
  var selectedMaritalStatus = "Never Married";
  String? selectedHeight = "4ft 6in / 137 cms";

 String? selectedHeightFrom = "4ft 6in / 137 cms";
  AuthController?authController;
  GetProfileController?getProfileController;
  UpdateController?updateController;
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
  var apiKey="";
  var selectionType="single";
  @override
  Widget build(BuildContext context) {
selectedMaritalStatus=getProfileController!.getProfileModel?.data?.user?.lookingFor??"Never Married";
selectedHeight=getProfileController!.getProfileModel?.data?.user?.partnerHeightTo.toString()??"4ft 6in / 137 cms";
selectedHeightFrom=getProfileController!.getProfileModel?.data?.user?.partnerHeightFrom.toString()??"4ft 6in / 137 cms";

return Scaffold(
     key: _scaffoldKey,
     endDrawer: SizedBox(
         width: AppConfig.width*0.7,
         child: PrefrenceEndDrawer(data:data,apiKey: apiKey,selectionType:selectionType)),
     appBar:AppBar(title: Text("Basic Info"),),
     body: Container(
       margin: EdgeInsets.all(10),
       child:Consumer<UpdateController>(
         builder: (context,updateController,child) {
           return Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
           SizedBox(height: AppConfig.height*0.05,),
           const Text("Partner Age",style:  TextStyle(fontWeight: FontWeight.w800,fontSize: 18),),
           RangeSlider(
               divisions: 52,
               activeColor: Colors.red[700],
               inactiveColor: Colors.red[300],
               min: 18,
               max: 70,
               values: values,
               labels: labels,

               onChanged: (value){
                 print("START: ${value.start}, End: ${value.end}");
                 setState(() {
                   values =value;
                   labels =RangeLabels("Age-${value.start.toInt().toString()}", "Age-${value.end.toInt().toString()}");
                 });
               }
           ),


             SizedBox(height: AppConfig.height*0.02,),
             Text("Partner Looking For"),
             Consumer<AuthController>(
                 builder: (context, controller, child) {
                   return controller.isLoading
                       ? const CircularProgressIndicator()
                       :  GestureDetector(onTap: (){
                     var v = controller.maritalStatusModel!.maritalStatus!
                         .map((item) {
                       return item.maritalStatus;
                     }).toList();
                     data=v;
                     apiKey="looking_for";
                     selectionType="multi";
                     setState(() {

                     });
                     print(apiKey);
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
                           Text(updateController.selectedMap['looking_for']??selectedMaritalStatus,style: const TextStyle(color: Colors.black,fontSize: 18),),
                           const Icon(Icons.arrow_drop_down_circle_outlined)
                         ],
                       ),));
                 }),
             SizedBox(height: AppConfig.height*0.02,),
             Row(children: [
               Column(children: [
                 const Text(
                   "Height From (in ft.)",
                   style: TextStyle(
                       fontWeight: FontWeight.w800, fontSize: 16),
                 ),
                 Consumer<AuthController>(
                     builder: (context, controller, child) {
                       return controller.isLoading
                           ? const CircularProgressIndicator()
                           : GestureDetector(
                           onTap: (){

                             var v = controller.heightModel!.heights!
                                 .map((item) {
                               return item.height;
                             }).toList();

                             data=v;
                             apiKey="partner_height_from";
                             selectionType="single";
                             setState(() {

                             });

                             _scaffoldKey.currentState!.openEndDrawer();
                           }, child:Container(
                         width: AppConfig.width*0.42,
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
                             Text(updateController.selectedMap['partner_height_from']??selectedHeightFrom!,style: const TextStyle(color: Colors.black,fontSize: 14),),
                             const Icon(Icons.arrow_drop_down_circle_outlined)
                           ],
                         ),));
                     }),
               ],),
               Column(children: [
                 const Text(
                   "Height To (in ft.)",
                   style: TextStyle(
                       fontWeight: FontWeight.w800, fontSize: 16),
                 ),
                 Consumer<AuthController>(
                     builder: (context, controller, child) {
                       return controller.isLoading
                           ? const CircularProgressIndicator()
                           : GestureDetector(onTap: (){

                         var v = controller.heightModel!.heights!
                             .map((item) {
                           return item.height;
                         }).toList();
                         // _showMultiSelect(
                         //   context,
                         //   v,
                         // );
                         data=v;
                         apiKey="partner_height_to";
                         selectionType="single";
                         setState(() {

                         });

                         _scaffoldKey.currentState!.openEndDrawer();
                       }, child:Container(
                         width: AppConfig.width*0.4,
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
                             Text(updateController.selectedMap['partner_height_to']??selectedHeight!,style: const TextStyle(color: Colors.black,fontSize: 13),),
                             const Icon(Icons.arrow_drop_down_circle_outlined)
                           ],
                         ),));
                     }),
               ],)

             ],),
             const SizedBox(
               height: 40,
             ),
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
                     updateController.addinMap( 'partner_age_from',values.start.toString(),);
                     updateController.addinMap('partner_age_to',values.end.toString(),);
                    // print( updateController!.selectedMap);
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