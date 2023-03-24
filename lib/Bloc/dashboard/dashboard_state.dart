import 'package:meta/meta.dart';

@immutable
abstract class DashboardState {}

class InitialDashboardState extends DashboardState {}

class DashboardCountLoading extends DashboardState {
  bool isLoading;
  DashboardCountLoading({required this.isLoading});
}

class DashboardCountFail extends DashboardState {
  final String? msg;

  DashboardCountFail({this.msg});
}

class DashboardCountSuccess extends DashboardState {
  int totalServiceDone;
  int totalEarning;
  int totalPaymentPending;
  int totalPaymentReceived;
  DashboardCountSuccess({required this.totalServiceDone,required this.totalEarning,required this.totalPaymentPending,required this.totalPaymentReceived});
}

