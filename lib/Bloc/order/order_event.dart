abstract class OrderEvent {}

class GetOrderList extends OrderEvent {

  String serviceUserId;

  GetOrderList({required this.serviceUserId});
}

class GetOrderDetail extends OrderEvent {
  String serviceUserId;
  String machineEnquiryId;

  GetOrderDetail({required this.serviceUserId,required this.machineEnquiryId});
}

class MachineQuotationReplyDetail extends OrderEvent {

  String machineEnquiryId;
  String customerUserId;

  MachineQuotationReplyDetail({required this.machineEnquiryId,required this.customerUserId});

}

class ProductList extends OrderEvent {

  String prodId,offSet,brandId,priceId,catId;

  ProductList({required this.prodId,required this.offSet,required this.brandId,required this.priceId,required this.catId});
}

class OnServiceRequestDetail extends OrderEvent {

  String userID,machineEnquiryId,jobWorkEnquiryId,transportEnquiryId;

  OnServiceRequestDetail({required this.userID,required this.machineEnquiryId, required this.jobWorkEnquiryId, required this.transportEnquiryId});

}

class CancelOrder extends OrderEvent {
  String serviceUserId;
  String machineEnquiryId;
  CancelOrder({required this.serviceUserId,required this.machineEnquiryId});
}