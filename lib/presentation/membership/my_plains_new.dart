import 'package:flutter/material.dart';
import 'package:rishtey/utils/app_config.dart';

class HomePages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    AppConfig.init(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [

                  ClipPath(
                    clipper: DrawClip(),
                    child: Container(
                      width: size.width,
                      height: size.height * 0.15,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [Color(0xffddc3fc), Color(0xff91c5fc)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight),
                      ),
                    ),
                  ),
                  ClipPath(
                    clipper: DrawClip2(),
                    child: Container(
                      width: size.width,
                      height: size.height * 0.18,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [Color(0xffa58fd2), Color(0xffddc3fc)],
                            begin: Alignment.bottomCenter,
                            end: Alignment.bottomRight),
                      ),
                    ),
                  ),


Container(

    margin:EdgeInsets.only(top: 20),child: Center(child: Text("Memberships",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w600),))),
                  Container(
                    margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.12),
                    decoration: BoxDecoration(color: Colors.grey.shade100,borderRadius: BorderRadius.only(bottomRight: Radius.circular(150),bottomLeft: Radius.circular(150))),
                    height: 200,



                  ),
                  Container(
                    margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.15),
alignment: Alignment.center,
                    //padding:const EdgeInsets.all(10),
                    height: size.height*0.08,
                    width: size.width*0.6,

                    decoration:  BoxDecoration(
                      border: Border.all(color:const Color(0xff459d9f)),
                      color: AppConfig.theme.primaryColor,
                      borderRadius:const  BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10)),
                    ),
                    child:  Center(
                      child: Text(
                        "Normal memberships",
                        style: TextStyle(color:  Colors.white,
                            fontSize: size.height*0.02,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
}

Widget input(String hint, bool pass) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
    child: Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30), color: Colors.white),
      child: TextFormField(
        decoration: InputDecoration(
            hintText: hint,
            contentPadding: EdgeInsets.only(top: 15, bottom: 15),
            prefix: pass
                ? Icon(Icons.lock_outline, color: Colors.grey)
                : Icon(Icons.person_outline, color: Colors.grey),
            suffixIcon: pass
                ? null
                : Icon(Icons.assignment_turned_in_rounded,
                color: Colors.greenAccent),
            border: UnderlineInputBorder(borderSide: BorderSide.none)),
      ),
    ),
  );
}

class DrawClip extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height * 0.80);
    path.cubicTo(size.width / 4, size.height, 3 * size.width / 4,
        size.height / 2, size.width, size.height * 0.8);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

class DrawClip2 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height * 0.08);
    path.cubicTo(size.width / 4, size.height, 3 * size.width / 4,
        size.height / 2, size.width, size.height * 0.9);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}