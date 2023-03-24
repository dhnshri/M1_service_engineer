

import 'package:flutter/cupertino.dart';
import 'package:service_engineer/Model/JobWorkEnquiry/service_request_detail_model.dart';
import 'package:service_engineer/Model/cart_list_repo.dart';
import 'package:service_engineer/Model/item_not_available_model.dart';

abstract class HomeEvent {}
// Machine Maintaince Home
class OnServiceRequest extends HomeEvent {
  String offSet,timeId;

  OnServiceRequest({required this.offSet,required this.timeId});
}

class ItemFilter extends HomeEvent {
  ItemFilter();
}

class MyTaskList extends HomeEvent {
  String userid;
  String offset;
  String timePeriod;
  MyTaskList({required this.userid, required this.offset, required this.timePeriod});
}

class OnServiceRequestDetail extends HomeEvent {

  String userID,machineServiceId,jobWorkServiceId,transportServiceId;

  OnServiceRequestDetail({required this.userID,required this.machineServiceId, required this.jobWorkServiceId, required this.transportServiceId});

}

class OnServiceRequestTranspotationDetail extends HomeEvent {

  String userID,machineServiceId,jobWorkServiceId,transportServiceId;

  OnServiceRequestTranspotationDetail({required this.userID,required this.machineServiceId, required this.jobWorkServiceId, required this.transportServiceId});

}
class OnServiceRequestJobWorkEnquiryDetail extends HomeEvent {

  String userID,machineServiceId,jobWorkServiceId,transportServiceId;

  OnServiceRequestJobWorkEnquiryDetail({required this.userID,required this.machineServiceId, required this.jobWorkServiceId, required this.transportServiceId});

}

class OnMyTaskTranspotationDetail extends HomeEvent {

  String userID,machineServiceId,jobWorkServiceId,transportServiceId;

  OnMyTaskTranspotationDetail({required this.userID,required this.machineServiceId, required this.jobWorkServiceId, required this.transportServiceId});

}

class OnMyTaskJobWorkEnquiryDetail extends HomeEvent {

  String userID,machineServiceId,jobWorkServiceId,transportServiceId;

  OnMyTaskJobWorkEnquiryDetail({required this.userID,required this.machineServiceId, required this.jobWorkServiceId, required this.transportServiceId});

}

class ProductList extends HomeEvent {

  String prodId,offSet,brandId,priceId;

  ProductList({required this.prodId,required this.offSet,required this.brandId,required this.priceId});

}

class AddToCart extends HomeEvent {

  String prodId,quantity,userId;

  AddToCart({required this.prodId,required this.quantity, required this.userId});

}

class CartList extends HomeEvent {

  String userId;

  CartList({ required this.userId});

}

class TrackProcessList extends HomeEvent {

  String userId;
  String machineEnquiryId;
  String jobWorkEnquiryId;
  String transportEnquiryId;

  TrackProcessList({ required this.userId, required this.machineEnquiryId, required this.jobWorkEnquiryId,
  required this.transportEnquiryId});

}

class OnTrackProcessList extends HomeEvent {

  String userId;
  String machineEnquiryId;
  String jobWorkEnquiryId;
  String transportEnquiryId;

  OnTrackProcessList({ required this.userId, required this.machineEnquiryId, required this.jobWorkEnquiryId,
    required this.transportEnquiryId});

}

class CreateTask extends HomeEvent {

  String userId;
  String machineEnquiryId;
  String jobWorkEnquiryId;
  String transportEnquiryId;
  String heading;
  String description;
  int status;

  CreateTask({ required this.userId, required this.machineEnquiryId, required this.jobWorkEnquiryId,
    required this.transportEnquiryId,required this.heading, required this.description,required this.status});

}

// Job Work Enquiry
class OnCreateTask extends HomeEvent {

  String userId;
  String machineEnquiryId;
  String jobWorkEnquiryId;
  String transportEnquiryId;
  String heading;
  String description;
  int status;

  OnCreateTask({ required this.userId, required this.machineEnquiryId, required this.jobWorkEnquiryId,
    required this.transportEnquiryId,required this.heading, required this.description,required this.status});

}
// Job Work Enquiry Home

class OnServiceRequestJWEList extends HomeEvent {
  String timePeriod;
  String offSet;
  OnServiceRequestJWEList({required this.offSet,required this.timePeriod});

}
class OnMyTaskJWEList extends HomeEvent {
  String userid;
  String offset;
  String timeId;
  OnMyTaskJWEList({required this.userid, required this.offset,required this.timeId });
}

// Transpotation
class OnServiceRequestTranspotation extends HomeEvent {
  String offSet;
  String timeId;
  OnServiceRequestTranspotation({required this.offSet,required this.timeId});
}

class OnMyTaskTranspotationList extends HomeEvent {
  String userid;
  String offset;
  String timeId;
  OnMyTaskTranspotationList({required this.userid, required this.offset,required this.timeId });
}
class TaskComplete extends HomeEvent {

  String serviceUserId;
  String dailyTaskId;
  String machineEnquiryId;
  String jobWorkEnquiryId;
  String transportEnquiryId;
  int status;

  TaskComplete({ required this.serviceUserId, required this.machineEnquiryId, required this.jobWorkEnquiryId,
    required this.transportEnquiryId,required this.dailyTaskId,required this.status});

}

class TaskCompleteJWE extends HomeEvent {

  String serviceUserId;
  String dailyTaskId;
  String machineEnquiryId;
  String jobWorkEnquiryId;
  String transportEnquiryId;
  int status;

  TaskCompleteJWE({ required this.serviceUserId, required this.machineEnquiryId, required this.jobWorkEnquiryId,
    required this.transportEnquiryId,required this.dailyTaskId,required this.status});

}

class SendQuotation extends HomeEvent {

  String serviceUserId;
  String workingTime;
  String dateOfJoining;
  String serviceCharge;
  String handlingCharge;
  String transportCharge;
  List<CartListModel> itemList;
  List<ItemNotAvailableModel> itemNotAvailableList;
  String commission;
  String machineEnquiryDate;
  int machineEnquiryId;
  String totalAmount;

  SendQuotation({ required this.serviceUserId, required this.workingTime, required this.dateOfJoining,
    required this.serviceCharge,required this.handlingCharge,required this.transportCharge,required this.itemList,
    required this.itemNotAvailableList, required this.commission,required this.machineEnquiryDate, required this.machineEnquiryId,required this.totalAmount});

}

class JobWorkSendQuotation extends HomeEvent {

  String serviceUserId;
  String jobWorkEnquiryId;
  String jobWorkEnquirydate;
  String packingCharge;
  String testingCharge;
  String transportCharge;
  List<TextEditingController> itemRateController;
  List<TextEditingController> volumeController;
  List<JobWorkEnquiryDetailsModel> itemList;
  String cgst;
  String sgst;
  String igst;
  String commission;
  String totalAmount;

  JobWorkSendQuotation({ required this.serviceUserId, required this.jobWorkEnquiryId, required this.jobWorkEnquirydate,
    required this.packingCharge,required this.testingCharge,required this.transportCharge,required this.itemList,
    required this.commission,required this.cgst, required this.sgst,required this.igst,required this.itemRateController,
    required this.volumeController,required this.totalAmount});

}