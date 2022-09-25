import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rishtey/models/castes_model.dart';
import 'package:rishtey/models/height_model.dart';
import 'package:rishtey/models/marital_status_model.dart';
import 'package:rishtey/models/mother_tongue_model.dart';
import 'package:rishtey/presentation/login/login_2.dart';
import 'package:rishtey/presentation/register/widgets/rounded_date_picker.dart';
import 'package:rishtey/presentation/register/widgets/rounded_picker.dart';
import 'package:rishtey/utils/app_snack_bar.dart';

import '../../controller/auth_controller.dart';
import '../../models/country_model.dart';
import '../../models/religion_model.dart';
import '../../models/states_model.dart';
import 'add_image_signup.dart';
class SignUpFourth extends StatefulWidget {
  const SignUpFourth({Key? key}) : super(key: key);

  @override
  State<SignUpFourth> createState() => _SignUpState();
}

class _SignUpState extends State<SignUpFourth> {
  AuthController? authController;
  double loginWidth = 350;
  final registerKey = GlobalKey<FormState>();
  static String _displayMarital(MaritalStatus option) => option.maritalStatus!;
  static String _displayReligions(Religions option) => option.religion!;
  static String _displayMotherTongue(MotherTongues option) => option.motherTongue!;
  static String _displayCastes(Casts option) => option.cast!;
  ReligionModel? data;
var motherTongueId;
var caste;
var maritalStatus;
var religion;


  @override
  void initState() {
    authController=Provider.of<AuthController>(context,listen: false);
    getData();
    super.initState();
  }
  getData()async{
    data=await authController!.getReligion(context);
  }
  @override
  Widget build(BuildContext context) {
    authController = Provider.of<AuthController>(context);
    return Scaffold(
        body: Consumer<AuthController>(builder: (context, authController, _) {
          return SafeArea(
            child: Container(
              height: MediaQuery.of(context).size.height,

              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Container(
                  padding: const EdgeInsets.all(20),
                  alignment: Alignment.bottomCenter,
                  child: Form(
                    key: registerKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Center(child:  Text("Good! your profile is 30% Completed",style: TextStyle(fontWeight: FontWeight.w800,fontSize: 16),)),
                        const SizedBox(height: 10,),
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
                        const Text(
                          "Your Mother Tongue",
                          style:
                          TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
                        ),
                        const SizedBox(height: 5),
                        Autocomplete<MotherTongues>(
                          displayStringForOption: _displayMotherTongue,
                          optionsBuilder: (TextEditingValue textEditingValue) {
                            return authController.motherTongueModel!.motherTongues!
                                .where((MotherTongues option) {
                              return option.motherTongue!
                                  .toLowerCase()
                                  .contains(textEditingValue.text.toLowerCase());
                            });
                          },
                          onSelected: (MotherTongues selection) {
                            setState(() {

                              authController.motherTongue=TextEditingController(text: selection.motherTongue.toString());
                              motherTongueId = selection.id.toString();
                            });

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

                                hintText: "Your Mother Tongue",
                              ),
                              validator: (val){
                                if(motherTongueId==null||motherTongueId==0){
                                  return"Please Choose Mother Tongue From Dropdown";
                                }
                              },
                            );
                          },
                        ),

                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          "Casts",
                          style:
                          TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
                        ),
                        const SizedBox(height: 5),
                        Autocomplete<Casts>(
                          displayStringForOption: _displayCastes,
                          optionsBuilder: (TextEditingValue textEditingValue) {
                            return authController.castesModel!.casts!
                                .where((Casts option) {
                              return option.cast!
                                  .toLowerCase()
                                  .contains(textEditingValue.text.toLowerCase());
                            });
                          },
                          onSelected: (Casts selection) {
                            setState(() {
                              authController.castes=TextEditingController(text: selection.cast.toString());
                              //authController.countryId=int.parse(selection.id.toString());
                              caste = selection.id.toString();
                            });
                            //authController.getStates(context);
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

                                hintText: "Select Castes",
                              ),
                              validator: (val){
                                if(caste==null||caste==0){
                                  return"Please Choose Castes  From Dropdown";
                                }
                              },
                            );
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          "Marital Status",
                          style:
                          TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
                        ),
                        const SizedBox(height: 5),
                        Autocomplete<MaritalStatus>(
                          displayStringForOption: _displayMarital,
                          optionsBuilder: (TextEditingValue textEditingValue) {
                            return authController.maritalStatusModel!.maritalStatus!
                                .where((MaritalStatus option) {
                              return option.maritalStatus!
                                  .toLowerCase()
                                  .contains(textEditingValue.text.toLowerCase());
                            });
                          },
                          onSelected: (MaritalStatus selection) {
                            setState(() {
                              authController.maritalStatus=TextEditingController(text: selection.maritalStatus.toString());
                              maritalStatus = selection.id.toString();
                            });
                            //authController.getStates(context);
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

                                hintText: "Marital Status",
                              ),
                              validator: (val){
                                if(maritalStatus==null||maritalStatus==0){
                                  return"Please Choose Marital Status From Dropdown";
                                }
                              },
                            );
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        authController.maritalStatus.text=="Never Married"?Container():   const Text(
                          "Have You Any Child",
                          style:
                          TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
                        ),
                        const SizedBox(height: 5),
                        authController.maritalStatus.text=="Never Married"?Container():  Container(
                          width: MediaQuery.of(context).size.width,
                          child: DropdownButton<String>(
                            underline: Container(height: 1,
                              color: Colors.black,
                            ),
                            icon: Container(),
                            value: authController.haveChild,
                            onChanged: (String ?newValue) {
                              setState(() {
                                authController.haveChild = newValue!;
                              });
                            },
                            items: <String>["Yes","No" ]
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                        authController.maritalStatus.text=="Never Married"?Container():  const SizedBox(
                          height: 20,
                        ),
                        authController.maritalStatus.text=="Never Married"||authController.haveChild=="No"?Container():   const Text(
                          "Number Of Child",
                          style:
                          TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
                        ),
                        SizedBox(height: 5),
                        authController.maritalStatus.text=="Never Married"|| authController.haveChild=="No"?Container(): Container(
                          width: MediaQuery.of(context).size.width,
                          child: DropdownButton<String>(
                            underline: Container(height: 1,
                              color: Colors.black,
                            ),
                            icon: Container(),
                            value: authController.numberChild,
                            onChanged: (String ?newValue) {
                              setState(() {
                                authController.numberChild = newValue!;
                              });
                            },
                            items: <String>[ '1',"2","3","4","5" ]
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                        authController.haveChild=="No"?Container(): const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          "Religion",
                          style:
                          TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
                        ),
                        const SizedBox(height: 5),
                        Autocomplete<Religions>(
                          displayStringForOption: _displayReligions,
                          optionsBuilder: (TextEditingValue textEditingValue) {
                            return authController.religionModel!.religions!
                                .where((Religions option) {
                              return option.religion!
                                  .toLowerCase()
                                  .contains(textEditingValue.text.toLowerCase());
                            });
                          },
                          onSelected: (Religions selection) {
                            setState(() {
                              authController.religion=TextEditingController(text: selection.religion.toString());
                              religion = selection.id.toString();
                            });
                            //authController.getStates(context);
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

                                hintText: "Your Religion",
                              ),
                              validator: (val){
                                if(religion==null||religion==0){
                                  return "Please Choose Religion From Dropdown";
                                }
                              },
                            );
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          "Is Manglik",
                          style:
                          TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
                        ),
                        const SizedBox(height: 5),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          child: DropdownButton<String>(
                            underline: Container(height: 1,
                              color: Colors.black,
                            ),
                            icon: Container(),
                            value: authController.isManglik,
                            onChanged: (String ?newValue) {
                              setState(() {
                                authController.isManglik = newValue!;
                              });
                            },
                            items: <String>['Yes', 'No', ]
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        )
                        ,
                        const SizedBox(
                          height: 20,
                        ),

                        const Text(
                          "Horoscope Needed",
                          style:
                          TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
                        ),
                        const SizedBox(height: 5),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          child: DropdownButton<String>(
                            underline: Container(height: 1,
                              color: Colors.black,
                            ),
                            icon: Container(),
                            value: authController.dropdownValue,
                            onChanged: (String ?newValue) {
                              setState(() {
                                authController.dropdownValue = newValue!;
                              });
                            },
                            items: <String>['Yes', 'No', ]
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        )
                        ,
                        //  const  Expanded(child: SizedBox()),
                        const SizedBox(
                          height: 40,
                        ),
                        Center(
                          child: GestureDetector(
                            onTap: () {
                              if (registerKey.currentState!.validate()) {
                                setState(() {
                                  loginWidth = 60;

                                  Future.delayed(const Duration(microseconds: 500), () {
                                    setState(() {
                                      // authController.isLoading=true;
                                      authController.signup4(context,"user/registration_step_four").then((res) => {
                                        if (res.statusCode == 200 ||
                                            res.statusCode == 201)
                                          {
                                            setState(() {
                                              loginWidth = 350;
                                              appSnackBar(
                                                  content:
                                                  "Data Saved Successfully",
                                                  context: context);
                                              Navigator.push(context, MaterialPageRoute(builder: (context)=>AddImageSignup()));
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
                                  child: authController.isLoading
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

                          },
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
            ),
          );
        }));
  }
}