

import 'package:flutter/cupertino.dart';

import '../../Model/JobWorkEnquiry/service_request_detail_model.dart';
import '../../Model/quotation_reply_detail_repo.dart';

abstract class QuotationReplyEvent {}
// Machine Maintaince QuotationReply

class OnQuotationReplyMachineMaintainceList extends QuotationReplyEvent {

  String offSet;
  String userId;

  OnQuotationReplyMachineMaintainceList({required this.offSet,required this.userId});

}
// jOB wORK eNQUIRY QuotationReply

class OnQuotationReplyJWEList extends QuotationReplyEvent {

  String offSet;
  String userId;

  OnQuotationReplyJWEList({required this.offSet,required this.userId});

}

class MachineQuotationReplyDetail extends QuotationReplyEvent {

  String machineEnquiryId;
  String customerUserId;

  MachineQuotationReplyDetail({required this.machineEnquiryId,required this.customerUserId});

}

class JobWorkQuotationReplyDetail extends QuotationReplyEvent {

  String jobWorkEnquiryId;
  String customerUserId;

  JobWorkQuotationReplyDetail({required this.jobWorkEnquiryId,required this.customerUserId});

}

class TransportQuotationReplyDetail extends QuotationReplyEvent {
  String transportEnquiryId;
  String customerUserId;
  TransportQuotationReplyDetail({required this.transportEnquiryId,required this.customerUserId});
}

// jOB transpotation QuotationReply

class OnQuotationReplyTranspotationList extends QuotationReplyEvent {

  String offSet;
  String service_user_id;

  OnQuotationReplyTranspotationList({required this.offSet,required this.service_user_id});

}

class JobWorkSendRevisedQuotation extends QuotationReplyEvent {

  String serviceUserId;
  String jobWorkEnquiryId;
  String jobWorkEnquirydate;
  String packingCharge;
  String testingCharge;
  String transportCharge;
  List<TextEditingController> itemRateController;
  List<TextEditingController> volumeController;
  List<QuotationRequiredItems> itemList;
  String cgst;
  String sgst;
  String igst;
  String commission;

  JobWorkSendRevisedQuotation({ required this.serviceUserId, required this.jobWorkEnquiryId, required this.jobWorkEnquirydate,
    required this.packingCharge,required this.testingCharge,required this.transportCharge,required this.itemList,
    required this.commission,required this.cgst, required this.sgst,required this.igst,required this.itemRateController,
    required this.volumeController});

}