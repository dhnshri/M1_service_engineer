import 'package:meta/meta.dart';
import 'package:service_engineer/Model/order_list_repo.dart';
import 'package:service_engineer/Model/order_repo.dart';
import 'package:service_engineer/Model/product_repo.dart';
import 'package:service_engineer/Model/quotation_reply_detail_repo.dart';
import 'package:service_engineer/Model/service_request_detail_repo.dart';
import 'package:service_engineer/Model/service_request_repo.dart';

@immutable
abstract class OrderState {}

class InitialOrderState extends OrderState {}

class OrderListLoading extends OrderState {
  bool isLoading;
  OrderListLoading({required this.isLoading});
}

class OrderListSuccess extends OrderState {
  final String? msg;
  List<OrderList> orderList;
  OrderListSuccess({this.msg,required this.orderList});
}

class OrderListFail extends OrderState {
  final String? msg;
  OrderListFail({this.msg});
}

class OrderDetailLoading extends OrderState {
  bool isLoading;
  OrderDetailLoading({required this.isLoading});
}

class OrderDetailSuccess extends OrderState {
  final String? msg;
  List<OrderModel> orderDetailList;
  OrderDetailSuccess({this.msg,required this.orderDetailList});
}

class OrderDetailFail extends OrderState {
  final String? msg;
  OrderDetailFail({this.msg});
}

class MachineQuotationReplyDetailLoading extends OrderState {
  bool isLoading;
  MachineQuotationReplyDetailLoading({required this.isLoading});
}
class MachineQuotationReplyDetailFail extends OrderState {
  final String? msg;
  MachineQuotationReplyDetailFail({this.msg});
}

class MachineQuotationReplyDetailSuccess extends OrderState {
  List<QuotationRequiredItems> quotationRequiredItemList;
  List<QuotationRequiredItems> quotationOtherItemList;
  List<QuotationCharges> quotationChargesList;
  List<CustomerReplyMsg> quotationMsgList;

  MachineQuotationReplyDetailSuccess({required this.quotationRequiredItemList, required this.quotationOtherItemList,
    required this.quotationChargesList,required this.quotationMsgList});
}

class ProductListLoading extends OrderState {
  bool isLoading;
  ProductListLoading({required this.isLoading});
}

class ProductListFail extends OrderState {
  final String? msg;
  ProductListFail({this.msg});
}

class ProductListSuccess extends OrderState {
  List<ProductDetails> productList;
  String message;
  ProductListSuccess({required this.productList, required this.message});
}

class ServiceRequestDetailLoading extends OrderState {
  bool isLoading;
  ServiceRequestDetailLoading({required this.isLoading});
}

class ServiceRequestDetailFail extends OrderState {
  final String? msg;
  ServiceRequestDetailFail({this.msg});
}

class ServiceRequestDetailSuccess extends OrderState {
  List<MachineServiceDetailsModel> machineServiceDetail;
  String message;
  ServiceRequestDetailSuccess({required this.machineServiceDetail, required this.message});
}

class CancelOrderLoading extends OrderState {
  bool isLoading;
  CancelOrderLoading({required this.isLoading});
}

class CancelOrderSuccess extends OrderState {
  final String? msg;
  CancelOrderSuccess({this.msg,});
}

class CancelOrderFail extends OrderState {
  final String? msg;
  CancelOrderFail({this.msg});
}