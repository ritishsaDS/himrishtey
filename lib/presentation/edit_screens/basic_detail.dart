import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:rishtey/controller/get_profile_controller.dart';
import 'package:rishtey/controller/update_controller.dart';
import 'package:rishtey/models/height_model.dart';
import 'package:rishtey/models/marital_status_model.dart';
import 'package:rishtey/presentation/profile/personal_profile.dart';
import 'package:rishtey/presentation/register/sign_up_second.dart';

import '../../controller/auth_controller.dart';
import '../../utils/shared_pref.dart';

class BasicDetails extends StatefulWidget {
  const BasicDetails({Key? key}) : super(key: key);

  @override
  State<BasicDetails> createState() => _BasicDetailsState();
}

class _BasicDetailsState extends State<BasicDetails> {
  AuthController? authController;
  UpdateController?updateController;
  GetProfileController?getProfileController;
  var heightId;

  var maritalStatus;

  static String _displayHeights(Heights option) => option.height!;
  static String _displayMarital(MaritalStatus option) => option.maritalStatus!;
  final registerKey = GlobalKey<FormState>();
  TextEditingController maritalController=TextEditingController();
  TextEditingController profileCreatedController=TextEditingController();
  TextEditingController healthInfo=TextEditingController();
  TextEditingController bloodGroup=TextEditingController();
  TextEditingController anyDisability=TextEditingController();
  String?gender;
  @override
  void initState() {
    super.initState();
    authController = Provider.of<AuthController>(context,listen: false);

    getProfileController = Provider.of<GetProfileController>(context,listen: false);
    authController!.getHeights(context);
    updateController=Provider.of<UpdateController>(context,listen: false);
  }
  @override
  Widget build(BuildContext context) {

    maritalController=TextEditingController(text: getProfileController?.getProfileModel?.data?.user?.maritalStatus);
    bloodGroup=TextEditingController(text: getProfileController?.getProfileModel?.data?.user?.bloodGroup);
    anyDisability=TextEditingController(text: getProfileController?.getProfileModel?.data?.user?.anyDisability);
    return Scaffold(
      appBar:AppBar(title: Text("Basic Details"),),
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

                        // const Center(
                        //     child: Text(
                        //       "Basic Details",
                        //       style:
                        //       TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
                        //     )),
                        const SizedBox(height: 25),
                        const Text(
                          "Profile Created By",
                          style:
                          TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
                        ),
                        const SizedBox(height: 5),
                        TextFormField(
                          readOnly: true,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(10),
                          ],

                        controller: profileCreatedController,
                          decoration:  InputDecoration(
                            filled: true,

                            hintText: getProfileController?.getProfileModel?.data?.user?.profileCreatedFor,
                            labelStyle:const TextStyle(
                                color: Color(
                                  0xff961b20,
                                ),
                                fontSize: 16),
                            hintStyle: TextStyle(color: Colors.grey.shade500),
                            fillColor: Colors.transparent,
                          ),
                          validator: (value) {

                            return null;
                          },
                          keyboardType: TextInputType.name,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          "Select Gender",
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
                            value: authController.genderValue,
                            onChanged: null,
                            items: <String>['Male', 'Female', 'Others', ]
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(

                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          "Select Height (in ft.)",
                          style:
                          TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Autocomplete<Heights>(
                          displayStringForOption: _displayHeights,
                          optionsBuilder: (TextEditingValue textEditingValue) {
                            return authController.heightModel!.heights!
                                .where((Heights option) {
                              return option.height!
                                  .toLowerCase()
                                  .contains(textEditingValue.text.toLowerCase());
                            });
                          },
                          onSelected: (Heights selection) {
                            setState(() {
                              authController.height=TextEditingController(text: selection.height);
                              heightId=selection.height;
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
                              decoration: InputDecoration(
                                filled: false,
                                fillColor: Colors.white70,

                                hintText: getProfileController?.getProfileModel?.data?.user?.height.toString()??"Select Height",
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
                        const Text(
                          "Marital Status",
                          style:
                          TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
                        ),
                        const SizedBox(height: 5),
                       Consumer<GetProfileController>(
                          builder: (context,Getcontroller,child) {
                            return Autocomplete<MaritalStatus>(

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
                                  readOnly: false,
                                  controller: maritalController,
                                  focusNode: focusNode,
                                  style: TextStyle(color: Colors.grey.shade500),
                                  onEditingComplete: onEditingComplete,
                                  decoration: InputDecoration(
                                    filled: false,
                                    fillColor: Colors.white70,
hintStyle: TextStyle(color: Colors.grey.shade500),

                                    hintText: Getcontroller.getProfileModel?.data?.user?.maritalStatus,
                                  ),
                                  validator: (val){
                                    // if(maritalStatus==null||maritalStatus==0){
                                    //   return"Please Choose Marital Status From Dropdown";
                                    // }
                                  },
                                );
                              },
                            );
                          }
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          "Health Information",
                          style:
                          TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
                        ),
                        // const SizedBox(height: 5),
                        // TextFormField(
                        //   controller: healthInfo,
                        //   inputFormatters: [
                        //     LengthLimitingTextInputFormatter(10),
                        //   ],
                        //   //controller: authController!.phoneNumber,
                        //   decoration: const InputDecoration(
                        //     filled: true,
                        //     hintText: "Enter health information",
                        //     labelStyle: TextStyle(
                        //         color: Color(
                        //           0xff961b20,
                        //         ),
                        //         fontSize: 16),
                        //     fillColor: Colors.transparent,
                        //   ),
                        //   validator: (value) {
                        //
                        //     return null;
                        //   },
                        //   keyboardType: TextInputType.name,
                        // ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          "Any Disability",
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
                        authController.haveChild=="No"?Container():  TextFormField(
                          controller: anyDisability,
                          inputFormatters: [
                            //LengthLimitingTextInputFormatter(10),
                            FilteringTextInputFormatter.allow(RegExp('[a-zA-Z ]')),
                          ],
                          //controller: authController!.phoneNumber,
                          decoration: const InputDecoration(
                            filled: true,
                            hintText: "Enter disability if you have any",
                            labelStyle: TextStyle(
                                color: Color(
                                  0xff961b20,
                                ),
                                fontSize: 16),
                            fillColor: Colors.transparent,
                          ),
                          validator: (value) {

                            return null;
                          },
                          keyboardType: TextInputType.name,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          "Blood Group",
                          style:
                          TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
                        ),
                        const SizedBox(height: 5),
                        TextFormField(
                          controller: bloodGroup,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(10),

                            FilteringTextInputFormatter.allow(RegExp('[a-zA-Z +]')),

                          ],
                          //controller: authController!.phoneNumber,
                          decoration: const InputDecoration(
                            filled: true,
                            hintText: "Enter your blood group",
                            labelStyle: TextStyle(
                                color: Color(
                                  0xff961b20,
                                ),
                                fontSize: 16),
                            fillColor: Colors.transparent,
                          ),
                          validator: (value) {

                            return null;
                          },
                          keyboardType: TextInputType.name,
                        ),
                        //  const  Expanded(child: SizedBox()),
                        const SizedBox(
                          height: 40,
                        ),
                        Center(
                          child: GestureDetector(
                            onTap: () async{
                             // if (registerKey.currentState!.validate()) {


                                var user_id = await SharedPref().getString(key: "user_id");
                                            Map<String, dynamic> data ={
                                              "user_id":user_id,
                                              "profile_created_for":profileCreatedController.text,
                                              "gender":"Male",
                                              "marital_status":maritalController.text,
                                              "height":heightId,
                                              "health_info":healthInfo.text,
                                              "any_disability":anyDisability.text.isEmpty?"No":anyDisability.text,
                                              "blood_group":bloodGroup.text
                                            };
                                           bool res= await updateController!.updateBasicDetails(context, data);

                                      if(res==true){
                                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>PersonalProfile()));
                                      }
                                        setState(() {



                                });
                             // }
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
