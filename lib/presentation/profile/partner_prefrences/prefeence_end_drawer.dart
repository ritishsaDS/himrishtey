import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rishtey/controller/auth_controller.dart';
import 'package:rishtey/controller/update_controller.dart';
import 'package:rishtey/utils/app_config.dart';
import 'package:rishtey/utils/shared_pref.dart';

import '../../../controller/search_controller.dart';



class PrefrenceEndDrawer extends StatefulWidget {
  dynamic data;
  String? apiKey;
  String? selectionType;
  PrefrenceEndDrawer({Key? key, this.data, this.apiKey,this.selectionType}) : super(key: key);

  @override
  State<PrefrenceEndDrawer> createState() => PrefrenceEndDrawerState();
}

class PrefrenceEndDrawerState extends State<PrefrenceEndDrawer> {
AuthController?authController;
  @override
  void initState() {
print("widget.apiKey");
print(widget.apiKey);
Future.delayed(Duration(milliseconds: 100),(){
  authController=Provider.of<AuthController>(context,listen: false);
  authController?.getStates(context);
});
    super.initState();
  }
List <String>mapList=[];
  @override
  Widget build(BuildContext context) {
    return Consumer<UpdateController>(
        builder: (context, searchController, child) {
          return Container(
            width: AppConfig.width * 0.6,
            color: Colors.white,
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: AppConfig.height * 0.9,
                  child: ListView.separated(
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            print(widget.apiKey);
                            if(widget.selectionType=="multi"){
                              mapList.add(widget.data[index]);
                              searchController.addInList(widget.data[index], widget.selectionType,widget.apiKey);
                              print(widget.apiKey);
                              searchController.addinMap(widget.apiKey, mapList.toString().replaceAll("]", "").replaceAll("[", ""));
                            }
                else{

                            searchController.addInList(widget.data[index], widget.selectionType,widget.apiKey);

                            searchController.addinMap(widget.apiKey, widget.data[index]);
                            }
                print(searchController.selectedMap);
if(widget.apiKey=="partner_state"){
  authController?.stateId=authController?.statesModel?.states?[index].id;
  authController?.getCities(context);
}
                          },
                          child: Row(
                            children: [
                              const SizedBox(
                                width: 20,
                              ),
                              Visibility(
                                  visible: searchController.selectedList
                                      .contains(widget.data[index]),
                                  child: const Icon(
                                    Icons.check,
                                    color: Colors.blue,
                                  )),
                              const SizedBox(
                                width: 10,
                              ),
                              Container(
                                  width: AppConfig.width * 0.45,
                                  child: Text(
                                    widget.data[index],
                                    style: TextStyle(
                                        color: AppConfig.theme.primaryColor),
                                  )),
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const Divider(
                          thickness: 1.5,
                        );
                      },
                      itemCount: widget.data!.length),
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                        onTap: () async {
                         Navigator.pop(context);

                         // searchController.advanceSearch(context, data);
                        },
                        child: const Text(
                          "Apply",
                          style: const TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.w600,
                              fontSize: 18),
                        )),
                     GestureDetector(
                      onTap: () async {
                        Navigator.pop(context);

                        // searchController.advanceSearch(context, data);
                      },
                      child: Text(
                      "Cancel",
                      style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.w600,
                          fontSize: 18),
                    )),
                  ],
                )
              ],
            ),
          );
        });
  }
}
