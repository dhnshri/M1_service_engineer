import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
  String dropdownValue = '+ 91';
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
        bottomNavigationBar:AppButton(
          onPressed: () async {

            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => SignUpAsScreen()));
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

                Expanded(
                  flex: 1,
                  child: SingleChildScrollView(
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
                                MediaQuery.of(context).size.width * 0.8,
                                height: 60,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                    BorderRadius.circular(8.0)),
                                child: Center(
                                  child: DropdownButtonHideUnderline(
                                      child: DropdownButton<String>(
                                        value: dropdownValue,
                                        icon: const Icon(Icons.arrow_downward),
                                        iconSize: 24,
                                        elevation: 16,
                                        iconEnabledColor: primaryAppColor,
                                        borderRadius:
                                        BorderRadius.circular(8.0),
                                        style: TextStyle(
                                            color: primaryAppColor,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600),
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            dropdownValue = newValue!;
                                          });
                                        },
                                        items: <String>[
                                          '+ 91',
                                          '+ 1',
                                          '+ 52',
                                          '+ 00'
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
                            ),
                          ],
                        ),
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
