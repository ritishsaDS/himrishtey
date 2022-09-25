import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:rishtey/controller/update_controller.dart';
import 'package:rishtey/models/states_model.dart';
import 'package:rishtey/presentation/profile/personal_profile.dart';
import 'package:rishtey/presentation/register/widgets/rounded_date_picker.dart';
import 'package:rishtey/utils/shared_pref.dart';

import '../../controller/auth_controller.dart';
import '../../utils/app_snack_bar.dart';

class ContactDetails extends StatefulWidget {
  Map<String,dynamic>?data;
  final String?title;
  ContactDetails({Key? key,this.data,this.title}) : super(key: key);

  @override
  State<ContactDetails> createState() => _ContactDetailsState();
}

class _ContactDetailsState extends State<ContactDetails> {
  AuthController? authController;
UpdateController?updateController;

  final registerKey = GlobalKey<FormState>();
  TextEditingController alternateNumber=TextEditingController();
  TextEditingController alternateNumber2=TextEditingController();
  TextEditingController whatsappNumber=TextEditingController();
  @override
  void initState() {
    updateController=Provider.of<UpdateController>(context,listen: false);
    authController = Provider.of<AuthController>(context,listen: false);
    //print(widget.data!['manglik']);
    authController!.phoneNumber=TextEditingController(text: widget.data!['mobile_number']);
    authController!.email=TextEditingController(text: widget.data!['email']);
    alternateNumber=TextEditingController(text:widget.data!['alternate_number'] );
    alternateNumber2=TextEditingController(text:widget.data!['alternate_number'] );
    whatsappNumber=TextEditingController(text:widget.data!['whatsapp_number'] );
    super.initState();
  }

  double loginWidth=350;
  static String _displayStates(States option) => option.name!;

  @override
  Widget build(BuildContext context) {

    //authController!.birthPlace=TextEditingController(text: widget.data!['birth_place']);
    return Scaffold(
      appBar: AppBar(title: Text(widget.title!),

      ),
      body: Container(
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Email",
                style:
                TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
              ),
              const SizedBox(height: 5),
              TextFormField(
                readOnly: true,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(10),
                ],
                controller: authController!.email,
                decoration: const InputDecoration(
                  filled: true,
                  hintText: "Enter Email",
                  labelStyle: TextStyle(
                      color: Color(
                        0xff961b20,
                      ),
                      fontSize: 16),
                  fillColor: Colors.transparent,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Phonenumber';
                  }
                  if (value.length <=9) {
                    return 'Phone Number Length Should be 10 Digit';
                  }
                  return null;
                },
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 20),
              const Text(
                "Phone Number",
                style:
                TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
              ),
              const SizedBox(height: 5),
              TextFormField(
                readOnly: true,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(10),
                ],
                controller: authController!.phoneNumber,
                decoration: const InputDecoration(
                  filled: true,
                  hintText: "Enter Phone Number",
                  labelStyle: TextStyle(
                      color: Color(
                        0xff961b20,
                      ),
                      fontSize: 16),
                  fillColor: Colors.transparent,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Phonenumber';
                  }
                  if (value.length <=9) {
                    return 'Phone Number Length Should be 10 Digit';
                  }
                  return null;
                },
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 20),
              const Text(
                "Alternate Number",
                style:
                TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
              ),
              const SizedBox(height: 5),
              TextFormField(

                readOnly: false,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(14),
                ],
                controller: alternateNumber,
                decoration: const InputDecoration(
                  filled: true,
                  hintText: "Enter Alternate Number",
                  labelStyle: TextStyle(
                      color: Color(
                        0xff961b20,
                      ),
                      fontSize: 16),
                  fillColor: Colors.transparent,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Phonenumber';
                  }
                  if (value.length <=9) {
                    return 'Phone Number Length Should be 10 Digit';
                  }
                  return null;
                },
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 20),
              const Text(
                "Alternate Number",
                style:
                TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
              ),
              const SizedBox(height: 5),
              TextFormField(

                readOnly: false,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(14),
                ],
                controller: alternateNumber2,
                decoration: const InputDecoration(
                  filled: true,
                  hintText: "Enter Alternate Number",
                  labelStyle: TextStyle(
                      color: Color(
                        0xff961b20,
                      ),
                      fontSize: 16),
                  fillColor: Colors.transparent,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Phonenumber';
                  }
                  if (value.length <=9) {
                    return 'Phone Number Length Should be 10 Digit';
                  }
                  return null;
                },
                keyboardType: TextInputType.phone,
              ),
          const SizedBox(height: 20),
          const Text(

            "Whatsapp Number",
            style:
            TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
          ),
          const SizedBox(height: 5),
          TextFormField(

            readOnly: false,
            inputFormatters: [
              LengthLimitingTextInputFormatter(10),
            ],
            controller: whatsappNumber,
            decoration: const InputDecoration(
              filled: true,
              hintText: "Enter Whatsapp Number",
              labelStyle: TextStyle(
                  color: Color(
                    0xff961b20,
                  ),
                  fontSize: 16),
              fillColor: Colors.transparent,
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter Phonenumber';
              }
              if (value.length <=9) {
                return 'Phone Number Length Should be 10 Digit';
              }
              return null;
            },
            keyboardType: TextInputType.phone,
          )
              ,
              const SizedBox(height: 40),
              Center(
                child: GestureDetector(
                  onTap: () async{



                      var user_id = await SharedPref().getString(key: "user_id");
                      Map<String, dynamic> data ={
                        "user_id":user_id,
                        "mobile_number":authController!.phoneNumber.text,
                        "alternate_number":alternateNumber.text,
                        "email":authController!.email.text,
                        "whatsapp_number":whatsappNumber.text,
                      };
                      bool res= await updateController!.updateBasicDetails(context, data);

                      if(res==true){
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>PersonalProfile()));
                      }
                      setState(() {



                      });
                    },

                  child: AnimatedContainer(
                      width: loginWidth,
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

            ],),
        ),),
    );}
  void _showDatePicker(ctx) {
    // showCupertinoModalPopup is a built-in function of the cupertino library
    showCupertinoModalPopup(

        context: ctx,
        builder: (_) => Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(16.0),color: Colors.black,),
          height: 300,

          child: CupertinoTheme(data: CupertinoThemeData(
            textTheme: CupertinoTextThemeData(
              dateTimePickerTextStyle: TextStyle(
                  fontSize: 16,
                  color: Colors.white
              ),
            ),
          ),

            child: Column(
              children: [
                SizedBox(
                  height: 240,
                  child: CupertinoDatePicker(

                      mode: CupertinoDatePickerMode.time,

                      initialDateTime: DateTime.now(),
                      onDateTimeChanged: (val) {
                        setState(() {
                          if(int.parse(val.toString().split(" ")[1].substring(0,2))<12){

                            authController?.birthTime.text = val.toString().split(" ")[1].substring(0,5)+" AM";
                          }
                          else{
                            var hours;

                            hours=int.parse(val.toString().split(" ")[1].substring(0,2))-12;
                            authController?.birthTime.text=hours.toString()+":"+val.toString().split(" ")[1].substring(3,5)+" PM";
                          }

                        });
                      }),
                ),

                // Close the modal
                CupertinoButton(

                  child: const Text('Submit',style: TextStyle(color: Colors.white),),
                  onPressed: () => Navigator.of(ctx).pop(),
                )
              ],
            ),),
        ));
  }
}