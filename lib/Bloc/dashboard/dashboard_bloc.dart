import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:service_engineer/Bloc/dashboard/dashboard_event.dart';
import 'package:service_engineer/Bloc/dashboard/dashboard_state.dart';
import 'package:service_engineer/Model/dashboard_cound_repo.dart';
import 'package:service_engineer/Repository/UserRepository.dart';




class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc({this.userRepository}) : super(InitialDashboardState());
  final UserRepository? userRepository;


  @override
  Stream<DashboardState> mapEventToState(event) async* {


    ///Machine DashBoard Count
    if (event is GetDashboardCount) {
      ///Notify loading to UI
      yield DashboardCountLoading(
        isLoading: false,
      );

      ///Fetch API via repository
      final DashboardCountRepo result = await userRepository!.fetchMachineDashboardCount(
        serviceUserId: event.serviceUserId
      );
      print(result);

      ///Case API fail but not have token
      if (result.success == true) {

        try {

          yield DashboardCountLoading(
            isLoading: true,
          );
          yield DashboardCountSuccess(totalServiceDone: result.totalServiceDoneCount!.toInt(),totalEarning: result.totalEarningCount!.toInt(),
            totalPaymentPending: result.totalPendingPaymentCount!.toInt(),totalPaymentReceived: result.totalReceicedPaymentCount!.toInt());
        } catch (error) {
          ///Notify loading to UI
          yield DashboardCountLoading(isLoading: false,);
          yield DashboardCountFail(msg: result.msg);
        }
      } else {
        ///Notify loading to UI
        yield DashboardCountLoading(isLoading: false,);
        yield DashboardCountFail(msg: result.msg);
      }
    }

    ///Jobwork Dashboard count
    if (event is GetJobWorkDashboardCount) {
      ///Notify loading to UI
      yield DashboardCountLoading(
        isLoading: false,
      );

      ///Fetch API via repository
      final DashboardCountRepo result = await userRepository!.fetchJobWorkDashboardCount(
          serviceUserId: event.serviceUserId
      );
      print(result);

      ///Case API fail but not have token
      if (result.success == true) {

        try {

          yield DashboardCountLoading(
            isLoading: true,
          );
          yield DashboardCountSuccess(totalServiceDone: result.totalServiceDoneCount!.toInt(),totalEarning: result.totalEarningCount!.toInt(),
              totalPaymentPending: result.totalPendingPaymentCount!.toInt(),totalPaymentReceived: result.totalReceicedPaymentCount!.toInt());
        } catch (error) {
          ///Notify loading to UI
          yield DashboardCountLoading(isLoading: false,);
          yield DashboardCountFail(msg: result.msg);
        }
      } else {
        ///Notify loading to UI
        yield DashboardCountLoading(isLoading: false,);
        yield DashboardCountFail(msg: result.msg);
      }
    }


    ///Transport Dashboard count
    if (event is GetTransportDashboardCount) {
      ///Notify loading to UI
      yield DashboardCountLoading(
        isLoading: false,
      );

      ///Fetch API via repository
      final DashboardCountRepo result = await userRepository!.fetchTransportDashboardCount(
          serviceUserId: event.serviceUserId
      );
      print(result);

      ///Case API fail but not have token
      if (result.success == true) {

        try {

          yield DashboardCountLoading(
            isLoading: true,
          );
          yield DashboardCountSuccess(totalServiceDone: result.totalServiceDoneCount!.toInt(),totalEarning: result.totalEarningCount!.toInt(),
              totalPaymentPending: result.totalPendingPaymentCount!.toInt(),totalPaymentReceived: result.totalReceicedPaymentCount!.toInt());
        } catch (error) {
          ///Notify loading to UI
          yield DashboardCountLoading(isLoading: false,);
          yield DashboardCountFail(msg: result.msg);
        }
      } else {
        ///Notify loading to UI
        yield DashboardCountLoading(isLoading: false,);
        yield DashboardCountFail(msg: result.msg);
      }
    }


  }

// yield LogoutSuccess();
}



