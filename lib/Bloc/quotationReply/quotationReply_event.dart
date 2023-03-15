

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