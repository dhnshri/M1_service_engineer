import 'package:meta/meta.dart';
import 'package:service_engineer/Model/MachineMaintance/myTaskModel.dart';
import 'package:service_engineer/Model/MachineMaintance/quotationReply.dart';
import 'package:service_engineer/Model/cart_list_repo.dart';
import 'package:service_engineer/Model/product_repo.dart';
import 'package:service_engineer/Model/service_request_detail_repo.dart';
import 'package:service_engineer/Model/service_request_repo.dart';
import 'package:service_engineer/Model/track_process_repo.dart';

import '../../Model/JobWorkEnquiry/my_task_model.dart';
import '../../Model/JobWorkEnquiry/service_request_model.dart';
import '../../Model/Transpotation/myTaskListModel.dart';
import '../../Model/Transpotation/serviceRequestDetailModel.dart';
import '../../Model/Transpotation/serviceRequestListModel.dart';
import '../../Model/customer_login.dart';

@immutable
abstract class HomeState {}

class InitialHomeState extends HomeState {}
//********* Machine Maintaince Home ***********
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

//Machine Maintaince My Task

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

// Transpotation

class ServiceRequestTranspotationLoading extends HomeState {
  bool isLoading;
  ServiceRequestTranspotationLoading({required this.isLoading});
}

class ServiceRequestTranspotationFail extends HomeState {
  final String? msg;
  ServiceRequestTranspotationFail({this.msg});
}

class ServiceRequestTranspotationSuccess extends HomeState {
  List<ServiceRequestTranspotationModel> serviceListData;
  String message;
  ServiceRequestTranspotationSuccess({required this.serviceListData, required this.message});
}

class MyTaskTranspotationLoading extends HomeState {
  bool isLoading;
  MyTaskTranspotationLoading({required this.isLoading});
}


class MyTaskTranspotationListSuccess extends HomeState {
  List<MyTaskTransportationModel> MyTaskList;
  MyTaskTranspotationListSuccess({required this.MyTaskList});
}

class MyTaskTranspotationListLoadFail extends HomeState {
  final String? msg;
  MyTaskTranspotationListLoadFail({this.msg});
}

class ServiceRequestTranspotationDetailLoading extends HomeState {
  bool isLoading;
  ServiceRequestTranspotationDetailLoading({required this.isLoading});
}

class ServiceRequestTranspotationDetailFail extends HomeState {
  final String? msg;
  ServiceRequestTranspotationDetailFail({this.msg});
}

class ServiceRequestTranspotationDetailSuccess extends HomeState {
  List<TransportDetailsModel> transportServiceDetail;
  String message;
  ServiceRequestTranspotationDetailSuccess({required this.transportServiceDetail, required this.message});
}


class AddToCartLoading extends HomeState {
  bool isLoading;
  AddToCartLoading({required this.isLoading});
}

class AddToCartFail extends HomeState {
  final String? msg;
  AddToCartFail({this.msg});
}

class AddToCartSuccess extends HomeState {
  String message;
  AddToCartSuccess({required this.message});
}

class CartListLoading extends HomeState {
  bool isLoading;
  CartListLoading({required this.isLoading});
}

class CartListFail extends HomeState {
  final String? msg;
  CartListFail({this.msg});
}

class CartListSuccess extends HomeState {
  List<CartListModel> cartList;
  String message;
  CartListSuccess({required this.cartList,required this.message});
}

class TrackProcssListLoading extends HomeState {
  bool isLoading;
  TrackProcssListLoading({required this.isLoading});
}

class TrackProcssListFail extends HomeState {
  final String? msg;
  TrackProcssListFail({this.msg});
}

class TrackProcssListSuccess extends HomeState {
  List<TrackProcessModel> trackProgressList;
  String message;
  TrackProcssListSuccess({required this.trackProgressList,required this.message});
}

class CreateTaskLoading extends HomeState {
  bool isLoading;
  CreateTaskLoading({required this.isLoading});
}

class CreateTaskFail extends HomeState {
  final String? msg;
  CreateTaskFail({this.msg});
}

class CreateTaskSuccess extends HomeState {
  String message;
  CreateTaskSuccess({required this.message});
}

class TaskCompleteLoading extends HomeState {
  bool isLoading;
  TaskCompleteLoading({required this.isLoading});
}

class TaskCompleteFail extends HomeState {
  final String? msg;
  TaskCompleteFail({this.msg});
}

class TaskCompleteSuccess extends HomeState {
  String message;
  TaskCompleteSuccess({required this.message});
}

class SendQuotationLoading extends HomeState {
  bool isLoading;
  SendQuotationLoading({required this.isLoading});
}

class SendQuotationFail extends HomeState {
  final String? msg;
  SendQuotationFail({this.msg});
}

class SendQuotationSuccess extends HomeState {
  String message;
  SendQuotationSuccess({required this.message});
}