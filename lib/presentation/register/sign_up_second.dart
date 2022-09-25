import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rishtey/models/height_model.dart';
import 'package:rishtey/presentation/login/login_2.dart';
import 'package:rishtey/presentation/register/sign_up_third.dart';
import 'package:rishtey/presentation/register/widgets/rounded_date_picker.dart';
import 'package:rishtey/presentation/register/widgets/rounded_picker.dart';
import 'package:rishtey/utils/app_snack_bar.dart';

import '../../controller/auth_controller.dart';
import '../../models/city_model.dart';
import '../../models/country_model.dart';
import '../../models/states_model.dart';
class SignUpSecond extends StatefulWidget {
  const SignUpSecond({Key? key}) : super(key: key);

  @override
  State<SignUpSecond> createState() => _SignUpState();
}

class _SignUpState extends State<SignUpSecond> {
  AuthController? authController;
  double loginWidth = 350;
  final registerKey = GlobalKey<FormState>();
  var heightId;
  var stateId;

  static String _displayStringForOption(Countries option) => option.name!;
  static String _displayStates(States option) => option.name!;
  static String _displayCities(Statess option) => option.name!;
  static String _displayHeights(Heights option) => option.height!;
  CountryModel? data;


  @override
  void initState() {
    authController=Provider.of<AuthController>(context,listen: false);
    getData();
    super.initState();
  }
  getData()async{
    data=await authController!.getCountries(context);
  }
  @override
  Widget build(BuildContext context) {
  //  authController = Provider.of<AuthController>(context);
    return Scaffold(
        body:  SafeArea(
            child: Container(
                margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                height: MediaQuery.of(context).size.height,

                child: Form(
                  key: registerKey,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Center(child:  Text("Good! your profile is 20% Completed",style: TextStyle(fontWeight: FontWeight.w800,fontSize: 16),)),
                      SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,

                        children: [

                          Container(

                            height: 100,
                            width: 85,

                            decoration: const BoxDecoration(shape: BoxShape.circle, image: DecorationImage(image: AssetImage("assets/pngIcons/Purple Login Screen.png"),fit: BoxFit.fill)),
                            child: Image.asset("assets/pngIcons/logo_icon 1.png",fit: BoxFit.fitWidth,),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20,),


                  const SizedBox(
                  height: 20,
                ),
                  const Text(
                    "Select Height(in ft.)",
                    style:
                    TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
                  ),
                  const SizedBox(height: 5),
                  Autocomplete<Heights>(
                    displayStringForOption: _displayHeights,
                    optionsBuilder: (TextEditingValue textEditingValue) {
                      return authController!.heightModel!.heights!
                          .where((Heights option) {
                        return option.height!
                            .toLowerCase()
                            .contains(textEditingValue.text.toLowerCase());
                      });
                    },
                    onSelected: (Heights selection) {
                      setState(() {
                        authController!.height=TextEditingController(text: selection.height);
                        heightId=selection.id;
                        //authController!.countryId=int.parse(selection.id.toString());
                        //stateValue = selection.id.toString();
                      });
                      //authController!.getStates(context);
                    },
                    fieldViewBuilder: (context, controller, focusNode,
                        onEditingComplete) {
                      //  this.stateController = controller;

                      return TextFormField(
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'[]')),
                        ],
                        controller: controller,
                        focusNode: focusNode,
                        onEditingComplete: onEditingComplete,
                        decoration:const InputDecoration(
                          filled: false,
                          fillColor: Colors.white70,

                          hintText: "Select Height",
                        ),
                        validator: (val){
                          if(heightId==null||heightId==0){
                            return "Please Choose Height From Dropdown";
                          }
                        },
                      );
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
Container(

  width: MediaQuery.of(context).size.width,
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
    Column(children: [
      const Text(
        "Select Date of birth",
        style:
        TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
      ),
      const SizedBox(height: 5),
      Container(

        width: MediaQuery.of(context).size.width*0.4,
        child: TextFormField(
          controller: authController!.dateinput,
          decoration: const InputDecoration(
              filled: true,

              hintText: "Enter Your Date Of Birth",
              labelStyle: TextStyle(
                color: Color(
                0xff961b20,
                ),
                fontSize: 16),
              fillColor: Colors.transparent,

              //fillColor: Colors.green
          ),onTap: (){
          CupertinoRoundedDatePickers.show(
              context,
              fontFamily: "Poppins",
              textColor: Colors.white,
              background: Colors.black,
              borderRadius: 16,

              initialDatePickerMode: CupertinoDatePickerMode.date,
              onDateTimeChanged: (newDateTime) {
                //\
                setState(() {
                authController!.dateinput=TextEditingController(text: newDateTime.toString().substring(0,10));
                });
                print(newDateTime);
              },

          );
        },
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter Date of birth';
            }
            return null;
          },
          keyboardType: TextInputType.emailAddress,
        ),
      ),
    ],),
    Column(children: [
      const Text(
        "Select Birth Time",
        style:
        TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
      ),
      const SizedBox(height: 5),
      Container(



        width: MediaQuery.of(context).size.width*0.4,
        child: TextFormField(
          readOnly: true,
          controller: authController!.birthTime,
          decoration: const InputDecoration(
            filled: true,
            hintText: "Select Birth Time"
            ,
            labelStyle: TextStyle(
                color: Color(
                  0xff961b20,
                ),
                fontSize: 16),
            fillColor: Colors.transparent,
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter Birth Time';
            }
            return null;
          },
          onChanged: (
              value
              ){
            authController!.birthTime.text=value;
            setState(() {

            });
          },
          onTap: (){
            _showDatePicker(context);

            
            
            // CupertinoRoundedDurationPickers.show(
            //
            //   context,
            //   textColor: Colors.white,
            //   background: Colors.black,
            //
            //   initialTimerDuration: const Duration(minutes:10),
            //   initialDurationPickerMode: CupertinoTimerPickerMode.hms,
            //
            //   fontFamily: "Poppins",
            //
            //   onDurationChanged: (newDuration) {
            //     //
            //     setState(() {
            //       authController!.birthTime=TextEditingController(text: newDuration.toString().substring(0,9));
            //     });
            //   },
            //
            // );
          },
          keyboardType: TextInputType.emailAddress,
        ),
      ),
    ],),
  ],),
),



                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "Select Country",
                        style:
                        TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
                      ),
                      const SizedBox(height: 5),
                      Autocomplete<Countries>(
                        displayStringForOption: _displayStringForOption,
                        optionsBuilder: (TextEditingValue textEditingValue) {
                          return authController!.countryModel!.countries!
                              .where((Countries option) {
                            return option.name!
                                .toLowerCase()
                                .contains(textEditingValue.text.toLowerCase());
                          });
                        },
                        onSelected: (Countries selection) {
                          setState(() {
                            authController!.countryId=int.parse(selection.id.toString());
                            authController!.countryName=TextEditingController(text: selection.name.toString());
                            //stateValue = selection.id.toString();
                          });
                          authController!.getStates(context);
                        },
                        fieldViewBuilder: (context, controller, focusNode,
                            onEditingComplete) {
                          //  this.stateController = controller;

                          return TextFormField(
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(RegExp(r'[]')),
                            ],
                            controller: controller,
                            focusNode: focusNode,
                            onEditingComplete: onEditingComplete,
                            decoration:const InputDecoration(
                              filled: false,
                              fillColor: Colors.white70,

                              hintText: "Select Country",
                            ),
                            validator: (val){
                              if(authController!.countryId==null||authController!.countryId==0){
                                return "Please Choose Country From Dropdown";
                              }
                            },
                          );
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "Select States",
                        style:
                        TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
                      ),
                      const SizedBox(height: 5),
                      Autocomplete<States>(
                        displayStringForOption: _displayStates,
                        optionsBuilder: (TextEditingValue textEditingValue) {
                          return authController!.statesModel!.states!
                              .where((States option) {
                            return option.name!
                                .toLowerCase()
                                .contains(textEditingValue.text.toLowerCase());
                          });
                        },
                        onSelected: (States selection) {
                          setState(() {
                            authController!.birthPlace=TextEditingController(text: selection.name.toString());
                            authController!.stateId = selection.id;
                            authController!.getCities(context);
                          });
                          //authController!.getStates(context);
                        },
                        fieldViewBuilder: (context, controller, focusNode,
                            onEditingComplete) {
                          //  this.stateController = controller;

                          return TextFormField(
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(RegExp(r'[]')),
                            ],
                            controller: controller,
                            focusNode: focusNode,
                            onEditingComplete: onEditingComplete,
                            decoration:const InputDecoration(
                              filled: false,
                              fillColor: Colors.white70,

                              hintText: "Select States",
                            ),
                            validator: (val){
                              if(authController!.stateId==null||authController!.stateId==0){
                                return "Please Choose State From Dropdown";
                              }
                            },
                          );
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "Enter City",
                        style:
                        TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
                      ),
                      const SizedBox(height: 5),
                      Autocomplete<Statess>(
                        displayStringForOption: _displayCities,
                        optionsBuilder: (TextEditingValue textEditingValue) {
                          return authController!.cityModel!.states!
                              .where((Statess option) {
                            return option.name!
                                .toLowerCase()
                                .contains(textEditingValue.text.toLowerCase());
                          });
                        },
                        onSelected: (Statess selection) {
                          setState(() {
                            authController!.cityLiving=TextEditingController(text: selection.name.toString());
                           authController!.cityId = selection.id.toString() ;
                          });
                          //authController!.getStates(context);
                        },
                        fieldViewBuilder: (context, controller, focusNode,
                            onEditingComplete) {
                          //  this.stateController = controller;

                          return TextFormField(
                            controller: controller,
                            focusNode: focusNode,
                            onEditingComplete: onEditingComplete,
                            decoration:const InputDecoration(
                              filled: false,
                              fillColor: Colors.white70,

                              hintText: "Select Cities",
                            ),
                            validator: (val){
                              if(controller.text.isEmpty){
                                return "Please Enter City ";
                              }
                              if(authController!.cityId==null){
                                authController!.getCities(context);
                              }

                            },
                          );
                        },
                      ),






                      //  const  Expanded(child: SizedBox()),
                      const SizedBox(
                        height: 30,
                      ),
                      Center(
                        child: GestureDetector(
                          onTap: () {
                            //print(DateTime.now()-DateTime.parse(authController!.dateinput.text));
                            if(DateTime.now().difference(DateTime.parse(authController!.dateinput.text)).inDays<6570){
                              appSnackBar(context: context,content: "Age Must be more than 18 years");
                            }
                           else if (registerKey.currentState!.validate()) {
                              setState(() {
                                loginWidth = 60;

                                Future.delayed(const Duration(microseconds: 1000), () {
                                  setState(() {
                                    // authController!.isLoading=true;
                                    authController!.signup2(context,"user/registration_step_two").then((res) => {
                                      if (res.statusCode == 200 ||
                                          res.statusCode == 201)
                                        {
                                          setState(() {
                                            loginWidth = 350;
                                            appSnackBar(
                                                content:
                                                "Data Saved Successfully",
                                                context: context);
                                            Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUpThird()));
                                          })
                                        }
                                    });
                                  });
                                });
                              });
                            }
                          },
                          child: AnimatedContainer(
                              width: loginWidth,
                              alignment: Alignment.center,
                              duration: const Duration(microseconds: 1000),
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
                                  "Next Step",
                                  style:  TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w800),
                                ),
                              )),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage2()));
;                        },
                        child: Center(
                          child: RichText(
                            text: const TextSpan(
                              text: "Already have an Account ? ",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "Poppins"),
                              children: <TextSpan>[
                                TextSpan(
                                    text: 'Login',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xff961b20),
                                        fontSize: 16,
                                        fontFamily: "Poppins")),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),

        ));
  }
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
  bool isAdult(String birthDateString) {
    String datePattern = "dd-MM-yyyy";

    DateTime birthDate = DateFormat(datePattern).parse(birthDateString);
    DateTime today = DateTime.now();

    int yearDiff = today.year - birthDate.year;
    int monthDiff = today.month - birthDate.month;
    int dayDiff = today.day - birthDate.day;
print(today.year - birthDate.year);
    return yearDiff > 18 || yearDiff == 18 && monthDiff >= 0 && dayDiff >= 0;
  }
}