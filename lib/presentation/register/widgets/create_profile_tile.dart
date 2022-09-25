import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rishtey/controller/auth_controller.dart';
import 'package:rishtey/presentation/register/sign_up.dart';

class CreateProfileTile extends StatelessWidget{
  final String name;
  final int index;
  final String image;
  const CreateProfileTile({Key? key, required this.name,required this.index,required this.image}) : super(key: key);
  @override
  Widget build(BuildContext context) {
  return Consumer<AuthController>(
    builder: (context,controller,child){
      return GestureDetector(
        onTap: (){
controller.selectValue(index);
Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUp()));
print(controller.createProfileForModel?.user?[controller.selectIndex].title);
        },
        child: Container(

          padding: EdgeInsets.all(1),
          child: Material(
            color: controller.select&&controller.selectIndex==index?Colors.redAccent:Colors.white,
            elevation: 5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(image,scale: 3,),
                SizedBox(height: 10,),
                Text(name,style: TextStyle(color:controller.select&&controller.selectIndex==index?Colors.white:Colors.black,fontWeight: FontWeight.w600),)
              ],),
          ),
        ),
      );
    }
  );
  }
}