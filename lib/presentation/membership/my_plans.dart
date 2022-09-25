import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:rishtey/controller/get_profile_controller.dart';
import 'package:rishtey/presentation/membership/my_plains_new.dart';
import 'package:rishtey/utils/app_button.dart';
import 'package:rishtey/utils/app_config.dart';

import '../../controller/ImagePickerController.dart';
import '../../models/plains_model.dart';

class ActivationDesign extends StatefulWidget {
  final String? id;
  final String? firstLine;
  final String? secondLine;
  final String? thirdLine;
  final String? fourthLine;
  final String? fifthLine;
  final String? memebershipName;
  const ActivationDesign(
      {Key? key,
      this.memebershipName,
      this.id,
      this.fifthLine,
      this.firstLine,
      this.secondLine,
      this.thirdLine,
      this.fourthLine})
      : super(key: key);

  @override
  State<ActivationDesign> createState() => _ActivationDesignState();
}

class _ActivationDesignState extends State<ActivationDesign> {
  bool changeColor = false;
  int checkIndex = 0;
  ImagePickerController? imagePickerController;
  GetProfileController? getProfileController;
  Razorpay? _razorpay;

  @override
  void dispose() {
    super.dispose();
    _razorpay!.clear();
  }

  void openCheckout(
    price,
  ) async {
    var options = {
      'key': 'rzp_test_12T0t47clp4pRC',
      'amount': double.parse(price) * 100,
      'name': '${getProfileController?.getProfileModel?.data?.user?.fullName}',
      'description': 'Payment',
      'prefill': {
        'contact':
            '${getProfileController?.getProfileModel?.data?.user?.mobileNumber}',
        'email': '${getProfileController?.getProfileModel?.data?.user?.email}'
      },
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
    print("lkndsvlkfvkjresponse");
    print(response.signature);
    print(response.paymentId);
    print(response.orderId);
    getProfileController!.updatePaymentStatus(
        context,
        imagePickerController?.plainsModel?.memberships?[checkIndex].id,
        DateTime.now(),
        imagePickerController?.plainsModel?.memberships?[checkIndex].planCost,
        response.paymentId,
        "RazorPay");
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(
        msg: "ERROR: " + response.code.toString() + " - " + response.message!,
        timeInSecForIosWeb: 4);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
        msg: "EXTERNAL_WALLET: " + response.walletName!, timeInSecForIosWeb: 4);
  }

  @override
  void initState() {
    _razorpay = Razorpay();
    _razorpay!.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay!.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay!.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    Future.delayed(Duration(milliseconds: 100), () {
      imagePickerController =
          Provider.of<ImagePickerController>(context, listen: false);
      getProfileController =
          Provider.of<GetProfileController>(context, listen: false);
      imagePickerController?.getPlains(context, widget.id);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      //appBar: AppBar(title: Text("Plains"), ),
      // backgroundColor: const Color(0xffcffbec),
      body: SafeArea(
        child: Consumer<ImagePickerController>(
            builder: (context, controller, child) {
          return controller.isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Stack(children: [
                        ClipPath(
                          clipper: DrawClip2(),
                          child: Container(
                            width: size.width,
                            height: size.height * 0.16,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [
                                    AppConfig.theme.primaryColor,
                                    AppConfig.theme.primaryColor
                                        .withOpacity(0.6)
                                  ],
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.bottomRight),
                            ),
                          ),
                        ),
                        ClipPath(
                          clipper: DrawClip(),
                          child: Container(
                            width: size.width,
                            height: size.height * 0.14,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  // colors: [Color(0xffddc3fc), Color(0xff91c5fc)],
                                  colors: [
                                    AppConfig.theme.primaryColor,
                                    AppConfig.theme.primaryColor
                                        .withOpacity(0.6)
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight),
                            ),
                          ),
                        ),
                        Center(
                          child: Container(
                              padding: EdgeInsets.only(top: 20),
                              child: Text(
                                "${widget.memebershipName}",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w800),
                              )),
                        )
                      ]),
                    ),
                    //SizedBox(height: size.height * 0.01),
                    Text(" Plains Descriptions",style: TextStyle(color: AppConfig.theme.primaryColor,fontSize: 18,fontWeight: FontWeight.w800),),
                    SizedBox(height: 10,),
                    Container(
                      height: size.height * 0.3,
                      width: size.width * 0.95,
                      //color: Colors.white,
                      decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xff2bc797)),
                          color: Colors.white),
                      child: ListView(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(width: size.width * 0.01),
                              const Icon(
                                Icons.adjust,
                                color: Color(0xff03266c),
                              ),
                              SizedBox(width: size.width * 0.02),
                              Container(
                                width: AppConfig.width * 0.8,
                                child: Text(
                                  "${widget.firstLine}",
                                  style: TextStyle(
                                    fontSize: size.height * 0.02,
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(width: size.width * 0.01),
                              const Icon(
                                Icons.adjust,
                                color: Color(0xff03266c),
                              ),
                              SizedBox(width: size.width * 0.02),
                              Container(
                                width: AppConfig.width * 0.8,
                                child: Text(
                                  "${widget.secondLine}",
                                  style: TextStyle(
                                    fontSize: size.height * 0.02,
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(width: size.width * 0.01),
                              const Icon(
                                Icons.adjust,
                                color: Color(0xff03266c),
                              ),
                              SizedBox(width: size.width * 0.02),
                              Container(
                                width: AppConfig.width * 0.8,
                                child: Text(
                                  "${widget.thirdLine}",
                                  style: TextStyle(
                                    fontSize: size.height * 0.02,
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(width: size.width * 0.01),
                              const Icon(
                                Icons.adjust,
                                color: Color(0xff03266c),
                              ),
                              SizedBox(width: size.width * 0.02),
                              Container(
                                width: AppConfig.width * 0.8,
                                child: Text(
                                  "${widget.fourthLine}",
                                  style: TextStyle(
                                    fontSize: size.height * 0.02,
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(width: size.width * 0.01),
                              const Icon(
                                Icons.adjust,
                                color: Color(0xff03266c),
                              ),
                              SizedBox(width: size.width * 0.02),
                              Container(
                                width: AppConfig.width * 0.8,
                                child: Text(
                                  "${widget.fifthLine}",
                                  style: TextStyle(
                                    fontSize: size.height * 0.02,
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(width: size.width * 0.01),
                              const Icon(
                                Icons.adjust,
                                color: Color(0xff03266c),
                              ),
                              SizedBox(width: size.width * 0.02),
                              Container(
                                width: AppConfig.width * 0.8,
                                child: Text(
                                  "${widget.fifthLine}",
                                  style: TextStyle(
                                    fontSize: size.height * 0.02,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: size.height * 0.02),

                    Expanded(
                      child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount:
                              controller.plainsModel!.memberships!.length,
                          itemBuilder: (BuildContext context, int index) {
                            return priceList(context, index,
                                controller.plainsModel!.memberships![index]);
                          }),
                    ),
                    SizedBox(height: size.height * 0.02),
                    AppButton(
                      onClick: () {
                        openCheckout( imagePickerController?.plainsModel?.memberships?[checkIndex].planCost);
                      },
                      textWidet: Text(
                        "Buy Now",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                    // GestureDetector(
                    //   onTap: (){
                    //
                    //   },
                    //   child: Container(
                    //       width: AppConfig.width*0.4,
                    //       height: AppConfig.height*0.05,
                    //       decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(10)),
                    //       child: Center(child: Text("Buy Now",style: TextStyle(
                    //           fontSize: 18,
                    //           fontWeight: FontWeight.w600,
                    //           color: AppConfig.theme.primaryColor),))),)
                  ],
                );
        }),
      ),
    );
  }

  Widget priceList(BuildContext context, int index, Memberships? model) {
    Size size = MediaQuery.of(context).size;
    changeColor = index == checkIndex;
    //changeColor = changeColors == true;
    return GestureDetector(
      onTap: (){
        checkIndex=index;
        setState(() {

        });
      },
      child: Container(
        height: size.height * 0.03,
        width: size.width * 0.5,
        margin: EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
           border: Border.all(color:checkIndex==index?AppConfig.theme.primaryColor:Colors.white,width: 2),
          color: AppConfig.theme.primaryColor.withOpacity(0.3),
        ),
        child: Column(
          // mainAxisSize: MainAxisSize.max,
          children: [
            Container(
                height: size.height * 0.07,
                width: size.width * 0.5,
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xff3187a3)),
                  color: AppConfig.theme.primaryColor.withOpacity(0.5),
                ),
                child: Center(
                  child: Text(
                    model?.planName ?? "",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: size.height * 0.02,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                )),
            SizedBox(height: 10),
            Card(
              elevation: 10,
              child: Container(
                  height: size.height * 0.05,
                  width: size.width * 0.5,
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xffcdffee)),
                    color: AppConfig.theme.shadowColor,
                  ),
                  child: Center(
                    child: Text(
                      "Val-${model?.durationDays} Days",
                      style: TextStyle(
                        fontSize: size.height * 0.02,
                        color: Colors.white,
                        //fontWeight: FontWeight.bold,
                        //fontStyle: FontStyle.italic
                      ),
                    ),
                  )),
            ),
            //SizedBox(height: size.height*0.098),
            SizedBox(height: size.height * 0.02),

            Container(
                height: size.height * 0.18,
                width: size.width * 0.45,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                  ),
                  color: const Color(0xff029ed7),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Prices (in INR)",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w600),
                    ),
                    Card(
                      color: Colors.transparent,
                      elevation: 10,
                      child: Container(
                          height: size.height * 0.05,
                          width: size.width * 0.35,
                          decoration: BoxDecoration(
                            border: Border.all(color: const Color(0xff6acad7)),
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(10),
                              topLeft: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            ),
                            color: const Color(0xffd9f9f5),
                          ),
                          child: Center(
                            child: Text(
                              "${model?.discountPercentage}",
                              style: TextStyle(
                                fontSize: size.height * 0.023,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.lineThrough,
                                color: const Color(0xff030206),
                                //fontWeight: FontWeight.bold,
                                //fontStyle: FontStyle.italic
                              ),
                            ),
                          )),
                    ),
                    // SizedBox(
                    //   height: size.height*0.01,
                    // ),
                    Card(
                      color: Colors.transparent,
                      elevation: 10,
                      child: Container(
                          height: size.height * 0.05,
                          width: size.width * 0.35,
                          decoration: BoxDecoration(
                            border: Border.all(color: const Color(0xff6acad7)),
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(10),
                              topLeft: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            ),
                            color: const Color(0xffd9f9f5),
                          ),
                          child: Center(
                            child: Text(
                              "${model?.planCost}",
                              style: TextStyle(
                                fontSize: size.height * 0.023,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xff030206),
                                //fontWeight: FontWeight.bold,
                                //fontStyle: FontStyle.italic
                              ),
                            ),
                          )),
                    ),
                    //SizedBox(height: size.height*0.02),

                    // InkWell(
                    //     onTap: (){
                    //
                    //       setState(() {
                    //         checkIndex = index;
                    //         changeColor =! changeColor;
                    //       });
                    //     },
                    //     child:changeColor?const Icon(Icons.circle,size: 25,color: Color(0xff98bb45),):
                    //     const  Icon(Icons.circle,size: 25,color: Color(0xfffdfef9),)
                    //   // :const Icon(Icons.circle,size: 25,color: ,)
                    // )
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
