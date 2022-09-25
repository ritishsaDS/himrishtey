import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:rishtey/controller/ImagePickerController.dart';
import 'package:rishtey/models/get_memberships.dart';
import 'package:rishtey/utils/app_button.dart';
import 'package:rishtey/utils/app_config.dart';

class Planscreen extends StatefulWidget {
  const Planscreen({Key? key, }) : super(key: key);

  @override
  State<Planscreen> createState() => _PlanscreenState();
}

class _PlanscreenState extends State<Planscreen> {
  Razorpay? _razorpay;
  ImagePickerController? imagePickerController;
  @override
  void initState() {
    _razorpay = Razorpay();
    _razorpay!.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay!.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay!.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    //openCheckout();
    Future.delayed(Duration(milliseconds: 100), () {
      imagePickerController =
          Provider.of<ImagePickerController>(context, listen: false);
      imagePickerController?.getMemberships(context);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay!.clear();
  }

  void openCheckout(price) async {
    var options = {
      'key': 'rzp_test_12T0t47clp4pRC',
      'amount': double.parse(price)*100,
      'name': 'Shaiq',
      'description': 'Payment',
      'prefill': {'contact': '8888888888', 'email': 'test@razorpay.com'},
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
    print(response);
    //getProfileController!.updatePaymentStatus(context);

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
    return Scaffold(
        appBar: AppBar(
          title: Text("My Memberships"),

        ),
        body: Consumer<ImagePickerController>(
          builder: (context,controller,child) {
            return Container(
              //height: AppConfig.height*0.8,
              width: AppConfig.width * 1,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  //physics: NeverScrollableScrollPhysics(),
                  //shrinkWrap: true,
                  itemCount: imagePickerController
                      ?.getMembershipsModel?.memberships?.length,
                  itemBuilder: (context, index) {
                    return Container(

                      width: AppConfig.width * 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 20,
                          ),

                          Row(

                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                width: 10,
                                height: 10,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle, color: Colors.black),
                              ),
                              Spacer(),
                              Container(
                                child: Text(
                                  imagePickerController?.getMembershipsModel
                                          ?.memberships?[index].membershipName ??
                                      "",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: AppConfig.theme.primaryColor),
                                ),
                              ),
                              Spacer(),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                width: 10,
                                height: 10,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle, color: Colors.black),
                              ),
                              Spacer(),
                              Container(
                                width: AppConfig.width * 0.9,
                                child: Text(
                                    imagePickerController?.getMembershipsModel
                                            ?.memberships?[index].planDescription ??
                                        "",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        color: AppConfig.theme.primaryColor)),
                              ),
                              Spacer(),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),

                          Row(
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                width: 10,
                                height: 10,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle, color: Colors.black),
                              ),
                              Spacer(),
                              Container(
                                width: AppConfig.width * 0.9,
                                child: Text(
                                    imagePickerController?.getMembershipsModel
                                            ?.memberships?[index].tagLine1 ??
                                        "",
                                    maxLines: 2,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        color: AppConfig.theme.primaryColor)),
                              ),
                              Spacer(),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),

                          Row(
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                width: 10,
                                height: 10,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle, color: Colors.black),
                              ),
                              Spacer(),
                              Container(
                                width: AppConfig.width * 0.9,
                                child: Text(
                                    imagePickerController?.getMembershipsModel
                                        ?.memberships?[index].tagLine4 ??
                                        "",
                                    maxLines: 2,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        color: AppConfig.theme.primaryColor)),
                              ),
                              Spacer(),
                            ],
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: AppConfig.width * 0.3,
                                  height: AppConfig.height * 0.25,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text("Price"),
                                      Divider(
                                        thickness: 1.5,
                                        height: 20,
                                      ),
                                      Text(
                                        "₹${imagePickerController?.getMembershipsModel?.memberships?[index].planCost ?? ""}",
                                        style: TextStyle(
                                            color: AppConfig.theme.primaryColor,
                                            fontWeight: FontWeight.w600),
                                      )
                                    ],
                                  ),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          color: AppConfig.theme.primaryColor)),
                                ),
                                Container(
                                  width: AppConfig.width * 0.3,
                                  height: AppConfig.height * 0.25,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text("Time"),
                                      Divider(
                                        thickness: 1.5,
                                        height: 20,
                                      ),
                                      Text(
                                        "${imagePickerController?.getMembershipsModel?.memberships?[index].durationDays ?? ""} Days",
                                        style: TextStyle(
                                            color: AppConfig.theme.primaryColor,
                                            fontWeight: FontWeight.w600),
                                      )
                                    ],
                                  ),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          color: AppConfig.theme.primaryColor)),
                                ),
                                Container(
                                  width: AppConfig.width * 0.3,
                                  height: AppConfig.height * 0.25,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text("Other"),
                                      Divider(
                                        thickness: 1.5,
                                        height: 20,
                                      ),
                                      Text("${imagePickerController?.getMembershipsModel?.memberships?[index].tagLine5 ?? ""}")
                                    ],
                                  ),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          color: AppConfig.theme.primaryColor)),

                                ),

                              ],
                            ),
                          ),
                          SizedBox(height: 40,),
                          // Expanded(child: SizedBox()),
                          AppButton(
                            onClick: () {
                              openCheckout(imagePickerController?.getMembershipsModel?.memberships?[index].planCost);
                            },
                            textWidet: Text("Buy Membership",style: TextStyle(color: Colors.white),),
                          )
                        ],
                      ),
                    );
                  }),
            );
          }
        ));
  }
}
