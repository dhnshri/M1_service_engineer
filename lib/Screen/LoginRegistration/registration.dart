import 'dart:async';

import 'dart:io';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Config/font.dart';
import '../../Widget/app_button.dart';
import '../../Screen/bottom_navbar.dart';
import 'login_screen.dart';


class RegistrationScreen extends StatefulWidget {
  final String? dropValue;
  const RegistrationScreen({Key? key,required this.dropValue}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailIdController = TextEditingController();
  final TextEditingController _createPasswordController = TextEditingController();
  final TextEditingController _reEnterPasswordController = TextEditingController();
  String dropdownValueModule = 'Machine Maintenance';
  String dropdownValue = '+ 91';
  String? phoneNum;
  String? role;
  bool loading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff062C56),
        body: Stack(
          children: [
            Image.asset(
              'assets/images/background.png',
              fit: BoxFit.cover,
              width: double.infinity,
              height: MediaQuery.of(context).size.height,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.10,
                    ),
                    Center(
                      child: SizedBox(
                          height: MediaQuery.of(context).size.height * 0.25,
                          child: Image.asset(
                              'assets/images/Logo.png')),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
                  ],
                ),
                Expanded(
                  flex: 1,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Column(
                          children: [
                            Text(
                              'Create Password',
                              style: ksubjectHeadingStyle,
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.01,
                            ),
                            Text(
                              'You have to enter email and phone',
                              softWrap: true,
                              style: registersubheadingStyle,
                            ),
                            Text(
                              ' number to register.',
                              softWrap: true,
                              style: registersubheadingStyle,
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.02,
                            ),
                            SizedBox(
                              width:
                              MediaQuery.of(context).size.width * 0.8,
                              height: 60,
                              child: TextFormField(
                                controller: _fullNameController,
                                keyboardType: TextInputType.number,
                                maxLength: 10,
                                cursorColor: primaryAppColor,
                                decoration: InputDecoration(
                                  disabledBorder: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.circular(8.0),
                                    borderSide: const BorderSide(
                                      color: Colors.white,
                                      width: 1.0,
                                    ),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.circular(8.0),
                                    borderSide: const BorderSide(
                                      color: Colors.red,
                                      width: 1.0,
                                    ),
                                  ),
                                  fillColor: Colors.white,
                                  filled: true,
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.circular(10.0),
                                    borderSide: const BorderSide(
                                        color: Colors.white, width: 1.0),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                      borderRadius:
                                      BorderRadius.circular(8.0),
                                      borderSide: const BorderSide(
                                        color: Colors.white,
                                        width: 1.0,
                                      )),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.circular(8.0),
                                    borderSide: const BorderSide(
                                      color: Colors.white,
                                      width: 1.0,
                                    ),
                                  ),
                                  hintText: 'Full Name',
                                  contentPadding: const EdgeInsets.fromLTRB(
                                      20.0, 20.0, 0.0, 0.0),
                                  hintStyle: GoogleFonts.poppins(
                                      color: Colors.grey,
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w500),
                                ),
                                onChanged: (val) {
                                  setState(() {
                                    // _phoneNumberController.text = val;
                                  });
                                },
                              ),
                            ),
                            SizedBox(
                              width:
                              MediaQuery.of(context).size.width * 0.8,
                              height: 60,
                              child: TextFormField(
                                controller: _emailIdController,
                                keyboardType: TextInputType.number,
                                maxLength: 10,
                                cursorColor: primaryAppColor,
                                decoration: InputDecoration(
                                  disabledBorder: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.circular(8.0),
                                    borderSide: const BorderSide(
                                      color: Colors.white,
                                      width: 1.0,
                                    ),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.circular(8.0),
                                    borderSide: const BorderSide(
                                      color: Colors.red,
                                      width: 1.0,
                                    ),
                                  ),
                                  fillColor: Colors.white,
                                  filled: true,
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.circular(10.0),
                                    borderSide: const BorderSide(
                                        color: Colors.white, width: 1.0),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                      borderRadius:
                                      BorderRadius.circular(8.0),
                                      borderSide: const BorderSide(
                                        color: Colors.white,
                                        width: 1.0,
                                      )),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.circular(8.0),
                                    borderSide: const BorderSide(
                                      color: Colors.white,
                                      width: 1.0,
                                    ),
                                  ),
                                  hintText: 'Email id',
                                  contentPadding: const EdgeInsets.fromLTRB(
                                      20.0, 20.0, 0.0, 0.0),
                                  hintStyle: GoogleFonts.poppins(
                                      color: Colors.grey,
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w500),
                                ),
                                onChanged: (val) {
                                  setState(() {
                                    // _phoneNumberController.text = val;
                                  });
                                },
                              ),
                            ),
                            SizedBox(
                              width:
                              MediaQuery.of(context).size.width * 0.8,
                              height: 60,
                              child: TextFormField(
                                controller: _phoneNumberController,
                                keyboardType: TextInputType.number,
                                maxLength: 10,
                                cursorColor: primaryAppColor,
                                decoration: InputDecoration(
                                  disabledBorder: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.circular(8.0),
                                    borderSide: const BorderSide(
                                      color: Colors.white,
                                      width: 1.0,
                                    ),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.circular(8.0),
                                    borderSide: const BorderSide(
                                      color: Colors.red,
                                      width: 1.0,
                                    ),
                                  ),
                                  fillColor: Colors.white,
                                  filled: true,
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.circular(10.0),
                                    borderSide: const BorderSide(
                                        color: Colors.white, width: 1.0),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                      borderRadius:
                                      BorderRadius.circular(8.0),
                                      borderSide: const BorderSide(
                                        color: Colors.white,
                                        width: 1.0,
                                      )),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.circular(8.0),
                                    borderSide: const BorderSide(
                                      color: Colors.white,
                                      width: 1.0,
                                    ),
                                  ),
                                  hintText: '+91 9657563423',
                                  contentPadding: const EdgeInsets.fromLTRB(
                                      20.0, 20.0, 0.0, 0.0),
                                  hintStyle: GoogleFonts.poppins(
                                      color: Colors.grey,
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w500),
                                ),
                                onChanged: (val) {
                                  setState(() {
                                    phoneNum = val;
                                    // _phoneNumberController.text = val;
                                  });
                                },
                              ),
                            ),

                            SizedBox(
                              width:
                              MediaQuery.of(context).size.width * 0.8,
                              height: 60,
                              child: TextFormField(
                                controller: _createPasswordController,
                                keyboardType: TextInputType.number,
                               // maxLength: 10,
                                cursorColor: primaryAppColor,
                                decoration: InputDecoration(
                                  disabledBorder: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.circular(8.0),
                                    borderSide: const BorderSide(
                                      color: Colors.white,
                                      width: 1.0,
                                    ),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.circular(8.0),
                                    borderSide: const BorderSide(
                                      color: Colors.red,
                                      width: 1.0,
                                    ),
                                  ),
                                  fillColor: Colors.white,
                                  filled: true,
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.circular(10.0),
                                    borderSide: const BorderSide(
                                        color: Colors.white, width: 1.0),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                      borderRadius:
                                      BorderRadius.circular(8.0),
                                      borderSide: const BorderSide(
                                        color: Colors.white,
                                        width: 1.0,
                                      )),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.circular(8.0),
                                    borderSide: const BorderSide(
                                      color: Colors.white,
                                      width: 1.0,
                                    ),
                                  ),
                                  hintText: 'Create Password',
                                  contentPadding: const EdgeInsets.fromLTRB(
                                      20.0, 20.0, 0.0, 0.0),
                                  hintStyle: GoogleFonts.poppins(
                                      color: Colors.grey,
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w500),
                                ),
                                onChanged: (val) {
                                  setState(() {
                                    phoneNum = val;
                                    // _phoneNumberController.text = val;
                                  });
                                },
                              ),
                            ),

                            SizedBox(
                              width:
                              MediaQuery.of(context).size.width * 0.8,
                              height: 60,
                              child: TextFormField(
                                controller: _reEnterPasswordController,
                                keyboardType: TextInputType.number,
                              //  maxLength: 10,
                                cursorColor: primaryAppColor,
                                decoration: InputDecoration(
                                  disabledBorder: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.circular(8.0),
                                    borderSide: const BorderSide(
                                      color: Colors.white,
                                      width: 1.0,
                                    ),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.circular(8.0),
                                    borderSide: const BorderSide(
                                      color: Colors.red,
                                      width: 1.0,
                                    ),
                                  ),
                                  fillColor: Colors.white,
                                  filled: true,
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.circular(10.0),
                                    borderSide: const BorderSide(
                                        color: Colors.white, width: 1.0),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                      borderRadius:
                                      BorderRadius.circular(8.0),
                                      borderSide: const BorderSide(
                                        color: Colors.white,
                                        width: 1.0,
                                      )),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.circular(8.0),
                                    borderSide: const BorderSide(
                                      color: Colors.white,
                                      width: 1.0,
                                    ),
                                  ),
                                  hintText: 'Confirm Password',
                                  contentPadding: const EdgeInsets.fromLTRB(
                                      20.0, 20.0, 0.0, 0.0),
                                  hintStyle: GoogleFonts.poppins(
                                      color: Colors.grey,
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w500),
                                ),
                                onChanged: (val) {
                                  setState(() {
                                    phoneNum = val;
                                    // _phoneNumberController.text = val;
                                  });
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 20.0),
                              child: Container(
                                width:
                                MediaQuery.of(context).size.width * 0.9,
                                height: 40,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                    BorderRadius.circular(8.0)),
                                child: DropdownButtonHideUnderline(
                                    child: DropdownButton2(
                                      items: <String>[
                                        'Machine Maintenance',
                                        'Job Work Enquiry',
                                        'Transportation',

                                      ].map((item) =>
                                          DropdownMenuItem<String>(
                                            value: item,
                                            child: Text(
                                              item,
                                              style: const TextStyle(
                                                  fontFamily: 'Poppins-Medium',
                                                  fontSize: 15,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w500
                                              ),
                                            ),
                                          ))
                                          .toList(),
                                      value: dropdownValueModule,
                                      onChanged: (value) {
                                        setState(() {
                                          dropdownValueModule = value as String;
                                        });
                                      },
                                      buttonHeight: 40,
                                      buttonWidth: 140,
                                      itemHeight: 40,
                                      buttonPadding: const EdgeInsets.only(left: 14, right: 14),
                                      dropdownPadding: const EdgeInsets.symmetric(vertical: 6),
                                      dropdownDecoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        // color: Colors.redAccent,
                                      ),
                                      // itemWidth: 140,
                                    )
                                  // DropdownButton<String>(
                                  //   isExpanded: true,
                                  //   value: dropdownValue,
                                  //   icon: Padding(
                                  //     padding: const EdgeInsets.only(left:100.0),
                                  //     child: const Icon(Icons.arrow_drop_down_sharp),
                                  //   ),
                                  //   iconSize: 24,
                                  //   elevation: 16,
                                  //   iconEnabledColor: primaryAppColor,
                                  //   borderRadius:
                                  //   BorderRadius.circular(8.0),
                                  //   style: TextStyle(
                                  //       color: Colors.black,
                                  //       fontSize: 16,
                                  //       fontWeight: FontWeight.normal),
                                  //   onChanged: (String? newValue) {
                                  //     setState(() {
                                  //       dropdownValue = newValue!;
                                  //     });
                                  //   },
                                  //   items: <String>[
                                  //     'Machine Maintenance',
                                  //     'Job Work Enquiry',
                                  //     'Transportation',
                                  //
                                  //   ].map<DropdownMenuItem<String>>(
                                  //           (String value) {
                                  //         return DropdownMenuItem<String>(
                                  //           value: value,
                                  //           child: Center(child: Text(value)),
                                  //         );
                                  //       }).toList(),
                                  // )),
                                ),
                              ),
                            ),
                            Padding(
                                padding:
                                const EdgeInsets.symmetric(horizontal: 40.0),
                                child: AppButton(
                                  onPressed: () async {

                                    Navigator.of(context).push(
                                        MaterialPageRoute(builder: (context) => BottomNavigation(index:0,dropValue: widget.dropValue,)));
                                    //   isconnectedToInternet = await ConnectivityCheck
                                    //       .checkInternetConnectivity();
                                    //   if (isconnectedToInternet == true) {
                                    //     if (_formKey.currentState!.validate()) {
                                    //       // setState(() {
                                    //       //   loading=true;
                                    //       // });
                                    //       _userLoginBloc!.add(OnLogin(email: _textEmailController.text,password: _textPasswordController.text));
                                    //     }
                                    //   } else {
                                    //     CustomDialogs.showDialogCustom(
                                    //         "Internet",
                                    //         "Please check your Internet Connection!",
                                    //         context);
                                    //   }
                                  },
                                  shape: const RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(50))),
                                  text: 'Sign in',
                                  loading: loading,


                                )
                            ),
                          ],
                        ),
                        SizedBox(height: 7),
                        TextButton(
                            child: const Text(
                              'Forget Password?',
                              style: TextStyle(
                                  color: Colors.white,
                                  letterSpacing: 1,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14),
                            ),
                            onPressed: () {
                              // Navigator.push(
                              //         context,
                              //         MaterialPageRoute(
                              //             builder: (context) =>
                              //             RegistrationScreen()
                              //                 // WebViewContainer(
                              //                 // "https://rccedu.org/register.php")
                              //         ))
                              //     .whenComplete(() => Navigator.pop(context));
                              // print('Pressed');
                            }),

                        TextButton(
                            child: const Text(
                              'Do not have any account? Create Account',
                              style: TextStyle(
                                  color: Colors.white,
                                  letterSpacing: 1,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14),
                            ),
                            onPressed: () {

                            })
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
 
