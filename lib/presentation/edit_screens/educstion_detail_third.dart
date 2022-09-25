import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:rishtey/controller/update_controller.dart';
import 'package:rishtey/models/AnnualIncomeModel.dart';
import 'package:rishtey/models/EducationModel.dart';
import 'package:rishtey/models/EmployerModel.dart';
import 'package:rishtey/models/OccupationModel.dart';
import 'package:rishtey/presentation/profile/personal_profile.dart';
import 'package:rishtey/presentation/register/sign_up_fourth.dart';
import 'package:rishtey/utils/app_config.dart';
import 'package:rishtey/utils/shared_pref.dart';

import '../../controller/auth_controller.dart';
import '../../controller/get_profile_controller.dart';
import '../../utils/app_snack_bar.dart';

class EducationDetailsThird extends StatefulWidget {
  const EducationDetailsThird({Key? key}) : super(key: key);

  @override
  State<EducationDetailsThird> createState() => _EducationDetailsThirdState();
}

class _EducationDetailsThirdState extends State<EducationDetailsThird> {
  final thirdFormKey = GlobalKey<FormState>();

  AuthController? authController;
  static String _displayStringForEducation(Education option) =>
      option.education;
  static String _displayStringForAnnualIncome(AnnualIncome option) =>
      option.annualIncome;
  static String _displayStringForOccupation(Occupation option) =>
      option.occupation;
  static String _displayStringForEmployerType(Employer option) =>
      option.employer;
  double loginWidth = 350;
  var educationId;
  var employerType;
  var occupation;
  var income;
  TextEditingController aboutCareer=TextEditingController();
  TextEditingController jobLocation=TextEditingController();
  TextEditingController organization=TextEditingController();
  TextEditingController annualIncome=TextEditingController();
  UpdateController?updateController;
  GetProfileController?getProfileController;
  @override
  void initState() {
    authController = Provider.of<AuthController>(context, listen: false);
    updateController = Provider.of<UpdateController>(context, listen: false);
    getProfileController = Provider.of<GetProfileController>(context, listen: false);
    authController!.getEducationType(context);
    authController!.getAnnualIncomeType(context);
    authController!.getEmployeType(context);
    authController!.getOccupationType(context);

    aboutCareer=TextEditingController(text:getProfileController?.getProfileModel?.data?.user?.aboutMyCareer );
    jobLocation=TextEditingController(text:getProfileController?.getProfileModel?.data?.user?.jobLocation );
    organization=TextEditingController(text:getProfileController?.getProfileModel?.data?.user?.organizationName );
    annualIncome=TextEditingController(text:getProfileController?.getProfileModel?.data?.user?.annualIncome);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("My Career"),),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            //height: MediaQuery.of(context).size.height,
            child: Container(
              padding: const EdgeInsets.all(20),
              alignment: Alignment.bottomCenter,
              child: Form(
                key: thirdFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    const SizedBox(
                      height: 20,
                    ),
                    // const Text(
                    //   "Select Education",
                    //   style:
                    //   TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
                    // ),
                    // const SizedBox(height: 5),
                    // Autocomplete<Education>(
                    //   displayStringForOption: _displayStringForEducation,
                    //   optionsBuilder: (TextEditingValue textEditingValue) {
                    //     return authController!.educationModel!.educations!
                    //         .where((Education option) {
                    //       return option.education
                    //           .toLowerCase()
                    //           .contains(textEditingValue.text.toLowerCase());
                    //     });
                    //   },
                    //   onSelected: (Education selection) {
                    //     setState(() {
                    //       authController?.educationController =
                    //           TextEditingController(text: selection.education);
                    //       //authController.countryId=int.parse(selection.id.toString());
                    //       educationId = selection.id.toString();
                    //     });
                    //     //authController.getStates(context);
                    //   },
                    //   fieldViewBuilder:
                    //       (context, controller, focusNode, onEditingComplete) {
                    //     //  this.stateController = controller;
                    //
                    //     return TextFormField(
                    //       //controller: controller,
                    //       focusNode: focusNode,
                    //       onEditingComplete: onEditingComplete,
                    //       decoration: const InputDecoration(
                    //         filled: false,
                    //         fillColor: Colors.white70,
                    //         hintText: "Select Education",
                    //       ),
                    //       validator: (val) {
                    //         if (educationId == null || educationId == 0) {
                    //           return "Please Choose Education from dropdown";
                    //         }
                    //       },
                    //     );
                    //   },
                    // ),
                    // const SizedBox(
                    //   height: 10,
                    // ),
                    // const SizedBox(
                    //   height: 10,
                    // ),

                    const Text(
                      "About My Career",
                      style:
                      TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
                    ),
                    const SizedBox(height: 5),
                    TextFormField(
                      maxLines: 5,
                      inputFormatters: [
                        //LengthLimitingTextInputFormatter(10),
                        FilteringTextInputFormatter.allow(RegExp('[a-zA-Z ]')),
                      ],
                     controller: aboutCareer,
                      decoration:  InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        filled: true,
                        hintText: "About Career",
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

                        return null;
                      },
                      keyboardType: TextInputType.name,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Select Employed In",
                      style:
                      TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
                    ),
                    const SizedBox(height: 5),
                    Autocomplete<Employer>(
                      displayStringForOption: _displayStringForEmployerType,
                      optionsBuilder: (TextEditingValue textEditingValue) {
                        return authController!.employerModel!.employers!
                            .where((Employer option) {
                          return option.employer
                              .toLowerCase()
                              .contains(textEditingValue.text.toLowerCase());
                        });
                      },
                      onSelected: (Employer selection) {
                        setState(() {
                          authController?.employeeTypeController =
                              TextEditingController(text: selection.employer);
                          //authController.countryId=int.parse(selection.id.toString());
                          employerType = selection.employer.toString();
                          print(authController?.employeeTypeController.text);
                        });
                        //authController.getStates(context);
                      },
                      fieldViewBuilder:
                          (context, controller, focusNode, onEditingComplete) {
                        //  this.stateController = controller;

                        return TextFormField(
                            inputFormatters: [
                              //LengthLimitingTextInputFormatter(10),
                              FilteringTextInputFormatter.allow(RegExp('[a-zA-Z ]')),
                            ],
                            controller: controller,

                            focusNode: focusNode,
                            onEditingComplete: onEditingComplete,
                            decoration:  InputDecoration(
                              filled: false,
                              fillColor: Colors.white70,
                              hintText: getProfileController?.getProfileModel?.data?.user?.employedIn??"Select Employed In",
                            ),
                            validator: (val) {
                              if (employerType == null || employerType == 0) {
                                return "Please Choose Employee from dropdown";
                              }
                            });
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    authController?.employeeTypeController.text ==
                        "Not Employed in"
                        ? Container()
                        : const Text(
                      "Select Occupation",
                      style: TextStyle(
                          fontWeight: FontWeight.w800, fontSize: 16),
                    ),
                    authController?.employeeTypeController.text ==
                        "Not Employed in"
                        ? Container()
                        : const SizedBox(height: 5),
                    authController?.employeeTypeController.text ==
                        "Not Employed in"
                        ? Container()
                        : Autocomplete<Occupation>(
                      displayStringForOption: _displayStringForOccupation,
                      optionsBuilder:
                          (TextEditingValue textEditingValue) {
                        return authController!
                            .occupationModel!.occupations!
                            .where((Occupation option) {
                          return option.occupation.toLowerCase().contains(
                              textEditingValue.text.toLowerCase());
                        });
                      },
                      onSelected: (Occupation selection) {
                        setState(() {
                          authController?.occupationController =
                              TextEditingController(
                                  text: selection.occupation);
                          //authController.countryId=int.parse(selection.id.toString());
                          occupation = selection.occupation.toString();
                        });
                        //authController.getStates(context);
                      },
                      fieldViewBuilder: (context, controller, focusNode,
                          onEditingComplete) {
                        //  this.stateController = controller;

                        return TextFormField(
                            controller: controller,
                            inputFormatters: [
                              //LengthLimitingTextInputFormatter(10),
                              FilteringTextInputFormatter.allow(RegExp('[a-zA-Z ]')),
                            ],
                            focusNode: focusNode,
                            onEditingComplete: onEditingComplete,
                            decoration:  InputDecoration(
                              filled: false,
                              fillColor: Colors.white70,
                              hintText: getProfileController?.getProfileModel?.data?.user?.occupation??"Select Occupation",
                            ),
                            validator: (val) {
                              if (occupation == null || occupation == 0) {
                                print("oianvkno[d");
                                authController!.addOccupation(context);
                                setState(() {
                                  authController?.occupationController =
                                      controller;
                                });
                                //  return "Please Choose Occupation from dropdown";
                              }
                            });
                      },
                    ),
                    authController?.employeeTypeController.text ==
                        "Not Employed in"
                        ? Container()
                        : const SizedBox(
                      height: 10,
                    ),
                    authController?.employeeTypeController.text ==
                        "Not Employed in"
                        ? Container()
                        : const SizedBox(
                      height: 10,
                    ),
                    authController?.employeeTypeController.text ==
                        "Not Employed in"
                        ? Container()
                        : const Text(
                      "Select Annual Income",
                      style: TextStyle(
                          fontWeight: FontWeight.w800, fontSize: 16),
                    ),
                    authController?.employeeTypeController.text ==
                        "Not Employed in"
                        ? Container()
                        : const SizedBox(height: 5),
                    authController?.employeeTypeController.text ==
                        "Not Employed in"
                        ? Container()
                        : TextFormField(
                            inputFormatters: [
                              //LengthLimitingTextInputFormatter(10),
                              FilteringTextInputFormatter.allow(RegExp('[a-zA-Z ]')),
                            ],
                            controller: annualIncome,

                            onTap: (){
                              showModalBottomSheet(

                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  backgroundColor: Colors.black, builder: (BuildContext context) {
                                    return Container(
                                      child: Column(children: [
                                        Expanded(child: ListView.builder(itemBuilder: (context,index){
                                          return Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              children: [
                                                GestureDetector(
                                                    onTap:(){
                                                      annualIncome=TextEditingController(text:authController!.annualIncomeModel!.annualIncomes![index].annualIncome );
                                                  Navigator.pop(context);
                                                    },
                                                    child: Text(authController!.annualIncomeModel!.annualIncomes![index].annualIncome,style: TextStyle(color: Colors.white),)),
                                             Divider(thickness: 1.5,color: Colors.white,),
                                              ],
                                            ),
                                          );
                                        },itemCount:authController!.annualIncomeModel!.annualIncomes!.length ,)),
                                        ElevatedButton(

                                            style: ElevatedButton.styleFrom(
                                              minimumSize: Size(AppConfig.width*0.8,AppConfig.height*0.07),
                                                primary: Colors.white,
                                                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),

                                                textStyle: TextStyle(

                                                    fontWeight: FontWeight.bold)),
                                            onPressed: (){}, child: Text("Submit",style: TextStyle(color: Colors.black),)),
                                        SizedBox(height: 10,)
                                      ],),
                                    );
                              }, context: context,

                              );
                            },
                            decoration: const InputDecoration(
                              filled: false,
                              fillColor: Colors.white70,
                              hintText: "Select Annual Income",
                            ),
                            validator: (val) {
                              if (income == null || income == 0) {
                                return "Please Choose Income from dropdown";
                              }
                            }
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Organization Name",
                      style:
                      TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
                    ),
                    const SizedBox(height: 5),
                    TextFormField(
                      controller: organization,
                      inputFormatters: [
                        //LengthLimitingTextInputFormatter(10),
                        FilteringTextInputFormatter.allow(RegExp('[a-zA-Z ]')),
                      ],
                      //controller: authController!.phoneNumber,
                      decoration: const InputDecoration(
                        filled: true,
                        hintText: "Enter Organization Name",
                        labelStyle: TextStyle(
                            color: Color(
                              0xff961b20,
                            ),
                            fontSize: 16),
                        fillColor: Colors.transparent,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter Organization Name';
                        }

                        return null;
                      },
                      keyboardType: TextInputType.name,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Job Location",
                      style:
                      TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
                    ),
                    const SizedBox(height: 5),
                    TextFormField(
                      inputFormatters: [
                        //LengthLimitingTextInputFormatter(10),
                        FilteringTextInputFormatter.allow(RegExp('[a-zA-Z ]')),
                      ],
                      controller: jobLocation,
                      decoration: const InputDecoration(
                        filled: true,
                        hintText: "Enter Job Location",
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
                      keyboardType: TextInputType.name,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Center(
                      child: GestureDetector(
                        onTap: () async{



                          var user_id = await SharedPref().getString(key: "user_id");
                          Map<String, dynamic> data ={
                            "user_id":user_id,
                            "about_my_career":aboutCareer.text,
                            "employed_in":employerType,
                            "occupation":occupation,
                            "organization_name":organization.text,
                            "job_location":jobLocation.text,
                            "annual_income":annualIncome.text
                          };
                          print(data);
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
                    const SizedBox(
                      height: 40,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
