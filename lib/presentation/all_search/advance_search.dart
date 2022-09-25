import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:rishtey/presentation/end_drawer_class.dart';
import 'package:rishtey/utils/app_config.dart';

import '../../controller/auth_controller.dart';
import '../../controller/get_profile_controller.dart';
import '../../controller/search_controller.dart';
import '../../models/advance_search_post_model.dart';

import '../../utils/app_button.dart';

class AdvanceSearch extends StatefulWidget {
  const AdvanceSearch({Key? key}) : super(key: key);

  @override
  State<AdvanceSearch> createState() => _AdvanceSearchState();
}

class _AdvanceSearchState extends State<AdvanceSearch> {
  AuthController? authController;
  SearchController? searchController;
  String? selectedValue;
  String? selectedState;
  String? selectedHeight;
  String? selectedCaste;
  String? selectedEducation;
  String? selectedEmployedIn;
  String? selectedHeightFrom;
  String? selectedMotherTongue;
  String? selectedAnnual;
  String? selectedAnnual2;
  String? selectedMaritalStatus;
  RangeValues values = const RangeValues(18, 70);
  RangeLabels labels =const RangeLabels('18', "70");
dynamic data=[];
dynamic apikey;
GetProfileController?getProfileController;
  @override
  void initState() {

    Future.delayed(const Duration(milliseconds: 100), () {
      authController = Provider.of<AuthController>(context, listen: false);
      searchController = Provider.of<SearchController>(context, listen: false);
      getProfileController = Provider.of<GetProfileController>(context, listen: false);
      selectedValue = "";
      selectedCaste = "";
      selectedState = "";
      selectedHeight = "";
      selectedEducation = "";
      selectedEmployedIn = "";
      selectedHeightFrom = "";
      selectedAnnual = "1 Lakh";
      selectedAnnual2 = "1 Lakh";
      selectedMotherTongue = "";
      selectedMaritalStatus = "";
      setState(() {});
      authController!.getHeights(context);
      authController!.getStates(context);
      // authController!.getCities(context);
      authController!.getMotherTongue(context);
      authController!.getCastes(context);
      authController!.getEducationType(context);
      authController!.getEmployeType(context);
      authController!.getAnnualIncomeType(context);
      authController!.getMaritalStatus(context);
      searchController!.clearData();
      

    });
    super.initState();
  }
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  final _multiSelectKey = GlobalKey<FormFieldState>();
  AdvanceSearchPostModel? advanceSearchPostModel = AdvanceSearchPostModel();

  var selectionType="single";
  TextEditingController profileId=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,

      endDrawer: SizedBox(
          width: AppConfig.width*0.7,
          child: EndDrawer(data:data,apiKey: apikey,selectionType:selectionType)),
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppConfig.theme.primaryColor),
        title: const Text("Advance Search"),
      ),
      body: Consumer<SearchController>(
          builder: (context, searchcontroller, child) {
          return Consumer<AuthController>(builder: (context, controller, child) {
            return controller.isLoading
                ? Center(child: const CircularProgressIndicator())
                : Container(
                    margin: const EdgeInsets.all(15),
                    child: SingleChildScrollView(
                      child: Consumer<SearchController>(builder: (context, controller, child) {
                        return controller.isLoading
                            ? const CircularProgressIndicator()
                            : Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Profile Id",
                                style: TextStyle(
                                    fontWeight: FontWeight.w800, fontSize: 18),
                              ),
                              Container(
                                  width: AppConfig.width*0.9,
                                  alignment: Alignment.centerLeft,
                                  height: AppConfig.height*0.07,
                                 // padding: const EdgeInsets.all(10),
                                  margin: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      border: Border.all(color: Colors.black)),
                                  child: TextFormField(
                                    controller: profileId,
                                    decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(vertical: 0,horizontal: 5),
                                        border: InputBorder.none,
                                        hintText: "Enter Profile id for search"),
                                  )),
                              Text.rich(
                                TextSpan(
                                  children: [
                                  const  TextSpan(text: 'Age - '),
                                    TextSpan(
                                      text: '${labels.toString().replaceAll("RangeLabels","")}',
                                      style: TextStyle(fontWeight: FontWeight.bold,color: AppConfig.theme.primaryColor),
                                    ),

                                  ],
                                ),
                              ),
                              RangeSlider(
                                  divisions: 52,
                                  activeColor: Colors.red[700],
                                  inactiveColor: Colors.red[300],
                                  min: 18,
                                  max: 70,
                                  values: values,
                                  labels: labels,
                                  onChanged: (value){

                                    setState(() {
                                      values =value;
                                      labels =RangeLabels("Age-${value.start.toInt().toString()}", "Age-${value.end.toInt().toString()}");
                                    });
                                  }
                              ),
                             Row(children: [
                               Column(children: [
                                 const Text(
                                   "Height From",
                                   style: TextStyle(
                                       fontWeight: FontWeight.w800, fontSize: 18),
                                 ),
                                 Consumer<AuthController>(
                                     builder: (context, controller, child) {
                                       return controller.isLoading
                                           ? const CircularProgressIndicator()
                                           : GestureDetector(
                                           onTap: (){

                                             var v = controller.heightModel!.heights!
                                                 .map((item) {
                                               return item.height;
                                             }).toList();

                                             data=v;
                                             apikey="height_from";
                                             selectionType="single";
                                             setState(() {

                                             });

                                             _scaffoldKey.currentState!.openEndDrawer();
                                           }, child:Container(
                                         width: AppConfig.width*0.42,
                                         alignment: Alignment.centerLeft,
                                         height: AppConfig.height*0.07,
                                         padding: const EdgeInsets.all(10),
                                         margin: const EdgeInsets.all(10),
                                         decoration: BoxDecoration(
                                             borderRadius: BorderRadius.circular(10.0),
                                             border: Border.all(color: Colors.black)),
                                         child: Row(
                                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                           children: [
                                             Text(searchcontroller.advanceData['height_from']??selectedHeightFrom!,style: const TextStyle(color: Colors.black,fontSize: 14),),
                                             const Icon(Icons.arrow_drop_down_circle_outlined)
                                           ],
                                         ),));
                                     }),
                               ],),
                               Column(children: [
                                 const Text(
                                   "Height To",
                                   style: TextStyle(
                                       fontWeight: FontWeight.w800, fontSize: 18),
                                 ),
                                 Consumer<SearchController>(
                                     builder: (context, searchcontroller, child) {
                                     return Consumer<AuthController>(
                                         builder: (context, controller, child) {
                                           return controller.isLoading
                                               ? const CircularProgressIndicator()
                                               : GestureDetector(onTap: (){

                                             var v = controller.heightModel!.heights!
                                                 .map((item) {
                                               return item.height;
                                             }).toList();
                                             // _showMultiSelect(
                                             //   context,
                                             //   v,
                                             // );
                                             data=v;
                                             apikey="height_to";
                                             selectionType="single";
                                             setState(() {

                                             });

                                             _scaffoldKey.currentState!.openEndDrawer();
                                           }, child:Container(
                                             width: AppConfig.width*0.4,
                                             alignment: Alignment.centerLeft,
                                             height: AppConfig.height*0.07,
                                             padding: const EdgeInsets.all(10),
                                             margin: const EdgeInsets.all(10),
                                             decoration: BoxDecoration(
                                                 borderRadius: BorderRadius.circular(10.0),
                                                 border: Border.all(color: Colors.black)),
                                             child: Row(
                                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                               children: [
                                                 Text(searchcontroller.advanceData['height_to']??selectedHeight!,style: const TextStyle(color: Colors.black,fontSize: 13),),
                                                 const Icon(Icons.arrow_drop_down_circle_outlined)
                                               ],
                                             ),));
                                         });
                                   }
                                 ),
                               ],)

                             ],),

                              const Text(
                                "State",
                                style: TextStyle(
                                    fontWeight: FontWeight.w800, fontSize: 18),
                              ),
                              Consumer<AuthController>(
                                  builder: (context, controller, child) {
                                return controller.isLoading
                                    ? const CircularProgressIndicator()
                                    : GestureDetector(onTap: (){

                                  var v = controller.statesModel!.states!
                                      .map((item) {
                                    return item.name;
                                  }).toList();
                                  // _showMultiSelect(
                                  //   context,
                                  //   v,
                                  // );
                                  data=v;
                                  apikey="state_name";
                                  selectionType="single";
                                  setState(() {

                                  });

                                  _scaffoldKey.currentState!.openEndDrawer();
                                },child:Container(
                                  width: AppConfig.width*0.9,
                                        alignment: Alignment.centerLeft,
                                        height: AppConfig.height*0.07,
                                        padding: const EdgeInsets.all(10),
                                        margin: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10.0),
                                            border: Border.all(color: Colors.black)),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(searchcontroller.advanceData["state_name"]??selectedState!,style: const TextStyle(color: Colors.black,fontSize: 18),),
                                            const Icon(Icons.arrow_drop_down_circle_outlined)
                                          ],
                                        ),));
                              }),
                              const Text(
                                "Religion",
                                style: TextStyle(
                                    fontWeight: FontWeight.w800, fontSize: 18),
                              ),
                              Consumer<SearchController>(
                                  builder: (context, searchcontroller, child) {
                                    print(searchcontroller.advanceData);
                                  return Consumer<AuthController>(
                                      builder: (context, controller, child) {
                                    return controller.isLoading
                                        ? const CircularProgressIndicator()
                                        : GestureDetector(onTap: (){

                                      var v = controller.religionModel!.religions!
                                          .map((item) {
                                        return item.religion;
                                      }).toList();
                                      data=v;
                                      apikey="religion";
                                      selectionType="multi";
                                      searchController!.emptyList();
                                     // searchController!.emptyList();
                                     // searchController!.emptyList();
                                      setState(() {

                                      });

                                     _scaffoldKey.currentState!.openEndDrawer();

                                    },child:Container(
                                        width: AppConfig.width*0.9,
                                        alignment: Alignment.centerLeft,
                                        height: AppConfig.height*0.07,
                                        padding: const EdgeInsets.all(10),
                                        margin: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10.0),
                                            border: Border.all(color: Colors.black)),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(searchcontroller.advanceData['religion']??selectedValue!,style: const TextStyle(color: Colors.black,fontSize: 18),),
                                            const Icon(Icons.arrow_drop_down_circle_outlined)
                                          ],
                                        ),));
                                  });
                                }
                              ),
                              const Text(
                                "Community",
                                style: TextStyle(
                                    fontWeight: FontWeight.w800, fontSize: 18),
                              ),
                              Consumer<AuthController>(
                                  builder: (context, controller, child) {
                                return controller.isLoading
                                    ? const CircularProgressIndicator()
                                    : GestureDetector(onTap: (){
                                  var v = controller.castesModel!.casts!
                                      .map((item) {
                                    return item.cast;
                                  }).toList();
                                  data=v;
                                  apikey="cast";
                                  selectionType="multi";
                                      searchController!.emptyList();
                                  

                                  setState(() {

                                  });

                                  _scaffoldKey.currentState!.openEndDrawer();
                                },child:Container(
                                    width: AppConfig.width*0.9,
                                    alignment: Alignment.centerLeft,
                                    height: AppConfig.height*0.07,
                                    padding: const EdgeInsets.all(10),
                                    margin: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10.0),
                                        border: Border.all(color: Colors.black)),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(searchcontroller.advanceData["cast"]??selectedCaste!,style: const TextStyle(color: Colors.black,fontSize: 18),),
                                        const Icon(Icons.arrow_drop_down_circle_outlined)
                                      ],
                                    ),));
                              }),
                              const Text(
                                "Annual Income",
                                style: TextStyle(
                                    fontWeight: FontWeight.w800, fontSize: 18),
                              ),
                              Row(
                                  children:[
                                    Consumer<AuthController>(
                                        builder: (context, controller, child) {
                                          return controller.isLoading
                                              ? const CircularProgressIndicator()
                                              :Container(
                                              width: AppConfig.width*0.43,
                                              alignment: Alignment.centerLeft,
                                              height: AppConfig.height*0.07,
                                              padding: const EdgeInsets.all(10),
                                              margin: const EdgeInsets.all(10),

                                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0),border: Border.all(color: Colors.grey)),
                                              child:DropdownButton(
                                                borderRadius: BorderRadius.circular(10.0),
                                                onChanged: ( newValue){
                                                  setState(() {
                                                    selectedAnnual = newValue.toString();
                                                    // selectedAnnual2=newValue.toString()
                                                    searchController!.advanceData["annual_income"]=selectedAnnual!;
                                                  });
                                                },
                                                value: selectedAnnual,
                                                items: controller.annualIncomeModel!.annualIncomes!.map((item) {
                                                  return  DropdownMenuItem(
                                                    child:  Text(item.annualIncome.toString()),
                                                    value: item.annualIncome.toString(),
                                                  );
                                                }).toList(),

                                                isExpanded: true, //make true to take width of parent widget
                                                underline: Container(), //empty line
                                                style: const TextStyle(fontSize: 18, color: Colors.black),
                                                dropdownColor: Colors.white,
                                                iconEnabledColor: Colors.black,
                                                hint: const Text("Select Your Religion"),//Icon color
                                              ) );
                                        }),
                                    Consumer<AuthController>(
                                        builder: (context, controller, child) {
                                          return controller.isLoading
                                              ? const CircularProgressIndicator()
                                              :Container(
                                              width: AppConfig.width*0.43,
                                              alignment: Alignment.centerLeft,
                                              height: AppConfig.height*0.07,
                                              padding: const EdgeInsets.all(10),
                                              margin: const EdgeInsets.all(10),

                                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0),border: Border.all(color: Colors.grey)),
                                              child:DropdownButton(
                                                borderRadius: BorderRadius.circular(10.0),
                                                onChanged: ( newValue){
                                                  setState(() {
                                                    selectedAnnual2 = newValue.toString();
                                                  });
                                                },
                                                value: selectedAnnual2,
                                                items: controller.annualIncomeModel!.annualIncomes!.map((item) {
                                                  return  DropdownMenuItem(
                                                    child:  Text(item.annualIncome.toString()),
                                                    value: item.annualIncome.toString(),
                                                  );
                                                }).toList(),

                                                isExpanded: true, //make true to take width of parent widget
                                                underline: Container(), //empty line
                                                style: const TextStyle(fontSize: 18, color: Colors.black),
                                                dropdownColor: Colors.white,
                                                iconEnabledColor: Colors.black,
                                                hint: const Text("Select Your Religion"),//Icon color
                                              ) );
                                        }),
                                  ]
                              ),
                              const Text(
                                "Mother Tongue",
                                style: TextStyle(
                                    fontWeight: FontWeight.w800, fontSize: 18),
                              ),
                              Consumer<AuthController>(
                                  builder: (context, controller, child) {
                                return controller.isLoading
                                    ? const CircularProgressIndicator()
                                    : GestureDetector(onTap: (){
                                  var v = controller.motherTongueModel!.motherTongues!
                                      .map((item) {
                                    return item.motherTongue;
                                  }).toList();
                                  data=v;
                                  apikey="mother_tongue";
                                  selectionType="multi";
                                      searchController!.emptyList();
                                  

                                  setState(() {

                                  });

                                  _scaffoldKey.currentState!.openEndDrawer();
                                },child:Container(
                                    width: AppConfig.width*0.9,
                                    alignment: Alignment.centerLeft,
                                    height: AppConfig.height*0.07,
                                    padding: const EdgeInsets.all(10),
                                    margin: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10.0),
                                        border: Border.all(color: Colors.black)),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(searchcontroller.advanceData["mother_tongue"]??selectedMotherTongue!,style: const TextStyle(color: Colors.black,fontSize: 18),),
                                        const Icon(Icons.arrow_drop_down_circle_outlined)
                                      ],
                                    ),));
                              }),
                              // const Text(
                              //   "Annual Income",
                              //   style: TextStyle(
                              //       fontWeight: FontWeight.w800, fontSize: 18),
                              // ),
                              // Consumer<AuthController>(
                              //     builder: (context, controller, child) {
                              //   return controller.isLoading
                              //       ? const CircularProgressIndicator()
                              //       : GestureDetector(onTap: (){
                              //     var v = controller.annualIncomeModel!.annualIncomes!
                              //         .map((item) {
                              //       return item.annualIncome;
                              //     }).toList();
                              //     data=v;
                              //     apiKey="annual_income";
                              //     selectionType="single";
                              //     setState(() {
                              //
                              //     });
                              //
                              //     _scaffoldKey.currentState!.openEndDrawer();
                              //   },child:Container(
                              //       width: AppConfig.width*0.9,
                              //       alignment: Alignment.centerLeft,
                              //       height: AppConfig.height*0.07,
                              //       padding: const EdgeInsets.all(10),
                              //       margin: const EdgeInsets.all(10),
                              //       decoration: BoxDecoration(
                              //           borderRadius: BorderRadius.circular(10.0),
                              //           border: Border.all(color: Colors.black)),
                              //       child: Row(
                              //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //         children: [
                              //           Text(selectedAnnual!,style: const TextStyle(color: Colors.black,fontSize: 18),),
                              //           const Icon(Icons.arrow_drop_down_circle_outlined)
                              //         ],
                              //       ),));
                              // }),
                              const Text(
                                "Education ",
                                style: TextStyle(
                                    fontWeight: FontWeight.w800, fontSize: 18),
                              ),
                              Consumer<AuthController>(
                                  builder: (context, controller, child) {
                                return controller.isLoading
                                    ? const CircularProgressIndicator()
                                    : GestureDetector(onTap: (){
                                  var v = controller.educationModel!.educations!
                                      .map((item) {
                                    return item.education;
                                  }).toList();
                                  data=v;
                                  apikey="education";
                                  selectionType="multi";
                                      searchController!.emptyList();
                                  

                                  setState(() {

                                  });

                                  _scaffoldKey.currentState!.openEndDrawer();
                                },child:Container(
                                    width: AppConfig.width*0.9,
                                    alignment: Alignment.centerLeft,
                                    height: AppConfig.height*0.07,
                                    padding: const EdgeInsets.all(10),
                                    margin: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10.0),
                                        border: Border.all(color: Colors.black)),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(searchcontroller.advanceData["education"]??selectedEducation!,style: const TextStyle(color: Colors.black,fontSize: 18),),
                                        const Icon(Icons.arrow_drop_down_circle_outlined)
                                      ],
                                    ),));
                              }),
                              const Text(
                                "Employed In",
                                style: TextStyle(
                                    fontWeight: FontWeight.w800, fontSize: 18),
                              ),
                              Consumer<AuthController>(
                                  builder: (context, controller, child) {
                                return controller.isLoading
                                    ? const CircularProgressIndicator()
                                    : GestureDetector(onTap: (){
                                  var v = controller.employerModel!.employers!
                                      .map((item) {
                                    return item.employer;
                                  }).toList();
                                  data=v;
                                  apikey="employed_in";
                                  selectionType="multi";
                                      searchController!.emptyList();
                                  setState(() {

                                  });

                                  _scaffoldKey.currentState!.openEndDrawer();
                                },child:Container(
                                    width: AppConfig.width*0.9,
                                    alignment: Alignment.centerLeft,
                                    height: AppConfig.height*0.07,
                                    padding: const EdgeInsets.all(10),
                                    margin: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10.0),
                                        border: Border.all(color: Colors.black)),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(searchcontroller.advanceData["employed_in"]??selectedEmployedIn!,style: const TextStyle(color: Colors.black,fontSize: 18),),
                                        const Icon(Icons.arrow_drop_down_circle_outlined)
                                      ],
                                    ),));
                              }),
                              const Text(
                                "Is Manglik",
                                style: TextStyle(
                                    fontWeight: FontWeight.w800, fontSize: 16),
                              ),
                              const SizedBox(height: 5),
                              Container(
                                width: AppConfig.width*0.9,
                                alignment: Alignment.centerLeft,
                                height: AppConfig.height*0.07,
                                padding: const EdgeInsets.all(10),
                                margin: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    border: Border.all(color: Colors.black)),
                                child: DropdownButton<String>(
                                  borderRadius: BorderRadius.circular(10.0),
                                  underline: Container(),
                                  isExpanded:
                                      true, //make true to take width of parent widget
                                  //empty line
                                  style: const TextStyle(
                                      fontSize: 18, color: Colors.black),
                                  dropdownColor: Colors.white,
                                  iconEnabledColor: Colors.black,
                                  icon:  const Icon(Icons.arrow_drop_down_circle_outlined),
                                  hint: const Text("Select Your Religion"),
                                  value: authController!.isManglik,
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      authController!.isManglik = newValue!;
                                      advanceSearchPostModel!.manglik = newValue;
                                      Map<String, dynamic> data = {
                                        "user_id": "27",
                                        "gender": "Female",
                                        "profile_id":profileId.text ,
                                      };
                                     // searchController!.advanceSearch(context,data);
                                    });
                                  },
                                  items: <String>[
                                    'Yes',
                                    'No',
                                  ].map<DropdownMenuItem<String>>((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                              ),
                              const Text(
                                "Marital Status",
                                style: TextStyle(
                                    fontWeight: FontWeight.w800, fontSize: 16),
                              ),
                              const SizedBox(height: 5),
                              Consumer<AuthController>(
                                  builder: (context, controller, child) {
                                return controller.isLoading
                                    ? const CircularProgressIndicator()
                                    :  GestureDetector(onTap: (){
                                  var v = controller.maritalStatusModel!.maritalStatus!
                                      .map((item) {
                                    return item.maritalStatus;
                                  }).toList();
                                  data=v;
                                  apikey="marital_status";
                                  selectionType="single";
                                  setState(() {

                                  });

                                  _scaffoldKey.currentState!.openEndDrawer();
                                },child:Container(
                                    width: AppConfig.width*0.9,
                                    alignment: Alignment.centerLeft,
                                    height: AppConfig.height*0.07,
                                    padding: const EdgeInsets.all(10),
                                    margin: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10.0),
                                        border: Border.all(color: Colors.black)),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(searchcontroller.advanceData["marital_status"]??selectedMaritalStatus!,style: const TextStyle(color: Colors.black,fontSize: 18),),
                                        const Icon(Icons.arrow_drop_down_circle_outlined)
                                      ],
                                    ),));
                              }),
                              Consumer<SearchController>(
                                  builder: (context, controller, child) {
                                return AppButton(
                                  onClick: () {
                                    Map<String, dynamic> data = {
                                      "user_id": "27",
                                      "gender": "Female",
                                      "profile_id":profileId.text ,
                                    };
                                    searchController!.advanceData['profile_id']=profileId.text;
                                    searchController!.advanceData['user_id']=getProfileController?.getProfileModel?.data?.user?.id;
                                    searchController!.advanceData['gender']=getProfileController?.getProfileModel?.data?.user?.gender;
                                    searchController!.advanceData['age_from']=values.start.toString();
                                    searchController!.advanceData['age_to']=values.end.toString();
                                    searchController!.advanceData['is_manglik']=advanceSearchPostModel?.manglik;
                                    searchController!.advanceData['annual_income_from']=selectedAnnual;
                                    searchController!.advanceData['annual_income_to']=selectedAnnual2;

                                    searchController!.advanceSearch(context,searchController!.advanceData);
                                  },
                                  textWidet: controller.isLoading
                                      ? const Center(
                                          child: CircularProgressIndicator(
                                          color: Colors.white,
                                        ))
                                      : const Text(
                                          "Advance Search",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                );
                              }),
                            ],
                          );
                        }
                      ),
                    ),
                  );
          });
        }
      ),
    );
  }

  // final valuestopopulate = {
  //   1: "India",
  //   2: "Britain",
  //   3: "Russia",
  //   4: "Canada",
  // };
  //
  // void _showMultiSelect(BuildContext context, v) async {
  //   print("lknkmpam$v");
  //   multiItem = [];
  //
  //
  //   for (int i = 0; i < v.length; i++) {
  //     multiItem.add(MultiSelectItem(i, v[i]));
  //   }
  //
  //   final items = multiItem;
  //
  //   final selectedValues = await showModalBottomSheet(
  //     backgroundColor: Colors.transparent,
  //     isScrollControlled: true, // required for min/max child size
  //     context: context,
  //     builder: (ctx) {
  //       return Container(
  //           decoration: const BoxDecoration(
  //               color: Colors.white,
  //               borderRadius: BorderRadius.only(
  //                   topLeft: Radius.circular(30.0),
  //                   topRight: Radius.circular(30.0))),
  //           child: MultiSelectBottomSheet(
  //
  //             confirmText:const Text("Apply"),
  //             itemsTextStyle: const TextStyle(color: Colors.black,fontWeight: FontWeight.w600),
  //             selectedColor: AppConfig.theme.primaryColor,
  //             searchable: true,
  //
  //             searchHint: "Type Something for search",
  //             selectedItemsTextStyle:TextStyle(color: AppConfig.theme.primaryColor,fontWeight: FontWeight.w600),
  //             onConfirm: (values) {},
  //             maxChildSize: 0.8,
  //             items: items,
  //             initialValue: [],
  //           ));
  //     },
  //   );
  //
  //   print(selectedValues);
  //   // getvaluefromkey(selectedValues!);
  // }

  // void getvaluefromkey(Set selection) {
  //   if (selection != null) {
  //     for (int x in selection.toList()) {
  //       print(valuestopopulate[x]);
  //     }
  //   }
  // }
}
