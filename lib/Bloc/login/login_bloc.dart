import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:service_engineer/Model/forgot_password_model.dart';
import 'package:service_engineer/main.dart';




import '../../Model/customer_login.dart';
import '../../Model/customer_registration.dart';
import '../../Repository/UserRepository.dart';
import '../../Utils/application.dart';

//for multipart
import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:service_engineer/main.dart';
import '../../app_bloc.dart';
import '../authentication/authentication_event.dart';
import 'login_event.dart';
import 'login_state.dart';


class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({this.userRepository}) : super(InitialLoginState());
  final UserRepository? userRepository;


  @override
  Stream<LoginState> mapEventToState(event) async* {


    ///Event for login
    if (event is OnLogin) {
      ///Notify loading to UI
      yield LoginLoading();
      var fcmToken = await FirebaseMessaging.instance.getToken();
      print(fcmToken);

      String deviceId = await getUniqueDeviceId();
      print(deviceId);

      ///Fetch API via repository
      final CustomerLoginRepo result = await userRepository!.login(
          username: event.username,
        password: event.password,
        token: fcmToken,
        deviceID: deviceId
      );
      print(result);

      ///Case API fail but not have token
      if (result.success == true) {
        ///Login API success
        // final  VendorLogin user = VendorLogin.fromJson(result.data);
        CustomerLogin user = new CustomerLogin();
        // user.status = user.status!.toInt();
        user = result.data!;
        AppBloc.authBloc.add(OnSaveUser(user));
        try {
          ///Begin start AuthBloc Event AuthenticationSave
          yield LoginSuccess(userModel: user, message: "Login Successfully");
        } catch (error) {
          ///Notify loading to UI
          yield LoginFail(msg: "Please Enter Correct Username and Password");
        }
      } else {
        ///Notify loading to UI
        yield LoginFail(msg: "Please Enter Correct Username and Password");
      }
    }


      ///Event for logout
      if (event is OnLogout) {
        yield LogoutLoading();


              final deletePreferences = await userRepository!.deleteUser();

              ///Clear user Storage user via repository
              Application.preferences = null;
              // Application.cartModel = null;

              /////updated on 10/02/2021
              if (deletePreferences) {
                yield LogoutSuccess();
              } else {
                final String message = "Cannot delete user data to storage phone";
                throw Exception(message);
              }
            }
            else{
              ///Notify loading to UI
              yield LogoutFail("error");
            }

            //On Forgot Password

    if (event is OnForgotPassword) {
      yield ForgotPasswordLoading(
        isLoading: false,
      );

      final ForgotPasswordRepo result = await userRepository!.fetchForgotPassword(
        email:event.email,
      );
      print(result.message);
      if (result.success == true) {
        try {
          ///Begin start AuthBloc Event AuthenticationSave
          yield ForgotPasswordLoading(
            isLoading: true,
          );
          yield ForgotPasswordSuccess(message: result.message.toString());
        } catch (error) {
          ///Notify loading to UI
          yield ForgotPasswordLoading(
            isLoading: true,
          );
          yield ForgotPasswordFail(message: result.message.toString());
        }
      } else {
        ///Notify loading to UI
        yield ForgotPasswordLoading(isLoading: true);
        yield ForgotPasswordFail(message: result.message.toString());
      }
    }

    // On Registration

    if (event is OnRegistration) {
      yield CustomerRegistrationLoading();

      final RegistrationRepo result = await userRepository!.registration(
        fullname:event.fullname,
        createPassword:event.createPassword,
        reCreatePassword:event.reCreatePassword,
        email:event.email,
        mobileNo:event.mobileNo,
        role:event.role,
        username:event.username,
      );
      print(result.message);
      if (result.message == "Service User successfully registered") {
     // if (result.message == null) {
        ///Login API success
        RegistrationModel user = RegistrationModel();
       // RegistrationModel user = new RegistrationModel();
       //  user.status = user.status!.toInt();
        user = result.user!;
        print(user);
      //  AppBloc.authBloc.add(OnSaveUser(user));
        try {
          ///Begin start AuthBloc Event AuthenticationSave

          yield CustomerRegistrationSuccess(msg: result.message);
        } catch (error) {
          ///Notify loading to UI
          yield CustomerRegistrationFail(msg: result.message);
        }
      } else {
        ///Notify loading to UI
        yield CustomerRegistrationFail(msg: result.message);
      }
    }

     }

    // yield LogoutSuccess();
  }



