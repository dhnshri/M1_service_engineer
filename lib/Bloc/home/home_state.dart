import 'package:meta/meta.dart';
import 'package:service_engineer/Model/MachineMaintance/myTaskModel.dart';
import 'package:service_engineer/Model/product_repo.dart';
import 'package:service_engineer/Model/service_request_detail_repo.dart';
import 'package:service_engineer/Model/service_request_repo.dart';

import '../../Model/JobWorkEnquiry/my_task_model.dart';
import '../../Model/JobWorkEnquiry/service_request_model.dart';
import '../../Model/customer_login.dart';

@immutable
abstract class HomeState {}

class InitialHomeState extends HomeState {}
//Machine Maintaince Home
class ServiceRequestLoading extends HomeState {
  bool isLoading;
  ServiceRequestLoading({required this.isLoading});
}

class ServiceRequestFail extends HomeState {
  final String? msg;
  ServiceRequestFail({this.msg});
}

class ServiceRequestSuccess extends HomeState {
  List<ServiceRequestModel> serviceListData;
  String message;
  ServiceRequestSuccess({required this.serviceListData, required this.message});
}


class ServiceRequestDetailLoading extends HomeState {
  bool isLoading;
  ServiceRequestDetailLoading({required this.isLoading});
}

class ServiceRequestDetailFail extends HomeState {
  final String? msg;
  ServiceRequestDetailFail({this.msg});
}

class ServiceRequestDetailSuccess extends HomeState {
  List<MachineServiceDetailsModel> machineServiceDetail;
  String message;
  ServiceRequestDetailSuccess({required this.machineServiceDetail, required this.message});
}

class MyTaskLoading extends HomeState {
  bool isLoading;
  MyTaskLoading({required this.isLoading});
}


class MyTaskListSuccess extends HomeState {
  List<MyTaskModel> MyTaskList;
  MyTaskListSuccess({required this.MyTaskList});
}

class MyTaskListLoadFail extends HomeState {
  final String? msg;
  MyTaskListLoadFail({this.msg});
}

class ProductListLoading extends HomeState {
  bool isLoading;
  ProductListLoading({required this.isLoading});
}

class ProductListFail extends HomeState {
  final String? msg;
  ProductListFail({this.msg});
}

class ProductListSuccess extends HomeState {
  List<ProductDetails> productList;
  String message;
  ProductListSuccess({required this.productList, required this.message});
}

//Job Work Enquiry Home

class ServiceRequestJWELoading extends HomeState {
  bool isLoading;
  ServiceRequestJWELoading({required this.isLoading});
}

class ServiceRequestJWEFail extends HomeState {
  final String? msg;
  ServiceRequestJWEFail({this.msg});
}

class ServiceRequestJWESuccess extends HomeState {
  List<JobWorkEnquiryServiceRequestModel> serviceListData;
  String message;
  ServiceRequestJWESuccess({required this.serviceListData, required this.message});
}
class MyTaskJWELoading extends HomeState {
  bool isLoading;
  MyTaskJWELoading({required this.isLoading});
}


class MyTaskJWEListSuccess extends HomeState {
  List<JobWorkEnquiryMyTaskModel> MyTaskJWEList;
  MyTaskJWEListSuccess({required this.MyTaskJWEList});
}

class MyTaskJWEListLoadFail extends HomeState {
  final String? msg;
  MyTaskJWEListLoadFail({this.msg});
}