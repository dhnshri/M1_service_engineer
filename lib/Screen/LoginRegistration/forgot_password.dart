import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:service_engineer/Bloc/login/bloc.dart';

import '../../Bloc/login/login_bloc.dart';
import '../../Bloc/login/login_state.dart';
import '../../Constant/theme_colors.dart';
import '../../Utils/connectivity_check.dart';
import '../../Widget/app_button.dart';
import '../../Widget/app_dialogs.dart';
import 'login_screen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String dropdownValueModule = 'Machine Maintenance';
  String dropdownValue = '+ 91';
  String? phoneNum;
  String? role;
  bool loading = true;
  String _value = "1";
  LoginBloc? _userLoginBloc;
  bool isconnectedToInternet = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _userLoginBloc = BlocProvider.of<LoginBloc>(context);
    // loading;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    _emailController.clear();

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forgot Password'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Email',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),

              BlocBuilder<LoginBloc, LoginState>(
                  builder: (context, signup) {
                    return BlocListener<LoginBloc, LoginState>(
                      listener: (context, state) {
                        if (state is ForgotPasswordSuccess) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen(
                                    dropValue:
                                    dropdownValueModule,
                                  )));
                          Fluttertoast.showToast(msg: state.message);
                          loading = false;
                        }

                        if (state is ForgotPasswordFail) {
                          Fluttertoast.showToast(msg: state.message);
                        }
                      },
                      child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: AppButton(
                            loading: loading,
                            onPressed: () async {
                              // if (dropdownValueModule ==
                              //     "Machine Maintenance") {
                              //   _value = '1';
                              // } else if (dropdownValueModule ==
                              //     "Job Work Enquiry") {
                              //   _value = '2';
                              // } else if (dropdownValueModule ==
                              //     "Transportation") {
                              //   _value = '3';
                              // }
                              isconnectedToInternet =
                              await ConnectivityCheck
                                  .checkInternetConnectivity();
                              if (isconnectedToInternet == true) {

                                 if (_emailController.text ==
                                    "") {
                                  Fluttertoast.showToast(
                                      msg: "Please enter email");
                                } else if (_formKey.currentState!
                                    .validate()) {
                                  _userLoginBloc!.add(OnForgotPassword(

                                    // role: 'Job Work Enquiry',
                                    email: _emailController.text,

                                  ));
                                }
                              } else {
                                CustomDialogs.showDialogCustom(
                                    "Internet",
                                    "Please check your Internet Connection!",
                                    context);
                              }
                            },
                            text: 'Password reset',
                            color: ThemeColors.buttonColor,
                          )),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
