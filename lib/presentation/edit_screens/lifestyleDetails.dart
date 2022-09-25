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

class LifestyleDetails extends StatefulWidget {
  Map<String,dynamic>?data;
  final String?title;
  LifestyleDetails({Key? key,this.data,this.title}) : super(key: key);

  @override
  State<LifestyleDetails> createState() => _LifestyleDetailsState();
}

class _LifestyleDetailsState extends State<LifestyleDetails> {
  AuthController? authController;
UpdateController?updateController;
  final registerKey = GlobalKey<FormState>();
  @override
  void initState() {
    authController = Provider.of<AuthController>(context,listen: false);
    updateController=Provider.of<UpdateController>(context,listen: false);
    super.initState();
  }
  String?diet;
  String?drinking="No";
  String?smoking="No";
  double loginWidth=350;
  static String _displayStates(States option) => option.name!;

  @override
  Widget build(BuildContext context) {

    //print(widget.data!['manglik']);
    //authController!.birthTime=TextEditingController(text: widget.data!['birth_date_time']);
    //authController!.dateinput=TextEditingController(text: widget.data!['birth_date_time']);
    //authController!.birthPlace=TextEditingController(text: widget.data!['birth_place']);
    return Scaffold(
      appBar: AppBar(title: Text("Lifesyle "),

      ),
      body: Container(
        margin: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const Text(
              "Diet",
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
                value: "Veg",
                onChanged: (String ?newValue) {
                  setState(() {
                   // authController!.dropdownValue = newValue!;
                  diet=newValue;
                  });
                },
                items: <String>['Pure Veg', 'Veg & NonVeg', ]
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            )
            ,
            const Text(
              "Is Drinking",
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
                value: drinking,
                onChanged: (String ?newValue) {
                  setState(() {
                    //authController!.dropdownValue = newValue!;
                  drinking=newValue;
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
            ),
            const Text(
              "Is Smoking",
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
                value: smoking,
                onChanged: (String ?newValue) {
                  setState(() {
                   // authController!.dropdownValue = newValue!;
                    smoking
                    =newValue;
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
            ),
            const SizedBox(height: 40),
            Center(
              child: GestureDetector(
                onTap: () async{



                  var user_id = await SharedPref().getString(key: "user_id");
                  Map<String, dynamic> data ={
                    "user_id":user_id,
                    "diet":diet,
                    "is_drinking":drinking,
                    "is_smoking":smoking,
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