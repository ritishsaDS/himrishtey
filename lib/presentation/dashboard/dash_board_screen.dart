import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:rishtey/controller/auth_controller.dart';
import 'package:rishtey/controller/get_profile_controller.dart';
import 'package:rishtey/presentation/all_search/advance_search.dart';
import 'package:rishtey/presentation/dashboard/view_all_profile.dart';
import 'package:rishtey/presentation/dashboard/widget/form_attributes.dart';
import 'package:rishtey/presentation/dashboard/widget/interest_profile.dart';
import 'package:rishtey/presentation/dynamic_pop_ups/first_pop_up.dart';
import 'package:rishtey/presentation/membership/membership_screen.dart';
import 'package:rishtey/presentation/profile/delete_account_reason.dart';
import 'package:rishtey/presentation/profile/personal_profile.dart';
import 'package:rishtey/presentation/register/reset_password.dart';
import 'package:rishtey/utils/app_config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../controller/dashboard_controller.dart';
import '../all_search/all_search/show_searches/search_dialog_box.dart';
import '../edit_screens/user_gallery/gallery.dart';
import '../login/login_2.dart';
import '../login/verify_mobile_number.dart';
import '../membership/wallet_screen.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({Key? key}) : super(key: key);

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  DashBoardController? dashBoardController;
  AuthController? authController;
  GetProfileController? getProfileController;
  var name = [
    "Basic Info",
    "Kundli & Astro",
    "Contact Details and ads",
    "Religion & Background",
    "Education Details",
    "Career",
    "Family Details",
    "Lifestyle",
    "Gallery",
    "Partner Prefrences"
  ];
  var desc = [
    "Describe your basic information",
    "Please fill up your Horoscope detail",
    "",
    "Enter religion and your background information from here",
    "Enter your educational details for a best educational match for you",
    "Fill Here about your career",
    "Edit about your family",
    "Write about your lifestyle",
    "Upload your photos from here and manage your  photo gallery",
    "What kind of life partner do you want please edit here"
  ];
  var photo = [
    "assets/pngIcons/info.png",
    "assets/pngIcons/kundli.png",
    "assets/pngIcons/contact.png",
    "assets/pngIcons/religion.png",
    "assets/pngIcons/graduation-cap.png",
    "assets/pngIcons/career-path.png",
    "assets/pngIcons/family.png",
    "assets/pngIcons/daily-health-app.png",
    "assets/pngIcons/copy.png",
    "assets/pngIcons/business.png"
  ];
  late List<dynamic> menuItems;

  @override
  void initState() {


    Future.delayed(const Duration(milliseconds: 100), () {
      dashBoardController =
          Provider.of<DashBoardController>(context, listen: false);
      authController = Provider.of<AuthController>(context, listen: false);
      getProfileController =
          Provider.of<GetProfileController>(context, listen: false);
      getProfileController!.getProfile(context);
      dashBoardController!.showPopUp(context);
      dashBoardController!.getDashBoardProfiles(context, "Male");
      dashBoardController!.getVerifiedProfiles(context);
      dashBoardController!.getMatchingProfiles(context);
      dashBoardController!.getShortlistedProfiles(context);

      authController!.getReligion(context);
      authController!.getCastes(context);
    });
    Future.delayed(const Duration(seconds: 5), () {
      show();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    AppConfig.init(context);
    return Scaffold(
      appBar: AppBar(
        leading: Container(
          width: 0,
        ),
        leadingWidth: 0,
        centerTitle: true,
        title: Consumer<GetProfileController>(
            builder: (context, controller, child) {
          return Row(
            children: [
              controller.isLoading
                  ? Container()
                  : Text(
                      "Hi , ${(controller.getProfileModel?.data?.user?.fullName)}",
                      style: TextStyle(fontSize: 15),
                    )
            ],
          );
        }),
        actions: [
          const SizedBox(
            width: 10,
          ),
          const Icon(
            Icons.notifications_active,
            size: 22,
          ),
          const SizedBox(
            width: 5,
          ),
          //Icon(Icons.settings),
          // SizedBox(
          //   width: 20,
          // ),

          PopupMenuButton<int>(
            icon: const Icon(Icons.settings, size: 22),
            itemBuilder: (context) => [
              // popupmenu item 1
              PopupMenuItem(
                value: 1,
                onTap: () {
                  showPrivacyDialog(context);
                },
                // row has two child icon and text.
                child: Row(
                  children: [
                    const Icon(
                      Icons.privacy_tip,
                      color: Colors.black,
                    ),
                    const SizedBox(
                      // sized box with width 10
                      width: 10,
                    ),
                    GestureDetector(
                        onTap: () {
                          showPrivacyDialog(context);
                        },
                        child: const Text(
                          "Privacy Settings",
                        ))
                  ],
                ),
              ),
              PopupMenuItem(
                value: 1,
                // row has two child icon and text.
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ResetPassword()));
                  },
                  child: Row(
                    children: const [
                      Icon(Icons.password, color: Colors.black),
                      SizedBox(
                        // sized box with width 10
                        width: 10,
                      ),
                      Text("Change Password")
                    ],
                  ),
                ),
              ),
              // popupmenu item 2
              PopupMenuItem(
                value: 2,
                // row has two child icon and text
                child: GestureDetector(
                  onTap: () {
                    displayHideProfileDialog(context);
                  },
                  child: Row(
                    children: const [
                      Icon(Icons.hide_image, color: Colors.black),
                      SizedBox(
                        // sized box with width 10
                        width: 10,
                      ),
                      Text("Hide Profile")
                    ],
                  ),
                ),
              ),
              PopupMenuItem(
                value: 2,
                // row has two child icon and text
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const DeleteAccountReason()));
                  },
                  child: Row(
                    children: const [
                      Icon(Icons.delete_sweep_sharp, color: Colors.black),
                      SizedBox(
                        // sized box with width 10
                        width: 10,
                      ),
                      Text("Delete Profile")
                    ],
                  ),
                ),
              ),
              PopupMenuItem(
                value: 1,
                // row has two child icon and text.
                child: GestureDetector(
                  onTap: () async {
                    // authController?.signOut();
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.clear();
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => LoginPage2()));
                  },
                  child: Row(
                    children: const [
                      Icon(Icons.password, color: Colors.black),
                      SizedBox(
                        // sized box with width 10
                        width: 10,
                      ),
                      Text("Logout")
                    ],
                  ),
                ),
              ),
            ],
            offset: const Offset(0, 30),
            color: Colors.white,
            elevation: 2,
          ),

          Center(
              child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => WalletScreen()));
                  },
                  child: Image.asset(
                    "assets/pngIcons/wallet.png",
                    width: AppConfig.width * 0.06,
                    height: AppConfig.height * 0.08,
                  ))),
          const SizedBox(
            width: 5,
          ),
          Consumer<GetProfileController>(builder: (context, controller, child) {
            return Center(
                child: Text(
              getProfileController?.getProfileModel?.data!.user!.walletAmount ??
                  "",
              style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
            ));
          }),
          const SizedBox(
            width: 10,
          )
        ],
      ),
      floatingActionButton:
          Column(mainAxisAlignment: MainAxisAlignment.end, children: [
        FloatingActionButton(
          child: const Icon(Icons.chat),
          onPressed: () {
            _launchUrl();
          },
          heroTag: null,
        ),
        const SizedBox(
          height: 20,
        ),
        FloatingActionButton(
          backgroundColor: Colors.pinkAccent,
          child: const Icon(Icons.search),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const AdvanceSearch()));
          },
          heroTag: null,
        )
      ]),
      body:
          Consumer<GetProfileController>(builder: (context, controller, child) {
        return Container(
          child: Stack(
            children: [
              controller.getProfileModel?.data?.user?.activation == "Banned"
                  ? Consumer<GetProfileController>(
                      builder: (context, controller, child) {
                      return Container(
                          alignment: Alignment.centerRight,
                          width: AppConfig.width,
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                  color: AppConfig.theme.primaryColor)),
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Gallery()));
                                  },
                                  child: Stack(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                            image: NetworkImage(
                                                "https://webtechworlds.com/himrishtey/photos/photo/" +
                                                    controller.getProfileModel!
                                                        .data!.user!.photo
                                                        .toString()
                                                        .replaceAll(
                                                            "file:///", "")),
                                          ),
                                          color: AppConfig.theme.primaryColor,
                                        ),
                                        width: AppConfig.width * 0.25,
                                        height: AppConfig.height * 0.12,
                                      ),
                                      const Positioned(
                                        bottom: 5,
                                        right: 5,
                                        child: CircleAvatar(
                                          radius: 13,
                                          backgroundColor: Colors.green,
                                          child: Icon(
                                            Icons.add,
                                            color: Colors.white,
                                            size: 20,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  width: 40,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: AppConfig.width * 0.23,
                                          child: Text(
                                            "Name:",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w800,
                                                fontSize:
                                                    AppConfig.width * 0.045),
                                          ),
                                        ),
                                        Text(
                                          controller.getProfileModel?.data?.user
                                                  ?.fullName ??
                                              "",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w800,
                                              fontSize: AppConfig.width * 0.05),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: AppConfig.width * 0.23,
                                          child: Text(
                                            "Account:",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w800,
                                                fontSize:
                                                    AppConfig.width * 0.045),
                                          ),
                                        ),
                                        Text(
                                          controller.getProfileModel?.data?.user
                                                      ?.active ==
                                                  ""
                                              ? "Free"
                                              : controller.getProfileModel?.data
                                                      ?.user?.active ??
                                                  "Free",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w800,
                                              fontSize: AppConfig.width * 0.05),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: AppConfig.width * 0.23,
                                          child: Text(
                                            "Profile ID:",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w800,
                                                fontSize:
                                                    AppConfig.width * 0.045),
                                          ),
                                        ),
                                        Text(
                                          controller.getProfileModel?.data?.user
                                                  ?.profileId ??
                                              "",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w800,
                                              fontSize: AppConfig.width * 0.05),
                                        ),
                                      ],
                                    )
                                  ],
                                )
                              ]),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: AppConfig.width * 0.5,
                                  ),
                                  GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    PersonalProfile()));
                                      },
                                      child: Text(
                                        "Edit Profile+",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w800,
                                            fontSize: 16,
                                            color: AppConfig.theme.primaryColor,
                                            decoration:
                                                TextDecoration.underline),
                                      )),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const SizedBox(
                                    width: 50,
                                  ),
                                  GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    MemberShipScreen()));
                                        // openCheckout();
                                      },
                                      child: Container(
                                        width: AppConfig.width * 0.5,
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: getProfileController
                                                      ?.getProfileModel
                                                      ?.data
                                                      ?.user
                                                      ?.activation ==
                                                  "Banned"
                                              ? Colors.black
                                              : getProfileController
                                                          ?.getProfileModel
                                                          ?.data
                                                          ?.user
                                                          ?.userType ==
                                                      "Yes"
                                                  ? Colors.green
                                                  : Colors.red,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Column(
                                          children: [
                                            getProfileController
                                                        ?.getProfileModel
                                                        ?.data
                                                        ?.user
                                                        ?.activation ==
                                                    "Banned"
                                                ? Text(
                                                    "Banned",
                                                    style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16),
                                                  )
                                                : Text(
                                                    getProfileController
                                                                ?.getProfileModel
                                                                ?.data
                                                                ?.user
                                                                ?.userType ==
                                                            "Yes"
                                                        ? "Active"
                                                        : "Active Now",
                                                    style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16),
                                                  ),
                                            // const Text("Click Here to Avtivate your profile",style: TextStyle(color: Colors.white),),
                                          ],
                                        ),
                                      )),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Image.network(
                                controller.getProfileModel?.data?.user
                                        ?.memberType ??
                                    "",
                                scale: 7,
                              ),
                              Text(
                                "${controller.getProfileModel?.data?.user?.memType}",
                                style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    color: AppConfig.theme.primaryColor,
                                    decoration: TextDecoration.underline),
                              ),
                              SizedBox(height: 50,),
                              Opacity(
                                  opacity: 0.6,
                                  child: Image.asset("assets/pngIcons/block.png",height: AppConfig.height*0.2,)),
                              Center(child: Text("Your Account is Banned \n Please Contact with our team",textAlign: TextAlign.center,style: TextStyle(fontSize: 18,fontWeight: FontWeight.w800),),)
                            ],
                          ));
//                                       Column(
//                                         crossAxisAlignment: CrossAxisAlignment
//                                             .center,
//                                         mainAxisAlignment: MainAxisAlignment
//                                             .end,
//                                         children: [
//
//                                           Row(
//                                             crossAxisAlignment: CrossAxisAlignment
//                                                 .center,
//                                             mainAxisAlignment: MainAxisAlignment
//                                                 .start,
//                                             children: [
//                                              SizedBox(width:AppConfig.width*0.2,),
//                                             Stack(
//                                               children: [
//
//                                                 Container(
//                                                   decoration: BoxDecoration(
//                                                     shape: BoxShape.circle,
//                                                     image: DecorationImage(
//                                                       image: NetworkImage(
//                                                           controller.getProfileModel?.data?.user?.photo??""),),
//                                                     color: AppConfig.theme
//                                                         .primaryColor,
//
//                                                   ),
//                                                   width: AppConfig.width * 0.18,
//                                                   height: AppConfig.height *
//                                                       0.12,
//
//
//                                                 ),
//                                                 const Positioned(
//                                                   bottom: 5,
//                                                   right: 15,
//                                                   child: CircleAvatar(
//                                                     radius: 13,
//                                                     backgroundColor: Colors
//                                                         .green,
//                                                     child: Icon(Icons.add,
//                                                       color: Colors.white,
//                                                       size: 20,),
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                            const SizedBox(width: 10,),
//                                             Text("Name:"),
//                                             Text(
//                                               controller.getProfileModel?.data?.user?.fullName??"",
//                                               style: TextStyle(
//                                                   color: Colors.black,
//                                                   fontWeight: FontWeight.w800,
//                                                   fontSize: AppConfig.width *
//                                                       0.05),),
//                                             const Spacer(),
//
//                                           ],),
//                                           Row(children: [
//                                             SizedBox(width:AppConfig.width*0.2,),
//                                             const Text("Id:"),
//                                             Text(
//                                               controller.getProfileModel?.data?.user?.profileId??"",
//                                               style: TextStyle(
//                                                   color: Colors.black,
//                                                   fontWeight: FontWeight.w800,
//                                                   fontSize: AppConfig.width *
//                                                       0.05),),
//
//                                           ],),
//                                           Row(children: [
//                                             SizedBox(width:AppConfig.width*0.2,),
//
//                                             const Text("Account"),
//                                             Text(
//                                               controller.getProfileModel?.data?.user!.gender??"",
//                                               style: TextStyle(
//                                                   color: Colors.black,
//                                                   fontWeight: FontWeight.w800,
//                                                   fontSize: AppConfig.width *
//                                                       0.05),),
//                                             // const Spacer(),
//                                             // const Text("Gotra/ "),
//                                             // Text(
//                                             //   controller.getProfileModel!.data!
//                                             //       .user!.gotra!,
//                                             //   style: TextStyle(
//                                             //       color: Colors.black,
//                                             //       fontWeight: FontWeight.w800,
//                                             //       fontSize: AppConfig.width *
//                                             //           0.05),),
//                                           ],),
//                                           // Row(children: [
//                                           //    SizedBox(width: AppConfig.screenWidth*0.4,),
//                                           //
//                                           //   Text(
//                                           //     controller.getProfileModel!.data!
//                                           //         .user!.birthDateTime!.toString().substring(0,10),
//                                           //     style: TextStyle(
//                                           //         color: Colors.black,
//                                           //         fontWeight: FontWeight.w800,
//                                           //         fontSize: AppConfig.width *
//                                           //             0.05),),
//                                           //   const Spacer(),
//                                           //   const Text("Community- "),
//                                           //   Text(
//                                           //     controller.getProfileModel!.data!
//                                           //         .user!.cast!, style: TextStyle(
//                                           //       color: Colors.black,
//                                           //       fontWeight: FontWeight.w800,
//                                           //       fontSize: AppConfig.width *
//                                           //           0.05),),
//                                           // ],),
// SizedBox(height: 10,),
//                                           GestureDetector(
//                                               onTap: () {
//                                                // openCheckout();
//                                               },
//                                               child: Container(
//                                                 padding:const EdgeInsets.all(10),
//                                                 decoration: BoxDecoration(
//                                                   color: AppConfig.theme.primaryColor,
//                                                   borderRadius:
//                                                   BorderRadius.circular(20),
//                                                 ),
//                                                 child: Column(
//                                                   children: [
//                                                     const Text("Activate Now",style: const TextStyle(color: Colors.white,fontSize: 16),),
//                                                    // const Text("Click Here to Avtivate your profile",style: TextStyle(color: Colors.white),),
//
//                                                   ],
//                                                 ),
//                                               )),
//                                           SizedBox(height: 10,),
//                                           Text("Edit Profile+",style: TextStyle(fontWeight: FontWeight.w800,color: AppConfig.theme.primaryColor,decoration: TextDecoration.underline),)
//                                       ,SizedBox(height: 10,)
//                                     ,Image.network(controller.getProfileModel?.data?.user?.memberType??"",scale: 7,),
//                                     Text("Trusted",style: TextStyle(fontWeight: FontWeight.w800,color: AppConfig.theme.primaryColor,decoration: TextDecoration.underline),)
//                                     ],
//                                       ),);
                    })
                  : Consumer<DashBoardController>(
                      builder: (context, controller, child) {
                      return controller.isLoading
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : Opacity(
                              opacity: controller.showLotie ? 0.4 : 1,
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                height: MediaQuery.of(context).size.height,
                                child: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Consumer<GetProfileController>(builder:
                                          (context, controller, child) {
                                        return Container(
                                            alignment: Alignment.centerRight,
                                            width: AppConfig.width,
                                            margin: const EdgeInsets.symmetric(
                                                vertical: 10),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                border: Border.all(
                                                    color: AppConfig
                                                        .theme.primaryColor)),
                                            padding: const EdgeInsets.all(8),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Row(children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder:
                                                                  (context) =>
                                                                      Gallery()));
                                                    },
                                                    child: Stack(
                                                      children: [
                                                        Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            shape:
                                                                BoxShape.circle,
                                                            image:
                                                                DecorationImage(
                                                              image: NetworkImage("https://webtechworlds.com/himrishtey/photos/photo/" +
                                                                  controller
                                                                      .getProfileModel!
                                                                      .data!
                                                                      .user!
                                                                      .photo
                                                                      .toString()
                                                                      .replaceAll(
                                                                          "file:///",
                                                                          "")),
                                                            ),
                                                            color: AppConfig
                                                                .theme
                                                                .primaryColor,
                                                          ),
                                                          width:
                                                              AppConfig.width *
                                                                  0.25,
                                                          height:
                                                              AppConfig.height *
                                                                  0.12,
                                                        ),
                                                        const Positioned(
                                                          bottom: 5,
                                                          right: 5,
                                                          child: CircleAvatar(
                                                            radius: 13,
                                                            backgroundColor:
                                                                Colors.green,
                                                            child: Icon(
                                                              Icons.add,
                                                              color:
                                                                  Colors.white,
                                                              size: 20,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 40,
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          SizedBox(
                                                            width: AppConfig
                                                                    .width *
                                                                0.23,
                                                            child: Text(
                                                              "Name:",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w800,
                                                                  fontSize: AppConfig
                                                                          .width *
                                                                      0.045),
                                                            ),
                                                          ),
                                                          Text(
                                                            controller
                                                                    .getProfileModel
                                                                    ?.data
                                                                    ?.user
                                                                    ?.fullName ??
                                                                "",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w800,
                                                                fontSize: AppConfig
                                                                        .width *
                                                                    0.05),
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          SizedBox(
                                                            width: AppConfig
                                                                    .width *
                                                                0.23,
                                                            child: Text(
                                                              "Account:",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w800,
                                                                  fontSize: AppConfig
                                                                          .width *
                                                                      0.045),
                                                            ),
                                                          ),
                                                          Text(
                                                            controller
                                                                        .getProfileModel
                                                                        ?.data
                                                                        ?.user
                                                                        ?.active ==
                                                                    ""
                                                                ? "Free"
                                                                : controller
                                                                        .getProfileModel
                                                                        ?.data
                                                                        ?.user
                                                                        ?.active ??
                                                                    "Free",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w800,
                                                                fontSize: AppConfig
                                                                        .width *
                                                                    0.05),
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          SizedBox(
                                                            width: AppConfig
                                                                    .width *
                                                                0.23,
                                                            child: Text(
                                                              "Profile ID:",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w800,
                                                                  fontSize: AppConfig
                                                                          .width *
                                                                      0.045),
                                                            ),
                                                          ),
                                                          Text(
                                                            controller
                                                                    .getProfileModel
                                                                    ?.data
                                                                    ?.user
                                                                    ?.profileId ??
                                                                "",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w800,
                                                                fontSize: AppConfig
                                                                        .width *
                                                                    0.05),
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  )
                                                ]),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    SizedBox(
                                                      width:
                                                          AppConfig.width * 0.5,
                                                    ),
                                                    GestureDetector(
                                                        onTap: () {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          PersonalProfile()));
                                                        },
                                                        child: Text(
                                                          "Edit Profile+",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w800,
                                                              fontSize: 16,
                                                              color: AppConfig
                                                                  .theme
                                                                  .primaryColor,
                                                              decoration:
                                                                  TextDecoration
                                                                      .underline),
                                                        )),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    const SizedBox(
                                                      width: 50,
                                                    ),
                                                    GestureDetector(
                                                        onTap: () {
                                                          if(getProfileController?.getProfileModel?.data?.user?.userType !=
                                                              "Yes"){
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          MemberShipScreen()));}
                                                          // openCheckout();
                                                        },
                                                        child: Container(
                                                          width:
                                                              AppConfig.width *
                                                                  0.5,
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(10),
                                                          decoration:
                                                              BoxDecoration(
                                                            color: getProfileController
                                                                        ?.getProfileModel
                                                                        ?.data
                                                                        ?.user
                                                                        ?.activation ==
                                                                    "Banned"
                                                                ? Colors.black
                                                                : getProfileController
                                                                            ?.getProfileModel
                                                                            ?.data
                                                                            ?.user
                                                                            ?.userType ==
                                                                        "Yes"
                                                                    ? Colors
                                                                        .green
                                                                    : Colors
                                                                        .red,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                          ),
                                                          child: Column(
                                                            children: [
                                                              getProfileController
                                                                          ?.getProfileModel
                                                                          ?.data
                                                                          ?.user
                                                                          ?.activation ==
                                                                      "Banned"
                                                                  ? Text(
                                                                      "Banned",
                                                                      style: const TextStyle(
                                                                          color: Colors
                                                                              .white,
                                                                          fontSize:
                                                                              16),
                                                                    )
                                                                  : Text(
                                                                      getProfileController?.getProfileModel?.data?.user?.userType ==
                                                                              "Yes"
                                                                          ? "Active"
                                                                          : "Active Now",
                                                                      style: const TextStyle(
                                                                          color: Colors
                                                                              .white,
                                                                          fontSize:
                                                                              16),
                                                                    ),
                                                              // const Text("Click Here to Avtivate your profile",style: TextStyle(color: Colors.white),),
                                                            ],
                                                          ),
                                                        )),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Image.network(
                                                  controller
                                                          .getProfileModel
                                                          ?.data
                                                          ?.user
                                                          ?.memberType ??
                                                      "",
                                                  scale: 7,
                                                ),
                                                Text(
                                                  "${controller.getProfileModel?.data?.user?.memType}",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w800,
                                                      color: AppConfig
                                                          .theme.primaryColor,
                                                      decoration: TextDecoration
                                                          .underline),
                                                )
                                              ],
                                            ));
//                                       Column(
//                                         crossAxisAlignment: CrossAxisAlignment
//                                             .center,
//                                         mainAxisAlignment: MainAxisAlignment
//                                             .end,
//                                         children: [
//
//                                           Row(
//                                             crossAxisAlignment: CrossAxisAlignment
//                                                 .center,
//                                             mainAxisAlignment: MainAxisAlignment
//                                                 .start,
//                                             children: [
//                                              SizedBox(width:AppConfig.width*0.2,),
//                                             Stack(
//                                               children: [
//
//
//                                                 Container(
//                                                   decoration: BoxDecoration(
//                                                     shape: BoxShape.circle,
//                                                     image: DecorationImage(
//                                                       image: NetworkImage(
//                                                           controller.getProfileModel?.data?.user?.photo??""),),
//                                                     color: AppConfig.theme
//                                                         .primaryColor,
//
//                                                   ),
//                                                   width: AppConfig.width * 0.18,
//                                                   height: AppConfig.height *
//                                                       0.12,
//
//
//                                                 ),
//                                                 const Positioned(
//                                                   bottom: 5,
//                                                   right: 15,
//                                                   child: CircleAvatar(
//                                                     radius: 13,
//                                                     backgroundColor: Colors
//                                                         .green,
//                                                     child: Icon(Icons.add,
//                                                       color: Colors.white,
//                                                       size: 20,),
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                            const SizedBox(width: 10,),
//                                             Text("Name:"),
//                                             Text(
//                                               controller.getProfileModel?.data?.user?.fullName??"",
//                                               style: TextStyle(
//                                                   color: Colors.black,
//                                                   fontWeight: FontWeight.w800,
//                                                   fontSize: AppConfig.width *
//                                                       0.05),),
//                                             const Spacer(),
//
//                                           ],),
//                                           Row(children: [
//                                             SizedBox(width:AppConfig.width*0.2,),
//                                             const Text("Id:"),
//                                             Text(
//                                               controller.getProfileModel?.data?.user?.profileId??"",
//                                               style: TextStyle(
//                                                   color: Colors.black,
//                                                   fontWeight: FontWeight.w800,
//                                                   fontSize: AppConfig.width *
//                                                       0.05),),
//
//                                           ],),
//                                           Row(children: [
//                                             SizedBox(width:AppConfig.width*0.2,),
//
//                                             const Text("Account"),
//                                             Text(
//                                               controller.getProfileModel?.data?.user!.gender??"",
//                                               style: TextStyle(
//                                                   color: Colors.black,
//                                                   fontWeight: FontWeight.w800,
//                                                   fontSize: AppConfig.width *
//                                                       0.05),),
//                                             // const Spacer(),
//                                             // const Text("Gotra/ "),
//                                             // Text(
//                                             //   controller.getProfileModel!.data!
//                                             //       .user!.gotra!,
//                                             //   style: TextStyle(
//                                             //       color: Colors.black,
//                                             //       fontWeight: FontWeight.w800,
//                                             //       fontSize: AppConfig.width *
//                                             //           0.05),),
//                                           ],),
//                                           // Row(children: [
//                                           //    SizedBox(width: AppConfig.screenWidth*0.4,),
//                                           //
//                                           //   Text(
//                                           //     controller.getProfileModel!.data!
//                                           //         .user!.birthDateTime!.toString().substring(0,10),
//                                           //     style: TextStyle(
//                                           //         color: Colors.black,
//                                           //         fontWeight: FontWeight.w800,
//                                           //         fontSize: AppConfig.width *
//                                           //             0.05),),
//                                           //   const Spacer(),
//                                           //   const Text("Community- "),
//                                           //   Text(
//                                           //     controller.getProfileModel!.data!
//                                           //         .user!.cast!, style: TextStyle(
//                                           //       color: Colors.black,
//                                           //       fontWeight: FontWeight.w800,
//                                           //       fontSize: AppConfig.width *
//                                           //           0.05),),
//                                           // ],),
// SizedBox(height: 10,),
//                                           GestureDetector(
//                                               onTap: () {
//                                                // openCheckout();
//                                               },
//                                               child: Container(
//                                                 padding:const EdgeInsets.all(10),
//                                                 decoration: BoxDecoration(
//                                                   color: AppConfig.theme.primaryColor,
//                                                   borderRadius:
//                                                   BorderRadius.circular(20),
//                                                 ),
//                                                 child: Column(
//                                                   children: [
//                                                     const Text("Activate Now",style: const TextStyle(color: Colors.white,fontSize: 16),),
//                                                    // const Text("Click Here to Avtivate your profile",style: TextStyle(color: Colors.white),),
//
//                                                   ],
//                                                 ),
//                                               )),
//                                           SizedBox(height: 10,),
//                                           Text("Edit Profile+",style: TextStyle(fontWeight: FontWeight.w800,color: AppConfig.theme.primaryColor,decoration: TextDecoration.underline),)
//                                       ,SizedBox(height: 10,)
//                                     ,Image.network(controller.getProfileModel?.data?.user?.memberType??"",scale: 7,),
//                                     Text("Trusted",style: TextStyle(fontWeight: FontWeight.w800,color: AppConfig.theme.primaryColor,decoration: TextDecoration.underline),)
//                                     ],
//                                       ),);
                                      }),
                                      Container(
                                        color: AppConfig.theme.primaryColor
                                            .withOpacity(0.4),
                                        padding: const EdgeInsets.all(10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Complete your Profile for more response",
                                              style: textTheme.headline6!
                                                  .copyWith(fontSize: 16),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                                "Please complete your profile 100% for 2x matches",
                                                style: textTheme.bodyText1),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                CircleAvatar(
                                                  radius: 20,
                                                  child:
                                                      const Icon(Icons.person),
                                                  backgroundColor:
                                                      Colors.grey.shade200,
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Consumer<
                                                            GetProfileController>(
                                                        builder: (context,
                                                            controller, child) {
                                                      return Text(
                                                        "Your Profile Score ${controller.getProfileModel?.data?.user?.profileCompleted}%",
                                                        style: textTheme
                                                            .headline3!
                                                            .copyWith(
                                                                fontSize: 15),
                                                      );
                                                    }),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              .7,
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
                                                )
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            SizedBox(
                                              height: AppConfig.height * 0.18,
                                              child: ListView.builder(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  return FormAttributes(
                                                      name: name[index],
                                                      photo: photo[index],
                                                      desc: desc[index]);
                                                },
                                                itemCount: name.length,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      getProfileController?.getProfileModel
                                                  ?.data?.user?.userType ==
                                              "Yes"
                                          ? Container()
                                          : GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            VerifyMobileNumber()));
                                              },
                                              child: Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Stack(
                                                        children: [
                                                          Image.asset(
                                                            "assets/pngIcons/verify.png",
                                                            width: AppConfig
                                                                    .width *
                                                                0.1,
                                                          ),
                                                          const Positioned(
                                                              top: 2,
                                                              right: 1,
                                                              child:
                                                                  const CircleAvatar(
                                                                backgroundColor:
                                                                    Colors.red,
                                                                radius: 5,
                                                              ))
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                        width: 10,
                                                      ),
                                                      Text(
                                                        "Verify your mobile and email address",
                                                        style: textTheme
                                                            .headline3!
                                                            .copyWith(
                                                                fontSize: 15),
                                                      ),
                                                      //  Spacer(),
                                                    ],
                                                  ),
                                                  Text(
                                                      "If you want to become our verified member , please verify your mobile number or email address",
                                                      style:
                                                          textTheme.bodyText1)
                                                ],
                                              ),
                                            ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Column(
                                        children: [
                                          Row(
                                            children: [
                                              Image.asset(
                                                "assets/pngIcons/reliability.png",
                                                width: AppConfig.width * 0.1,
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                "Verify your profile",
                                                style: textTheme.headline3!
                                                    .copyWith(fontSize: 15),
                                              )
                                            ],
                                          ),
                                          Text(
                                              "If you want to show your profile as a trusted profile , please verify your profile",
                                              style: textTheme.bodyText1)
                                        ],
                                      ),
                                      const Divider(
                                        thickness: 2,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Verified Profiles ",
                                              style: textTheme.headline6!
                                                  .copyWith(fontSize: 16),
                                            ),
                                            GestureDetector(
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              ViewProfiles(
                                                                title:
                                                                    "Verified Profiles",
                                                                user: controller
                                                                    .verifiedProfileModel!,
                                                              )));
                                                },
                                                child: Text(
                                                  "View All>>",
                                                  style: TextStyle(
                                                      color: AppConfig
                                                          .theme.primaryColor,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ))
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.22,
                                        child: CarouselSlider.builder(
                                            options: CarouselOptions(
                                                autoPlay: true,
                                                viewportFraction: 0.9),
                                            // scrollDirection: Axis.horizontal,
                                            itemCount: (controller
                                                        .verifiedProfileModel
                                                        ?.user ??
                                                    [])
                                                .length,
                                            itemBuilder: (BuildContext context,
                                                int index, int pageViewIndex) {
                                              return InterestProfile(
                                                data: controller
                                                    .verifiedProfileModel!.user!
                                                    .elementAt(index),
                                                index: index,
                                              );
                                            }),
                                      ),
                                      SizedBox(
                                        height: AppConfig.height * 0.03,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Recent Profiles ",
                                              style: textTheme.headline6!
                                                  .copyWith(fontSize: 16),
                                            ),
                                            GestureDetector(
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              ViewProfiles(
                                                                title:
                                                                    "Recent Profiles",
                                                                user: controller
                                                                    .dashBoardProfilesModel,
                                                              )));
                                                },
                                                child: Text(
                                                  "View All>>",
                                                  style: TextStyle(
                                                      color: AppConfig
                                                          .theme.primaryColor,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ))
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.22,
                                        child: CarouselSlider.builder(
                                            options: CarouselOptions(
                                                autoPlay: true,
                                                viewportFraction: 0.9),
                                            itemCount: (controller
                                                        .dashBoardProfilesModel
                                                        ?.user ??
                                                    [])
                                                .length,
                                            itemBuilder: (BuildContext context,
                                                int index, int pageViewIndex) {
                                              return InterestProfile(
                                                  index: index,
                                                  data: controller
                                                      .dashBoardProfilesModel!
                                                      .user!
                                                      .elementAt(index));
                                            }),
                                      ),
                                      SizedBox(
                                        height: AppConfig.height * 0.03,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Matching Profiles ",
                                              style: textTheme.headline6!
                                                  .copyWith(fontSize: 16),
                                            ),
                                            GestureDetector(
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              ViewProfiles(
                                                                title:
                                                                    "Matching Profiles",
                                                                user: controller
                                                                    .matchingProfilesModel,
                                                              )));
                                                },
                                                child: Text(
                                                  "View All>>",
                                                  style: TextStyle(
                                                      color: AppConfig
                                                          .theme.primaryColor,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ))
                                          ],
                                        ),
                                      ),
                                      Text(
                                        "Matches Suggested Just For You",
                                        style: textTheme.bodyText1!.copyWith(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w800),
                                      ),
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.22,
                                        child: controller
                                                        .matchingProfilesModel ==
                                                    null ||
                                                controller.matchingProfilesModel
                                                        ?.user!.length ==
                                                    0
                                            ? const Center(
                                                child: Text("No Data Found"),
                                              )
                                            : CarouselSlider.builder(
                                                options: CarouselOptions(
                                                    autoPlay: true,
                                                    viewportFraction: 0.9),
                                                itemCount: (controller
                                                            .matchingProfilesModel
                                                            ?.user ??
                                                        [])
                                                    .length,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index,
                                                        int pageIndex) {
                                                  return InterestProfile(
                                                      index: index,
                                                      data: controller
                                                          .matchingProfilesModel!
                                                          .user!
                                                          .elementAt(index));
                                                }),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Shortlisted Profiles ",
                                              style: textTheme.headline6!
                                                  .copyWith(fontSize: 16),
                                            ),
                                            GestureDetector(
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              ViewProfiles(
                                                                title:
                                                                    "Matching Profiles",
                                                                user: controller
                                                                    .matchingProfilesModel,
                                                              )));
                                                },
                                                child: Text(
                                                  "View All>>",
                                                  style: TextStyle(
                                                      color: AppConfig
                                                          .theme.primaryColor,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ))
                                          ],
                                        ),
                                      ),
                                      Text(
                                        "Matches Suggested Just For You",
                                        style: textTheme.bodyText1!.copyWith(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w800),
                                      ),
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.22,
                                        child: controller
                                                        .shortlistedProfileModel ==
                                                    null ||
                                                controller
                                                        .shortlistedProfileModel
                                                        ?.user!
                                                        .length ==
                                                    0
                                            ? const Center(
                                                child: Text("No Data Found"),
                                              )
                                            : CarouselSlider.builder(
                                                options: CarouselOptions(
                                                    autoPlay: true,
                                                    viewportFraction: 0.9),
                                                itemCount: (controller
                                                            .shortlistedProfileModel
                                                            ?.user ??
                                                        [])
                                                    .length,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index,
                                                        int pageIndex) {
                                                  return InterestProfile(
                                                      index: index,
                                                      data: controller
                                                          .shortlistedProfileModel!
                                                          .user!
                                                          .elementAt(index));
                                                }),
                                      ),
                                    ],
                                  ),
                                ),
                              ));
                    }),
              Consumer<DashBoardController>(
                  builder: (context, controller, child) {
                return Positioned(
                  top: 0,
                  bottom: 0,
                  right: 0,
                  left: 0,
                  child: Visibility(
                      visible: controller.showLotie,
                      child: Lottie.asset(
                        'assets/jsons/doneLottie.json',
                        repeat: false,
                      )),
                );
              }),
            ],
          ),
        );
      }),
    );
  }

  Future<void> _launchUrl() async {
    var whatsappUrl = "whatsapp://send?phone=919857102002";
    //await canLaunch(whatsappUrl)? launch(whatsappUrl):print("open whatsapp app link or do a snackbar with notification that there is no whatsapp installed");
    if (!await launchUrl(Uri.parse(whatsappUrl))) {
      throw 'Could not launch ';
    }
  }

  show() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return FirstPopUp();
        });
  }
}
