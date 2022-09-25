import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:rishtey/controller/get_profile_controller.dart';
import 'package:rishtey/controller/update_controller.dart';
import 'package:rishtey/models/castes_model.dart';
import 'package:rishtey/models/marital_status_model.dart';
import 'package:rishtey/models/mother_tongue_model.dart';
import 'package:rishtey/presentation/profile/personal_profile.dart';
import 'package:rishtey/utils/app_snack_bar.dart';
import 'package:rishtey/utils/shared_pref.dart';

import '../../controller/auth_controller.dart';
import '../../models/religion_model.dart';
import '../register/add_image_signup.dart';

class RelationDetailsForth extends StatefulWidget {
  const RelationDetailsForth({Key? key}) : super(key: key);

  @override
  State<RelationDetailsForth> createState() => _SignUpState();
}

class _SignUpState extends State<RelationDetailsForth> {
  AuthController? authController;
  double loginWidth = 350;
  final registerKey = GlobalKey<FormState>();
  static String _displayMarital(MaritalStatus option) => option.maritalStatus!;
  static String _displayReligions(Religions option) => option.religion!;
  static String _displayMotherTongue(MotherTongues option) =>
      option.motherTongue!;
  static String _displayCastes(Casts option) => option.cast!;
  ReligionModel? data;
  var motherTongueId;
  var caste;
  var maritalStatus;
  var religion;
TextEditingController religionController=TextEditingController();
GetProfileController?getProfileController;
UpdateController?updateController;
TextEditingController gotraController=TextEditingController();
TextEditingController nativePlaceController=TextEditingController();
TextEditingController motherTongueController=TextEditingController();
TextEditingController communityController=TextEditingController();
TextEditingController subCommunityController=TextEditingController();


  @override
  void initState() {
    authController = Provider.of<AuthController>(context, listen: false);
    authController!.getReligion(context);
    authController!.getMotherTongue(context);
    authController!.getCastes(context);
    updateController = Provider.of<UpdateController>(context, listen: false);
    getProfileController = Provider.of<GetProfileController>(context, listen: false);
    religionController=TextEditingController(text: getProfileController?.getProfileModel?.data?.user?.religion);
    motherTongueController=TextEditingController(text: getProfileController?.getProfileModel?.data?.user?.motherTongue);
   gotraController=TextEditingController(text: getProfileController?.getProfileModel?.data?.user?.gotra);
    communityController=TextEditingController(text: getProfileController?.getProfileModel?.data?.user?.cast);
   nativePlaceController=TextEditingController(text:getProfileController?.getProfileModel?.data?.user?.nativePlace );
    // getData();
    super.initState();
  }

  getData() async {
    data = await authController!.getReligion(context);
  }

  @override
  Widget build(BuildContext context) {
    print("lbnlf${getProfileController?.getProfileModel?.data?.user?.religion}");

    return Scaffold(
        appBar: AppBar(title: Text("Religion Details"),

        ),
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

                        // const SizedBox(
                        //   height: 20,
                        // ),
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
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(RegExp(r'[]')),
                              ],
                              focusNode: focusNode,
                              onEditingComplete: onEditingComplete,
                              decoration: InputDecoration(
                                filled: false,
                                fillColor: Colors.white70,

                                hintText: getProfileController?.getProfileModel?.data?.user?.religion??"Your Religion",
                              ),
                              validator: (val){
                                if(religion==null||religion==0){
                                  return "Please Choose Religion From Dropdown";
                                }
                              },
                            );
                          },
                        ),
                        const SizedBox(height: 20),
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
                              motherTongueController=TextEditingController(text: selection.motherTongue.toString());

                              motherTongueId = selection.id.toString();
                            });

                          },
                          fieldViewBuilder: (context, controller, focusNode,
                              onEditingComplete) {
                            //  this.stateController = controller;

                            return TextFormField(
                              controller: controller,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(RegExp(r'[]')),
                              ],
                              focusNode: focusNode,
                              onEditingComplete: onEditingComplete,
                              decoration: InputDecoration(
                                filled: false,
                                fillColor: Colors.white70,

                                hintText: motherTongueController.text.isEmpty?"Select Mother Tongue":motherTongueController.text,
                              ),
                              validator: (val){
                                // if(motherTongueId==null||motherTongueId==0){
                                //   return"Please Choose Mother Tongue From Dropdown";
                                // }
                              },
                            );
                          },
                        ),

                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          "Community",
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
                              communityController=TextEditingController(text: selection.cast.toString());
                              //authController.countryId=int.parse(selection.id.toString());
                              caste = selection.id.toString();
                            });
                            //authController.getStates(context);
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

                                hintText: communityController.text,
                              ),
                              validator: (val){
                                // if(caste==null||caste==0){
                                //   return"Please Choose Castes  From Dropdown";
                                // }
                              },
                            );
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          "Sub-Community",
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
                              authController.castes = TextEditingController(
                                  text: selection.cast.toString());
                              //authController.countryId=int.parse(selection.id.toString());
                              caste = selection.id.toString();
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
                              controller: subCommunityController,
                              focusNode: focusNode,
                              onEditingComplete: onEditingComplete,
                              decoration:  InputDecoration(
                                filled: false,
                                fillColor: Colors.white70,
                                hintText: getProfileController?.getProfileModel?.data?.user?.subCast??"Select Sub-Community",
                              ),
                              validator: (val) {
                                // if (caste == null || caste == 0) {
                                //   return "Please Choose Community  From Dropdown";
                                // }
                              },
                            );
                          },
                        ),
                        const SizedBox(height: 20),



                        const Text(
                          "Gotra",
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
                          controller: gotraController,
                          decoration: const InputDecoration(
                            filled: true,
                            hintText: "Enter your Gotra",
                            labelStyle: TextStyle(
                                color: Color(
                                  0xff961b20,
                                ),
                                fontSize: 16),
                            fillColor: Colors.transparent,
                          ),
                          validator: (value) {


                          },
                          keyboardType: TextInputType.emailAddress,
                        ),
                        const Text(
                          "Native Place",
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
                          controller: nativePlaceController,
                          decoration: const InputDecoration(
                            filled: true,
                            hintText: "Enter your Native Place",
                            labelStyle: TextStyle(
                                color: Color(
                                  0xff961b20,
                                ),
                                fontSize: 16),
                            fillColor: Colors.transparent,
                          ),
                          validator: (value) {


                          },
                          keyboardType: TextInputType.emailAddress,
                        ),
                        SizedBox(height: 40,),
                        Center(
                          child: GestureDetector(
                            onTap: () async{



                                var user_id = await SharedPref().getString(key: "user_id");
                                Map<String, dynamic> data ={
                                  "user_id":user_id,
                                  "religion":authController.religion.text,
                                  "mother_tongue":motherTongueController.text,
                                  "community":communityController.text,
                                  "gotra":gotraController.text,
                                  "sub_community":subCommunityController.text,
                                  "native_place":nativePlaceController.text
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
}
