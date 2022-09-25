import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rishtey/presentation/bottom_navigation_bar.dart';
import 'package:rishtey/utils/app_button.dart';

import '../../../controller/ImagePickerController.dart';
import '../../../controller/get_profile_controller.dart';
import '../../../utils/app_config.dart';
import 'gallery_alert.dart';
import 'image_edit.dart';

class Gallery extends StatefulWidget {
  @override
  State<Gallery> createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  GetProfileController? getProfileController;
  ImagePickerController? imagePickerController;
  var age;
  var fullImage = "";
  @override
  void initState() {
    Future.delayed(Duration(milliseconds: 100),(){
      getProfileController =
          Provider.of<GetProfileController>(context, listen: false);
      imagePickerController =
          Provider.of<ImagePickerController>(context, listen: false);
      getProfileController!.getProfile(context);
    });

    // fullImage = getProfileController?.getProfileModel?.data?.user?.photo
    //         ?.replaceAll("file:///", "") ??
    //     "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => MyHomePage()));
        return Future.value(true);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("My Photos"),
        ),
        floatingActionButton: AppButton(
          onClick: () {
            showAlertDialog(context);
          },
          textWidet: Text(
            "Add More Photos",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Container(
          margin: EdgeInsets.all(10),
          child: Consumer<GetProfileController>(
              builder: (context, controller, child) {
            return getProfileController?.getProfileModel?.images?.length == 0
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.info_rounded,
                        size: 100,
                        color: AppConfig.theme.primaryColor.withOpacity(0.7),
                      ),
                      Center(
                          child: Text(
                        "No Images Available",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: AppConfig.width * 0.1),
                      ))
                    ],
                  )
                : Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(20),
                        color: Colors.grey.shade300,
                        child: Row(
                          children: [
                            Text("Privacy Settings"),
                            Spacer(),
                            // Text(
                            //   getProfileController?.getProfileModel?.images?[0]
                            //               .privacy ==
                            //           "2"
                            //       ? "Visible to member i shotlisted"
                            //       : "Visible to all members",
                            //   style: TextStyle(fontWeight: FontWeight.w800),
                            // ),
                            // SizedBox(
                            //   width: AppConfig.width * 0.75,
                            // ),
                            GestureDetector(
                                onTap: () {
                                  showPrivacyDialog(context);
                                },
                                child: Text(
                                  "Edit",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: AppConfig.theme.primaryColor),
                                )),
                          ],
                        ),
                      ),
                      const Divider(
                        thickness: 1,
                        height: 20,
                        color: Colors.grey,
                      ),
                      Consumer<GetProfileController>(
                          builder: (context, controller, child) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Edit(
                                          title:
                                          "https://webtechworlds.com/himrishtey/photos/photo/" +
                                              (controller.getProfileModel?.data?.user
                                                  ?.photo ??
                                                  "")
                                        )));
                          },
                          child: SizedBox(
                              height: AppConfig.height * 0.45,
                              width: AppConfig.width,
                              child: Image.network(
                                "https://webtechworlds.com/himrishtey/photos/photo/" +
                                        (controller.getProfileModel?.data?.user
                                                ?.photo ??
                                            "") ??
                                    'https://thumbs.dreamstime.com/b/handsome-male-model-posing-elegant-smile-88528667.jpg',
                                fit: BoxFit.fill,
                              )),
                        );
                      }),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: AppConfig.height * 0.2,
                        width: AppConfig.width,
                        child: getProfileController
                                    ?.getProfileModel?.images?.length ==
                                0
                            ? Column(
                                children: [
                                  Icon(
                                    Icons.hourglass_empty,
                                    size: 60,
                                  ),
                                  Text("No Images Uploaded Yet")
                                ],
                              )
                            : ListView.builder(
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      // fullImage=getProfileController?.getProfileModel?.images?[index].images??"";
                                      // setState(() {
                                      //
                                      // });
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) => Edit(
                                                          title: getProfileController
                                                                  ?.getProfileModel
                                                                  ?.images?[
                                                                      index]
                                                                  .images ??
                                                              "",
                                                        )));
                                            // fullImage=getProfileController?.getProfileModel?.images?[index].images??"";
                                            // setState(() {
                                            //
                                            // });
                                          },
                                          child: Image.network(
                                              getProfileController
                                                      ?.getProfileModel
                                                      ?.images?[index]
                                                      .images ??
                                                  "")),
                                    ),
                                  );
                                },
                                scrollDirection: Axis.horizontal,
                                itemCount: getProfileController
                                    ?.getProfileModel?.images?.length,
                              ),
                      )
                    ],
                  );
          }),
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed: () {},
    );
    Widget continueButton = TextButton(
      child: Text("Camera"),
      onPressed: () {},
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      contentPadding: EdgeInsets.zero,
      title: Text("Pick Images"),
      content: Container(
        height: AppConfig.height * 0.25,
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () {
                imagePickerController!.pickGallery(context, api: "Yes");
              },
              child: CircleAvatar(
                radius: 40,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.image, color: Colors.black),
                    Text(
                      "Gallery",
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                imagePickerController!.pickImage(context, api: "Yes");
              },
              child: CircleAvatar(
                radius: 40,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.camera, color: Colors.black),
                    Text(
                      "Camera",
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      actions: [
        cancelButton,
        //continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}

showPrivacyDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return GalleryAlert();
    },
  );
}
