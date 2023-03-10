import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:service_engineer/Screen/LoginRegistration/registration.dart';
import 'package:service_engineer/Widget/custom_snackbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Bloc/login/login_bloc.dart';
import '../../Bloc/login/login_event.dart';
import '../../Bloc/login/login_state.dart';
import '../../Config/font.dart';
import '../../Model/customer_login.dart';
import '../../Utils/connectivity_check.dart';
import '../../Widget/app_button.dart';
import '../../Widget/app_dialogs.dart';
import '../JobWorkEnquiry/Home/home.dart';
import '../bottom_navbar.dart';

class LoginScreen extends StatefulWidget {
  final String? dropValue;
  const LoginScreen({Key? key,required this.dropValue}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginBloc? _userLoginBloc;
  final _textPhoneNumberController = TextEditingController();
  final _textPasswordController = TextEditingController();
  String dropdownValue = '+ 91';
  String? phoneNum;
  String? role;
  bool loading = true;
  final _formKey = GlobalKey<FormState>();
  bool isconnectedToInternet = false;
  CustomerLogin? userModel;



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   // loading;
    _userLoginBloc = BlocProvider.of<LoginBloc>(context);

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

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
    return Scaffold(
      body: SingleChildScrollView(
        child: BlocBuilder<LoginBloc,LoginState>(builder: (context,login){
          return BlocListener<LoginBloc,LoginState>(listener: (context,state){
            if(state is LoginSuccess)
            {
              loading = false;
              SchedulerBinding.instance.addPostFrameCallback((_) {

                // add your code here.

                Timer.periodic(const Duration(seconds: 10), (timer) {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> BottomNavigation(index: 0,dropValue: state.userModel.role.toString(),)));
                  showCustomSnackBar(context,'Login Successfully',isError: false);
                  timer.cancel();
                });
              });

              // Timer.periodic(const Duration(seconds: 10), (_) {
              //   Navigator.push(context, MaterialPageRoute(builder: (context)=> BottomNavigation(index: 0,)));
              // });

            }
            if(state is LoginFail){
              showCustomSnackBar(context,'Login Failed');
              // Fluttertoast.showToast(msg: "Login Failed");
            }
          },
            child:Container(
              child: Form(
                key: _formKey,
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
                        SingleChildScrollView(
                          child: Column(
                            children: [
                              Column(
                                children: [
                                  SizedBox(
                                    width:
                                    MediaQuery.of(context).size.width * 0.8,
                                    height: 60,
                                    child: TextFormField(
                                      controller: _textPhoneNumberController,
                                      keyboardType: TextInputType.text,
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
                                        hintText: 'Username',
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
                                  SizedBox(
                                    width:
                                    MediaQuery.of(context).size.width * 0.8,
                                    height: 60,
                                    child: TextFormField(
                                      controller: _textPasswordController,
                                      keyboardType: TextInputType.text,
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
                                        hintText: 'Password',
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

                                          // Navigator.of(context).push(
                                          //     MaterialPageRoute(builder: (context) => BottomNavigation(index:0,dropValue: widget.dropValue,)));
                                            isconnectedToInternet = await ConnectivityCheck
                                                .checkInternetConnectivity();
                                            if (isconnectedToInternet == true) {
                                              if (_formKey.currentState!.validate()) {
                                                // setState(() {
                                                //   loading=true;
                                                // });
                                                _userLoginBloc!.add(OnLogin(username: _textPhoneNumberController.text,password: _textPasswordController.text));
                                              }
                                            } else {
                                              CustomDialogs.showDialogCustom(
                                                  "Internet",
                                                  "Please check your Internet Connection!",
                                                  context);
                                            }
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
                                    Navigator.of(context).push(
                                        MaterialPageRoute(builder: (context) => RegistrationScreen(dropValue:dropdownValue ,)));
                                  })
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        }),

      ),
    );
  }
}

