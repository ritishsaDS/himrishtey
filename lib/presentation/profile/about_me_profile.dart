import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rishtey/presentation/edit_screens/basic_detail.dart';
import 'package:rishtey/presentation/edit_screens/contact_details.dart';
import 'package:rishtey/presentation/edit_screens/educstion_detail_third.dart';
import 'package:rishtey/presentation/edit_screens/kundli_astro.dart';
import 'package:rishtey/presentation/edit_screens/lifestyleDetails.dart';
import 'package:rishtey/presentation/edit_screens/relation_detail_fourth.dart';
import 'package:rishtey/presentation/profile/personal_profile.dart';
import 'package:rishtey/presentation/profile/widgets/info_tile.dart';

import '../../models/get_profile_model.dart';
import '../edit_screens/educationaldetails.dart';
import '../edit_screens/familyDetails.dart';

class AboutMe extends StatelessWidget {
  User? userModel;
  AboutMe({Key? key, required this.userModel}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.black)),
            child: ExpansionTile(
              trailing: SizedBox(
                width: 0,
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Basic Info"),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BasicDetails()));
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(color: Colors.grey)),
                      child: Text(
                        "Edit",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w800),
                      ),
                    ),
                  )
                ],
              ),
              children: [
                Container(
                  child: Column(
                    children: [
                      infoTile(
                          name: "Profile Created By: ",
                          data: userModel!.profileCreatedFor!),
                      infoTile(name: "Gender: ", data: userModel!.gender!),
                      infoTile(
                          name: "Marital Status: ",
                          data: userModel!.maritalStatus!),
                      infoTile(
                          name: "Height: ", data: userModel!.height.toString()),
                      infoTile(
                          name: "Health Information: ",
                          data: userModel!.healthInfo!),
                      infoTile(
                          name: "Any Disability: ",
                          data: userModel?.anyDisability??"No"),
                      infoTile(
                          name: "Blood Group: ", data: userModel!.bloodGroup!),
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.black)),
            child: ExpansionTile(
              trailing: SizedBox(),
              title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Kundli & Astro"),
                    GestureDetector(
                      onTap: () {
                        Map<String, dynamic> data = {
                          "birth_date_time": userModel!.birthDateTime,
                          "birth_place": userModel!.birthPlace,
                          "horoscope_needed": "${userModel!.horoscopeNeeded}",
                          "manglik": userModel!.manglik,
                          "birth_date_time": userModel!.birthDateTime
                        };
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EditDetails(
                                      data: data,
                                      title: "Kundli & Astro",
                                    )));
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            border: Border.all(color: Colors.grey)),
                        child: const Text(
                          "Edit",
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.w800),
                        ),
                      ),
                    )
                  ]),
              children: [
                Container(
                  child: Column(
                    children: [
                      infoTile(
                        name: "Date Of Birth: ",
                        data: userModel!.birthDateTime!.split(" ")[0],
                      ),
                      infoTile(
                        name: "Time Of Birth: ",
                        data: userModel!.birthDateTime!.split(" ")[1]+userModel!.birthDateTime!.toString().split(" ")[2],
                      ),
                      infoTile(
                        name: "Place Of Birth: ",
                        data: userModel!.birthPlace.toString(),
                      ),
                      infoTile(
                        name: "Horoscope Match is Must: ",
                        data: "${userModel!.horoscopeNeeded}",
                      ),
                      infoTile(name: "Manglik: ", data: userModel!.manglik!),
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.black)),
            child: ExpansionTile(
              trailing: SizedBox(),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Contact Details & Ads"),
                  GestureDetector(
                    onTap: (){

                        Map<String,dynamic> data={
                          "mobile_number":userModel!.mobileNumber.toString(),
                          "alternate_number":"${userModel!.alternateNumber.toString()}",
                          "email": userModel!.email.toString(),
                          "whatsapp_number":userModel!.whatsappNumber.toString()};
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>ContactDetails(data:data ,title: "Contact Details",)));


                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(color: Colors.grey)),
                      child: Text(
                        "Edit",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w800),
                      ),
                    ),
                  )
                ],
              ),
              children: [
                Container(
                  child: Column(
                    children: [
                      infoTile(
                          name: "Mobile Number: ",
                          data: userModel!.mobileNumber.toString()),
                      infoTile(
                          name: "Alternate Mobile Number: ",
                          data: userModel!.alternateNumber!),
                      infoTile(name: "Email ID: ", data: userModel!.email!),
                      infoTile(
                          name: "Whatsapp Number: ",
                          data: userModel!.whatsappNumber!),
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.black)),
            child: ExpansionTile(
              trailing: SizedBox(),
              title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Religion & Background"),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RelationDetailsForth()));
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            border: Border.all(color: Colors.grey)),
                        child: Text(
                          "Edit",
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.w800),
                        ),
                      ),
                    )
                  ]),
              children: [
                Container(
                  child: Column(
                    children: [
                      infoTile(name: "Religion: ", data: userModel!.religion!),
                      infoTile(name: "Native Place ", data: userModel!.nativePlace!),
                      infoTile(
                          name: "Mother Tongue: ",
                          data: userModel!.motherTongue!),
                      infoTile(name: "Community: ", data: userModel!.cast!),
                      infoTile(
                          name: "Sub Community: ", data: userModel!.subCast!),
                      infoTile(name: "Gotra : ", data: userModel!.gotra!),
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.black)),
            child: ExpansionTile(
              trailing: SizedBox(),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Education Details"),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                          builder: (context) => EducationDetails()));
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(color: Colors.grey)),
                      child: Text(
                        "Edit",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w800),
                      ),
                    ),
                  )
                ],
              ),
              children: [
                Container(
                  child: Column(
                    children: [
                      infoTile(
                          name: "About My Education: ",
                          data: userModel!.aboutMyEducation!),
                      infoTile(
                          name: "Highest Education: ",
                          data: userModel!.education!),
                      infoTile(
                          name: "Any Other Qualification: ",
                          data: userModel!.anyOtherQualifications!),
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.black)),
            child: ExpansionTile(
              trailing: SizedBox(),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Career"),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EducationDetailsThird()));
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(color: Colors.grey)),
                      child: Text(
                        "Edit",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w800),
                      ),
                    ),
                  )
                ],
              ),
              children: [
                Container(
                  child: Column(
                    children: [
                      infoTile(
                          name: "About My Career: ",
                          data: userModel!.aboutMyCareer!),
                      infoTile(
                          name: "Employed In: ", data: userModel!.employedIn!),
                      infoTile(
                          name: "Occupation: ", data: userModel!.occupation!),
                      infoTile(
                          name: "Organization Name: ",
                          data: userModel!.organizationName!),
                      infoTile(
                          name: "Job Location : ",
                          data: userModel!.jobLocation!),
                      infoTile(
                          name: "Annual Income: ",
                          data: userModel!.annualIncome!),
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.black)),
            child: ExpansionTile(
              trailing: SizedBox(),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Family Details"),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>FamilyDetails()));
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(color: Colors.grey)),
                      child: Text(
                        "Edit",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w800),
                      ),
                    ),
                  )
                ],
              ),
              children: [
                Container(
                  child: Column(
                    children: [
                      infoTile(
                          name: "About My Family: ",
                          data: userModel!.aboutFamily!),
                      infoTile(
                          name: "Father Name: ", data: userModel!.fatherName!),
                      infoTile(
                          name: "Father Occupation: ",
                          data: userModel!.fatherOccupation!),
                      infoTile(
                          name: "Mother Name: ", data: userModel!.motherName!),
                      infoTile(
                          name: "Mother Occupation: ",
                          data: userModel!.motherOccupation!),
                      infoTile(
                          name: "Number Of Brother (s): ",
                          data: userModel!.noOfBrothers!),
                      infoTile(
                          name: "Married Brother (s): ",
                          data: userModel!.marriedBrothers!),
                      infoTile(
                          name: "Number Of Sister (s): ",
                          data: userModel!.noOfSisters!),
                      infoTile(
                          name: "Married Sister (s): ",
                          data: userModel!.marriedSisters!),
                      infoTile(
                          name: "Family Income: ",
                          data: userModel!.familyIncome!),
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.black)),
            child: ExpansionTile(
              trailing: SizedBox(),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("LifeStyle"),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LifestyleDetails()));
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(color: Colors.grey)),
                      child: Text(
                        "Edit",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w800),
                      ),
                    ),
                  )
                ],
              ),
              children: [
                Container(
                  child: Column(
                    children: [
                      infoTile(name: "Diet: ", data: userModel!.diet!),
                      infoTile(
                          name: "Is Drinking: ", data: userModel!.isDrinking!),
                      infoTile(
                          name: "Is Smoking: ", data: userModel!.isSmoking!),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

}
calculateAge(DateTime birthDate) {
  DateTime currentDate = DateTime.now();
  int age = currentDate.year - birthDate.year;
  int month1 = currentDate.month;
  int month2 = birthDate.month;
  if (month2 > month1) {
    age--;
  } else if (month1 == month2) {
    int day1 = currentDate.day;
    int day2 = birthDate.day;
    if (day2 > day1) {
      age--;
    }
  }
  return age;
}