import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:rishtey/controller/ImagePickerController.dart';
import 'package:rishtey/utils/app_config.dart';

import '../../controller/dashboard_controller.dart';
import '../../controller/get_profile_controller.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({Key? key}) : super(key: key);

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  bool changeColor = false;
  int checkIndex =0;
  ImagePickerController?imagePickerController;
TextEditingController textEditingController=TextEditingController();
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
      imagePickerController=Provider.of<ImagePickerController>(context,listen: false);

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
      'amount': int.parse(textEditingController.text)*100,
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
    getProfileController!.addMoneyInWallet(getProfileController?.otherProfileDetail?.data?.user?.id,context,textEditingController.text,response.paymentId,"RazorPay",type: "wallet");

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
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        
        backgroundColor: AppConfig.theme.primaryColor,
        shadowColor: AppConfig.theme.primaryColor,
        title: const Text('Wallet',style: TextStyle(color: Colors.white,
            fontSize: 25),),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [

               Icon(Icons.account_balance_wallet_sharp,color: AppConfig.theme.primaryColor),
                SizedBox(width: 10,),
              Consumer<GetProfileController>(
                builder: (context,controller,child) {
                  return Text('Balance- ${controller.getProfileModel?.data?.user?.walletAmount}',style: TextStyle(
                      color: Colors.black,fontSize: size.height*0.023
                  ),);
                }
              ),
                SizedBox(width: 10,)
            ],),
            Row(children: [
              SizedBox(width: size.width*0.07,height: size.height*0.03,),
              Text('Add coins to wallet',style: TextStyle(
                  fontSize: size.height*0.023,
                  fontWeight: FontWeight.bold
              ),)
            ],),
            Row(children: [
              SizedBox(width: size.width*0.07,height: size.height*0.03,),
              Text(r'you can add upto $10k coins',style: TextStyle(
                fontSize: size.height*0.018,
              ),)
            ],),
            //SizedBox(height: size.height*0.02,),
             Padding(
              padding: EdgeInsets.all(20),
              child: TextField(
controller: textEditingController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "Enter amount of coins to add",
                  contentPadding: EdgeInsets.symmetric(horizontal: 20),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),

                        borderSide: BorderSide(color: Colors.grey)
                    )
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [

                  GestureDetector(
                    onTap: (){
                      textEditingController.text="500";
                      setState(() {

                      });
                    },
                    child: Container(
alignment: Alignment.center,
                      width: size.width*0.25,
                      height: size.height*0.04,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(color: Colors.grey)
                      ),
                      child:  Text(
                        "500+",style: TextStyle(fontSize: 18,color: AppConfig.theme.primaryColor,fontWeight: FontWeight.w800),)),
                  ),

                  GestureDetector(
                    onTap: (){
                      textEditingController.text="1000";
                      setState(() {

                      });
                    },
                    child: Container(
                        alignment: Alignment.center,
                        width: size.width*0.25,
                        height: size.height*0.04,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(color: Colors.grey)
                        ),
                        child:  Text(
                          "1000+",style: TextStyle(fontSize: 18,color: AppConfig.theme.primaryColor,fontWeight: FontWeight.w800),)),
                  ),

                  GestureDetector(
                    onTap: (){
                      textEditingController.text="2000";
                      setState(() {

                      });
                    },
                    child: Container(
                        alignment: Alignment.center,
                        width: size.width*0.25,
                        height: size.height*0.04,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(color: Colors.grey)
                        ),
                        child:  Text(
                          "2000+",style: TextStyle(fontSize: 18,color: AppConfig.theme.primaryColor,fontWeight: FontWeight.w800),)),
                  ),

                ],),
            ),
            SizedBox(height: 10,),
            ElevatedButton(onPressed: (){
              openCheckout();
            }, child: Text('Add+',
              style: TextStyle(fontSize: size.height*0.02),),
              style:  ElevatedButton.styleFrom(
                  primary: AppConfig.theme.primaryColor,
                  padding: const EdgeInsets.symmetric(horizontal: 40)
              ),
            ),
            SizedBox(height: 10,),
             Row(children: [
               SizedBox(width: size.width*0.08,height: size.height*0.04,),
               Text('Show Transaction History',style: TextStyle(
                 fontSize: size.height*0.02,
               ),),
               Spacer(),
               Icon(Icons.arrow_forward),
               SizedBox(width: size.width*0.08,)
             ],),
            SizedBox(height: size.height*0.01),
            Text('Add Coin From Our\n Special Offers',style: TextStyle(
                fontSize: size.height*0.025,
                fontWeight: FontWeight.bold
            ),textAlign: TextAlign.center),
            Text('Limited Time offers',style: TextStyle(
                color: Colors.red,
                fontSize: size.height*0.018,
                fontWeight: FontWeight.bold
            ),textAlign: TextAlign.center,),

            SizedBox(height: size.height*0.03),
            // Container(
            //   height: size.height*0.325,
            //   width: size.width*0.3,
            //   color: Colors.green,
            // )
            Expanded(
              child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  itemBuilder:(BuildContext context,int index){
                    return priceList(context,index);
                  }),
            ),
          ],
        ),
      ),
    );
  }
  Widget priceList(BuildContext context ,int index){
    Size size =MediaQuery.of(context).size;
    changeColor = index == checkIndex;
    //changeColor = changeColors == true;
    return Container(
      margin: EdgeInsets.only(right: 5),
      height: size.height*0.05,
      width: size.width*0.48,
      decoration: BoxDecoration(
        border: Border.all(color:const Color(0xff4baca7)),
        color:AppConfig.theme.primaryColor
      ),
      child: Column(
        // mainAxisSize: MainAxisSize.max,
        children: [
          Container(
              height: size.height*0.05,
              width: size.width*0.5,
              decoration: BoxDecoration(
                border: Border.all(color:const Color(0xff3187a3)),
                color:const Color(0xff56d6d9),
              ),
              child: Center(
                child: Text("Name",style: TextStyle(
                    fontSize: size.height*0.03,
                    color:const Color(0xff063042),
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic
                ),),
              )
          ),
          SizedBox(height: size.height*0.006),
          Card(
            elevation: 10,
            child: Container(
                height: size.height*0.05,
                width: size.width*0.5,
                decoration: BoxDecoration(
                  border: Border.all(color:const Color(0xffcdffee)),
                  color:const Color(0xff7fe7bf),
                ),
                child: Center(
                  child: Text("Validity-*****",style: TextStyle(
                    fontSize: size.height*0.023,
                    color: Colors.white,
                    //fontWeight: FontWeight.bold,
                    //fontStyle: FontStyle.italic
                  ),),
                )
            ),
          ),
          //SizedBox(height: size.height*0.098),
          SizedBox(height: size.height*0.01),

          Container(
              height: size.height*0.2,
              width: size.width*0.5,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
                borderRadius:const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                ),
                color:const Color(0xff029ed7),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,

                children: [
                  Card(color: Colors.transparent,
                    elevation: 10,
                    child: Container(
                        height: size.height*0.05,
                        width: size.width*0.35,
                        decoration: BoxDecoration(
                          border: Border.all(color:const Color(0xff6acad7)),
                          borderRadius:const BorderRadius.only(
                            topRight: Radius.circular(10),
                            topLeft: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          ),
                          color:const Color(0xffd9f9f5),
                        ),
                        child: Center(
                          child: Text(r"$ 1000",style: TextStyle(
                            fontSize: size.height*0.023,
                            fontWeight: FontWeight.bold,
                            color:const Color(0xff030206),
                            //fontWeight: FontWeight.bold,
                            //fontStyle: FontStyle.italic
                          ),
                          ),
                        )
                    ),
                  ),
                  //SizedBox(height: size.height*0.02),

                  Card(
                    color: Colors.transparent,
                    elevation: 10,
                    child: Container(
                        height: size.height*0.05,
                        width: size.width*0.35,
                        decoration: BoxDecoration(
                          border: Border.all(color:const Color(0xff6acad7)),
                          borderRadius:const BorderRadius.only(
                            topRight: Radius.circular(10),
                            topLeft: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          ),
                          color:const Color(0xffd9f9f5),
                        ),
                        child: Center(
                          child: Text(r"$ 950",style: TextStyle(
                            fontSize: size.height*0.023,
                            fontWeight: FontWeight.bold,
                            color:const Color(0xff030206),
                            //fontWeight: FontWeight.bold,
                            //fontStyle: FontStyle.italic
                          ),),
                        )
                    ),
                  ),
                  SizedBox(
                    height: size.height*0.01,
                  ),
                  InkWell(
                      onTap: (){

                        setState(() {
                          checkIndex = index;
                          changeColor =! changeColor;
                        });
                      },
                      child:changeColor?const Icon(Icons.circle,size: 25,color: Color(0xff98bb45),):
                      const  Icon(Icons.circle,size: 25,color: Color(0xfffdfef9),)
                    // :const Icon(Icons.circle,size: 25,color: ,)
                  )
                ],
              )
          )
        ],
      ),
    );
  }

}