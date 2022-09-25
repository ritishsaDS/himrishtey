import 'package:flutter/material.dart';

class ModelBottomSheet extends StatefulWidget {
  const ModelBottomSheet({Key? key}) : super(key: key);

  @override
  State<ModelBottomSheet> createState() => _ModelBottomSheetState();
}

class _ModelBottomSheetState extends State<ModelBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Model Bottom Sheet"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: ElevatedButton(
                onPressed: () {
                  modelSheet(context);
                },
                child: const Text('Model Sheet'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
  modelSheet(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return Container(
            // height: size.height*1,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                color: Color(0xff83bf89)),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        onPressed: () {},
                        child: const Text(
                          'X',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                          ),
                        ))
                  ],
                ),
                const CircleAvatar(
                  radius: 65,
                  backgroundImage: ExactAssetImage('images/profile-image.png'),
                  //child: Image.asset('images/profile-image.png'),
                ),
                SizedBox(height: size.height * 0.02),
                Text(
                  'Upgrade Now to get full access',
                  style: TextStyle(
                      color: Colors.white, fontSize: size.height * 0.025),
                ),
                Card(
                  color: Colors.transparent,
                  shadowColor: Colors.white,
                  elevation: 12,
                  child: Container(
                    height: size.height * 0.25,
                    width: size.width * 0.85,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                        ),
                        color: Colors.white),
                    child: ListView(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children:  [
                            SizedBox(width: size.width*0.03,
                                height: size.height*0.02),
                            const Icon(
                              Icons.call,
                              color: Colors.blue,
                            ),
                            SizedBox(width: size.width*0.03),
                            Text(
                              '+91-78********',
                              style: TextStyle(color: Colors.grey,
                                  fontSize: size.height*0.019),
                            ),
                            SizedBox(width: size.width*0.264),
                            Icon(
                              Icons.lock,
                              color: Colors.grey,
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children:  [
                            SizedBox(width: size.width*0.03,
                                height: size.height*0.06),
                            const Icon(
                              Icons.video_call,
                              color: Colors.blue,
                            ),
                            SizedBox(width: size.width*0.03),
                            Text(
                              'Video call with Shaadi Meet',
                              style: TextStyle(color: Colors.grey,
                                  fontSize: size.height*0.018
                              ),
                            ),
                            SizedBox(width: size.width*0.06),
                            Icon(
                              Icons.lock,
                              color: Colors.grey,
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children:  [
                            SizedBox(width: size.width*0.03,
                                height: size.height*0.06),
                            const Icon(
                              Icons.whatsapp,
                              color: Colors.green,
                            ),
                            SizedBox(width: size.width*0.03),
                            Text(
                              'Chat by WhatsApp',
                              style: TextStyle(color: Colors.grey,
                                  fontSize: size.height*0.018
                              ),
                            ),
                            SizedBox(width: size.width*0.2),
                            Icon(
                              Icons.lock,
                              color: Colors.grey,
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children:  [
                            SizedBox(width: size.width*0.02,
                                height: size.height*0.06),
                            const Icon(
                              Icons.message_outlined,
                              color: Colors.blue,
                            ),
                            SizedBox(width: size.width*0.03),
                            Text(
                              'Message via Shaadi Meet',
                              style: TextStyle(color: Colors.grey,
                                  fontSize: size.height*0.018
                              ),
                            ),
                            SizedBox(width: size.width*0.06),
                            Icon(
                              Icons.lock,
                              color: Colors.grey,
                            )
                          ],
                        ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        //   children:  [
                        //     SizedBox(width: size.width*0.03,
                        //         height: size.height*0.04),
                        //     const Icon(
                        //       Icons.mail,
                        //       color: Colors.blue,
                        //     ),
                        //     SizedBox(width: size.width*0.03),
                        //     Text(
                        //       '**********@gmail.com',
                        //       style: TextStyle(color: Colors.grey,
                        //           fontSize: size.height*0.018
                        //       ),
                        //     ),
                        //     SizedBox(width: size.width*0.06),
                        //     Icon(
                        //       Icons.lock,
                        //       color: Colors.grey,
                        //     )
                        //   ],
                        // )

                      ],
                    ),
                  ),
                ),
                Text(
                  "Center",
                  style: TextStyle(fontSize: 18),
                )
              ],
            ),
          );
        });
  }
