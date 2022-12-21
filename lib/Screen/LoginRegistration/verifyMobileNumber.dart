import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:service_engineer/Screen/LoginRegistration/registration.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Config/font.dart';
import '../../Widget/app_button.dart';

class VerifyMobileNumberScreen extends StatefulWidget {
  const VerifyMobileNumberScreen({Key? key}) : super(key: key);

  @override
  _VerifyMobileNumberScreenState createState() => _VerifyMobileNumberScreenState();
}

class _VerifyMobileNumberScreenState extends State<VerifyMobileNumberScreen> {
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
    // _phoneNumberController.clear();

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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 20.0),
                                  child: Container(
                                    height: 42,
                                    width: 70,
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
                                const SizedBox(
                                  width: 10.0,
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.6,
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
                                      hintText: 'Mobile Number',
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
                                )
                              ],
                            ),
                            SizedBox(
                              width:
                              MediaQuery.of(context).size.width * 0.12,
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
                                  hintText: 'Mobile Number',
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
                            const SizedBox(
                              height: 7.0,
                            ),
                            Padding(
                                padding:
                                const EdgeInsets.symmetric(horizontal: 40.0),
                                child: AppButton(
                                  onPressed: () async {

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
                                  text: 'Verify Number',
                                  loading: loading,


                                )
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
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
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(builder: (context) => RegistrationScreen()));
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
