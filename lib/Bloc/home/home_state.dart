
import 'package:meta/meta.dart';
import 'package:service_engineer/Model/service_request_repo.dart';

import '../../Model/customer_login.dart';


@immutable
abstract class HomeState {}

class InitialHomeState extends HomeState {}

class HomeLoading extends HomeState {}

class HomeFail extends HomeState {
  final String? msg;

  HomeFail({this.msg});
}

class HomeSuccess extends HomeState {
  List<ServiceRequestModel> serviceListData;
  String message;
  HomeSuccess({required this.serviceListData,required this.message});
}