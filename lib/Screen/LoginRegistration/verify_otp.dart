import 'dart:async';
import 'dart:convert';


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:service_engineer/Screen/LoginRegistration/registration.dart';

import '../../Constant/theme_colors.dart';
import '../../Widget/app_button.dart';



class VerificationScreen extends StatefulWidget {
  String? dropValue;
  String? phoneNumber;
  String? verificationId;
  VerificationScreen({Key? key,required this.dropValue, required this.phoneNumber, required this.verificationId}):super(key: key);

  @override
  _VerificationScreenState createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  String? _number;
  Timer? _timer;
  int _seconds = 0;
  var otp;
  AuthCredential? authservice;
  UserCredential? authResult;
  var number,firebaseUser_Id;
  String authStatus="",deviceId="",token="";
  String pass='12345678';
  final TextEditingController _otpController = TextEditingController();
  bool loading = false;
  var verificationId;







  @override
  void initState() {
    super.initState();

    // _number = widget.number!.startsWith('+') ? widget.countryCode!+widget.number! : '+'+widget.countryCode!+widget.number!;
    // verificationId = widget.token ?? '';
    _startTimer();
    print(widget.phoneNumber);
    print(widget.verificationId);
    verificationId = widget.verificationId ?? '';


  }

  void _startTimer() {
    _seconds = 60;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      _seconds = _seconds - 1;
      if(_seconds == 0) {
        timer.cancel();
        _timer?.cancel();
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();

    _timer?.cancel();
  }

  Future<dynamic> checkotp(dynamic phone,String verificationId) async {
    otp = "";

    if (verificationId != null && otp != null) {
      try {
        // authservice =await FirebaseAuth.instance(
        //     PhoneAuthProvider.credential(
        //   verificationId: verificationId,
        //   smsCode: otp,
        // ));
        authservice =
            PhoneAuthProvider.credential(
              verificationId: verificationId,
              smsCode: otp,
            );
      } catch (e) {
        print(e);
      }
    }
    // call signin method
    signIn(authservice!, phone);
  }

  signIn(AuthCredential credential, phone) async {
    authResult = await FirebaseAuth.instance
        .signInWithCredential(credential)
        .catchError((onError) {
      print('SignIn Error: ${onError.toString()}\n\n');
    });

    if (authResult != null) {
      // firebaseUser_Id=authResult.user.uid.toString();

      print("fb_id"+firebaseUser_Id);
      // _login(authController, widget.number);

    } else {
      Fluttertoast.showToast(msg: 'Please enter valid sms code');
    }
  }

  Future<void> verifyPhoneNumber(BuildContext context,String number) async {

    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: number,
        timeout: const Duration(seconds: 15),
        verificationCompleted: (AuthCredential authCredential) {
          //  signIn(authCredential);
          print('verfication completed called sent called');
          // _otpController.text = authCredential.token.toString();
        },
        verificationFailed: (FirebaseAuthException authException) {
          print(authException.message.toString() + "Inside auth failed");
          setState(() {
            // authStatus = authException.message;
          });
          if (authStatus != "") {
            // showCustomSnackBar(authStatus);
          }
        },
        codeSent: (String verId, [int? forceCodeResent]) {
          setState(() {

            verificationId = verId;
            loading = false;
            // checkotp(number,authController,verificationId);
          });
        },
        codeAutoRetrievalTimeout: (String verId) {

          setState(() {
            authStatus = "TIMEOUT";
          });
        },
      );
    }catch(e){
      print(e);
      // showCustomSnackBar(e);
    }

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff062C56),
      appBar: AppBar(
        centerTitle: true,
        title: Text("OTP Verification",
        style: TextStyle(color: Colors.white),),
        backgroundColor: Color(0xff062C56),
        leading: InkWell(
            onTap: (){
              Navigator.of(context).pop();
            },
            child: Icon(Icons.arrow_back_ios,color: Colors.white,)),

      ),
      body: SingleChildScrollView(
        child: Stack(
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
                Text("Enter OTP send to ${widget.phoneNumber}",
                style: TextStyle(
                  fontFamily: 'Poppins-Medium',
                  fontSize: 20,
                  color: ThemeColors.whiteTextColor) ,),
                Padding(
                  padding: const EdgeInsets.all(30),
                  child: Center(
                    child: PinCodeTextField(
                      length: 6,
                      obscureText: false,
                      animationType: AnimationType.fade,
                      pinTheme: PinTheme(
                        // inactiveColor: ThemeColors.textFieldHintColor,
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(5),
                        fieldHeight: 50,
                        fieldWidth: 40,
                        activeFillColor: Colors.white,
                        inactiveFillColor: Colors.white,
                      ),
                      animationDuration: const Duration(milliseconds: 300),
                      // backgroundColor: Colors.blue.shade50,
                      enableActiveFill: true,
                      // controller: textEditingController,
                      onCompleted: (v) {
                        debugPrint("Completed");
                      },
                      onChanged: (value) {
                        debugPrint(value);
                        setState(() {
                          // currentText = value;
                        });
                      },
                      beforeTextPaste: (text) {
                        return true;
                      },
                      appContext: context,
                    ),
                  ),
                ),
                Padding(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 40.0),
                    child: AppButton(
                      onPressed: () async {

                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) =>
                            RegistrationScreen(dropValue: widget.dropValue,)
                            // VerificationScreen()
                            ));
                        otp = widget.verificationId;

                        // if (verificationId != null && otp != null) {
                        //   try {
                        //     // authservice =await FirebaseAuth.instance(
                        //     //     PhoneAuthProvider.credential(
                        //     //   verificationId: verificationId.toString,
                        //     //   smsCode: otp,
                        //     // ));
                        //     authservice =
                        //         PhoneAuthProvider.credential(
                        //           verificationId: verificationId,
                        //           smsCode: otp,
                        //         );
                        //   } catch (e) {
                        //     print(e);
                        //     Fluttertoast.showToast(msg: e.toString());                          }
                        //
                        //   if (authservice != null){
                        //     authResult = await FirebaseAuth.instance
                        //         .signInWithCredential(authservice!)
                        //         .catchError((onError) {
                        //       print('SignIn Error: ${onError.toString()}\n\n');
                        //     });
                        //
                        //     if (authResult != null) {
                        //       firebaseUser_Id=authResult!.user!.uid.toString();
                        //
                        //       print("fb_id"+firebaseUser_Id);
                        //       // _login(authController, widget.number);
                        //       print("Otp verified successfully");
                        //
                        //     } else {
                        //       Fluttertoast.showToast(msg: 'Please enter valid sms code');
                        //     }
                        //   }
                        // }

                      },
                      shape: const RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.all(Radius.circular(50))),
                      text: 'Verify',
                      loading: true,


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
