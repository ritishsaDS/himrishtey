
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rishtey/controller/auth_controller.dart';
import 'package:rishtey/utils/app_config.dart';

import '../controller/get_profile_controller.dart';
import 'firebase/cjat.dart';
import 'firebase/firebase_chats.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {

  DatabaseMethods databaseMethods = new DatabaseMethods();
  TextEditingController searchEditingController = new TextEditingController();
  QuerySnapshot ?searchResultSnapshot;
  GetProfileController? getProfileController;
  bool isLoading = false;
  bool haveUserSearched = false;

  initiateSearch() async {
    if(searchEditingController.text.isNotEmpty){
      setState(() {
        isLoading = true;
      });
      await databaseMethods.getUserInfo(searchEditingController.text)
          .then((snapshot){
        print("$snapshot");
        searchResultSnapshot = snapshot;

        setState(() {
          isLoading = false;
          haveUserSearched = true;
        });
        print("${searchResultSnapshot!.docs.length}");
      });
    }
  }

  Widget userList(){
    return haveUserSearched ? ListView.builder(
        shrinkWrap: true,
        itemCount: searchResultSnapshot!.docs.length,
        itemBuilder: (context, index){
          return userTile(
            searchResultSnapshot!.docs[index]["userName"],
            searchResultSnapshot!.docs[index]["userEmail"],
          );
        }) : Container();
  }

  /// 1.create a chatroom, send user to the chatroom, other userdetails
  sendMessage(String userName){
    List<String> users = ["Dhdhj",userName];

    String chatRoomId = getChatRoomId("Dhdhj",userName);

    Map<String, dynamic> chatRoom = {
      "users": users,
      "chatRoomId" : chatRoomId,
    };

    databaseMethods.addChatRoom(chatRoom, chatRoomId);

    Navigator.push(context, MaterialPageRoute(
        builder: (context) => Chat(
          chatRoomId: chatRoomId,
        )
    ));

  }

  Widget userTile(String userName,String userEmail){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                userName,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16
                ),
              ),
              Text(
                userEmail,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16
                ),
              )
            ],
          ),
          Spacer(),
          GestureDetector(
            onTap: (){
           sendMessage(userEmail);
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12,vertical: 8),
              decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(24)
              ),
              child: Text("Message",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16
                ),),
            ),
          )
        ],
      ),
    );
  }


  getChatRoomId(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }

  @override
  void initState() {
    super.initState();


     getProfileController=Provider.of<GetProfileController>(context,listen:false);

  print(getProfileController?.getProfileModel?.data?.user?.fullName);
    getUserInfogetChats();

  }
  Stream<QuerySnapshot> ?chatRooms;

  Widget chatRoomsList() {
    return StreamBuilder<QuerySnapshot>(
      stream: chatRooms,
      builder: (context, snapshot) {
        print(snapshot.data?.docs.length);
        return snapshot.hasData
            ? ListView.builder(
            itemCount: snapshot.data!.docs.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {

              return snapshot.data?.docs.length==0?Container(
                  child: Center(child: Text("No Conversations yet!!!"),)): ChatRoomsTile(
                  userName: snapshot.data!.docs[index].get('chatRoomId')
                      .toString()
                      .replaceAll("_", "")
                      .replaceAll(userName, ""),
                  chatRoomId: snapshot.data!.docs[index].get("chatRoomId"),
                  data: snapshot.data!.docs[index].data().toString()
              );
            })
            :snapshot.data?.docs.length==0?Container(
            child: Center(child: Text("No Conversations yet!!!"),)): Container(
          child: Center(child: Text("No Conversations yet!!!"),),
        );
      },
    );
  }


var userName;
  getUserInfogetChats() async {

    DatabaseMethods().getUserChats(getProfileController?.getProfileModel?.data?.user?.email??"").then((snapshots)async {
      setState(()  {
        userName=getProfileController?.getProfileModel?.data?.user?.fullName;
        chatRooms = snapshots;
        print("chatRooms!.length$userName");

        var data = chatRooms!.length;
        print(data.asStream().length.then((value) =>print("kjbljn")));

        print(
            "we got the data + ${chatRooms!.first.toString()} this is name Dhdhj");
      });
      print("snapshots"+snapshots.length.toString());
    });
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
     appBar:  AppBar(
       automaticallyImplyLeading: false,
       title: Text("HIM RISHTEY"),

       elevation: 0.0,
       centerTitle: false,
     ),
      body: isLoading ? Container(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ) :  SafeArea(
        child: Column(
          children: [
            Center(
              child: Container(
                  padding: const EdgeInsets.all(10.0),
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance.collection('users')
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError)
                        return new Text('Error: ${snapshot.error}');
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                          return new Text('Loading...');
                        default:
                          return Container(
                            height: AppConfig.height-180,
                            child: ListView.builder(itemBuilder: (context,index){
                              return   Container(
                                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          height: 60,
                                          width: 60,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              image: DecorationImage(image: NetworkImage("https://raw.githubusercontent.com/ritishsaDS/apniStationary/main/assets/icons/avatar.jpeg"))
                                          ),

                                        ),
                                        SizedBox(
                                          width: 12,
                                        ),
                                        Text(snapshot.data!.docs[index]['userName']??"",
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                                color: Colors.black
                                                ,
                                                fontSize: 16,

                                                fontWeight: FontWeight.w900)),
                                        Expanded(child: SizedBox(),),
                                        GestureDetector(
                                          onTap: ()async{
                                          var id=await  getChatRoomId(snapshot.data!.docs[index]['userEmail'],getProfileController?.getProfileModel?.data?.user?.email??"");
                                            Navigator.push(context, MaterialPageRoute(
                                                builder: (context) => Chat(
                                                  chatRoomId: id,
                                                  name:snapshot.data!.docs[index]['userName']
                                                )
                                            ));
                                            //sendMessage(userName);
                                          },
                                          child: Container(
                                            padding: EdgeInsets.symmetric(horizontal: 12,vertical: 8),
                                            decoration: BoxDecoration(
                                                color: Colors.blue,
                                                borderRadius: BorderRadius.circular(24)
                                            ),
                                            child: Text("Message",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16
                                              ),),
                                          ),
                                        )
                                      ],
                                    ),
                                    Divider(thickness: 1,)
                                  ],
                                ),
                              );
                            },itemCount: snapshot.data!.docs.length,),
                          );
                      }
                    },
                  )),
            ),
      //       Container(
      //         height: MediaQuery.of(context).size.height,
      //         child:
      //
      //           chatRoomsList()
      //
      // ),
          ],
        )),
    );
  }
}class ChatRoomsTile extends StatelessWidget {
  final String ?userName;
  final String ?chatRoomId;
  final dynamic data;

  ChatRoomsTile({this.userName,this.data,@required this.chatRoomId});

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: (){
        // Navigator.push(context, MaterialPageRoute(
        //     builder: (context) => Chat(
        //         chatRoomId: chatRoomId,
        //         data:data
        //     )
        // ));
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(image: NetworkImage("https://raw.githubusercontent.com/ritishsaDS/apniStationary/main/assets/icons/avatar.jpeg"))
                  ),

                ),
                SizedBox(
                  width: 12,
                ),
                Text(userName??"",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        color: Colors.black
                        ,
                        fontSize: 16,

                        fontWeight: FontWeight.w900)),
                Expanded(child: SizedBox(),),
                GestureDetector(
                  onTap: (){
                    print(userName);
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) => Chat(
                          chatRoomId: chatRoomId,
                        )
                    ));
                    //sendMessage(userName);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12,vertical: 8),
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(24)
                    ),
                    child: Text("Message",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16
                      ),),
                  ),
                )
              ],
            ),
            Divider(thickness: 1,)
          ],
        ),
      ),
    );
  }
}