
import 'package:meta/meta.dart';
import 'package:service_engineer/Model/service_request_repo.dart';

import '../../Model/customer_login.dart';


@immutable
abstract class HomeState {}

class InitialHomeState extends HomeState {}

class ServiceRequestLoading extends HomeState {}

class ServiceRequestFail extends HomeState {
  final String? msg;
  ServiceRequestFail({this.msg});
}

class ServiceRequestSuccess extends HomeState {
  List<ServiceRequestModel> serviceListData;
  String message;
  ServiceRequestSuccess({required this.serviceListData,required this.message});
}