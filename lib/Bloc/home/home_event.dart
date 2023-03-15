

import 'package:flutter/cupertino.dart';
import 'package:service_engineer/Model/JobWorkEnquiry/service_request_detail_model.dart';
import 'package:service_engineer/Model/cart_list_repo.dart';
import 'package:service_engineer/Model/item_not_available_model.dart';

abstract class HomeEvent {}
// Machine Maintaince Home
class OnServiceRequest extends HomeEvent {

  String userID,offSet;

  OnServiceRequest({required this.userID,required this.offSet});

}

class MyTaskList extends HomeEvent {
  String userid;
  String offset;
  MyTaskList({required this.userid, required this.offset });
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

  String prodId,offSet;

  ProductList({required this.prodId,required this.offSet,});

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

  String offSet;

  OnServiceRequestJWEList({required this.offSet});

}
class OnMyTaskJWEList extends HomeEvent {
  String userid;
  String offset;
  OnMyTaskJWEList({required this.userid, required this.offset });
}

// Transpotation
class OnServiceRequestTranspotation extends HomeEvent {
  String offSet;
  OnServiceRequestTranspotation({required this.offSet});
}

class OnMyTaskTranspotationList extends HomeEvent {
  String userid;
  String offset;
  OnMyTaskTranspotationList({required this.userid, required this.offset });
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

  SendQuotation({ required this.serviceUserId, required this.workingTime, required this.dateOfJoining,
    required this.serviceCharge,required this.handlingCharge,required this.transportCharge,required this.itemList,
    required this.itemNotAvailableList, required this.commission,required this.machineEnquiryDate, required this.machineEnquiryId});

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

  JobWorkSendQuotation({ required this.serviceUserId, required this.jobWorkEnquiryId, required this.jobWorkEnquirydate,
    required this.packingCharge,required this.testingCharge,required this.transportCharge,required this.itemList,
    required this.commission,required this.cgst, required this.sgst,required this.igst,required this.itemRateController,
    required this.volumeController});

}