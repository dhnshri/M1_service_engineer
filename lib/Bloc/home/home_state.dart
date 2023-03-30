import 'package:meta/meta.dart';
import 'package:service_engineer/Model/MachineMaintance/myTaskModel.dart';
import 'package:service_engineer/Model/MachineMaintance/quotationReply.dart';
import 'package:service_engineer/Model/cart_list_repo.dart';
import 'package:service_engineer/Model/filter_repo.dart';
import 'package:service_engineer/Model/product_repo.dart';
import 'package:service_engineer/Model/quotation_reply_detail_repo.dart';
import 'package:service_engineer/Model/service_request_detail_repo.dart';
import 'package:service_engineer/Model/service_request_repo.dart';
import 'package:service_engineer/Model/track_model.dart';
import 'package:service_engineer/Model/track_process_repo.dart';

import '../../Model/JobWorkEnquiry/my_task_detail_model.dart';
import '../../Model/JobWorkEnquiry/my_task_model.dart';
import '../../Model/JobWorkEnquiry/service_request_detail_model.dart';
import '../../Model/JobWorkEnquiry/service_request_model.dart';
import '../../Model/JobWorkEnquiry/task_hand_over_jwe_model.dart';
import '../../Model/JobWorkEnquiry/track_process_report_model.dart';
import '../../Model/MachineMaintance/task_hand_over_model.dart';
import '../../Model/Transpotation/MyTaskTransportDetailModel.dart';
import '../../Model/Transpotation/myTaskListModel.dart';
import '../../Model/Transpotation/serviceRequestDetailModel.dart';
import '../../Model/Transpotation/serviceRequestListModel.dart';
import '../../Model/Transpotation/transport_task_hand_over_model.dart';
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

class MachineHandOverServiceRequestListLoading extends HomeState {
  bool isLoading;
  MachineHandOverServiceRequestListLoading({required this.isLoading});
}

class MachineHandOverServiceRequestListFail extends HomeState {
  final String? msg;
  MachineHandOverServiceRequestListFail({this.msg});
}

class MachineHandOverServiceRequestListSuccess extends HomeState {
  List<ServiceRequestModel> serviceListData;
  String message;
  MachineHandOverServiceRequestListSuccess({required this.serviceListData, required this.message});
}

class MachineHandOverTaskDetailLoading extends HomeState {
  bool isLoading;
  MachineHandOverTaskDetailLoading({required this.isLoading});
}

class MachineHandOverTaskDetailFail extends HomeState {
  final String? msg;
  MachineHandOverTaskDetailFail({this.msg});
}

class MachineHandOverTaskDetailSuccess extends HomeState {
  List<HandOverTaskDetailModel> serviceListData;
  MachineHandOverTaskDetailSuccess({required this.serviceListData,});
}

class JobWorkHandOverServiceRequestListLoading extends HomeState {
  bool isLoading;
  JobWorkHandOverServiceRequestListLoading({required this.isLoading});
}

class JobWorkHandOverServiceRequestListFail extends HomeState {
  final String? msg;
  JobWorkHandOverServiceRequestListFail({this.msg});
}

class JobWorkHandOverServiceRequestListSuccess extends HomeState {
  List<JobWorkEnquiryMyTaskModel> serviceListData;
  String message;
  JobWorkHandOverServiceRequestListSuccess({required this.serviceListData, required this.message});
}

class TransportHandOverServiceRequestListLoading extends HomeState {
  bool isLoading;
  TransportHandOverServiceRequestListLoading({required this.isLoading});
}

class TransportHandOverServiceRequestListFail extends HomeState {
  final String? msg;
  TransportHandOverServiceRequestListFail({this.msg});
}

class TransportHandOverServiceRequestListSuccess extends HomeState {
  List<JobWorkEnquiryMyTaskModel> serviceListData;
  String message;
  TransportHandOverServiceRequestListSuccess({required this.serviceListData, required this.message});
}

class AcceptRejectHandoverLoading extends HomeState {
  bool isLoading;
  AcceptRejectHandoverLoading({required this.isLoading});
}

class AcceptRejectHandoverFail extends HomeState {
  final String? msg;
  AcceptRejectHandoverFail({this.msg});
}

class AcceptRejectHandoverSuccess extends HomeState {
  String message;
  AcceptRejectHandoverSuccess({required this.message});
}


class BrandFilterLoading extends HomeState {
  bool isLoading;
  BrandFilterLoading({required this.isLoading});
}

class BrandFilterFail extends HomeState {
  final String? msg;
  BrandFilterFail({this.msg});
}

class BrandFilterSuccess extends HomeState {
  List<FilterModule> brandListData;
  BrandFilterSuccess({required this.brandListData,});
}

class CategoryFilterLoading extends HomeState {
  bool isLoading;
  CategoryFilterLoading({required this.isLoading});
}

class CategoryFilterFail extends HomeState {
  final String? msg;
  CategoryFilterFail({this.msg});
}

class CategoryFilterSuccess extends HomeState {
  List<FilterModule> categoryListData;
  CategoryFilterSuccess({required this.categoryListData,});
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

class ServiceRequestJobWorkEnquryDetailLoading extends HomeState {
  bool isLoading;
  ServiceRequestJobWorkEnquryDetailLoading({required this.isLoading});
}

class ServiceRequestJobWorkEnquryDetailFail extends HomeState {
  final String? msg;
  ServiceRequestJobWorkEnquryDetailFail({this.msg});
}

class ServiceRequestJobWorkEnquryDetailSuccess extends HomeState {
  List<JobWorkEnquiryDetailsModel> jobWorkEnquryServiceDetail;
  String message;
  ServiceRequestJobWorkEnquryDetailSuccess({required this.jobWorkEnquryServiceDetail, required this.message});
}

class MyTaskTranspotationDetailLoading extends HomeState {
  bool isLoading;
  MyTaskTranspotationDetailLoading({required this.isLoading});
}

class MyTaskTranspotationDetailFail extends HomeState {
  final String? msg;
  MyTaskTranspotationDetailFail({this.msg});
}

class MyTaskTranspotationDetailSuccess extends HomeState {
  List<TransportMyTaskDetailsModel> transportMyTaskDetail;
  String message;
  MyTaskTranspotationDetailSuccess({required this.transportMyTaskDetail, required this.message});
}

class TransportQuotationReplyDetailLoading extends HomeState {
  bool isLoading;
  TransportQuotationReplyDetailLoading({required this.isLoading});
}
class TransportQuotationReplyDetailFail extends HomeState {
  final String? msg;
  TransportQuotationReplyDetailFail({this.msg});
}

class TransportQuotationReplyDetailSuccess extends HomeState {
  List<VehicleDetails> vehicleDetailsList;
  List<QuotationCharges> quotationDetailsList;
  List<QuotationCharges> quotationChargesList;
  List<CustomerReplyMsg> quotationMsgList;
  TransportQuotationReplyDetailSuccess({required this.vehicleDetailsList,required this.quotationDetailsList,
    required this.quotationChargesList,required this.quotationMsgList});
}

class MyTaskJobWorkEnquiryDetailLoading extends HomeState {
  bool isLoading;
  MyTaskJobWorkEnquiryDetailLoading({required this.isLoading});
}

class MyTaskJobWorkEnquiryDetailFail extends HomeState {
  final String? msg;
  MyTaskJobWorkEnquiryDetailFail({this.msg});
}

class MyTaskJobWorkEnquiryDetailSuccess extends HomeState {
  List<MyTaskEnquiryDetails> MyTaskDetail;
  String message;
  MyTaskJobWorkEnquiryDetailSuccess({required this.MyTaskDetail, required this.message});
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

class TransportUpdateProcessLoading extends HomeState {
  bool isLoading;
  TransportUpdateProcessLoading({required this.isLoading});
}

class TransportUpdateProcessFail extends HomeState {
  final String? msg;
  TransportUpdateProcessFail({this.msg});
}

class TransportUpdateProcessSuccess extends HomeState {
  String message;
  TransportUpdateProcessSuccess({required this.message});
}

class TransportGetProcessLoading extends HomeState {
  bool isLoading;
  TransportGetProcessLoading({required this.isLoading});
}

class TransportGetProcessFail extends HomeState {
  final String? msg;
  TransportGetProcessFail({this.msg});
}

class TransportGetProcessSuccess extends HomeState {
  String message;
  List<TrackDataModel> trackData;
  TransportGetProcessSuccess({required this.message,required this.trackData});
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
// For Machine Maintaince
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

// For Transpotation
class TrackProcssListTransportLoading extends HomeState {
  bool isLoading;
  TrackProcssListTransportLoading({required this.isLoading});
}

class TrackProcssListTransportFail extends HomeState {
  final String? msg;
  TrackProcssListTransportFail({this.msg});
}

class TrackProcssListTransportSuccess extends HomeState {
  List<TrackProcessModel> trackProgressList;
  String message;
  TrackProcssListTransportSuccess({required this.trackProgressList,required this.message});
}

class JobWorkQuotationReplyDetailLoading extends HomeState {
  bool isLoading;
  JobWorkQuotationReplyDetailLoading({required this.isLoading});
}
class JobWorkQuotationReplyDetailFail extends HomeState {
  final String? msg;
  JobWorkQuotationReplyDetailFail({this.msg});
}

class JobWorkQuotationReplyDetailSuccess extends HomeState {
  List<QuotationRequiredItems> quotationRequiredItemList;
  List<QuotationCharges> quotationChargesList;
  List<CustomerReplyMsg> quotationMsgList;

  JobWorkQuotationReplyDetailSuccess({required this.quotationRequiredItemList,
    required this.quotationChargesList,required this.quotationMsgList});
}

//For Job Work Enquiry
class TrackProcssJWEListLoading extends HomeState {
  bool isLoading;
  TrackProcssJWEListLoading({required this.isLoading});
}

class TrackProcssJWEListFail extends HomeState {
  final String? msg;
  TrackProcssJWEListFail({this.msg});
}

class TrackProcssJWEListSuccess extends HomeState {
  List<TrackProcessJobWorkEnquiryModel> trackProgressList;
  String message;
  TrackProcssJWEListSuccess({required this.trackProgressList,required this.message});
}
// Machine Maintaince
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
// Transportation
class CreateTaskTransportLoading extends HomeState {
  bool isLoading;
  CreateTaskTransportLoading({required this.isLoading});
}

class CreateTaskTransportFail extends HomeState {
  final String? msg;
  CreateTaskTransportFail({this.msg});
}

class CreateTaskTransportSuccess extends HomeState {
  String message;
  CreateTaskTransportSuccess({required this.message});
}

// Job Work Enquiry Create Task

class CreateTaskJWELoading extends HomeState {
  bool isLoading;
  CreateTaskJWELoading({required this.isLoading});
}

class CreateTaskJWEFail extends HomeState {
  final String? msg;
  CreateTaskJWEFail({this.msg});
}

class CreateTaskJWESuccess extends HomeState {
  String message;
  CreateTaskJWESuccess({required this.message});
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

class TaskCompleteJWELoading extends HomeState {
  bool isLoading;
  TaskCompleteJWELoading({required this.isLoading});
}

class TaskCompleteJWEFail extends HomeState {
  final String? msg;
  TaskCompleteJWEFail({this.msg});
}

class TaskCompleteJWESuccess extends HomeState {
  String message;
  TaskCompleteJWESuccess({required this.message});
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
// 

class JobWorkSendQuotationLoading extends HomeState {
  bool isLoading;
  JobWorkSendQuotationLoading({required this.isLoading});
}

class JobWorkSendQuotationFail extends HomeState {
  final String? msg;
  JobWorkSendQuotationFail({this.msg});
}

class JobWorkSendQuotationSuccess extends HomeState {
  String message;
  JobWorkSendQuotationSuccess({required this.message});
}
// Transpotation
class TranspotationSendQuotationLoading extends HomeState {
  bool isLoading;
  TranspotationSendQuotationLoading({required this.isLoading});
}

class TranspotationSendQuotationFail extends HomeState {
  final String? msg;
  TranspotationSendQuotationFail({this.msg});
}

class TranspotationSendQuotationSuccess extends HomeState {
  String message;
  TranspotationSendQuotationSuccess({required this.message});
}

// Machine maintaince Task handover
class TaskHandOverLoading extends HomeState {

  bool isLoading;
  TaskHandOverLoading({required this.isLoading});
}

class TaskHandOverFail extends HomeState {
  final String? msg;
  TaskHandOverFail({this.msg});
}

class TaskHandOverSuccess extends HomeState {
  List<MachineMaintanceTaskHandOverModel> serviceListData;
  String message;
  TaskHandOverSuccess({required this.message,required this.serviceListData});
}

// Transport Task handover
class TransportTaskHandOverLoading extends HomeState {

  bool isLoading;
  TransportTaskHandOverLoading({required this.isLoading});
}

class TransportTaskHandOverFail extends HomeState {
  final String? msg;
  TransportTaskHandOverFail({this.msg});
}

class TransportTaskHandOverSuccess extends HomeState {
  List<TransportTaskHandOverModel> serviceListTransportData;
  String message;
  TransportTaskHandOverSuccess({required this.message,required this.serviceListTransportData});
}

// Job Work Enquiry Task handover
class JobWorkEnquiryTaskHandOverLoading extends HomeState {

  bool isLoading;
  JobWorkEnquiryTaskHandOverLoading({required this.isLoading});
}

class JobWorkEnquiryTaskHandOverFail extends HomeState {
  final String? msg;
  JobWorkEnquiryTaskHandOverFail({this.msg});
}

class JobWorkEnquiryTaskHandOverSuccess extends HomeState {
  List<JobWorkEnquiryTaskHandOverModel> serviceListJWEData;
  String message;
  JobWorkEnquiryTaskHandOverSuccess({required this.message,required this.serviceListJWEData});
}