import 'package:flutter/material.dart';
import 'package:rishtey/utils/app_button.dart';
import 'package:rishtey/utils/app_config.dart';

import '../../utils/delete_account_dialog.dart';
var reason="";
class DeleteAccountReason extends StatefulWidget {
  const DeleteAccountReason({Key? key}) : super(key: key);

  @override
  State<DeleteAccountReason> createState() => _DeleteAccountReasonState();
}

class _DeleteAccountReasonState extends State<DeleteAccountReason> {
  reasons? _character = reasons.amDeletedProfileTemperory;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text("Delete Account"),),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            AppConfig.sizedBoxV(0.02),
            Text("After Pressing Delete Button Your Account would be Permanent Deleted,\nAll matches you've looked\nConnected or contacted & chat history",style: TextStyle(fontWeight: FontWeight.w200,fontSize: 18,color: Colors.grey.shade400),),
            AppConfig.sizedBoxV(0.05),
            RadioListTile<reasons>(
                title: Text('Am getting married',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 18),),
                value: reasons.amDeletedProfileTemperory,
                groupValue: _character,
                //your group value,
                onChanged: ( reasons ?value) {

                    _character = value;
                    reason="Am getting married";
                    setState(() {

                    });

                }),
            RadioListTile<reasons>(
                title: Text('Found my match on Himrishtey.com',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 18),),
                value: reasons.notGetASuitablePartner,
                groupValue: _character,
                //your group value,
                onChanged: ( reasons ?value) {


                  setState(() {
                    _character = value;
                    reason="Found my match on Himrishtey.com";
                  });
                  print(_character);
                }),
            RadioListTile<reasons>(

                title: Text('Found my match elsewhere',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 18),),
                value: reasons.privacy,
                groupValue: _character,
                //your group value,
                onChanged: ( reasons ?value) {

                  _character = value;
                  reason='Found my match elsewhere';
setState(() {

});
                }),
            RadioListTile<reasons>(
                title: Text('Unsatisfactory Experience',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 18),),
                value: reasons.fraud,
                groupValue: _character,
                //your group value,
                onChanged: ( reasons ?value) {

                  _character = value;
                  reason='Unsatisfactory Experience';
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
                  reason='Other';
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
                "Delete Account",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w800),
              ),
              onClick: () {

                showDialog(
                    context: context,
                    builder: (_) => BaseAlertDialog(
                          content:
                              "Are you sure you want to delete your account",
                          title: "Delete Account",
                        ));
              },
            )
          ],
        ),
      ),
    );
  }
}
enum reasons { privacy, amDeletedProfileTemperory,notGetASuitablePartner,fraud,other }