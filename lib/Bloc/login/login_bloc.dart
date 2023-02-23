import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:service_engineer/main.dart';



import '../../Api/api.dart';
import '../../Model/customer_login.dart';
import '../../Repository/UserRepository.dart';
import '../../Utils/application.dart';

//for multipart
import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

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
          yield LoginFail(msg: "Login Fail");
        }
      } else {
        ///Notify loading to UI
        yield LoginFail(msg: "Login Fail");
      }
    }


    //   ///Event for logout
    //   if (event is OnLogout) {
    //     yield LogoutLoading();
    //
    //
    //           final deletePreferences = await userRepository!.deleteUser();
    //
    //           ///Clear user Storage user via repository
    //           Application.preferences = null;
    //           // Application.cartModel = null;
    //
    //           /////updated on 10/02/2021
    //           if (deletePreferences) {
    //             yield LogoutSuccess();
    //           } else {
    //             final String message = "Cannot delete user data to storage phone";
    //             throw Exception(message);
    //           }
    //         }
    //         else{
    //           ///Notify loading to UI
    //           yield LogoutFail("error");
    //         }
    //
    //
    //
    if (event is OnRegistration) {
      yield CustomerRegistrationLoading();

      Map<String,dynamic> params={
        'name':event.fullname,
        'password':event.createPassword,
        'password_confirmation':event.reCreatePassword,
        'email':event.email,
        'mobile':event.mobileNo,
        'role':event.role,
      };

      var response=await http.post(Uri.parse(Api.CUSTOMER_REGISTER),body: params);

      try {
        var resp = json.decode(response.body);
        if (response.statusCode == 200) {
          yield CustomerRegistrationSuccess(msg: resp['message']);
        }else{
          yield CustomerRegistrationFail(msg: resp['message']);

        }
      } catch (e) {
        print(e);
      }
    }
     }

    // yield LogoutSuccess();
  }



