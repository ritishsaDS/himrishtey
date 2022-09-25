import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rishtey/presentation/profile/about_me_profile.dart';

import '../../controller/InterestListController.dart';
import '../../utils/app_config.dart';

class AcceptedInterestList extends StatefulWidget {
  const AcceptedInterestList({Key? key}) : super(key: key);

  @override
  State<AcceptedInterestList> createState() => _AcceptedInterestListState();
}

class _AcceptedInterestListState extends State<AcceptedInterestList> {
  InterestListController? interestListController;
  @override
  void initState() {
    interestListController =
        Provider.of<InterestListController>(context, listen: false);

    interestListController?.acceptedInvitationList(context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<InterestListController>(
          builder: (context, controler, child) {
        return controler.isLoading
            ? const Center(child: CircularProgressIndicator())
            : controler.interestListModel!.user!.length == 0
                ? Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.info,
                          color: AppConfig.theme.primaryColor,
                          size: 50,
                        ),
                        const Text(
                          "No Interest Accepted",
                          style: TextStyle(
                            fontSize: 24,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: controler.interestListModel!.user!.length,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 5),
                        margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset:
                                  const Offset(0, 7), // changes position of shadow
                            ),
                          ],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.network(
                                "https://webtechworlds.com/himrishtey/photos/photo/"+controler.interestListModel!.user![index].photo.toString().replaceAll("file:///",""),
                                fit: BoxFit.fill,
                                height:
                                     MediaQuery.of(context).size.height * 0.16,
                                width:
                                     MediaQuery.of(context).size.height * 0.12,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  controler.interestListModel!.user![index].profileId??"",
                                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
                                ),
                                Text(
                                  "${controler.interestListModel!.user![index].fullName}",
                                  style: const TextStyle(
                                    fontSize: 14,
                                   // fontWeight: FontWeight.w800
                                  ),
                                ),
                                Text(
                                  "${calculateAge(DateTime.parse(controler.interestListModel!.user![index].birthDateTime.toString().substring(0, 10)))} Years",
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  "${controler.interestListModel!.user![index].height}",
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                                SizedBox(
                                  width: AppConfig.width * 0.43,
                                  child: Text(
                                    "${controler.interestListModel!.user![index].religion}: ${controler.interestListModel!.user![index].cast}",
                                    maxLines: 1,
                                    style: const TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: AppConfig.width * 0.43,
                                  child: Text(
                                    "${controler.interestListModel!.user![index].motherTongue}",
                                    maxLines: 2,
                                    style: const TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                Text(
                                  controler
                                      .interestListModel!.user![index].education
                                      .toString(),
                                ),
                                // Text(
                                //  "Send Message"
                                // ),
                              ],
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                          ],
                        ),
                      );
                    });
      }),
    );
  }
}
