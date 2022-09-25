import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rishtey/presentation/bottom_navigation_bar.dart';
import 'package:rishtey/presentation/profile/profile_prefrences.dart';
import 'package:rishtey/utils/app_config.dart';

import '../../controller/get_profile_controller.dart';
import '../edit_screens/user_gallery/gallery.dart';
import 'about_me_profile.dart';

class PersonalProfile extends StatefulWidget{
   int?tab=0;
   PersonalProfile({Key? key,this.tab}) : super(key: key);

  @override
  State<PersonalProfile> createState() => _PersonalProfileState();
}

class _PersonalProfileState extends State<PersonalProfile>  with SingleTickerProviderStateMixin {
  TabController? _tabController;
  GetProfileController?getProfileController;
  var age=0;
  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    Future.delayed(const Duration(milliseconds: 100),(){
      getProfileController=Provider.of<GetProfileController>(context,listen: false);
      getProfileController?.getProfile(context);
      age=calculateAge(DateTime.parse(getProfileController!.getProfileModel!.data!.user!.birthDateTime!.toString().substring(0,10)));

    });
    _tabController!.animateTo(widget.tab??0);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController!.dispose();
  }
  @override
  Widget build(BuildContext context) {

  //  print("odsnxkv;ma${getProfileController?.getProfileModel?.data?.user?.fullName}");
   return WillPopScope(
     onWillPop: ()async {
       Navigator.push(context, MaterialPageRoute(builder: (context)=>MyHomePage()));
       return true;
     },
     child: Scaffold(
       appBar: AppBar(title: const Text("Personal Profile"),)

       ,
       body: Consumer<GetProfileController>(
         builder: (context,controller,child) {
           return controller.isLoading?Center(child: CircularProgressIndicator()):
           Container(
             padding: const EdgeInsets.all(10),
             child: Column(


             children: [
             Container(
               child: Row(

               children: [
                 GestureDetector(
                   onTap:(){
                     Navigator.push(context, MaterialPageRoute(builder: (context)=>Gallery()));
                   },
                   child: Stack(
                     children: [

                       Container(
                         decoration: BoxDecoration(
                           shape: BoxShape.circle,
                           image: DecorationImage(
                             image: NetworkImage(
                                 "https://webtechworlds.com/himrishtey/photos/photo/"+controller.getProfileModel!.data!.user!.photo.toString().replaceAll("file:///","")),),
                           color: AppConfig.theme
                               .primaryColor,

                         ),
                         width: AppConfig.width * 0.25,
                         height: AppConfig.height *
                             0.12,


                       ),
                       const Positioned(
                         bottom: 5,
                         right: 15,
                         child: CircleAvatar(
                           radius: 13,
                           backgroundColor: Colors
                               .green,
                           child: Icon(Icons.add,
                             color: Colors.white,
                             size: 20,),
                         ),
                       ),
                     ],
                   ),
                 ),
               const SizedBox(width: 30,),
               Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 mainAxisAlignment: MainAxisAlignment.start,
                 children: [
                 Row(children:  [
                  const Text("User Name: ",style: TextStyle(fontSize: 16,),),
                   Text("${controller.getProfileModel?.data?.user?.fullName}",style:const TextStyle(fontSize: 16,fontWeight: FontWeight.w800)),

                 ],),
                 Row(children:  [
                   const   Text("Age: ",style: TextStyle(fontSize: 16,),),
                   Text("$age ",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w800)),

                 ],),

                 Row(children: const [
                   Text("Plan: ",style: TextStyle(fontSize: 16,),),
                   Text("Silver ",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w800)),

                 ],),
                   Row(children:  [
                     Text("Profile Id: ",style: TextStyle(fontSize: 16,),),
                     Text("${controller.getProfileModel?.data?.user?.profileId} ",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w800)),

                   ],),
               ],)
             ],),),
               const Divider(thickness: 1,height: 20,color: Colors.grey,),

                     // give the tab bar a height [can change hheight to preferred height]
                     Container(
                       height: 45,
                       decoration: BoxDecoration(
                         color: Colors.grey[300],
                         borderRadius: BorderRadius.circular(
                           25.0,
                         ),
                       ),
                       child: TabBar(
                         controller: _tabController,
                         // give the indicator a decoration (color and border radius)
                         indicator: BoxDecoration(
                           borderRadius: BorderRadius.circular(
                             25.0,
                           ),
                           color: Colors.green,
                         ),
                         labelColor: Colors.white,
                         unselectedLabelColor: Colors.black,
                         tabs: const [
                           // first tab [you can add an icon using the icon property]
                           Tab(
                             text: 'About Me',
                           ),

                           // second tab [you can add an icon using the icon property]
                           Tab(
                             text: 'Preferences',
                           ),
                         ],
                       ),
                     ),
                     // tab bar view here
                     Expanded(
                       child: TabBarView(
                         controller: _tabController,
                         children:  [
                           // first tab bar view widget
                           AboutMe(userModel:getProfileController?.getProfileModel?.data?.user),

                           // second tab bar view widget
                           Prefrences(userModel: getProfileController?.getProfileModel?.data?.user)
                         ],
                       ),
                     ),



             ],),);
         }
       ),

     ),
   );
  }
}