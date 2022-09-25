import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rishtey/models/AnnualIncomeModel.dart';
import 'package:rishtey/models/EducationModel.dart';
import 'package:rishtey/models/EmployerModel.dart';
import 'package:rishtey/models/OccupationModel.dart';
import 'package:rishtey/presentation/register/sign_up_fourth.dart';

import '../../controller/auth_controller.dart';
import '../../utils/app_snack_bar.dart';

class SignUpThird extends StatefulWidget {
  const SignUpThird({Key? key}) : super(key: key);

  @override
  State<SignUpThird> createState() => _SignUpThirdState();
}

class _SignUpThirdState extends State<SignUpThird> {
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
  @override
  void initState() {
    authController = Provider.of<AuthController>(context, listen: false);
    authController!.getEducationType(context);
    authController!.getAnnualIncomeType(context);
    authController!.getEmployeType(context);
    authController!.getOccupationType(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,

            child: Container(
              padding: const EdgeInsets.all(20),
              alignment: Alignment.bottomCenter,
              child: Form(
                key: thirdFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Center(child:  Text("Good! your profile is 25% Completed",style: TextStyle(fontWeight: FontWeight.w800,fontSize: 16),)),
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
                    const Text(
                      "Select Education",
                      style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
                    ),
                    const SizedBox(height: 5),
                    Autocomplete<Education>(
                      displayStringForOption: _displayStringForEducation,
                      optionsBuilder: (TextEditingValue textEditingValue) {
                        return authController!.educationModel!.educations!
                            .where((Education option) {
                          return option.education
                              .toLowerCase()
                              .contains(textEditingValue.text.toLowerCase());
                        });
                      },
                      onSelected: (Education selection) {
                        setState(() {
                          authController?.educationController =
                              TextEditingController(text: selection.education);
                          //authController.countryId=int.parse(selection.id.toString());
                          educationId = selection.id.toString();
                        });
                        //authController.getStates(context);
                      },
                      fieldViewBuilder:
                          (context, controller, focusNode, onEditingComplete) {
                        //  this.stateController = controller;

                        return TextFormField(
                          controller: controller,
                          focusNode: focusNode,
                          onEditingComplete: onEditingComplete,
                          decoration: const InputDecoration(
                            filled: false,
                            fillColor: Colors.white70,
                            hintText: "Select Education",
                          ),
                          validator: (val){
                            if(educationId==null||educationId==0){
                              return "Please Choose Education from dropdown";
                            }
                          },
                        );
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Select Employer Type",
                      style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
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
                          employerType = selection.id.toString();
                          print(authController?.employeeTypeController.text);
                        });
                        //authController.getStates(context);
                      },
                      fieldViewBuilder:
                          (context, controller, focusNode, onEditingComplete) {
                        //  this.stateController = controller;

                        return TextFormField(
                          controller: controller,
                          focusNode: focusNode,
                          onEditingComplete: onEditingComplete,
                          decoration: const InputDecoration(
                            filled: false,
                            fillColor: Colors.white70,
                            hintText: "Select Employee Type",
                          ),
                            validator: (val){
    if(employerType==null||employerType==0){
    return "Please Choose Employee from dropdown";
    }}
                        );
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    authController?.employeeTypeController.text=="Not Employed in"?Container(): const Text(
                      "Select Occupation",
                      style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
                    ),
                    authController?.employeeTypeController.text=="Not Employed in"?Container(): const SizedBox(height: 5),
                    authController?.employeeTypeController.text=="Not Employed in"?Container(): Autocomplete<Occupation>(
                      displayStringForOption: _displayStringForOccupation,
                      optionsBuilder: (TextEditingValue textEditingValue) {
                        return authController!.occupationModel!.occupations!
                            .where((Occupation option) {
                          return option.occupation
                              .toLowerCase()
                              .contains(textEditingValue.text.toLowerCase());
                        });
                      },
                      onSelected: (Occupation selection) {
                        setState(() {
                          authController?.occupationController =
                              TextEditingController(text: selection.occupation);
                          //authController.countryId=int.parse(selection.id.toString());
                          occupation = selection.id.toString();
                        });
                        //authController.getStates(context);
                      },
                      fieldViewBuilder:
                          (context, controller, focusNode, onEditingComplete) {
                        //  this.stateController = controller;

                        return TextFormField(
                          controller: controller,
                          focusNode: focusNode,
                          onEditingComplete: onEditingComplete,
                          decoration: const InputDecoration(
                            filled: false,
                            fillColor: Colors.white70,
                            hintText: "Select Occupation",
                          ),
                            validator: (val){
                              if(occupation==null||occupation==0){
                                print("oianvkno[d");
                                authController!.addOccupation(context);
                                setState(() {
                                  authController?.occupationController=controller;
                                });
                              //  return "Please Choose Occupation from dropdown";
                              }}
                        );
                      },
                    ),
                    authController?.employeeTypeController.text=="Not Employed in"?Container(): const SizedBox(
                      height: 10,
                    ),
                    authController?.employeeTypeController.text=="Not Employed in"?Container():const SizedBox(
                      height: 10,
                    ),
                    authController?.employeeTypeController.text=="Not Employed in"?Container(): const Text(
                      "Select Annual Income",
                      style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
                    ),
                    authController?.employeeTypeController.text=="Not Employed in"?Container(): const SizedBox(height: 5),
                    authController?.employeeTypeController.text=="Not Employed in"?Container(): Autocomplete<AnnualIncome>(
                      displayStringForOption: _displayStringForAnnualIncome,
                      optionsBuilder: (TextEditingValue textEditingValue) {
                        return authController!.annualIncomeModel!.annualIncomes!
                            .where((AnnualIncome option) {
                          return option.annualIncome
                              .toLowerCase()
                              .contains(textEditingValue.text.toLowerCase());
                        });
                      },
                      onSelected: (AnnualIncome selection) {
                        setState(() {
                          authController?.annualIcomController =
                              TextEditingController(text: selection.annualIncome);
                          //authController.countryId=int.parse(selection.id.toString());
                          income = selection.id.toString();
                        });
                        //authController.getStates(context);
                      },
                      fieldViewBuilder:
                          (context, controller, focusNode, onEditingComplete) {
                        //  this.stateController = controller;

                        return TextFormField(
                          controller: controller,
                          focusNode: focusNode,
                          onEditingComplete: onEditingComplete,
                          decoration: const InputDecoration(
                            filled: false,
                            fillColor: Colors.white70,
                            hintText: "Select Annual Income",
                          ),
                            validator: (val){
                              if(income==null||income==0){
                                return "Please Choose Income from dropdown";
                              }}
                        );
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          if (thirdFormKey.currentState!.validate()) {
                            setState(() {
                              loginWidth = 60;

                              Future.delayed(const Duration(microseconds: 500), () {
                                setState(() {
    // if(occupation==null||occupation==0){
    // print("oianvkno[d");
    // authController!.addOccupation(context);
    // //  return "Please Choose Occupation from dropdown";
    // }
                                  // authController.isLoading=true;
                                  authController!.signup3(context,"user/registration_step_three").then((res) => {
                                    if (res.statusCode == 200 ||
                                        res.statusCode == 201)
                                      {
                                        setState(() {
                                          loginWidth = 350;
                                          appSnackBar(
                                              content:
                                              "Data Saved Successfully",
                                              context: context);
                                          Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUpFourth()));

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
