import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rishtey/utils/app_config.dart';

import '../controller/search_controller.dart';
import '../utils/shared_pref.dart';

class EndDrawer extends StatefulWidget {
  dynamic data;
  String? apiKey;
  String? selectionType;
  EndDrawer({Key? key, this.data, this.apiKey,this.selectionType}) : super(key: key);

  @override
  State<EndDrawer> createState() => _EndDrawerState();
}

class _EndDrawerState extends State<EndDrawer> {
  SearchController? searchController;
  @override
  void initState() {
    print("ojfmkclm${widget.apiKey}");
    Future.delayed(Duration(milliseconds: 200),(){
      searchController = Provider.of<SearchController>(context, listen: false);
      //searchController!.emptyList();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchController>(
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
                        searchController.addInList(widget.data[index],widget.selectionType);
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
                      var user_id =
                          await SharedPref().getString(key: "user_id");
                      // Map<String, dynamic> data = {
                      //   "user_id": "27",
                      //   "gender": "Female",
                      //   widget.apiKey!: searchController.selectedList
                      //       .toString()
                      //       .replaceAll("]", "")
                      //       .replaceAll("[", ""),
                      // };

                      searchController.advanceData['user_id']="27";
                      searchController.advanceData['gender']="Female";
                      searchController.advanceData[widget.apiKey!]=searchController.selectedList
                          .toString()
                          .replaceAll("]", "")
                          .replaceAll("[", "");
                      setState(() {});
                      searchController.addValue(widget.apiKey,searchController.selectedList
                          .toString()
                          .replaceAll("]", "")
                          .replaceAll("[", ""));
                      Navigator.pop(context);
                      //searchController.advanceSearch(context, data);
                    },
                    child: const Text(
                      "Apply",
                      style: const TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.w600,
                          fontSize: 18),
                    )),
                const Text(
                  "Cancel",
                  style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.w600,
                      fontSize: 18),
                ),
              ],
            )
          ],
        ),
      );
    });
  }
}
