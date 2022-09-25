import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:rishtey/models/states_model.dart';
import 'package:rishtey/presentation/register/widgets/rounded_date_picker.dart';

import '../../controller/auth_controller.dart';

class ReligionDetail extends StatefulWidget {
  Map<String,dynamic>?data;
  final String?title;
  ReligionDetail({Key? key,this.data,this.title}) : super(key: key);

  @override
  State<ReligionDetail> createState() => _ReligionDetailState();
}

class _ReligionDetailState extends State<ReligionDetail> {
  AuthController? authController;

  final registerKey = GlobalKey<FormState>();
  @override
  void initState() {

    super.initState();
  }
  static String _displayStates(States option) => option.name!;

  @override
  Widget build(BuildContext context) {
    authController = Provider.of<AuthController>(context);
    //print(widget.data!['manglik']);
    authController!.phoneNumber=TextEditingController(text: widget.data!['mobile_number']);
    authController!.email=TextEditingController(text: widget.data!['email']);
    //authController!.birthPlace=TextEditingController(text: widget.data!['birth_place']);
    return Scaffold(
      appBar: AppBar(title: Text(widget.title!),

      ),
      body: Container(
        margin: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Email",
              style:
              TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
            ),
            const SizedBox(height: 5),
            TextFormField(
              inputFormatters: [
                LengthLimitingTextInputFormatter(10),
              ],
              controller: authController!.email,
              decoration: const InputDecoration(
                filled: true,
                hintText: "Enter Email",
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
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 20),
            const Text(
              "Phone Number",
              style:
              TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
            ),
            const SizedBox(height: 5),
            TextFormField(
              inputFormatters: [
                LengthLimitingTextInputFormatter(10),
              ],
              controller: authController!.phoneNumber,
              decoration: const InputDecoration(
                filled: true,
                hintText: "Enter Phone Number",
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
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 20),
            const Text(
              "Alternate Number",
              style:
              TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
            ),
            const SizedBox(height: 5),
            TextFormField(
              inputFormatters: [
                LengthLimitingTextInputFormatter(10),
              ],
              controller: authController!.phoneNumber,
              decoration: const InputDecoration(
                filled: true,
                hintText: "Enter Phone Number",
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
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 20),
            const Text(
              "Whatsapp Number",
              style:
              TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
            ),
            const SizedBox(height: 5),
            TextFormField(
              inputFormatters: [
                LengthLimitingTextInputFormatter(10),
              ],
              controller: authController!.phoneNumber,
              decoration: const InputDecoration(
                filled: true,
                hintText: "Enter Phone Number",
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
              keyboardType: TextInputType.phone,
            )
            ,
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