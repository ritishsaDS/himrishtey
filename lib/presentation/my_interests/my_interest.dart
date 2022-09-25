import 'package:flutter/material.dart';
import 'package:rishtey/presentation/my_interests/PendingInterest.dart';
import 'package:rishtey/presentation/my_interests/rejected_by_me.dart';
import 'package:rishtey/utils/app_config.dart';

import '../../utils/theme_clas.dart';
import 'AcceptedInterest.dart';
import 'RecievedInterest.dart';
import 'RejectedInterest.dart';
import 'SentInterestList.dart';

class MyInterest extends StatefulWidget {
  @override
  State<MyInterest> createState() => _MyInterestState();
}

class _MyInterestState extends State<MyInterest> {
  @override
  void initState() {
    print("Ritis");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: lightTheme,

      home: DefaultTabController(
        length: 6,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: AppConfig.theme.primaryColor,
            title: const Text('My Interest'),
            bottom:  TabBar(
              isScrollable: true,
              padding: EdgeInsets.symmetric(horizontal: 5),
              labelStyle: TextStyle(color: Colors.white),
              labelColor: Colors.white,
              indicatorColor: Colors.white,
              tabs: [
                Tab(text: "Recieved Interest"),
                Tab(icon: Column(children: const[
                  Text("Accepted Interest",style: TextStyle(fontSize: 16),),
                  Text("(Accepted by me)",style: TextStyle(fontSize: 12),)
                ],)),
                Tab(icon: Column(children: const[
                  Text("Rejected Interest",style: TextStyle(fontSize: 16),),
                  Text("(Rejected by me)",style: TextStyle(fontSize: 12),)
                ],)),
                Tab(icon: Column(children: const[
                  Text("Pending Interest",style: TextStyle(fontSize: 16),),
                  Text("(Sent by me)",style: TextStyle(fontSize: 12),)
                ],)),
                Tab(icon: Column(children: const[
                  Text("Accepted Interest",style: TextStyle(fontSize: 16),),
                  Text("(Sent by me)",style: TextStyle(fontSize: 12),)
                ],)),
                Tab(icon: Column(children: const[
                  Text("Rejected Interest",style: TextStyle(fontSize: 16),),
                  Text("(Sent by me)",style: TextStyle(fontSize: 12),)
                ],)),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              Container(
                height: AppConfig.height,
                child: ReceivedInterestList(),
              ),
              Container(
                height: AppConfig.height,
                child: AcceptedInterestList(),
              ),
              Container(
                height: AppConfig.height,
                child: RejectedInterestList(),
              ),
              Container(
                height: AppConfig.height,
                child: SentInterestList(),
              ),
              Container(
                height: AppConfig.height,
                child: PendingInterestList(),
              ),
              Container(
                height: AppConfig.height,
                child: RejectedMeInterestList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
