import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:service_engineer/Screen/LoginRegistration/verifyMobileNumber.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Config/font.dart';
import '../../Widget/app_button.dart';

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
  // void saveDeviceTokenAndId() async {
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   //for device Id
  //   var deviceInfo = DeviceInfoPlugin();
  //   if (Platform.isAndroid) {
  //     // import 'dart:io'
  //     var androidDeviceId = await deviceInfo.androidInfo;
  //     // print("androiId" + androidDeviceId.androidId);
  //     sharedPreferences.setString('deviceId', androidDeviceId.androidId);
  //   } else {
  //     var iosDeviceId = await deviceInfo.iosInfo;
  //     sharedPreferences.setString('deviceId', iosDeviceId.identifierForVendor);
  //     print("iosId" + iosDeviceId.identifierForVendor);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff062C56),
        bottomNavigationBar:Padding(
          padding: const EdgeInsets.all(10.0),
          child: AppButton(
            onPressed: () async {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => VerifyMobileNumberScreen()));
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
                            style: ksubjectHeadingStyle,
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01,
                          ),
                          Text(
                            'Please Select the role to sign up',
                            softWrap: true,
                            style: ksubjectSubheadingStyle,
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
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
                                      child: DropdownButton<String>(
                                        isExpanded: true,
                                        value: dropdownValue,
                                        icon: Padding(
                                          padding: const EdgeInsets.only(left:100.0),
                                          child: const Icon(Icons.arrow_drop_down_sharp),
                                        ),
                                        iconSize: 24,
                                        elevation: 16,
                                        iconEnabledColor: primaryAppColor,
                                        borderRadius:
                                        BorderRadius.circular(8.0),
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.normal),
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            dropdownValue = newValue!;
                                          });
                                        },
                                        items: <String>[
                                          'Machine Maintenance',
                                          'Job Work Enquiry',
                                          'Transportation',

                                        ].map<DropdownMenuItem<String>>(
                                                (String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Center(child: Text(value)),
                                              );
                                            }).toList(),
                                      )),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right:14.0,left: 14.0),
                            child: Text(
                              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
                              softWrap: true,
                              style: ksubjectSubheadingStyle.copyWith(fontSize: 10),
                            ),
                          ),
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
