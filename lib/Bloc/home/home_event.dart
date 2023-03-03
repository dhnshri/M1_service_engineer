

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

class ProductList extends HomeEvent {

  String prodId,offSet;

  ProductList({required this.prodId,required this.offSet,});

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