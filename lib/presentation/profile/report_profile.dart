import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rishtey/controller/auth_controller.dart';
import 'package:rishtey/utils/app_button.dart';
import 'package:rishtey/utils/app_config.dart';

import '../../utils/delete_account_dialog.dart';
var Reportreason="";
class ReportAccountReason extends StatefulWidget {
  final String?profileId;
  const ReportAccountReason({Key? key,this.profileId}) : super(key: key);

  @override
  State<ReportAccountReason> createState() => _DeleteAccountReasonState();
}

class _DeleteAccountReasonState extends State<ReportAccountReason> {
  reasons? _character = reasons.amDeletedProfileTemperory;
AuthController?authController;
@override
  void initState() {
  Future.delayed((Duration(milliseconds: 100)),(){
    authController=Provider.of<AuthController>(context,listen: false);
  });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text("Report Account"),),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            AppConfig.sizedBoxV(0.02),
//            AppConfig.sizedBoxV(0.05),
            RadioListTile<reasons>(
                title: Text('Fake People',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 18),),
                value: reasons.amDeletedProfileTemperory,
                groupValue: _character,
                //your group value,
                onChanged: ( reasons ?value) {

                  _character = value;
                  Reportreason="Fake People";
                  setState(() {

                  });

                }),
            RadioListTile<reasons>(
                title: Text('Misbehave in chat',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 18),),
                value: reasons.notGetASuitablePartner,
                groupValue: _character,
                //your group value,
                onChanged: ( reasons ?value) {


                  setState(() {
                    _character = value;
                    Reportreason="Misbehave in chat";
                  });
                  print(_character);
                }),
            RadioListTile<reasons>(

                title: Text('Wrong Contact Number',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 18),),
                value: reasons.privacy,
                groupValue: _character,
                //your group value,
                onChanged: ( reasons ?value) {

                  _character = value;
                  Reportreason='Wrong Contact Number';
                  setState(() {

                  });
                }),
            RadioListTile<reasons>(
                title: Text('Already Engaged/Married',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 18),),
                value: reasons.fraud,
                groupValue: _character,
                //your group value,
                onChanged: ( reasons ?value) {

                  _character = value;
                  Reportreason='Already Engaged/Married';
                  setState(() {

                  });
                }),
            RadioListTile<reasons>(
                title: Text("Don't pickup the call",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 18),),
                value: reasons.call,
                groupValue: _character,
                //your group value,
                onChanged: ( reasons ?value) {

                  _character = value;
                  Reportreason="Don't pickup the call";
                  setState(() {

                  });
                }),
            RadioListTile<reasons>(
                title: Text('Other',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 18),),
                value: reasons.other,
                groupValue: _character,
                //your group value,
                onChanged: ( reasons ?value) {

                  _character = value;
                  Reportreason='Other';
                  setState(() {

                  });
                }),
            _character==reasons.other? TextField(
              // controller: model.textController,
              maxLines: 5,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(7),
                ),
                hintText: "Type Reason",
                //hintMaxLines: 3,
              ),
            ):Container(),
            Expanded(child: SizedBox()),
            AppButton(
              textWidet: Text(
                "Report Account",
                style:
                TextStyle(color: Colors.white, fontWeight: FontWeight.w800),
              ),
              onClick: () {
                authController?.reportProfile(context, widget.profileId);

              },
            )
          ],
        ),
      ),
    );
  }
}
enum reasons { privacy, amDeletedProfileTemperory,notGetASuitablePartner,fraud,other,call }