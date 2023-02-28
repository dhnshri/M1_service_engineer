

abstract class HomeEvent {}

class OnServiceRequest extends HomeEvent {

  String userID,offSet;

  OnServiceRequest({required this.userID,required this.offSet});

}

class OnServiceRequestDetail extends HomeEvent {

  String userID,machineServiceId,jobWorkServiceId,transportServiceId;

  OnServiceRequestDetail({required this.userID,required this.machineServiceId, required this.jobWorkServiceId, required this.transportServiceId});

}

