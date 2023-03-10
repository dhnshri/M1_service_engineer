

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
// jOB transpotation QuotationReply

class OnQuotationReplyTranspotationList extends QuotationReplyEvent {

  String offSet;
  String service_user_id;

  OnQuotationReplyTranspotationList({required this.offSet,required this.service_user_id});

}