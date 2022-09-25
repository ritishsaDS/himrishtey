import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:rishtey/controller/get_profile_controller.dart';
import 'package:rishtey/presentation/dashboard/dash_board_screen.dart';
import 'package:rishtey/presentation/dashboard/matching_profiles.dart';
import 'package:rishtey/presentation/login/login_2.dart';
import 'package:rishtey/presentation/membership/membership_screen.dart';
import 'package:rishtey/presentation/membership/plains_screen.dart';
import 'package:rishtey/presentation/my_interests/my_interest.dart';
import 'package:rishtey/presentation/profile/delete_account_reason.dart';
import 'package:rishtey/presentation/profile/personal_profile.dart';
import 'package:rishtey/presentation/register/forgot_password.dart';
import 'package:rishtey/presentation/register/reset_password.dart';
import 'package:rishtey/utils/app_config.dart';
import 'package:rishtey/utils/app_snack_bar.dart';
import 'package:rishtey/utils/firebase/firebase_auth.dart';
import 'package:rishtey/utils/theme_clas.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controller/rating_controller.dart';
import '../utils/delete_account_dialog.dart';
import '../utils/firebase/firebase_chats.dart';
import '../utils/search_chat.dart';
import 'all_search/advance_search.dart';
import 'all_search/all_search/show_searches/search_dialog_box.dart';
import 'all_search/quick_search.dart';
import 'bottom_bar_item.dart';
import 'chat_ui.dart';
import 'coming_soon.dart';
import 'dashboard/shortlisted_profiles.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);


  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  AuthService authService=AuthService();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  RatingController?ratingController;
  GetProfileController?getProfileController;
  double rating = 0;
  final _inactiveColor = Colors.black;
  List<Widget> pages = [
    Container(
        alignment: Alignment.center,
        child:const DashBoardScreen()
    ),
    Container(
        alignment: Alignment.center,
        child: MyInterest()
    ),
    Container(
      alignment: Alignment.center,
      child: FrostedDemo(),
    ),
    Container(
      alignment: Alignment.center,
      child: FrostedDemo(),
    ),
    // Container(
    //   alignment: Alignment.center,
    //   child: const Text("Settings",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
    // ),
  ];
  @override
  void initState() {
    Future.delayed(Duration(milliseconds: 100),(){
      ratingController=Provider.of<RatingController>(context,listen: false);
      getProfileController=Provider.of<GetProfileController>(context,listen: false);
    });
    // print("FirebaseAuth.instance.currentUser");
    // print(FirebaseAuth.instance.currentUser);
    // DatabaseMethods().searchByName("Dhdhj");
    super.initState();
  }
  DateTime ?currentBackPressTime;

  @override
  Widget build(BuildContext context) {
    AppConfig.init(context);
    return WillPopScope(
      onWillPop: (){
        if(_currentIndex!=0){
          _currentIndex=0;
          setState(() {

          });
          return Future.value(false);
        }

        else{
          DateTime now = DateTime.now();
          if (currentBackPressTime == null ||
              now.difference(currentBackPressTime!) > Duration(seconds: 3)) {
            currentBackPressTime = now;
            appSnackBar(content: "Press Again to exit app", context: context);
            return Future.value(false);
          }
          return Future.value(true);
        }

      },
      child: Consumer<RatingController>(
        builder: (context,controller,child) {
          return Scaffold(

            endDrawer:  Drawer(
          child: ListView(
          padding: EdgeInsets.zero,
            children: [
              Consumer<GetProfileController>(
                builder: (context,controller,child) {
                  return DrawerHeader(
                    child: Row(
                      children: [
                       CircleAvatar(
                         radius: 50,
                         backgroundImage:NetworkImage("https://webtechworlds.com/himrishtey/photos/photo/" +(controller.getProfileModel?.data?.user?.photo??""))),
                        SizedBox(width: 10,), Column(
                           mainAxisAlignment: MainAxisAlignment.center,
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             Text(
                              'Profile Id-${controller.getProfileModel?.data?.user?.profileId}',
                              style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                             Text(
                               'Name -${controller.getProfileModel?.data?.user?.fullName}',
                               style: TextStyle(color: Colors.black, fontSize: 16),
                             ),
                             SizedBox(height: 10,),
                             SizedBox(
                               width:
                               MediaQuery.of(context)
                                   .size
                                   .width *
                                   .4,
                               child:
                               LinearProgressIndicator(
                                 value: double.parse(
                                     (getProfileController
                                         ?.getProfileModel
                                         ?.data
                                         ?.user
                                         ?.profileCompleted ??
                                         "0")) /
                                     100,
                                 backgroundColor: Colors
                                     .grey.shade400,
                                 valueColor:
                                 const AlwaysStoppedAnimation<
                                     Color>(
                                     Colors.green),
                               ),
                             )
                           ],
                         ),
                      ],
                    ),
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10.0),
                            bottomRight: Radius.circular(10.0)),
                        color: Colors.white,
                        image: DecorationImage(
                            fit: BoxFit.fill, image: AssetImage('assets/sideimg.jpg'))),
                  );
                }
              ),
 ListTile(
  onTap: (){
          Navigator.pop(context);
  },
  title: Text("Home",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w800,fontSize: 20),),leading: Icon(Icons.home),),
 ListTile(
  onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>MemberShipScreen()));

  },
  title:const Text("Activate your membership",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w800,fontSize: 20)),leading: Icon(Icons.card_membership),),
              ListTile(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> PersonalProfile()));          },
                title: const Text("Edit Profile",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w800,fontSize: 20)),leading: const Icon(Icons.edit),),
              ListTile(
  onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>QuickSearch()));
  },
  title: const Text("Quick Search",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w800,fontSize: 20)),leading: const Icon(Icons.search),),
 ListTile(
  onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>const AdvanceSearch()));
  },
  title: const Text("Advance Search",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w800,fontSize: 20)),leading: const Icon(Icons.search_off_sharp),),
 ListTile(
  onTap: (){
          displayTextInputDialog(context);
  },
  title: const Text("Search By Profile Id",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w800,fontSize: 20)),leading: const Icon(Icons.person_search_rounded),),
              ListTile(
                onTap: (){
                  _currentIndex=1;
                  Navigator.pop(context);
                  setState(() {

                  });
                },
                title: const Text("Interest Inbox",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w800,fontSize: 20)),leading: const Icon(Icons.person_search_rounded),),
 ListTile(
  onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>const MatchingProfile()));
  },
  title: const Text("Matching Profile",style: const TextStyle(color: Colors.black,fontWeight: FontWeight.w800,fontSize: 20)),leading: const Icon(Icons.indeterminate_check_box),),

              ListTile(

onTap: (){
  Navigator.push(context, MaterialPageRoute(builder: (context)=>const ShortListedProfile()));
},
  title: const Text("ShortListed Profile",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w800,fontSize: 20)),leading: const Icon(Icons.verified),),
                  ListTile(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>const ResetPassword()));
                },
                title: const Text("Reset Password",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w800,fontSize: 20)),leading: const Icon(Icons.password),),
const ListTile(title: Text("My Contact",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w800,fontSize: 20)),leading: Icon(Icons.contact_phone_outlined),),
 ListTile(
  onTap: (){
          _launchUrl();
  },

  title: Text("Refer & Earn",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w800,fontSize: 20)),leading: Icon(Icons.room_preferences),),
              // ListTile(
              //   onTap: (){
              //     _launchUrl();
              //   },
              //
              //   title: Text("Report Profile",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w800,fontSize: 20)),leading: Icon(Icons.report),),
 ListTile(
  onTap:(){_launchUrl();},
  title: const Text("Success Stories",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w800,fontSize: 20)),leading:Icon(Icons.location_history_rounded)),
 ListTile(
  onTap: (){
             Navigator.push(context, MaterialPageRoute(builder: (context)=> const DeleteAccountReason()));
  },
  title: const Text("Delete Profile",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w800,fontSize: 20)),leading: const Icon(Icons.delete_sweep_sharp),),
 ListTile(
  onTap:(){_launchUrl();},
  title: const Text("Refund & Cancellation",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w800,fontSize: 20)),leading:Icon(Icons.cabin_sharp)),
              ListTile(
                onTap: () async {
                  showAlertDialog(context); },
                title:const Text("Rate Us",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w800,fontSize: 20)),leading: const Icon(Icons.star_rate_outlined),),

              ListTile(
                onTap: () async {
                 // showAlertDialog(context);
                  _launchCaller("9857102002");
                  },
                title:Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Helpline Number-",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w800,fontSize: 18)),
                  Text("9857102002",style: TextStyle(color: AppConfig.theme.primaryColor,fontWeight: FontWeight.w800,fontSize: 20)),
                  ],
                ),leading: const Icon(Icons.help),),

              ListTile(
                onTap: () async {
                 _launchUrl(); },
                title:const Text("Terms & Conditions",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w800,fontSize: 20)),leading: const Icon(Icons.privacy_tip),),

              ListTile(
                onTap: () async {
                  authService.signOut();
                  SharedPreferences prefs=await SharedPreferences.getInstance();
                  prefs.clear();
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginPage2()));
                  },
                title:const Text("Logout",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w800,fontSize: 20)),leading: const Icon(Icons.logout),),

            ],
          ),
          ),
            key: _scaffoldKey,
              body: pages[_currentIndex],
              bottomNavigationBar: _buildBottomBar()
          );
        }
      ),
    );
  }

  Widget _buildBottomBar(){
    return CustomAnimatedBottomBar(
      onTap:(){

      },
      containerHeight: 70,
      backgroundColor: primaryColor,
      selectedIndex: _currentIndex,
      showElevation: true,
      itemCornerRadius: 24,
      curve: Curves.easeIn,
      onItemSelected: (index) => setState(() => _currentIndex = index),
      items: <BottomNavyBarItem>[
        BottomNavyBarItem(
          key: _scaffoldKey,
          icon: const Icon(Icons.home),
          title: const Text('Home'),
          activeColor: Colors.white,
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
        BottomNavyBarItem(
          key: _scaffoldKey,
          icon: const Icon(Icons.people),
          title: const Text('Interest'),
          activeColor: Colors.white,
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
        BottomNavyBarItem(
          icon: const Icon(Icons.message),
          title: const Text(
            'Chat ',
          ),
          key: _scaffoldKey,
          activeColor: Colors.white,
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
        BottomNavyBarItem(
          icon: const Icon(Icons.miscellaneous_services_sharp,size: 30,),
          title: const Text('Other  Service'),
          activeColor: Colors.white,
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
          key: _scaffoldKey,
        ),
        BottomNavyBarItem(
onTap: (){
  _scaffoldKey.currentState!.openEndDrawer();

},
          key: _scaffoldKey,
          icon: const Icon(Icons.apps),
          title: const Text('Menu'),
          activeColor: Colors.white,
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  showAlertDialog(context) {
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Consumer<RatingController>(builder: (context, model, child) {
                return AlertDialog(insetPadding: EdgeInsets.symmetric(horizontal: AppConfig.width*0.05),
                  title: const Text("Rating"),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      RatingBar.builder(
                        initialRating: 0,
                        minRating: rating,
                        direction: Axis.horizontal,
                        allowHalfRating: false,
                        itemCount: 5,
                        itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                        itemBuilder: (context, _) =>  Icon(
                          Icons.star,
                          color: AppConfig.theme.primaryColor,
                        ),
                        onRatingUpdate: (rating) {
                          // setState(() {
                          //   this.rating = rating;
                          // });
                          model.updateRatting(
                            rating: rating,
                            context: context
                          );
                          print("kjbnl/");
                          if(model.rating==4||model.rating==5){
                            print(";rejfnvlnkerl");
                            showCustomDialog(context);
                          }
                          // Consumer<RatingController>(
                          //   builder: (context,model,child){
                          //     return model.rating = rating;
                          //   },
                          // );
                        },
                      ),
                      // RatingBar.builder(
                      //   initialRating: 0,
                      //   minRating: rating,
                      //   direction: Axis.horizontal,
                      //   allowHalfRating: false,
                      //   itemCount: 5,
                      //   itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                      //   itemBuilder: (context, _) => const Icon(
                      //     Icons.star,
                      //     color: Colors.amber,
                      //   ),
                      //   onRatingUpdate: (rating) {
                      //     setState(() {
                      //       this.rating = rating;
                      //     });
                      //   },
                      // ),
                      const SizedBox(height: 15),
                      Consumer<RatingController>(
                        builder: (context, model, child) {
                          return Text(model.comment??"");
                        },
                      )
                      //Text(ratingUpdate().toString()),
                    ],
                  ),
                  actions: [
                    TextField(
                      controller: model.textController,
                      maxLines: 5,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7),
                        ),
                        hintText: "Type minimum 30 character",
                        //hintMaxLines: 3,
                      ),
                    ),
                    Consumer<RatingController>(
                      builder: (context, model, child) {
                        return ElevatedButton(
                            onPressed: () {
                              //model.updateRatting(ratting: 0);
                              // model.updateRatting();
                              model.textController.clear();
                              model.sendRatingToserver(context,getProfileController?.getProfileModel?.data?.user?.fullName??"",getProfileController?.getProfileModel?.data?.user?.email??"",getProfileController?.getProfileModel?.data?.user?.profileId,);
                              //Navigator.pop(context);
                              //Navigator.push(context, )
                            },
                            child: const Text('ok'));
                      },
                    ),
                  ],
                );
              });
            });
      },
    );
  }
  Widget getBody() {
    List<Widget> pages = [
      Container(
        alignment: Alignment.center,
        child:const DashBoardScreen()
      ),
      Container(
        alignment: Alignment.center,
        child: MyInterest()
      ),
      Container(
        alignment: Alignment.center,
        child:Search()
      ),
      Container(
        alignment: Alignment.center,
        child: FrostedDemo()
      ),
      Container(
        alignment: Alignment.center,
        child: const Text("Settings",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
      ),
    ];
    return IndexedStack(
      index: _currentIndex,
      children: pages,
    );
  }
  Future<void> _launchUrl() async {
    if (!await launchUrl(Uri.parse("https://www.himrishtey.com"))) {
      throw 'Could not launch ';
    }
  }
  _launchCaller(phone) async {
    var url = "tel:$phone";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

}

void showCustomDialog(BuildContext context) {
  showGeneralDialog(
    context: context,
    barrierLabel: "Barrier",
    barrierDismissible: true,
    barrierColor: Colors.black.withOpacity(0.5),
    transitionDuration: Duration(milliseconds: 700),
    pageBuilder: (_, __, ___) {
      return AlertDialog(
          title: const Text("Rate Us"),
      content:Container(
        height: AppConfig.height*0.15,
        child: Column(children: [
          Text("Thanks for liking us please take some time to rate us on playstore"),
          Container(
              alignment: Alignment.bottomRight,
              child: ElevatedButton(onPressed: (){}, child: Text("Rate now"),style: ElevatedButton.styleFrom(primary: Colors.blueAccent),))
        ],),
        margin: EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(40)),
      ));
    },
    transitionBuilder: (_, anim, __, child) {
      Tween<Offset> tween;
      if (anim.status == AnimationStatus.reverse) {
        tween = Tween(begin: Offset(-1, 0), end: Offset.zero);
      } else {
        tween = Tween(begin: Offset(1, 0), end: Offset.zero);
      }

      return SlideTransition(
        position: tween.animate(anim),
        child: FadeTransition(
          opacity: anim,
          child: Container(child: child),
        ),
      );
    },
  );
}
