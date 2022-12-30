import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:service_engineer/Screen/LoginRegistration/registration.dart';
import 'package:service_engineer/Screen/LoginRegistration/verify_otp.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:country_list_pick/country_list_pick.dart';

import '../../Config/font.dart';
import '../../Widget/app_button.dart';

class VerifyMobileNumberScreen extends StatefulWidget {
  final String? dropValue;
  const VerifyMobileNumberScreen({Key? key,required this.dropValue}) : super(key: key);

  @override
  _VerifyMobileNumberScreenState createState() => _VerifyMobileNumberScreenState();
}

class _VerifyMobileNumberScreenState extends State<VerifyMobileNumberScreen> {
  final TextEditingController _phoneNumberController = TextEditingController();
  String dropdownValue = '+ 91';
  String? phoneNum;
  String? role;
  bool loading = true;
  var countrycode;
  String authStatus="";
  var verificationId;


  // String? smsCode;
  // bool smsCodeSent = false;
  // String? verificationId;
  final _formKey = GlobalKey<FormState>();

  Future<void> verifyPhoneNumber(BuildContext context,String number) async {

    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: countrycode+number,
        timeout: const Duration(seconds: 15),
        verificationCompleted: (AuthCredential authCredential) {
          //  signIn(authCredential);
          print('verfication completed called sent called');
          //commented on 14/062021
          // setState(() {
          //   authStatus = "sucess";
          // });
          // if (authStatus != "") {
          //   scaffoldKey?.currentState?.showSnackBar(SnackBar(
          //     content: Text(authStatus),
          //   ));
          // }
        },
        verificationFailed: (FirebaseAuthException authException) {
          print(authException.message.toString() + "Inside auth failed");
          setState(() {
            // authStatus = "Authentication failed";
            authStatus = authException.message!;
          });
          // loader.remove();
          // Helper.hideLoader(loader);
          if (authStatus != "") {
            // scaffoldKey.currentState.showSnackBar(SnackBar(
            //   content: Text(authStatus),
            // ));
            Fluttertoast.showToast(msg: authStatus);

          }
        },
        codeSent: (String? verId, [int? forceCodeResent]) {
          // loader.remove();
          // Helper.hideLoader(loader);
          // this.verificationId = verId;
          setState(() {
            // authStatus = "OTP has been successfully sent";
            // // user.deviceToken = verId;
            verificationId = verId;
            loading=true;
            // Navigator.push(context,MaterialPageRoute(builder: (context)=>
            //     OtpScreen(
            //       mobileNum:_mobilecontroller.text,
            //       verificationId:verificationId.toString(),
            //     )));
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) =>
                    // RegistrationScreen(dropValue: widget.dropValue,)
                  VerificationScreen(dropValue: widget.dropValue,phoneNumber: countrycode+number,verificationId: verificationId,)
                ));

          });

        },
        codeAutoRetrievalTimeout: (String verId) {
          // user.deviceToken = verId;
          //    print('coderetreival sent called' + verificationId);
          setState(() {
            authStatus = "TIMEOUT";
          });
        },
      );
    }catch(e){
      print(e);
      Fluttertoast.showToast(msg: e.toString());

    }

  }



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
                CountryListPick(
                  appBar: AppBar(
                    backgroundColor: Color(0xff062C56),
                    title: Text('Pick your country',
                    style: TextStyle(color: Colors.white),),
                    leading: InkWell(
                        onTap: (){
                          Navigator.of(context).pop();
                        },
                        child: Icon(Icons.arrow_back_ios,color: Colors.white,)),
                  ),
                  // if you need custome picker use this
                  pickerBuilder: (context, CountryCode? countryCode) {
                    countrycode=countryCode!.dialCode.toString();
                    return
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0,right: 15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                                padding: EdgeInsets.all(8.0),
                                height: 45.0,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(5.0),
                                    bottomLeft: Radius.circular(5.0),
                                  ),
                                ),

                                child:
                                Row(
                                  children: [
                                    Align(
                                        alignment: Alignment.center,
                                        child:Text(countryCode.dialCode.toString(),
                                          style: TextStyle(
                                              color: Colors.black
                                          ),

                                        )),
                                    Icon(Icons.arrow_drop_down,color: Colors.black,)
                                  ],
                                )),
                            SizedBox(width: 5,),
                            Expanded(
                                child:
                                Container(
                                    height: 45.0,
                                    // margin: EdgeInsets.only(right: 25.0),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:   BorderRadius.only(
                                        topRight: Radius.circular(5.0),
                                        bottomRight: Radius.circular(5.0),
                                      ),
                                      // border: Border.all(
                                      //
                                      //   color: Theme.of(context).primaryColor,  // red as border color
                                      // ),
                                    ),
                                    child:
                                    Align(
                                      alignment: Alignment.center,
                                      child:
                                      TextFormField(
                                        controller:_phoneNumberController,
                                        style: TextStyle(
                                            fontFamily: 'Poppins-Regular',color: Colors.black,fontSize: 15.0,
                                            fontWeight: FontWeight.w500
                                        ),
                                        keyboardType: TextInputType.phone,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "Mobile Number",
                                        ),
                                        onChanged: (value) {
                                          // this.phoneNo=value;
                                          print(value);
                                        },
                                      ),
                                    )
                                )
                            ),
                          ],
                        ),
                      );
                  },
                  // theme: CountryTheme(
                  //   isShowFlag: true,
                  //   isShowTitle: true,
                  //   isShowCode: true,
                  //   isDownIcon: false,
                  //   showEnglishName: true,
                  // ),
                  initialSelection: '+91',
                  // or
                  // initialSelection: 'US'
                  onChanged: (CountryCode? code) {
                    print(code!.name);
                    print(code.code);
                    print(code.dialCode);
                    print(code.flagUri);
                  },
                ),

                SizedBox(
                  height: 40,
                ),

                Padding(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 40.0),
                    child: AppButton(
                      onPressed: () async {

                        // Navigator.of(context).push(
                        //     MaterialPageRoute(builder: (context) =>
                        //         // RegistrationScreen(dropValue: widget.dropValue,)
                        //       VerificationScreen(dropValue: widget.dropValue,phoneNumber: '',verificationId: verificationId,)
                        //     ));
                        if(_phoneNumberController.text.isEmpty){
                          Fluttertoast.showToast(msg: 'Please enter mobile number');
                        }else if(_phoneNumberController.text.length!=10){
                          Fluttertoast.showToast(msg: 'Please enter valid number');
                        }else{
                          // otpVerify.phone=_mobilecontroller.text;
                          // otpVerify.countrycode=countrycode.toString();
                          // otpVerify.flagRoleType=widget.flagRoleType.toString();
                          // // Navigator.pushNamed(context, Routes.otp);
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => OtpScreen(),
                          //   ),
                          // );
                          setState(() {
                            loading=false;
                          });
                          verifyPhoneNumber(context, _phoneNumberController.text);
                        }

                        // verifyPhoneNumber(context, _phoneNumberController.text);

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
          ],
        ),
      ),
    );
  }
}
