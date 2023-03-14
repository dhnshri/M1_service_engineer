import 'package:meta/meta.dart';
import 'package:service_engineer/Model/MachineMaintance/myTaskModel.dart';
import 'package:service_engineer/Model/MachineMaintance/quotationReply.dart';
import 'package:service_engineer/Model/product_repo.dart';
import 'package:service_engineer/Model/quotation_reply_detail_repo.dart';
import 'package:service_engineer/Model/service_request_detail_repo.dart';
import 'package:service_engineer/Model/service_request_repo.dart';

import '../../Model/JobWorkEnquiry/my_task_model.dart';
import '../../Model/JobWorkEnquiry/quotation_reply.dart';
import '../../Model/JobWorkEnquiry/service_request_model.dart';
import '../../Model/Transpotation/quotationReplyModel.dart';
import '../../Model/customer_login.dart';

@immutable
abstract class QuotationReplyState {}

class InitialQuotationReplyState extends QuotationReplyState {}


// Machine Maintaince Quotation Reply
class QuotationReplyLoading extends QuotationReplyState {
  bool isLoading;
  QuotationReplyLoading({required this.isLoading});
}
class QuotationReplyFail extends QuotationReplyState {
  final String? msg;
  QuotationReplyFail({this.msg});
}

class QuotationReplySuccess extends QuotationReplyState {
  List<QuotationReplyModel> quotationReplyListData;
  String message;
  QuotationReplySuccess({required this.quotationReplyListData, required this.message});
}

class MachineQuotationReplyDetailLoading extends QuotationReplyState {
  bool isLoading;
  MachineQuotationReplyDetailLoading({required this.isLoading});
}
class MachineQuotationReplyDetailFail extends QuotationReplyState {
  final String? msg;
  MachineQuotationReplyDetailFail({this.msg});
}

class MachineQuotationReplyDetailSuccess extends QuotationReplyState {
  List<QuotationRequiredItems> quotationRequiredItemList;
  List<QuotationRequiredItems> quotationOtherItemList;
  List<QuotationCharges> quotationChargesList;
  List<CustomerReplyMsg> quotationMsgList;

  MachineQuotationReplyDetailSuccess({required this.quotationRequiredItemList, required this.quotationOtherItemList,
  required this.quotationChargesList,required this.quotationMsgList});
}

// Job Work Enquiry Quotation Reply
class QuotationReplyJWELoading extends QuotationReplyState {
  bool isLoading;
  QuotationReplyJWELoading({required this.isLoading});
}
class QuotationReplyJWEFail extends QuotationReplyState {
  final String? msg;
  QuotationReplyJWEFail({this.msg});
}

class QuotationReplyJWESuccess extends QuotationReplyState {
  List<QuotationReplyJobWorkEnquiryModel> quotationReplyJWEListData;
  String message;
  QuotationReplyJWESuccess({required this.quotationReplyJWEListData, required this.message});
}

// Transpotation Quotation Reply
class QuotationReplyTransportLoading extends QuotationReplyState {
  bool isLoading;
  QuotationReplyTransportLoading({required this.isLoading});
}
class QuotationReplyTransportFail extends QuotationReplyState {
  final String? msg;
  QuotationReplyTransportFail({this.msg});
}

class QuotationReplyTransportSuccess extends QuotationReplyState {
  List<QuotationReplyTransportModel> quotationReplyTransportListData;
  String message;
  QuotationReplyTransportSuccess({required this.quotationReplyTransportListData, required this.message});
}