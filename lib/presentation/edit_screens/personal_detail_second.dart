import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:rishtey/models/height_model.dart';
import 'package:rishtey/presentation/profile/personal_profile.dart';
import 'package:rishtey/presentation/register/sign_up_third.dart';
import 'package:rishtey/presentation/register/widgets/rounded_date_picker.dart';
import 'package:rishtey/utils/app_snack_bar.dart';
import 'package:rishtey/utils/shared_pref.dart';

import '../../controller/auth_controller.dart';
import '../../models/city_model.dart';
import '../../models/country_model.dart';
import '../../models/states_model.dart';

class PersonalDetailsSecond extends StatefulWidget {
  const PersonalDetailsSecond({Key? key}) : super(key: key);

  @override
  State<PersonalDetailsSecond> createState() => _PersonalDetailsSecondState();
}

class _PersonalDetailsSecondState extends State<PersonalDetailsSecond> {
  AuthController? authController;
  double loginWidth = 350;
  final registerKey = GlobalKey<FormState>();
  var heightId;
  var stateId;

  static String _displayStringForOption(Countries option) => option.name!;
  static String _displayStates(States option) => option.name!;
  static String _displayCities(Statess option) => option.name!;
  static String _displayHeights(Heights option) => option.height!;
  CountryModel? data;

  @override
  void initState() {
    authController = Provider.of<AuthController>(context, listen: false);
    getData();
    super.initState();
  }

  getData() async {
    data = await authController!.getCountries(context);
  }

  @override
  Widget build(BuildContext context) {
    //  authController = Provider.of<AuthController>(context);
    return Scaffold(
        body: SafeArea(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            height: MediaQuery.of(context).size.height,
            child: Form(
              key: registerKey,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Center(
                        child: Text(
                          "Personal Details",
                          style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
                        )),
                    SizedBox(
                      height: 10,
                    ),

                    const SizedBox(
                      height: 20,
                    ),

                    const Text(
                      "Select Gender",
                      style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
                    ),
                    const SizedBox(height: 5),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: DropdownButton<String>(
                        underline: Container(
                          height: 1,
                          color: Colors.black,
                        ),
                        icon: Container(),
                        value: authController!.genderValue,
                        onChanged: (String? newValue) {
                          setState(() {
                            authController!.genderValue = newValue!;
                          });
                        },
                        items: <String>[
                          'Male',
                          'Female',
                          'Others',
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "Select Height",
                      style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
                    ),
                    const SizedBox(height: 5),
                    Autocomplete<Heights>(
                      displayStringForOption: _displayHeights,
                      optionsBuilder: (TextEditingValue textEditingValue) {
                        return authController!.heightModel!.heights!
                            .where((Heights option) {
                          return option.height!
                              .toLowerCase()
                              .contains(textEditingValue.text.toLowerCase());
                        });
                      },
                      onSelected: (Heights selection) {
                        setState(() {
                          authController!.height =
                              TextEditingController(text: selection.height);
                          heightId = selection.id;
                          //authController!.countryId=int.parse(selection.id.toString());
                          //stateValue = selection.id.toString();
                        });
                        //authController!.getStates(context);
                      },
                      fieldViewBuilder:
                          (context, controller, focusNode, onEditingComplete) {
                        //  this.stateController = controller;

                        return TextFormField(
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(r'[]')),
                          ],
                          controller: controller,
                          focusNode: focusNode,
                          onEditingComplete: onEditingComplete,
                          decoration: const InputDecoration(
                            filled: false,
                            fillColor: Colors.white70,
                            hintText: "Select Height",
                          ),
                          validator: (val) {
                            if (heightId == null || heightId == 0) {
                              return "Please Choose Height From Dropdown";
                            }
                          },
                        );
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              const Text(
                                "Select Date of birth",
                                style: TextStyle(
                                    fontWeight: FontWeight.w800, fontSize: 16),
                              ),
                              const SizedBox(height: 5),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.4,
                                child: TextFormField(
                                  controller: authController!.dateinput,
                                  decoration: const InputDecoration(
                                    filled: true,

                                    hintText: "Enter Your Date Of Birth",
                                    labelStyle: TextStyle(
                                        color: Color(
                                          0xff961b20,
                                        ),
                                        fontSize: 16),
                                    fillColor: Colors.transparent,

                                    //fillColor: Colors.green
                                  ),
                                  onTap: () {
                                    CupertinoRoundedDatePickers.show(
                                      context,
                                      fontFamily: "Poppins",
                                      textColor: Colors.white,
                                      background: Colors.black,
                                      borderRadius: 16,
                                      initialDatePickerMode:
                                      CupertinoDatePickerMode.date,
                                      onDateTimeChanged: (newDateTime) {
                                        //\
                                        setState(() {
                                          authController!.dateinput =
                                              TextEditingController(
                                                  text: newDateTime
                                                      .toString()
                                                      .substring(0, 10));
                                        });
                                        print(newDateTime);
                                      },
                                    );
                                  },
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter Date of birth';
                                    }
                                    return null;
                                  },
                                  keyboardType: TextInputType.emailAddress,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              const Text(
                                "Select Birth Time",
                                style: TextStyle(
                                    fontWeight: FontWeight.w800, fontSize: 16),
                              ),
                              const SizedBox(height: 5),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.4,
                                child: TextFormField(
                                  readOnly: true,
                                  controller: authController!.birthTime,
                                  decoration: const InputDecoration(
                                    filled: true,
                                    hintText: "Select Birth Time",
                                    labelStyle: TextStyle(
                                        color: Color(
                                          0xff961b20,
                                        ),
                                        fontSize: 16),
                                    fillColor: Colors.transparent,
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter Birth Time';
                                    }
                                    return null;
                                  },
                                  onChanged: (value) {
                                    authController!.birthTime.text = value;
                                    setState(() {});
                                  },
                                  onTap: () {
                                    _showDatePicker(context);
                                  },
                                  keyboardType: TextInputType.emailAddress,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "Select Country",
                      style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
                    ),
                    const SizedBox(height: 5),
                    Autocomplete<Countries>(
                      displayStringForOption: _displayStringForOption,
                      optionsBuilder: (TextEditingValue textEditingValue) {
                        return authController!.countryModel!.countries!
                            .where((Countries option) {
                          return option.name!
                              .toLowerCase()
                              .contains(textEditingValue.text.toLowerCase());
                        });
                      },
                      onSelected: (Countries selection) {
                        setState(() {
                          authController!.countryId =
                              int.parse(selection.id.toString());
                          authController!.countryName = TextEditingController(
                              text: selection.name.toString());
                          //stateValue = selection.id.toString();
                        });
                        authController!.getStates(context);
                      },
                      fieldViewBuilder:
                          (context, controller, focusNode, onEditingComplete) {
                        //  this.stateController = controller;

                        return TextFormField(
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(r'[]')),
                          ],
                          controller: controller,
                          focusNode: focusNode,
                          onEditingComplete: onEditingComplete,
                          decoration: const InputDecoration(
                            filled: false,
                            fillColor: Colors.white70,
                            hintText: "Select Country",
                          ),
                          validator: (val) {
                            if (authController!.countryId == null ||
                                authController!.countryId == 0) {
                              return "Please Choose Country From Dropdown";
                            }
                          },
                        );
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "Select States",
                      style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
                    ),
                    const SizedBox(height: 5),
                    Autocomplete<States>(
                      displayStringForOption: _displayStates,
                      optionsBuilder: (TextEditingValue textEditingValue) {
                        return authController!.statesModel!.states!
                            .where((States option) {
                          return option.name!
                              .toLowerCase()
                              .contains(textEditingValue.text.toLowerCase());
                        });
                      },
                      onSelected: (States selection) {
                        setState(() {
                          authController!.birthPlace = TextEditingController(
                              text: selection.name.toString());
                          authController!.stateId = selection.id;
                          authController!.getCities(context);
                        });
                        //authController!.getStates(context);
                      },
                      fieldViewBuilder:
                          (context, controller, focusNode, onEditingComplete) {
                        //  this.stateController = controller;

                        return TextFormField(
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(r'[]')),
                          ],
                          controller: controller,
                          focusNode: focusNode,
                          onEditingComplete: onEditingComplete,
                          decoration: const InputDecoration(
                            filled: false,
                            fillColor: Colors.white70,
                            hintText: "Select States",
                          ),
                          validator: (val) {
                            if (authController!.stateId == null ||
                                authController!.stateId == 0) {
                              return "Please Choose State From Dropdown";
                            }
                          },
                        );
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "Enter City",
                      style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
                    ),
                    const SizedBox(height: 5),
                    Autocomplete<Statess>(
                      displayStringForOption: _displayCities,
                      optionsBuilder: (TextEditingValue textEditingValue) {
                        return authController!.cityModel!.states!
                            .where((Statess option) {
                          return option.name!
                              .toLowerCase()
                              .contains(textEditingValue.text.toLowerCase());
                        });
                      },
                      onSelected: (Statess selection) {
                        setState(() {
                          authController!.cityLiving = TextEditingController(
                              text: selection.name.toString());
                          authController!.cityId = selection.id.toString();
                        });
                        //authController!.getStates(context);
                      },
                      fieldViewBuilder:
                          (context, controller, focusNode, onEditingComplete) {
                        //  this.stateController = controller;

                        return TextFormField(
                          controller: controller,
                          focusNode: focusNode,
                          onEditingComplete: onEditingComplete,
                          decoration: const InputDecoration(
                            filled: false,
                            fillColor: Colors.white70,
                            hintText: "Select Cities",
                          ),
                          validator: (val) {
                            if (controller.text.isEmpty) {
                              return "Please Enter City ";
                            }
                            if (authController!.cityId == null) {
                              authController!.getCities(context);
                            }
                          },
                        );
                      },
                    ),

                    //  const  Expanded(child: SizedBox()),
                    const SizedBox(
                      height: 30,
                    ),
                    Center(
                      child: GestureDetector(



                        child: AnimatedContainer(
                            width: loginWidth,
                            alignment: Alignment.center,
                            duration: const Duration(microseconds: 1000),
                            height: 60,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                gradient: const LinearGradient(
                                  begin: Alignment.topRight,
                                  end: Alignment.topLeft,
                                  colors: [
                                    Color(0xffFF5D4B),
                                    Color(0xffFF7C57),
                                  ],
                                )),
                            child: Center(
                              child: authController!.isLoading
                                  ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                                  : const Text(
                                "Update",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w800),
                              ),
                            )),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  void _showDatePicker(ctx) {
    // showCupertinoModalPopup is a built-in function of the cupertino library
    showCupertinoModalPopup(
        context: ctx,
        builder: (_) => Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
            color: Colors.black,
          ),
          height: 300,
          child: CupertinoTheme(
            data: CupertinoThemeData(
              textTheme: CupertinoTextThemeData(
                dateTimePickerTextStyle:
                TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 240,
                  child: CupertinoDatePicker(
                      mode: CupertinoDatePickerMode.time,
                      initialDateTime: DateTime.now(),
                      onDateTimeChanged: (val) {
                        setState(() {
                          if (int.parse(val
                              .toString()
                              .split(" ")[1]
                              .substring(0, 2)) <
                              12) {
                            authController?.birthTime.text = val
                                .toString()
                                .split(" ")[1]
                                .substring(0, 5) +
                                " AM";
                          } else {
                            var hours;

                            hours = int.parse(val
                                .toString()
                                .split(" ")[1]
                                .substring(0, 2)) -
                                12;
                            authController?.birthTime.text =
                                hours.toString() +
                                    ":" +
                                    val
                                        .toString()
                                        .split(" ")[1]
                                        .substring(3, 5) +
                                    " PM";
                          }
                        });
                      }),
                ),

                // Close the modal
                CupertinoButton(
                  child: const Text(
                    'Submit',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () => Navigator.of(ctx).pop(),
                )
              ],
            ),
          ),
        ));
  }
}
