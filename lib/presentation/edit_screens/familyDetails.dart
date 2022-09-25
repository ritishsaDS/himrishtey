import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:rishtey/controller/update_controller.dart';
import 'package:rishtey/models/AnnualIncomeModel.dart';
import 'package:rishtey/models/family_status.dart';
import 'package:rishtey/presentation/profile/personal_profile.dart';
import 'package:rishtey/presentation/register/sign_up_second.dart';
import 'package:rishtey/utils/shared_pref.dart';

import '../../controller/auth_controller.dart';
import '../../controller/get_profile_controller.dart';
import '../../models/family_status.dart';

class FamilyDetails extends StatefulWidget {
  const FamilyDetails({Key? key}) : super(key: key);

  @override
  State<FamilyDetails> createState() => _FamilyDetailsState();
}

class _FamilyDetailsState extends State<FamilyDetails> {
  AuthController? authController;
  TextEditingController aboutFamily=TextEditingController();
  TextEditingController fatherOccupation=TextEditingController();
  TextEditingController fathername=TextEditingController();
  TextEditingController motherOccupation=TextEditingController();
  TextEditingController motherName=TextEditingController();
  TextEditingController numberBro=TextEditingController();
  TextEditingController marriedBro=TextEditingController();
  TextEditingController numberSis=TextEditingController();
  TextEditingController marriedSis=TextEditingController();
  TextEditingController annualIncome=TextEditingController();
  TextEditingController familyStatus=TextEditingController();
  TextEditingController familyAnnualIncome=TextEditingController();
  static String _displayStringForAnnualIncome(AnnualIncome option) =>
      option.annualIncome;
  static String _displayStringForFamilySTatus(MotherTongues option) =>
      option.value!;
  final registerKey = GlobalKey<FormState>();
  UpdateController?updateController;
  GetProfileController?getProfileController;
  @override
  void initState() {

    super.initState();
    authController = Provider.of<AuthController>(context,listen: false);
    authController!.getAnnualIncomeType(context);
    authController!.getFamilyStatus(context);
    updateController = Provider.of<UpdateController>(context,listen: false);
    getProfileController = Provider.of<GetProfileController>(context,listen: false);

    aboutFamily=TextEditingController(text:getProfileController?.getProfileModel?.data?.user?.aboutFamily );
    fatherOccupation=TextEditingController(text:getProfileController?.getProfileModel?.data?.user?.fatherOccupation);
    fathername=TextEditingController(text:getProfileController?.getProfileModel?.data?.user?.fatherName);
    motherOccupation=TextEditingController(text:getProfileController?.getProfileModel?.data?.user?.motherOccupation);
    motherName=TextEditingController(text:getProfileController?.getProfileModel?.data?.user?.motherName);
    numberBro=TextEditingController(text:getProfileController?.getProfileModel?.data?.user?.noOfBrothers);
    marriedBro=TextEditingController(text:getProfileController?.getProfileModel?.data?.user?.marriedBrothers);
    numberSis=TextEditingController(text:getProfileController?.getProfileModel?.data?.user?.noOfSisters);
    marriedSis=TextEditingController(text:getProfileController?.getProfileModel?.data?.user?.marriedSisters);
    annualIncome=TextEditingController(text:getProfileController?.getProfileModel?.data?.user?.annualIncome);
    familyStatus=TextEditingController(text:getProfileController?.getProfileModel?.data?.user?.familyStatus);
    familyAnnualIncome=TextEditingController(text:getProfileController?.getProfileModel?.data?.user?.familyIncome);
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text("Family Details"),),
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
                        const Text(
                          "About My Family",
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
                          controller: aboutFamily,
                          decoration:  InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            filled: true,
                            hintText: "About My Family",
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
SizedBox(height: 20,),
                        const Text(
                          "Father Name",
                          style:
                          TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
                        ),
                        const SizedBox(height: 5),
                        TextFormField(
                          inputFormatters: [
                            //LengthLimitingTextInputFormatter(10),
                            FilteringTextInputFormatter.allow(RegExp('[a-zA-Z ]')),
                          ],
                          textCapitalization: TextCapitalization.words,
                          controller:fathername,
                          decoration: const InputDecoration(
                            filled: true,
                            hintText: "Enter your Father name",
                            labelStyle: TextStyle(
                                color: Color(
                                  0xff961b20,
                                ),
                                fontSize: 16),
                            fillColor: Colors.transparent,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter Father Name';
                            }
                            if (value.length <= 3) {
                              return 'Father Name Length Should be More than 3';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.emailAddress,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          "Father Occupation",
                          style:
                          TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
                        ),
                        const SizedBox(height: 5),
                        TextFormField(
                          inputFormatters: [
                            //LengthLimitingTextInputFormatter(10),
                            FilteringTextInputFormatter.allow(RegExp('[a-zA-Z ]')),
                          ],
                          controller: fatherOccupation,
                          decoration: const InputDecoration(
                            filled: true,
                            hintText: "Enter Father Occupation",
                            labelStyle: TextStyle(
                                color: Color(
                                  0xff961b20,
                                ),
                                fontSize: 16),
                            fillColor: Colors.transparent,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter Father Occupation';
                            }

                          },
                          keyboardType: TextInputType.emailAddress,
                        ),
                        const SizedBox(
                          height: 20,
                        ),

                        const Text(
                          "Mother Name",
                          style:
                          TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
                        ),
                        const SizedBox(height: 5),
                        TextFormField(
                          inputFormatters: [
                            //LengthLimitingTextInputFormatter(10),
                            FilteringTextInputFormatter.allow(RegExp('[a-zA-Z ]')),
                          ],
                          controller: motherName,
                          decoration: const InputDecoration(
                            filled: true,
                            hintText: "Enter Mother Name",
                            labelStyle: TextStyle(
                                color: Color(
                                  0xff961b20,
                                ),
                                fontSize: 16),
                            fillColor: Colors.transparent,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter Mother Name';
                            }

                          },
                          keyboardType: TextInputType.name,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          "Mother Occupation",
                          style:
                          TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
                        ),
                        const SizedBox(height: 5),
                        TextFormField(
                          inputFormatters: [
                            //LengthLimitingTextInputFormatter(10),
                            FilteringTextInputFormatter.allow(RegExp('[a-zA-Z ]')),
                          ],
                          controller: motherOccupation,
                          decoration: const InputDecoration(
                            filled: true,

                            hintText: "Mother Occupation",
                            labelStyle: TextStyle(
                                color: Color(
                                  0xff961b20,
                                ),
                                fontSize: 16),
                            fillColor: Colors.transparent,
                            errorMaxLines: 3,
                            //fillColor: Colors.green
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter Mother Occupation';
                            }
                          },
                          keyboardType: TextInputType.visiblePassword,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          "Number of Brothers",
                          style:
                          TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
                        ),
                        const SizedBox(height: 5),
                        TextFormField(
                          //textCapitalization: TextCapitalization.words,
                          controller: numberBro,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(1),
                            FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                          ],
                          decoration: const InputDecoration(
                            filled: true,
                            hintText: "Enter Number of Brothers",
                            labelStyle: TextStyle(
                                color: Color(
                                  0xff961b20,
                                ),
                                fontSize: 16),
                            fillColor: Colors.transparent,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter Number of Brothers';
                            }

                          },
                          keyboardType: TextInputType.number,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          "Married Brothers",
                          style:
                          TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
                        ),
                        const SizedBox(height: 5),
                        TextFormField(
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(1),
                            FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                          ],
                          controller: marriedBro,
                          decoration: const InputDecoration(
                            filled: true,
                            hintText: "Enter Married Brothers",
                            labelStyle: TextStyle(
                                color: Color(
                                  0xff961b20,
                                ),
                                fontSize: 16),
                            fillColor: Colors.transparent,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter Married Brothers';
                            }

                          },
                          keyboardType: TextInputType.number,
                        ),
                        const SizedBox(
                          height: 20,
                        ),

                        const Text(
                          "Number of Sisters",
                          style:
                          TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
                        ),
                        const SizedBox(height: 5),
                        TextFormField(
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(1),
                            FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                          ],
                          controller: numberSis,
                          //controller: authController.phoneNumber,
                          decoration: const InputDecoration(
                            filled: true,
                            hintText: "Number of Sisters",
                            labelStyle: TextStyle(
                                color: Color(
                                  0xff961b20,
                                ),
                                fontSize: 16),
                            fillColor: Colors.transparent,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter Number of Sisters';
                            }

                          },
                          keyboardType: TextInputType.number,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          "Married Sisters",
                          style:
                          TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
                        ),
                        const SizedBox(height: 5),
                        TextFormField(
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(1),
                            FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                          ],
                          controller: marriedSis,
                          decoration: const InputDecoration(
                            filled: true,

                            hintText: "Married Sisters",
                            labelStyle: TextStyle(
                                color: Color(
                                  0xff961b20,
                                ),
                                fontSize: 16),
                            fillColor: Colors.transparent,
                            errorMaxLines: 3,
                            //fillColor: Colors.green
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter Married Sisters';
                            } 
                          },
                          keyboardType: TextInputType.number,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(

                          "Family Annual Income",
                          style:
                          TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
                        ),
                        const SizedBox(height: 5),
                        Autocomplete<AnnualIncome>(
                          displayStringForOption:
                          _displayStringForAnnualIncome,
                          optionsBuilder:
                              (TextEditingValue textEditingValue) {
                            return authController
                                .annualIncomeModel!.annualIncomes!
                                .where((AnnualIncome option) {
                              return option.annualIncome
                                  .toLowerCase()
                                  .contains(
                                  textEditingValue.text.toLowerCase());
                            });
                          },
                          onSelected: (AnnualIncome selection) {
                            setState(() {
                              // authController.annualIcomController =
                              //     TextEditingController(
                              //         text: selection.annualIncome);
                              familyAnnualIncome.text= selection.annualIncome;
                              //authController.countryId=int.parse(selection.id.toString());
                             // income = selection.id.toString();
                            });
                            //authController.getStates(context);
                          },
                          fieldViewBuilder: (context, controller, focusNode,
                              onEditingComplete) {
                            //  this.stateController = controller;

                            return TextFormField(
                                inputFormatters: [
                                  //LengthLimitingTextInputFormatter(10),
                                  FilteringTextInputFormatter.allow(RegExp('[a-zA-Z ]')),
                                ],
                                controller: familyAnnualIncome,
                                focusNode: focusNode,
                                onEditingComplete: onEditingComplete,
                                decoration: const InputDecoration(
                                  filled: false,
                                  fillColor: Colors.white70,
                                  hintText: "Select Family Annual Income",
                                ),
                                validator: (val) {

                                });
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          "Family Status",
                          style:
                          TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
                        ),
                        const SizedBox(height: 5),
                        Autocomplete<MotherTongues>(
                          displayStringForOption:
                          _displayStringForFamilySTatus,
                          optionsBuilder:
                              (TextEditingValue textEditingValue) {
                            return authController
                                .familystatus!.motherTongues!
                                .where((MotherTongues option) {
                              return option.value!
                                  .toLowerCase()
                                  .contains(
                                  textEditingValue.text.toLowerCase());
                            });
                          },
                          onSelected: (MotherTongues selection) {
                            setState(() {
                              // authController.annualIcomController =
                              //     TextEditingController(
                              //         text: selection.annualIncome);
                              familyStatus.text= selection.value!;
                              //authController.countryId=int.parse(selection.id.toString());
                              // income = selection.id.toString();
                            });
                            //authController.getStates(context);
                          },
                          fieldViewBuilder: (context, controller, focusNode,
                              onEditingComplete) {
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
                                  hintText: getProfileController?.getProfileModel?.data?.user?.familyStatus??"Select Family Status",
                                ),
                                validator: (val) {

                                });
                          },
                        ),
                        //  const  Expanded(child: SizedBox()),
                        const SizedBox(
                          height: 40,
                        ),
                        Center(
                          child: GestureDetector(

                              onTap: () async{



                                var user_id = await SharedPref().getString(key: "user_id");
                                Map<String,dynamic> data={
                                  "user_id":user_id,
                                  "about_family":aboutFamily.text,
                                  "father_name":fathername.text,
                                  "father_occupation":fatherOccupation.text,
                                  "mother_name":motherName.text,
                                  "mother_occupation":motherOccupation.text,
                                  "no_of_brothers":numberBro.text,
                                  "no_of_sisters":numberSis.text,
                                  "married_brothers":marriedBro.text,
                                  "married_sisters":marriedSis.text,
                                  "family_income":familyAnnualIncome.text,
                                  "family_status":familyStatus.text,
                                };
                                bool res= await updateController!.updateBasicDetails(context, data);

                                if(res==true){
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>PersonalProfile()));
                                }
                                setState(() {



                                });

                              },

                            child: AnimatedContainer(
                                width: authController.loginWidth,
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
                                    "Update",
                                    style: TextStyle(
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
          );
        }));
  }

  bool validateStructure(String value) {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(value);
  }
}
