

abstract class QuotationReplyEvent {}
// Machine Maintaince QuotationReply

class OnQuotationReplyMachineMaintainceList extends QuotationReplyEvent {

  String offSet;

  OnQuotationReplyMachineMaintainceList({required this.offSet});

}
// jOB wORK eNQUIRY QuotationReply

class OnQuotationReplyJWEList extends QuotationReplyEvent {

  String offSet;

  OnQuotationReplyJWEList({required this.offSet});

}
// jOB transpotation QuotationReply

class OnQuotationReplyTranspotationList extends QuotationReplyEvent {

  String offSet;
  String service_user_id;

  OnQuotationReplyTranspotationList({required this.offSet,required this.service_user_id});

}