import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:service_engineer/Constant/theme_colors.dart';
import 'package:service_engineer/Repository/UserRepository.dart';
import 'package:service_engineer/Screen/LoginRegistration/verifyMobileNumber.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import '../../Config/font.dart';
import '../../Widget/app_button.dart';
import 'login_screen.dart';

class SignUpAsScreen extends StatefulWidget {
  const SignUpAsScreen({Key? key}) : super(key: key);

  @override
  _SignUpAsScreenState createState() => _SignUpAsScreenState();
}

class _SignUpAsScreenState extends State<SignUpAsScreen> {
  final TextEditingController _phoneNumberController = TextEditingController();
  String dropdownValue = 'Machine Maintenance';
  String? phoneNum;
  String? role;
  bool loading = true;

  // String? smsCode;
  // bool smsCodeSent = false;
  // String? verificationId;
  final _formKey = GlobalKey<FormState>();



  @override
  void initState() {
    // TODO: implement initState
    //saveDeviceTokenAndId();
    super.initState();
    _phoneNumberController.clear();

  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // getroleofstudent();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff062C56),
        bottomNavigationBar:Padding(
          padding: const EdgeInsets.all(10.0),
          child: AppButton(
            onPressed: () async {
              UserRepository().saveRole(dropdownValue);
              // Navigator.of(context).push(
              //     MaterialPageRoute(builder: (context) => VerifyMobileNumberScreen(dropValue: dropdownValue,)));
              Navigator.of(context).push(
                     MaterialPageRoute(builder: (context) => LoginScreen(dropValue: dropdownValue,)));
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
            text: 'Next',
            loading: loading,
            color: ThemeColors.buttonColor,


          ),
        ),
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
                SizedBox(
                  height: 90,
                ),
                Expanded(
                  flex: 1,
                  child: SingleChildScrollView(
                    child: Center(
                      child: Column(
                        children: [
                          Text(
                            'Sign Up As',
                            style: TextStyle(fontFamily: 'Poppins-SemiBold',fontSize: 25,fontWeight: FontWeight.w600,
                            color: ThemeColors.whiteTextColor),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01,
                          ),
                          Text(
                            'Please Select the role to sign up',
                            softWrap: true,
                            style: TextStyle(fontFamily: 'Poppins-Regular',fontSize: 16,fontWeight: FontWeight.w400,
                                color: ThemeColors.whiteTextColor),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.06,
                          ),
                          Column(
                            children: [
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
                                        value: dropdownValue,
                                        onChanged: (value) {
                                          setState(() {
                                            dropdownValue = value as String;
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
                              )
                            ],
                          ),
                          // SizedBox(
                          //   height: MediaQuery.of(context).size.height * 0.01,
                          // ),
                          // Padding(
                          //   padding: const EdgeInsets.only(right:14.0,left: 14.0),
                          //   child: Text(
                          //     'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
                          //     softWrap: true,
                          //     style: ksubjectSubheadingStyle.copyWith(fontSize: 10),
                          //   ),
                          // ),
                        ],
                      ),
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
