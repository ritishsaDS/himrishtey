
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:ui';

import 'package:crop_image/crop_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:rishtey/controller/ImagePickerController.dart';
import 'package:rishtey/presentation/profile/onboarding_flow.dart';


class CropImages extends StatefulWidget {
  final File title;

  const CropImages({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<CropImages> {
  XFile? _pickedFile;
  CroppedFile? _croppedFile;
  final controller = CropController(
    aspectRatio: 1,

    defaultCrop: const Rect.fromLTRB(0.1, 0.1, 0.9, 0.9),
  );
  ImagePickerController?imagePickerController;
  @override
  void initState() {
    Future.delayed(Duration(milliseconds: 100),(){
      imagePickerController=Provider.of<ImagePickerController>(context,listen: false);
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(title: Text("Profile Picture",),actions: [
        TextButton(
          onPressed: _finished,
          child: const Text('Set as profile picture',style: TextStyle(color: Colors.white),),
        ),
      ],),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Expanded(child: _body()),
        ],
      ),
    );
  }

  Widget _body() {
    return _imageCard();

  }

  Widget _imageCard() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding:
            const EdgeInsets.symmetric(horizontal: kIsWeb ? 24.0 : 16.0),
            child: Card(
              elevation: 4.0,
              child: Padding(
                padding: const EdgeInsets.all(kIsWeb ? 24.0 : 16.0),
                child: _image(),
              ),
            ),
          ),


        ],
      ),
    );
  }

  Widget _image() {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return  CropImage(
      alwaysShowThirdLines: true,
      controller: controller,
      image: Image.file(widget.title),
    )
    ;

  }


  Future<void> _finished() async {
    var image = await controller.croppedImage();
    var bitmap = await controller.croppedBitmap();
    var  data = await bitmap.toByteData(format: ImageByteFormat.png);
    var bytes = data!.buffer.asUint8List();
    String base64Image =  base64Encode(bytes);
    // log(bytes.toString());
    log(base64Image);
   bool?res=await imagePickerController?.setProfilePic(context,base64Image);
   if(res==true){
     Navigator.push(context, MaterialPageRoute(builder: (context)=>OnboardingFlow()));
   }
    //print(image.);
    //final bytes = images!.readAsBytesSync();
    //  String base64Image =  base64Encode(bytes);
    // // final bytes = image.buffer.asUint8List();
    // Uint8List bytes = Uint8List.fromList([int.parse(image.toString())]);

    // Uint8List bytes = Uint8List.fromList(controller.toString().codeUnits);
    // print(bytes);
    //  Uint8List imagebytes = await  //convert to bytes
    //  String base64string = base64.encode(imagebytes);
    //  String base64Image =  base64Encode(bytes);

// print(controller.croppedImage().then((value) {
//   print(value.toString().codeUnits);
// }));
//     await showDialog<bool>(
//       context: context,
//       builder: (context) {
//         return SimpleDialog(
//           contentPadding: const EdgeInsets.all(6.0),
//           titlePadding: const EdgeInsets.all(8.0),
//           title: const Text('Cropped image'),
//           children: [
//             Text('relative: ${controller.value.crop}'),
//             Text('pixels: ${controller.cropSize}'),
//             const SizedBox(height: 5),
//             image,
//             TextButton(
//               onPressed: () => Navigator.pop(context, true),
//               child: const Text('OK'),
//             ),
//           ],
//         );
//       },
//     );
  }


  Future<void> _uploadImage() async {
    final pickedFile =
    await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _pickedFile = pickedFile;
      });
    }
  }

  void _clear() {
    setState(() {
      _pickedFile = null;
      _croppedFile = null;
    });
  }
}