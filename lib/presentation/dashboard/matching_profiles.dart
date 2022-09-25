import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rishtey/presentation/dashboard/widget/interest_profile.dart';

import '../../controller/dashboard_controller.dart';

class MatchingProfile extends StatelessWidget{
  const MatchingProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(

        appBar: AppBar(title: Text("Matching Profile"),), body:   Consumer<DashBoardController>(
        builder: (context, controller, child) {
          return controller.isLoading
              ? const Center(
            child: CircularProgressIndicator(),
          )
              : Opacity(
            opacity: controller.showLotie?0.4:1,
            child:Column(children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Matching Profiles ",
                      style:
                      textTheme.headline6!.copyWith(fontSize: 16),
                    ),


                  ],
                ),
              ),
              Text(
                "Matches Suggested Just For You",
                style: textTheme.bodyText1!.copyWith(
                    fontSize: 14, fontWeight: FontWeight.w800),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.8,
                child: controller.matchingProfilesModel==null||controller.matchingProfilesModel?.user!.length==0?
                Center(child: Text("No Data Found"),)
                    :ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: (controller.matchingProfilesModel?.user??[]).length,
                    itemBuilder: (BuildContext context, int index) {
                      return InterestProfile(
                          data:controller.matchingProfilesModel!.user!
                              .elementAt(index));
                    }),
              ),
            ],),);}));
  }
}