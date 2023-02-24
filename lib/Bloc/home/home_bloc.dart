import 'dart:async';


import 'package:bloc/bloc.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:service_engineer/Model/service_request_repo.dart';
import 'package:service_engineer/Repository/UserRepository.dart';
import 'package:service_engineer/main.dart';



import '../../app_bloc.dart';
import '../authentication/authentication_event.dart';
import 'Home_event.dart';
import 'Home_state.dart';


class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({this.userRepository}) : super(InitialHomeState());
  final UserRepository? userRepository;


  @override
  Stream<HomeState> mapEventToState(event) async* {


    ///Event for Home
    if (event is OnServiceRequest) {
      ///Notify loading to UI
      yield HomeLoading();

      ///Fetch API via repository
      final ServiceRequestRepo result = await userRepository!
          .fetchServiceRequestList(
        offSet: event.offSet,
        statusID: event.statusID,
        userID: event.userID,
      );
      print(result);

      ///Case API fail but not have token
      if (result.success == true) {
        ///Home API success
        // final  VendorHome user = VendorHome.fromJson(result.data);
        ServiceRequestModel user = new ServiceRequestModel();
        // user.status = user.status!.toInt();
        user = result.data!;
        try {
          ///Begin start AuthBloc Event AuthenticationSave

          // yield HomeSuccess(userModel: user, message: "Home Successfully");
        } catch (error) {
          ///Notify loading to UI
          yield HomeFail(msg: "Home Fail");
        }
      } else {
        ///Notify loading to UI
        yield HomeFail(msg: "Home Fail");
      }
    }
  }


}
