import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:rishtey/controller/get_profile_controller.dart';
import 'package:rishtey/controller/update_controller.dart';
import 'package:rishtey/models/EducationModel.dart';
import 'package:rishtey/models/states_model.dart';
import 'package:rishtey/presentation/profile/personal_profile.dart';
import 'package:rishtey/utils/shared_pref.dart';
import '../../controller/auth_controller.dart';
import '../../utils/app_snack_bar.dart';

class EducationDetails extends StatefulWidget {
  Map<String,dynamic>?data;
  final String?title;
  EducationDetails({Key? key,this.data,this.title}) : super(key: key);

  @override
  State<EducationDetails> createState() => _EducationDetailsState();
}

class _EducationDetailsState extends State<EducationDetails> {
  AuthController? authController;
  GetProfileController?getProfileController;
  static String _displayStringForEducation(Education option) =>
      option.education;
  var educationId;
  final registerKey = GlobalKey<FormState>();
  double loginWidth=350;
  TextEditingController aboutEducation=TextEditingController();
  TextEditingController anyEducation=TextEditingController();
  UpdateController?updateController;
  @override

  void initState() {
    authController = Provider.of<AuthController>(context,listen: false);
    updateController = Provider.of<UpdateController>(context,listen: false);
    getProfileController = Provider.of<GetProfileController>(context,listen: false);
    authController!.getEducationType(context);
    authController?.educationController=TextEditingController(text:getProfileController?.getProfileModel?.data?.user?.education);
    aboutEducation=TextEditingController(text:getProfileController?.getProfileModel?.data?.user?.aboutMyEducation);
   anyEducation=TextEditingController(text:getProfileController?.getProfileModel?.data?.user?.anyOtherQualifications);
    super.initState();
  }
  static String _displayStates(States option) => option.name!;

  @override
  Widget build(BuildContext context) {

    //print(widget.data!['manglik']);
    // authController!.birthTime=TextEditingController(text: widget.data!['birth_date_time']);
    // authController!.dateinput=TextEditingController(text: widget.data!['birth_date_time']);
    // authController!.birthPlace=TextEditingController(text: widget.data!['birth_place']);
    return Scaffold(
      appBar: AppBar(title: Text("Education Details"),

      ),
      body: Container(
        margin: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "About My Education",
              style:
              TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
            ),
            const SizedBox(height: 5),
            TextFormField(

              controller: aboutEducation,
              inputFormatters: [
                //LengthLimitingTextInputFormatter(10),
                FilteringTextInputFormatter.allow(RegExp('[a-zA-Z ]')),
              ],
              maxLines: 5,
              //controller: authController!.phoneNumber,
              decoration:  InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                filled: true,
                hintText: "Enter your educations",
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
            const SizedBox(height: 20),
          const Text(
            "Select Education",
            style:
            TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
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
                  hintText: getProfileController?.getProfileModel?.data?.user?.education??"Select Education",
                ),
                validator: (val) {
                  if (educationId == null || educationId == 0) {
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
          "Any Other Qualification",
          style:
          TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
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
                  inputFormatters: [
                    //LengthLimitingTextInputFormatter(10),
                    FilteringTextInputFormatter.allow(RegExp('[a-zA-Z ]')),
                  ],
                  controller: anyEducation,
                  focusNode: focusNode,
                  onEditingComplete: onEditingComplete,
                  decoration: const InputDecoration(
                    filled: false,
                    fillColor: Colors.white70,
                    hintText: "Select Education",
                  ),
                  validator: (val) {
                    if (educationId == null || educationId == 0) {
                      return "Please Choose Education from dropdown";
                    }
                  },
                );
              },
            ),
        const SizedBox(height: 20),
            const SizedBox(height: 40),
            Center(
              child: GestureDetector(
                onTap: () async{



                    var user_id = await SharedPref().getString(key: "user_id");
                    Map<String, dynamic> data ={
                      "user_id":user_id,
                      "about_my_education":aboutEducation.text,
                      "education":authController!.educationController.text,
                      "any_other_qualifications":anyEducation.text
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
          ],),),
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