import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:service_engineer/main.dart';
import '../../Model/customer_login.dart';
import '../../Repository/UserRepository.dart';
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
    //   if (event is OnRegistration) {
    //     yield VendorRegistrationLoading();
    //
    //
    //     MultipartRequest request = new MultipartRequest(
    //         'POST', Uri.parse(Api.VENDOR_Registration));
    //     request.fields['user_type'] = event.userType;
    //     request.fields['full_name'] = event.fullName;
    //     request.fields['cat_id'] = event.catId;
    //     request.fields['subcat_id'] = event.subId;
    //     request.fields['subsubcat_id'] = event.subSubId;
    //     request.fields['bussiness_name'] = event.businessName;
    //     request.fields['ownership_type'] = event.ownershipType;
    //     request.fields['est_year'] = event.estYear;
    //     request.fields['tot_employee'] = event.totalEmp;
    //     request.fields['annual_turnover'] = event.annualTurnover;
    //     request.fields['gst_no'] = event.gSTIN;
    //     request.fields['address'] = event.address;
    //     request.fields['pin_code'] = event.pinCode;
    //     request.fields['mobile_no'] = event.mobile;
    //     request.fields['email'] = event.email;
    //     request.fields['refer_by'] = event.referby;
    //
    //     List<MultipartFile> imageUpload = <MultipartFile>[];
    //
    //     final multipartFile = await http.MultipartFile.fromPath(
    //       'com_logo', event.comLogo!.imagePath.toString(),
    //       // contentType: MediaType(mimeTypeData[0], mimeTypeData[1])
    //     );
    //
    //     imageUpload.add(multipartFile);
    //     request.files.addAll(imageUpload);
    //     final streamedResponse = await request.send();
    //     final response = await http.Response.fromStream(streamedResponse);
    //     var resp = json.decode(response.body);
    //     try {
    //       if (resp['result'] == 'Success') {
    //         yield VendorRegistrationSuccess(msg: resp['Message']);
    //       }else{
    //         yield VendorRegistrationFail(msg: resp['Message']);
    //
    //       }
    //     } catch (e) {
    //       yield VendorRegistrationFail(msg: resp['Message']);
    //       rethrow;
    //     }
    //   }
    //
     }

    // yield LogoutSuccess();
  }



