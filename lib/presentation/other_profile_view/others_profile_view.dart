import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:readmore/readmore.dart';
import 'package:rishtey/controller/dashboard_controller.dart';
import 'package:rishtey/presentation/bottom_navigation_bar.dart';
import 'package:rishtey/presentation/membership/membership_screen.dart';
import 'package:rishtey/presentation/profile/about_me_profile.dart';
import 'package:rishtey/presentation/razorpay_payment.dart';
import 'package:rishtey/utils/app_snack_bar.dart';
import '../../controller/get_profile_controller.dart';
import '../../utils/app_config.dart';
import '../profile/report_profile.dart';
import 'bottom_sheet.dart';
import 'other_profile_gallery.dart';

class OtherProfileView extends StatefulWidget {
  final String? id;
  final int? getId;

  const OtherProfileView({Key? key, this.id, this.getId}) : super(key: key);

  @override
  State<OtherProfileView> createState() => _OtherProfileViewState();
}

class _OtherProfileViewState extends State<OtherProfileView> {
  Razorpay? _razorpay;

  GetProfileController? getProfileController;
  DashBoardController? dashBoardController;

  @override
  void initState() {
    super.initState();

    _razorpay = Razorpay();
    _razorpay!.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay!.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay!.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    Future.delayed(const Duration(milliseconds: 100), () {
      getProfileController =
          Provider.of<GetProfileController>(context, listen: false);
      getProfileController!.otherProfile(context, widget.getId);
      dashBoardController =
          Provider.of<DashBoardController>(context, listen: false);
    });
    //openCheckout();
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay!.clear();
  }

  void openCheckout() async {
    var options = {
      'key': 'rzp_test_12T0t47clp4pRC',
      'amount': int.parse(getProfileController?.otherProfileDetail?.data?.user?.profileView??"0")*100,
      'name': '${getProfileController?.getProfileModel?.data?.user?.fullName}',
      'description': 'Get Full Access of profile',
      'prefill': {'contact': '${getProfileController?.getProfileModel?.data?.user?.mobileNumber??"0494940404"}', 'email': '${getProfileController?.getProfileModel?.data?.user?.email}'},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay!.open(options);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    getProfileController!.addMoneyInWallet(getProfileController?.otherProfileDetail?.data?.user?.id,context,getProfileController?.otherProfileDetail?.data?.user?.profileView,response.paymentId,"RazorPay");

    // Fluttertoast.showToast(
    //     msg: "SUCCESS: " +response.paymentId!, timeInSecForIosWeb: 4);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Fluttertoast.showToast(
    //     msg: "ERROR: " + response.code.toString() + " - " + response.message!,
    //     timeInSecForIosWeb: 4);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Fluttertoast.showToast(
    //     msg: "EXTERNAL_WALLET: " + response.walletName!, timeInSecForIosWeb: 4);
  }

  @override
  Widget build(BuildContext context) {
    print("kmvdslfvmklm${getProfileController?.otherProfileDetail?.images?.length}");
    return WillPopScope(
      onWillPop: (){
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => MyHomePage()));
        return Future.value(true);
      },
      child: Scaffold(
        bottomNavigationBar: Container(
          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(color: Colors.white, boxShadow: [
            BoxShadow(
              color: Colors.black,
              blurRadius: 20.0,
            ),
          ]),
          child: Consumer<GetProfileController>(
              builder: (context, cintroller, child) {
            return cintroller.otherProfileDetail?.data?.user?.interest == "0"
                ? Row(
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      const Text(
                        "Like This Profile",
                        style:
                            TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Consumer<DashBoardController>(
                          builder: (context, controller, child) {
                        return GestureDetector(
                            onTap: () {
                              getProfileController?.sendInterest(
                                  context, widget.id,
                                  type: "other");
                            },
                            child: const Text(
                              "Send Interest Now ",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                  color: Colors.pinkAccent),
                            ));
                      }),
                      const SizedBox(
                        width: 10,
                      ),
                      const CircleAvatar(
                        radius: 30,
                        child: Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 30,
                        ),
                      )
                    ],
                  )
                : Container(
                    alignment: Alignment.center,
                    height: AppConfig.height * 0.06,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        bottomSheetIcon(
                            onTap: () {
                              if (cintroller.otherProfileDetail?.data?.user
                                      ?.shortlisted ==
                                  "Yes") {
                                cintroller.removeShortlistProfile(
                                    context,
                                    cintroller
                                        .otherProfileDetail?.data?.user?.id);
                              } else {
                                cintroller.shortlistProfile(
                                    context,
                                    cintroller
                                        .otherProfileDetail?.data?.user?.id);
                              }
                            },
                            name: cintroller.otherProfileDetail?.data?.user
                                        ?.shortlisted ==
                                    "Yes"
                                ? "Shortlisted"
                                : "Shortlist",
                            icon: cintroller.otherProfileDetail?.data?.user
                                        ?.shortlisted ==
                                    "No"
                                ? "assets/pngIcons/filled_syart.png"
                                : "assets/pngIcons/star.png"),
                        bottomSheetIcon(
                            onTap: () {
                              modelSheet(context,getProfileController!);
                            },
                            name: "Contact Detail",
                            icon: "assets/pngIcons/telephone-call.png"),
                        bottomSheetIcon(
                            onTap: () {},
                            name: "Chat",
                            icon: "assets/pngIcons/chat.png"),
                        bottomSheetIcon(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>ReportAccountReason(profileId: widget.getId.toString(),)));
                            },
                            name: "Report \nProfile",
                            icon: "assets/pngIcons/reportUser.png"),
                        bottomSheetIcon(
                            onTap: () {},
                            name: "Share \nProfile",
                            icon: "assets/pngIcons/share.png"),
                      ],
                    ),
                  );
          }),
        ),
        body: Consumer<GetProfileController>(
            builder: (context, getProfileController, child) {
          return getProfileController.isLoading
              ? const Center(child: CircularProgressIndicator())
              : SafeArea(
                  child: Stack(
                    children: [
                      Consumer<GetProfileController>(
                          builder: (context, controllers, child) {
                        return Opacity(
                          opacity: controllers.showLotie ? 0.4 : 1,
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  Stack(
                                    children: [
                                      ColorFiltered(
                                        colorFilter: ColorFilter.mode(
                                            Colors.black.withOpacity(0.2),
                                            BlendMode.darken),
                                        child: Image.network(
                                            getProfileController
                                                    .otherProfileDetail?.data?.user?.photo
                                                    .toString()
                                                    .replaceAll("file:///", "") ??
                                                "",
                                            fit: BoxFit.fill,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.5,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width),
                                      ),
                                      Positioned(
                                          bottom: 10,
                                          left: 20,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Image.network(
                                                    getProfileController
                                                            .otherProfileDetail
                                                            ?.data
                                                            ?.user
                                                            ?.memberType ??
                                                        "",
                                                    width: AppConfig.width * 0.05,
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    "${getProfileController.otherProfileDetail?.data?.user?.fullName}(${getProfileController.otherProfileDetail?.data?.user?.profileId})",
                                                    style: const TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w800,
                                                        color: Colors.white),
                                                  )
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        calculateAge(DateTime.parse(
                                                                    getProfileController
                                                                            .otherProfileDetail
                                                                            ?.data
                                                                            ?.user
                                                                            ?.birthDateTime ??
                                                                        ""))
                                                                .toString() +
                                                            "years  " +
                                                            "${getProfileController.otherProfileDetail?.data?.user?.height}\"" +
                                                            " || ${getProfileController.otherProfileDetail?.data?.user?.occupation}",
                                                        style: const TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.w800,
                                                            color: Colors.white),
                                                      ),
                                                      Text(
                                                        "${getProfileController.otherProfileDetail?.data?.user?.motherTongue} || ${getProfileController.otherProfileDetail?.data?.user?.religion}",
                                                        style: const TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.w800,
                                                            color: Colors.white),
                                                      )
                                                    ],
                                                  ),
                                                  // const SizedBox(
                                                  //   width: 20,
                                                  // ),
                                                  // Text(
                                                  //   getProfileController
                                                  //       .otherProfileDetail
                                                  //       ?.data
                                                  //       ?.user
                                                  //       ?.occupation ??
                                                  //       "",
                                                  //   style: const TextStyle(
                                                  //       fontSize: 16,
                                                  //       fontWeight:
                                                  //       FontWeight.w800,
                                                  //       color: Colors.white),
                                                  // ),
                                                  // Column(
                                                  //   mainAxisAlignment:
                                                  //       MainAxisAlignment.start,
                                                  //   crossAxisAlignment:
                                                  //       CrossAxisAlignment.start,
                                                  //   children: [
                                                  //     // Text(
                                                  //     //   getProfileController
                                                  //     //           .otherProfileDetail
                                                  //     //           ?.data
                                                  //     //           ?.user
                                                  //     //           ?.occupation ??
                                                  //     //       "",
                                                  //     //   style: const TextStyle(
                                                  //     //       fontSize: 16,
                                                  //     //       fontWeight:
                                                  //     //           FontWeight.w800,
                                                  //     //       color: Colors.white),
                                                  //     // ),
                                                  //
                                                  //   ],
                                                  // )
                                                ],
                                              ),
                                              Text(
                                                "${getProfileController.otherProfileDetail?.data?.user?.stateLivingIn}",
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w800,
                                                    color: Colors.white),
                                              )
                                            ],
                                          )),
                                      Positioned(
                                          top: 50,
                                          right: 0,
                                          child: GestureDetector(

                                            onTap: (){
                                              Navigator.push(context, MaterialPageRoute(builder: (context)=>OtherProfileGellery()));
                                            },
                                            child: Container(
                                                padding: const EdgeInsets.symmetric(
                                                    horizontal: 10, vertical: 5),
                                                decoration: BoxDecoration(
                                                    color: Colors.black26,
                                                    borderRadius:
                                                        BorderRadius.circular(10)),
                                                child: Column(
                                                  children: [
                                                    const Icon(
                                                      Icons.camera_alt,
                                                      size: 20,
                                                      color: Colors.white,
                                                    ),
                                                    Text("${getProfileController.otherProfileDetail?.images?.length??0}",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w800),)
                                                  ],
                                                )),
                                          ))
                                    ],
                                  ),
                                  Container(
                                    width: AppConfig.width,
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15.0),
                                      ),
                                      elevation: 4,
                                      child: Container(
                                        padding: const EdgeInsets.all(10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "About ${getProfileController.otherProfileDetail?.data?.user?.fullName}",
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w800,
                                                  fontSize: 16),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            ReadMoreText(
                                              getProfileController.otherProfileDetail?.data?.user?.aboutMe ?? "",
                                              trimLines: 3,
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w600),
                                              colorClickableText: Colors.pink,
                                              trimMode: TrimMode.Line,
                                              trimCollapsedText: '...Read More',
                                              trimExpandedText: ' Read less ',
                                            ),
                                            // Text(
                                            //     "${getProfileController.otherProfileDetail?.data?.user?.aboutMe}")
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "Basic Details",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w800,
                                              fontSize: 18),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Wrap(
                                          children: [
                                            basicDetails(
                                                text:
                                                    "Created By ${getProfileController.otherProfileDetail?.data!.user!.profileCreatedFor}"),
                                            basicDetails(
                                              text:
                                                  "${calculateAge(DateTime.parse(getProfileController.otherProfileDetail?.data?.user?.birthDateTime.toString().substring(0, 10) ?? "1980-12-20"))} Years ",
                                            ),
                                            basicDetails(
                                                text:
                                                    "Profile Id-${getProfileController.otherProfileDetail?.data!.user!.profileId}"),
                                            basicDetails(
                                                text:
                                                    "Height - ${getProfileController.otherProfileDetail?.data!.user!.height}\""),
                                          ],
                                        ),
                                        // basicTile(
                                        //     heading: "Height",
                                        //     text:
                                        //         "${getProfileController.otherProfileDetail?.data!.user!.height}"),
                                        //
                                        // basicTile(
                                        //     heading: "Profile Id ",
                                        //     icon: const Icon(
                                        //       Icons.supervised_user_circle,
                                        //       color: Colors.white,
                                        //     ),
                                        //     text:
                                        //         "${getProfileController.otherProfileDetail?.data!.user!.profileId}"),
                                        // basicTile(
                                        //     heading: "Created By ",
                                        //     icon: const Icon(
                                        //       Icons.supervised_user_circle,
                                        //       color: Colors.white,
                                        //     ),
                                        //     text:
                                        //         "${getProfileController.otherProfileDetail?.data!.user!.profileCreatedFor}"),
                                        // basicTile(
                                        //     heading: "Age",
                                        //     text:
                                        //         "${calculateAge(DateTime.parse(getProfileController.otherProfileDetail?.data?.user?.birthDateTime.toString().substring(0, 10) ?? "1980-12-20"))}",
                                        //     icon: const Icon(
                                        //         Icons.calendar_today_outlined,
                                        //         color: Colors.white)),
                                        basicTile(
                                            heading: "Marital Status",
                                            text:
                                                "${getProfileController.otherProfileDetail?.data!.user!.maritalStatus}",
                                            icon: const Icon(Icons.person,
                                                color: Colors.white)),
                                        basicTile(
                                            heading: "Native Place",
                                            text:
                                                "Lives In ${getProfileController.otherProfileDetail?.data!.user!.cityLivingIn}",
                                            icon: const Icon(
                                                Icons.location_on_sharp,
                                                color: Colors.white)),
                                        // basicTile(
                                        //     heading: "Community",
                                        //     text: "Brahmin",
                                        //     icon: const Icon(
                                        //       Icons.group,
                                        //       color: Colors.white,
                                        //     )),
                                        // basicTile(
                                        //     heading: "Diet Preferences",
                                        //     text:
                                        //         "${getProfileController.otherProfileDetail?.data!.user!.diet}",
                                        //     icon: const Icon(
                                        //       Icons.food_bank_outlined,
                                        //       color: Colors.white,
                                        //     )),
                                        basicTile(
                                            heading: "Religion & Mother Tongue",
                                            text:
                                                "${getProfileController.otherProfileDetail?.data!.user!.religion}, ${getProfileController.otherProfileDetail?.data!.user!.motherTongue}",
                                            icon: const Icon(
                                              Icons.group,
                                              color: Colors.white,
                                            )),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "Astro & Kundli Details",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w800,
                                              fontSize: 18),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        basicTile(
                                            heading: "Date Of Birth",
                                            text:
                                                "${getProfileController.otherProfileDetail?.data?.user?.birthDateTime.toString().substring(0, 10) ?? ""}",
                                            icon: const Icon(
                                                Icons.calendar_view_day,
                                                color: Colors.white),
                                            bgColor: Colors.redAccent),
                                        getProfileController.otherProfileDetail
                                                    ?.data?.user?.profileViewed ==
                                                "Yes"
                                            ? basicTile(
                                                showIcon: false,
                                                heading: "Time of birth",
                                                text:
                                                    "${getProfileController.otherProfileDetail?.data?.user?.birthDateTime.toString().split(" ")[1] ?? ""}",
                                                icon: const Icon(
                                                    Icons.watch_later_outlined,
                                                    color: Colors.white),
                                                bgColor: Colors.redAccent)
                                            : basicTile(
                                                showIcon: true,
                                                heading: "Time of birth",
                                                text:
                                                    //  "***${getProfileController.otherProfileDetail?.data?.user?.birthDateTime.toString().substring(10, 13) ?? ""}",
                                                    "**:** AM",
                                                icon: const Icon(
                                                    Icons.watch_later_outlined,
                                                    color: Colors.white),
                                                bgColor: Colors.redAccent),
                                        getProfileController.otherProfileDetail
                                                    ?.data?.user?.profileViewed ==
                                                "Yes"
                                            ? basicTile(
                                                showIcon: false,
                                                heading: "Place of birth",
                                                text: getProfileController
                                                    .otherProfileDetail!
                                                    .data!
                                                    .user!
                                                    .birthPlace!,
                                                icon: const Icon(Icons.place,
                                                    color: Colors.white),
                                                bgColor: Colors.redAccent)
                                            : basicTile(
                                                showIcon: true,
                                                heading: "Place of birth",
                                                text: getProfileController
                                                            .otherProfileDetail!
                                                            .data!
                                                            .user!
                                                            .birthPlace!
                                                            .length >
                                                        4
                                                    ? "${getProfileController.otherProfileDetail!.data!.user!.birthPlace.toString().substring(0, 4)}*****"
                                                    : "${getProfileController.otherProfileDetail?.data?.user?.birthPlace.toString() ?? ""}*****",
                                                icon: const Icon(Icons.place,
                                                    color: Colors.white),
                                                bgColor: Colors.redAccent),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  getProfileController.otherProfileDetail?.data
                                              ?.user?.profileViewed ==
                                          "Yes"
                                      ? Container()
                                      : Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            const Text(
                                                "Want to get full information"),
                                            GestureDetector(
                                                onTap: () {
                                                  if(getProfileController
                                                      .getProfileModel
                                                      ?.data
                                                      ?.user
                                                      ?.membershipType ==
                                                      "No Membership"){
Navigator.push(context, MaterialPageRoute(builder: (context)=>MemberShipScreen()));
                                                  }
                                                  else if(getProfileController
                                                      .otherProfileDetail
                                                      ?.data
                                                      ?.user
                                                      ?.profileView=="0"){
                                                    appSnackBar(content: "Price of this profile id is not set yet", context: context);
                                                  }
                                                  else{
                                                    if(int.parse(getProfileController.getProfileModel!.data!.user!.walletAmount!)<int.parse(getProfileController.otherProfileDetail!.data!.user!.profileView!)){
                                                     showAlertPaymentDialog(context);
                                                    }
                                                    else{
                                                      showAlertDialog(context, getProfileController.otherProfileDetail!.data!.user!.profileView!, getProfileController.otherProfileDetail!.data!.user!.id);
                                                    }

                                                  }

                                                },
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.all(15),
                                                  decoration: BoxDecoration(
                                                    color: AppConfig
                                                        .theme.primaryColor,
                                                    borderRadius:
                                                        BorderRadius.circular(20),
                                                  ),
                                                  child: Column(
                                                    children: [
                                                      Text(
                                                        getProfileController
                                                                    .getProfileModel
                                                                    ?.data
                                                                    ?.user
                                                                    ?.membershipType ==
                                                                "No Membership"
                                                            ? "Upgrade Now"
                                                            : "Unlock Now",
                                                        style: const TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 22),
                                                      ),
                                                      Text(
                                                        getProfileController
                                                                    .getProfileModel
                                                                    ?.data
                                                                    ?.user
                                                                    ?.membershipType ==
                                                                "No Membership"
                                                            ? "Click here to activate your profile"
                                                            : "Click here to unlock details",
                                                        style: const TextStyle(
                                                            color: Colors.white),
                                                      ),
                                                    ],
                                                  ),
                                                )),
                                          ],
                                        ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "Religion Information",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w800,
                                              fontSize: 18),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        basicTile(
                                            heading: "Community",
                                            text:
                                                "${getProfileController.otherProfileDetail?.data?.user?.cast.toString()}",
                                            icon: const Icon(
                                                Icons.calendar_view_day,
                                                color: Colors.white),
                                            bgColor: Colors.redAccent),
                                        basicTile(
                                            heading: "SubCommunity",
                                            text:
                                                "${getProfileController.otherProfileDetail?.data?.user?.subCast.toString()}",
                                            icon: const Icon(
                                                Icons.watch_later_outlined,
                                                color: Colors.white),
                                            bgColor: Colors.redAccent),
                                        basicTile(
                                            heading: "Gotra",
                                            text:
                                                "${getProfileController.otherProfileDetail?.data?.user?.gotra.toString()}",
                                            icon: const Icon(Icons.place,
                                                color: Colors.white),
                                            bgColor: Colors.redAccent),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "Education & Career",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w800,
                                              fontSize: 18),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        basicTile(
                                            heading: "Education & Career",
                                            text:
                                                "${getProfileController.otherProfileDetail?.data!.user!.aboutMyEducation}",
                                            icon: const Icon(Icons.location_city,
                                                color: Colors.white),
                                            bgColor: Colors.orangeAccent),
                                        basicTile(
                                            heading: "Education",
                                            text:
                                                "${getProfileController.otherProfileDetail?.data!.user!.education}",
                                            icon: const Icon(Icons.location_city,
                                                color: Colors.white),
                                            bgColor: Colors.orangeAccent),
                                        basicTile(
                                            heading: "Other Qualifications",
                                            text:
                                                "${getProfileController.otherProfileDetail?.data!.user!.anyOtherQualifications}",
                                            icon: const Icon(Icons.location_city,
                                                color: Colors.white),
                                            bgColor: Colors.orangeAccent),
                                        basicTile(
                                            heading: "Employed In",
                                            text:
                                                "${getProfileController.otherProfileDetail?.data!.user!.employedIn}",
                                            icon: const Icon(
                                                Icons.wallet_travel_sharp,
                                                color: Colors.white),
                                            bgColor: Colors.orangeAccent),
                                        basicTile(
                                            heading: "Occupation",
                                            text:
                                                "${getProfileController.otherProfileDetail?.data!.user!.occupation}",
                                            icon: const Icon(Icons.location_city,
                                                color: Colors.white),
                                            bgColor: Colors.orangeAccent),
                                        basicTile(
                                            heading: "Currently Working",
                                            text:
                                                "${getProfileController.otherProfileDetail?.data!.user!.organizationName} ",
                                            icon: const Icon(
                                                Icons.account_balance_wallet,
                                                color: Colors.white),
                                            bgColor: Colors.orangeAccent),
                                        basicTile(
                                            heading: "Job Location",
                                            text:
                                                "${getProfileController.otherProfileDetail?.data!.user!.jobLocation}",
                                            icon: const Icon(
                                                Icons.cast_for_education_sharp,
                                                color: Colors.white),
                                            bgColor: Colors.orangeAccent),
                                        // basicTile(
                                        //     heading: "Education Field",
                                        //     text: "${getProfileController.otherProfileDetail?.data!.user!.hi}",
                                        //     icon: const Icon(
                                        //         Icons.menu_book_outlined,
                                        //         color: Colors.white),
                                        //     bgColor: Colors.orangeAccent),
                                        // basicTile(
                                        //     heading: "College Name",
                                        //     text: "**********",
                                        //     icon: const Icon(Icons.library_add,
                                        //         color: Colors.white),
                                        //     bgColor: Colors.orangeAccent),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "Contact Details",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w800,
                                              fontSize: 18),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        getProfileController.otherProfileDetail
                                                    ?.data?.user?.profileViewed ==
                                                "Yes"
                                            ? basicTile(
                                                heading: "Contact No.",
                                                text: getProfileController
                                                    .otherProfileDetail!
                                                    .data!
                                                    .user!
                                                    .mobileNumber!,
                                                icon: const Icon(Icons.call,
                                                    color: Colors.white),
                                                bgColor: Colors.redAccent)
                                            : basicTile(
                                                heading: "Contact No.",
                                                text: getProfileController
                                                            .otherProfileDetail!
                                                            .data!
                                                            .user!
                                                            .mobileNumber!
                                                            .length >
                                                        4
                                                    ? "${getProfileController.otherProfileDetail?.data!.user!.mobileNumber.toString().substring(0, 4)}*******"
                                                    : "${getProfileController.otherProfileDetail?.data!.user!.mobileNumber.toString()}",
                                                showIcon: true,
                                                icon: const Icon(Icons.call,
                                                    color: Colors.white),
                                                bgColor: Colors.redAccent),
                                        getProfileController.otherProfileDetail
                                                    ?.data?.user?.profileViewed ==
                                                "Yes"
                                            ? basicTile(
                                                heading: "Whatsapp No.",
                                                text: getProfileController
                                                    .otherProfileDetail
                                                    ?.data!
                                                    .user!
                                                    .whatsappNumber!,
                                                showIcon: false,
                                                icon: const Icon(Icons.call,
                                                    color: Colors.white),
                                                bgColor: Colors.redAccent)
                                            : basicTile(
                                                heading: "Whatsapp No.",
                                                text: getProfileController
                                                            .otherProfileDetail
                                                            ?.data!
                                                            .user!
                                                            .whatsappNumber!
                                                            .length >
                                                        4
                                                    ? "${getProfileController.otherProfileDetail?.data!.user!.whatsappNumber.toString().substring(0, 4)}*******"
                                                    : "${getProfileController.otherProfileDetail?.data!.user!.whatsappNumber.toString()}",
                                                showIcon: true,
                                                icon: const Icon(Icons.call,
                                                    color: Colors.white),
                                                bgColor: Colors.redAccent),
                                        getProfileController.otherProfileDetail
                                                    ?.data?.user?.profileViewed ==
                                                "Yes"
                                            ? basicTile(
                                                heading: "Email Id",
                                                text: getProfileController
                                                    .otherProfileDetail!
                                                    .data!
                                                    .user!
                                                    .email!,
                                                showIcon: false,
                                                icon: const Icon(Icons.email,
                                                    color: Colors.white),
                                                bgColor: Colors.redAccent)
                                            : basicTile(
                                                heading: "Email Id",
                                                text: getProfileController
                                                            .otherProfileDetail!
                                                            .data!
                                                            .user!
                                                            .email!
                                                            .length >
                                                        4
                                                    ? "${getProfileController.otherProfileDetail?.data!.user!.email.toString().substring(0, 4)}*******"
                                                    : "${getProfileController.otherProfileDetail?.data!.user!.email.toString()}",
                                                showIcon: true,
                                                icon: const Icon(Icons.email,
                                                    color: Colors.white),
                                                bgColor: Colors.redAccent),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  getProfileController.otherProfileDetail?.data
                                              ?.user?.profileViewed ==
                                          "Yes"
                                      ? Container()
                                      : Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            const Text(
                                                "Want to get full information"),
                                            GestureDetector(
                                                onTap: () {
                                                  //openCheckout();
                                                  if(getProfileController
                                                      .getProfileModel
                                                      ?.data
                                                      ?.user
                                                      ?.membershipType ==
                                                      "No Membership"){
                                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>MemberShipScreen()));

                                                  }
                                                  else if(getProfileController
                                                      .otherProfileDetail
                                                      ?.data
                                                      ?.user
                                                      ?.profileView=="0"){
                                                    appSnackBar(content: "Price of this profile id is not set yet", context: context);
                                                  }
                                                  else{
                                                    if(int.parse(getProfileController.getProfileModel!.data!.user!.walletAmount!)<int.parse(getProfileController.otherProfileDetail!.data!.user!.profileView!)){
                                                      showAlertPaymentDialog(context);
                                                    }
                                                    else{
                                                      showAlertDialog(context, getProfileController.otherProfileDetail!.data!.user!.profileView!, getProfileController.otherProfileDetail!.data!.user!.id);
                                                    }

                                                  }
                                                  // showAlertPaymentDialog(context);
                                                },
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.all(15),
                                                  decoration: BoxDecoration(
                                                    color: AppConfig
                                                        .theme.primaryColor,
                                                    borderRadius:
                                                        BorderRadius.circular(20),
                                                  ),
                                                  child: Column(
                                                    children: [
                                                      Text(
                                                        getProfileController
                                                                    .getProfileModel
                                                                    ?.data
                                                                    ?.user
                                                                    ?.membershipType ==
                                                                "No Membership"
                                                            ? "Upgrade Now"
                                                            : "Unlock Now",
                                                        style: const TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 22),
                                                      ),
                                                      Text(
                                                        getProfileController
                                                                    .getProfileModel
                                                                    ?.data
                                                                    ?.user
                                                                    ?.membershipType ==
                                                                "No Membership"
                                                            ? "Click Here to Activate your profile"
                                                            : "Click here to unlock details",
                                                        style: const TextStyle(
                                                            color: Colors.white),
                                                      ),
                                                    ],
                                                  ),
                                                )),
                                          ],
                                        ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "Family Details",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w800,
                                              fontSize: 18),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        basicTile(
                                            heading: "Family Type",
                                            text:
                                                "${getProfileController.otherProfileDetail?.data!.user!.familyStatus}",
                                            icon: const Icon(Icons.location_city,
                                                color: Colors.white),
                                            bgColor: Colors.orangeAccent),
                                        basicTile(
                                            heading: "Father Occupation",
                                            text:
                                                "${getProfileController.otherProfileDetail?.data!.user!.fatherOccupation}",
                                            icon: const Icon(
                                                Icons.wallet_travel_sharp,
                                                color: Colors.white),
                                            bgColor: Colors.orangeAccent),
                                        basicTile(
                                            heading: "Mother Occupation",
                                            text:
                                                "${getProfileController.otherProfileDetail?.data!.user!.motherOccupation}",
                                            icon: const Icon(Icons.location_city,
                                                color: Colors.white),
                                            bgColor: Colors.orangeAccent),
                                        basicTile(
                                            heading: "Brothers",
                                            text:
                                                "${getProfileController.otherProfileDetail?.data!.user!.noOfBrothers} ",
                                            icon: const Icon(
                                                Icons.account_balance_wallet,
                                                color: Colors.white),
                                            bgColor: Colors.orangeAccent),
                                        basicTile(
                                            heading: "Married Brothers",
                                            text:
                                                "${getProfileController.otherProfileDetail?.data!.user!.marriedBrothers}",
                                            icon: const Icon(
                                                Icons.cast_for_education_sharp,
                                                color: Colors.white),
                                            bgColor: Colors.orangeAccent),
                                        basicTile(
                                            heading: "Sisters",
                                            text:
                                                "${getProfileController.otherProfileDetail?.data!.user!.noOfSisters}",
                                            icon: const Icon(
                                                Icons.menu_book_outlined,
                                                color: Colors.white),
                                            bgColor: Colors.orangeAccent),
                                        basicTile(
                                            heading: "Married Sisters",
                                            text:
                                                "${getProfileController.otherProfileDetail?.data!.user!.marriedSisters}",
                                            icon: const Icon(Icons.library_add,
                                                color: Colors.white),
                                            bgColor: Colors.orangeAccent),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "Life Style",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w800,
                                              fontSize: 18),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        basicTile(
                                            heading: "Diet",
                                            text:
                                                "${getProfileController.otherProfileDetail?.data!.user!.diet}",
                                            icon: const Icon(Icons.call,
                                                color: Colors.white),
                                            bgColor: Colors.redAccent),
                                        basicTile(
                                            heading: "Smoking",
                                            text:
                                                "${getProfileController.otherProfileDetail?.data!.user!.isSmoking}",
                                            icon: const Icon(Icons.email,
                                                color: Colors.white),
                                            bgColor: Colors.redAccent),
                                        basicTile(
                                            heading: "Drinking",
                                            text:
                                                "${getProfileController.otherProfileDetail?.data!.user!.isDrinking}",
                                            icon: const Icon(Icons.email,
                                                color: Colors.white),
                                            bgColor: Colors.redAccent),
                                        basicTile(
                                            heading: "Any Disability",
                                            text:
                                                "${getProfileController.otherProfileDetail?.data!.user!.anyDisability}",
                                            icon: const Icon(Icons.email,
                                                color: Colors.white),
                                            bgColor: Colors.redAccent),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    "Partner Prefrences",
                                    style: TextStyle(
                                        color: AppConfig.theme.primaryColor,
                                        fontWeight: FontWeight.w800,
                                        fontSize: AppConfig.width * 0.05),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        basicTile(
                                            heading: "Height should be ",
                                            text:
                                                "${getProfileController.otherProfileDetail?.data!.user!.partnerHeightFrom}-${getProfileController.otherProfileDetail?.data!.user!.partnerHeightTo}",
                                            icon: const Icon(
                                                Icons.calendar_today_outlined,
                                                color: Colors.white)),
                                        basicTile(
                                            heading: "Age ",
                                            text:
                                                "${getProfileController.otherProfileDetail?.data!.user!.partnerAgeFrom}-${getProfileController.otherProfileDetail?.data!.user!.partnerAgeTo}",
                                            icon: const Icon(
                                                Icons.calendar_today_outlined,
                                                color: Colors.white)),
                                        basicTile(
                                            heading: "Marital Status",
                                            text:
                                                "${getProfileController.otherProfileDetail?.data!.user!.lookingFor}",
                                            icon: const Icon(Icons.person,
                                                color: Colors.white)),
                                        basicTile(
                                            heading: "Religion & Mother Tongue",
                                            text:
                                                "${getProfileController.otherProfileDetail?.data!.user!.partnerReligion}, ${getProfileController.otherProfileDetail?.data!.user!.partnerMothertongue}",
                                            icon: const Icon(
                                              Icons.group,
                                              color: Colors.white,
                                            )),
                                        basicTile(
                                            heading: "Community",
                                            text:
                                                "${getProfileController.otherProfileDetail?.data!.user!.partnerReligion}",
                                            icon: const Icon(
                                              Icons.group,
                                              color: Colors.white,
                                            )),
                                        basicTile(
                                            heading: "Is Manglik",
                                            text:
                                                "${getProfileController.otherProfileDetail?.data!.user!.isPartnerManglik}",
                                            icon: const Icon(
                                              Icons.group,
                                              color: Colors.white,
                                            )),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        basicTile(
                                            heading: "Highest Qualification",
                                            text:
                                                "${getProfileController.otherProfileDetail?.data!.user!.partnerEducation}",
                                            icon: const Icon(
                                                Icons.cast_for_education_sharp,
                                                color: Colors.white),
                                            bgColor:
                                                AppConfig.theme.primaryColor),
                                        basicTile(
                                            heading: "Partner's Occupation",
                                            text:
                                                "${getProfileController.otherProfileDetail?.data!.user!.partnerOccupation}",
                                            icon: const Icon(
                                                Icons.wallet_travel_sharp,
                                                color: Colors.white),
                                            bgColor:
                                                AppConfig.theme.primaryColor),

                                        basicTile(
                                            heading: "Annual Income",
                                            text:
                                                "${getProfileController.otherProfileDetail?.data!.user!.annualIncome} annually",
                                            icon: const Icon(
                                                Icons.account_balance_wallet,
                                                color: Colors.white),
                                            bgColor:
                                                AppConfig.theme.primaryColor),

                                        basicTile(
                                            heading: "City",
                                            text:
                                                "${getProfileController.otherProfileDetail?.data!.user!.partnerCity}",
                                            icon: const Icon(
                                                Icons.location_on_sharp,
                                                color: Colors.white)),
                                        basicTile(
                                            heading: "State",
                                            text:
                                                "${getProfileController.otherProfileDetail?.data!.user!.partnerState}",
                                            icon: const Icon(
                                                Icons.location_on_sharp,
                                                color: Colors.white)),
                                        basicTile(
                                            heading: "Country",
                                            text:
                                                "${getProfileController.otherProfileDetail?.data!.user!.partnerCountry}",
                                            icon: const Icon(
                                                Icons.location_on_sharp,
                                                color: Colors.white)),

                                        basicTile(
                                            heading: "Diet Preferences",
                                            text:
                                                "${getProfileController.otherProfileDetail?.data!.user!.partnerDiet}",
                                            icon: const Icon(
                                              Icons.food_bank_outlined,
                                              color: Colors.white,
                                            )),
                                        basicTile(
                                            heading: "Drinking",
                                            text:
                                                "${getProfileController.otherProfileDetail?.data!.user!.isPartnerDrinking}",
                                            icon: const Icon(
                                              Icons.food_bank_outlined,
                                              color: Colors.white,
                                            )),
                                        basicTile(
                                            heading: "Smoking",
                                            text:
                                                "${getProfileController.otherProfileDetail?.data!.user!.isPartnerSmoking}",
                                            icon: const Icon(
                                              Icons.food_bank_outlined,
                                              color: Colors.white,
                                            )),
                                        basicTile(
                                            heading: "About My Partner",
                                            text:
                                                "${getProfileController.otherProfileDetail?.data!.user!.aboutMe}",
                                            icon: const Icon(
                                                Icons.cast_for_education_sharp,
                                                color: Colors.white),
                                            bgColor:
                                                AppConfig.theme.primaryColor),

                                        // basicTile(
                                        //     heading: "Education Field",
                                        //     text: "${getProfileController.otherProfileDetail?.data!.user!.hi}",
                                        //     icon: const Icon(
                                        //         Icons.menu_book_outlined,
                                        //         color: Colors.white),
                                        //     bgColor: Colors.orangeAccent),
                                        // basicTile(
                                        //     heading: "College Name",
                                        //     text: "**********",
                                        //     icon: const Icon(Icons.library_add,
                                        //         color: Colors.white),
                                        //     bgColor: Colors.orangeAccent),
                                        // Column(
                                        //   crossAxisAlignment:
                                        //       CrossAxisAlignment.start,
                                        //   children: [
                                        //     const Text(
                                        //         "Want to get full information"),
                                        //     GestureDetector(
                                        //       onTap: () {
                                        //         openCheckout();
                                        //       },
                                        //       child: Row(
                                        //         children: [
                                        //           const CircleAvatar(
                                        //             radius: 25,
                                        //             backgroundColor:
                                        //                 Colors.orangeAccent,
                                        //             child: const Icon(
                                        //               Icons
                                        //                   .workspace_premium_outlined,
                                        //               color: Colors.white,
                                        //               size: 30,
                                        //             ),
                                        //           ),
                                        //           const SizedBox(
                                        //             width: 20,
                                        //           ),
                                        //           const Text(
                                        //             "Get Premium",
                                        //             style: TextStyle(
                                        //                 color: Colors.black,
                                        //                 fontWeight:
                                        //                     FontWeight.w600),
                                        //           ),
                                        //         ],
                                        //       ),
                                        //     ),
                                        //   ],
                                        // )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                      Consumer<GetProfileController>(
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
      ),
    );
  }

  Widget basicDetails({String? text}) {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: AppConfig.theme.primaryColor),
      child: Text(
        text!,
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  Widget basicTile(
      {String? heading,
      String? text,
      Icon? icon,
      bgColor,
      bool? showIcon = false}) {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: bgColor ?? AppConfig.theme.primaryColor,
            child: icon,
          ),
          AppConfig.sizedBoxH(0.02),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                heading!,
                style: TextStyle(fontSize: 12, color: Colors.grey.shade400),
              ),
              Container(
                width: AppConfig.width * 0.5,
                child: Row(
                  children: [
                    showIcon == true
                        ? Container(
                            child: Text(
                            text ?? "",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600),
                          ))
                        : Container(
                            width: AppConfig.width * 0.5,
                            child: ReadMoreText(
                              text ?? "",
                              trimLines: 2,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600),
                              colorClickableText: Colors.pink,
                              trimMode: TrimMode.Line,
                              trimCollapsedText: '...Read More',
                              trimExpandedText: ' Read less ',
                            ),
                          ),
                    showIcon == true ? const Icon(Icons.lock) : Container()
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget bottomSheetIcon({String? name, String? icon, VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap!,
      child: Column(
        children: [
          Image.asset(
            icon!,
            width: AppConfig.width * 0.08,
          ),
          Text(
            name!,
            style: const TextStyle(color: Colors.black, fontSize: 10),
          )
        ],
      ),
    );
  }
  modelSheet(BuildContext context,GetProfileController getProfileController) {
    Size size = MediaQuery.of(context).size;
    return showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return Container(
            // height: size.height*1,
            decoration:  BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                color: AppConfig.theme.primaryColor),
            child: Column(
              children: [
                SizedBox(height: 10,),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.end,
                //   children: [
                //    CircleAvatar(child: Icon(Icons.clear),)
                //   ],
                // ),
                //
                // SizedBox(height: size.height * 0.02),
                Text(
                  'Upgrade Now to get full access',
                  style: TextStyle(
                      color: Colors.white, fontSize: size.height * 0.025),
                ),
                Card(
                  color: Colors.transparent,
                  shadowColor: Colors.white,
                  elevation: 12,
                  child: Container(
                    height: size.height * 0.5,
                    width: size.width * 0.9,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                        ),
                        color: Colors.white),
                    child: ListView(
                      //mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        getProfileController.otherProfileDetail
                            ?.data?.user?.profileViewed ==
                            "Yes"
                            ? basicTile(
                            heading: "Contact No.",
                            text: getProfileController
                                .otherProfileDetail!
                                .data!
                                .user!
                                .mobileNumber!,
                            icon: const Icon(Icons.call,
                                color: Colors.white),
                            bgColor: Colors.redAccent)
                            : basicTile(
                            heading: "Contact No.",
                            text: getProfileController
                                .otherProfileDetail!
                                .data!
                                .user!
                                .mobileNumber!
                                .length >
                                4
                                ? "${getProfileController.otherProfileDetail?.data!.user!.mobileNumber.toString().substring(0, 4)}*******"
                                : "${getProfileController.otherProfileDetail?.data!.user!.mobileNumber.toString()}",
                            showIcon: true,
                            icon: const Icon(Icons.call,
                                color: Colors.white),
                            bgColor: Colors.redAccent),
                        getProfileController.otherProfileDetail
                            ?.data?.user?.profileViewed ==
                            "Yes"
                            ? basicTile(
                            heading: "Whatsapp No.",
                            text: getProfileController
                                .otherProfileDetail
                                ?.data!
                                .user!
                                .whatsappNumber!,
                            showIcon: false,
                            icon: const Icon(Icons.call,
                                color: Colors.white),
                            bgColor: Colors.redAccent)
                            : basicTile(
                            heading: "Whatsapp No.",
                            text: getProfileController
                                .otherProfileDetail
                                ?.data!
                                .user!
                                .whatsappNumber!
                                .length >
                                4
                                ? "${getProfileController.otherProfileDetail?.data!.user!.whatsappNumber.toString().substring(0, 4)}*******"
                                : "${getProfileController.otherProfileDetail?.data!.user!.whatsappNumber.toString()}",
                            showIcon: true,
                            icon: const Icon(Icons.call,
                                color: Colors.white),
                            bgColor: Colors.redAccent),
                        getProfileController.otherProfileDetail
                            ?.data?.user?.profileViewed ==
                            "Yes"
                            ? basicTile(
                            heading: "Email Id",
                            text: getProfileController
                                .otherProfileDetail!
                                .data!
                                .user!
                                .email!,
                            showIcon: false,
                            icon: const Icon(Icons.email,
                                color: Colors.white),
                            bgColor: Colors.redAccent)
                            : basicTile(
                            heading: "Email Id",
                            text: getProfileController
                                .otherProfileDetail!
                                .data!
                                .user!
                                .email!
                                .length >
                                4
                                ? "${getProfileController.otherProfileDetail?.data!.user!.email.toString().substring(0, 4)}*******"
                                : "${getProfileController.otherProfileDetail?.data!.user!.email.toString()}",
                            showIcon: true,
                            icon: const Icon(Icons.email,
                                color: Colors.white),
                            bgColor: Colors.redAccent),
                        basicTile(
                            heading: "Date Of Birth",
                            text:
                            "${getProfileController.otherProfileDetail?.data?.user?.birthDateTime.toString().substring(0, 10) ?? ""}",
                            icon: const Icon(
                                Icons.calendar_view_day,
                                color: Colors.white),
                            bgColor: Colors.redAccent),
                        getProfileController.otherProfileDetail
                            ?.data?.user?.profileViewed ==
                            "Yes"
                            ? basicTile(
                            showIcon: false,
                            heading: "Time of birth",
                            text:
                            "${getProfileController.otherProfileDetail?.data?.user?.birthDateTime.toString().split(" ")[1] ?? ""}",
                            icon: const Icon(
                                Icons.watch_later_outlined,
                                color: Colors.white),
                            bgColor: Colors.redAccent)
                            : basicTile(
                            showIcon: true,
                            heading: "Time of birth",
                            text:
                            //  "***${getProfileController.otherProfileDetail?.data?.user?.birthDateTime.toString().substring(10, 13) ?? ""}",
                            "**:** AM",
                            icon: const Icon(
                                Icons.watch_later_outlined,
                                color: Colors.white),
                            bgColor: Colors.redAccent),
                        getProfileController.otherProfileDetail
                            ?.data?.user?.profileViewed ==
                            "Yes"
                            ? basicTile(
                            showIcon: false,
                            heading: "Place of birth",
                            text: getProfileController
                                .otherProfileDetail!
                                .data!
                                .user!
                                .birthPlace!,
                            icon: const Icon(Icons.place,
                                color: Colors.white),
                            bgColor: Colors.redAccent)
                            : basicTile(
                            showIcon: true,
                            heading: "Place of birth",
                            text: getProfileController
                                .otherProfileDetail!
                                .data!
                                .user!
                                .birthPlace!
                                .length >
                                4
                                ? "${getProfileController.otherProfileDetail!.data!.user!.birthPlace.toString().substring(0, 4)}*****"
                                : "${getProfileController.otherProfileDetail?.data?.user?.birthPlace.toString() ?? ""}*****",
                            icon: const Icon(Icons.place,
                                color: Colors.white),
                            bgColor: Colors.redAccent),

                      ],
                    ),
                  ),
                ),

              ],
            ),
          );
        });
  }
  // void _modalBottomSheetMenu() {
  //   showModalBottomSheet(
  //       context: context,
  //       builder: (builder) {
  //         return modelSheet(context);
  //       });
  // }

  showAlertDialog(context, price, profileId) {
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          return AlertDialog(
            insetPadding:
                EdgeInsets.symmetric(horizontal: AppConfig.width * 0.05),
            title: const Text("Alert"),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "You want to view this detail",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "We deduct this amount(${getProfileController?.otherProfileDetail?.data?.user?.profileView??0} points) from your wallet",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                        onTap: () async{
                          bool? res=await getProfileController?.deductMoney(
                              context, profileId, price);
                          Navigator.pop(context);
                          // openCheckout();
                        },
                        child: Container(
                          width: AppConfig.width * 0.3,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "Yes,Sure",
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                              // const Text("Click Here to Avtivate your profile",style: TextStyle(color: Colors.white),),
                            ],
                          ),
                        )),
                    SizedBox(
                      width: 20,
                    ),
                    GestureDetector(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: Text("Cancel"))
                  ],
                )
              ],
            ),
            actions: [],
          );
        });
      },
    );
  }

  showAlertPaymentDialog(context) {
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          return AlertDialog(
            insetPadding:
                EdgeInsets.symmetric(horizontal: AppConfig.width * 0.05),
            title: const Text("Alert"),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "You want to view this detail",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "You don't have enough money in your wallet ,\nAdd Money in wallet",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                        onTap: () {
                           openCheckout();
                           Navigator.pop(context);
                        },
                        child: Container(
                          width: AppConfig.width * 0.3,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: AppConfig.theme.primaryColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "Yes,Sure",
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                              // const Text("Click Here to Avtivate your profile",style: TextStyle(color: Colors.white),),
                            ],
                          ),
                        )),
                    SizedBox(
                      width: 20,
                    ),
                    GestureDetector(
                        onTap: (){
                          Navigator.pop(context);

                        },
                        child: Text("Cancel"))
                  ],
                )
              ],
            ),
            actions: [],
          );
        });
      },
    );
  }
}
