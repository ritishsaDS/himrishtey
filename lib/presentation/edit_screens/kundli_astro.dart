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

class EditDetails extends StatefulWidget {
  Map<String,dynamic>?data;
  final String?title;
   EditDetails({Key? key,this.data,this.title}) : super(key: key);

  @override
  State<EditDetails> createState() => _EditDetailsState();
}

class _EditDetailsState extends State<EditDetails> {
  AuthController? authController;
UpdateController?updateController;
  TextEditingController dateOfBirth=TextEditingController();
  TextEditingController selectBirthTime=TextEditingController();
  TextEditingController placeBirth=TextEditingController();
  TextEditingController manglik=TextEditingController();
  TextEditingController horoscope=TextEditingController();
  final registerKey = GlobalKey<FormState>();
  @override
  void initState() {

    super.initState();
    authController = Provider.of<AuthController>(context,listen: false);
    //print(widget.data!['manglik']);
    authController!.birthTime=TextEditingController(text: widget.data!['birth_date_time'].toString().split(" ")[1]+widget.data!['birth_date_time'].toString().split(" ")[2]);
    //authController!.birthTime=TextEditingController(text: widget.data!['birth_date_time']);
    authController!.dateinput=TextEditingController(text: widget.data!['birth_date_time'].toString().split(" ")[0]);
    authController!.birthPlace=TextEditingController(text: widget.data!['birth_place'].toString());
    updateController=Provider.of<UpdateController>(context,listen: false);
    authController!.getStates(context);
  }
  double loginWidth = 350;
  static String _displayStates(States option) => option.name!;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text(widget.title!),

      ),
body: Container(
  margin: EdgeInsets.all(20),
  child: Column(
  mainAxisAlignment: MainAxisAlignment.start,
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
  Form(
    key: registerKey,
    child: Container(

      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        const Text(
          "Select Birth Time",
          style:
          TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
        ),
        const SizedBox(height: 5),
        Container(



          width: MediaQuery.of(context).size.width,
          child: TextFormField(
            readOnly: true,
            controller: authController!.birthTime,
            style: TextStyle(color: Colors.grey.shade500),
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
             // _showDatePicker(context);



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
    ),
  ),
    const SizedBox(height: 20),
    Container(

      width: MediaQuery.of(context).size.width,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
        const Text(
          "Select Date of birth",
          style:
          TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
        ),
        const SizedBox(height: 5),
        Container(

          width: MediaQuery.of(context).size.width,
          child: TextFormField(
            style: TextStyle(color: Colors.grey.shade500),
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
            // CupertinoRoundedDatePickers.show(
            //   context,
            //   fontFamily: "Poppins",
            //   textColor: Colors.white,
            //   background: Colors.black,
            //   borderRadius: 16,
            //
            //   initialDatePickerMode: CupertinoDatePickerMode.date,
            //   onDateTimeChanged: (newDateTime) {
            //     //\
            //     setState(() {
            //       authController!.dateinput=TextEditingController(text: newDateTime.toString().substring(0,10));
            //     });
            //     print(newDateTime);
            //   },
            //
            // );
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
    ),
    const SizedBox(height: 20),
  const Text(
    "Place of birth ",
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
          FilteringTextInputFormatter.allow(RegExp(r'[A-Za-z ]')),
        ],
        controller: authController!.birthPlace,

        focusNode: focusNode,
        onEditingComplete: onEditingComplete,
        decoration: InputDecoration(
          filled: false,
          fillColor: Colors.white70,

          hintText:  authController!.birthPlace.text.isEmpty?"Enter Place of birth":authController!.birthPlace.text,
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
      value: authController!.isManglik,
      onChanged: (String ?newValue) {
        setState(() {
          authController!.isManglik = newValue!;
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
    "Horoscope match is must",
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
      value: authController!.dropdownValue,
      onChanged: (String ?newValue) {
        setState(() {
          authController!.dropdownValue = newValue!;
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
    Center(
      child: GestureDetector(
        onTap: () async{



            var user_id = await SharedPref().getString(key: "user_id");
            Map<String, dynamic> data ={
              "user_id":user_id,
              "birth_date_time":authController!.birthTime.text,
              "date_of_birth":authController!.dateinput.text,
              "birth_place":authController!.birthPlace.text,
              "horoscope_needed":authController!.dropdownValue,
              "manglik":authController!.isManglik
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