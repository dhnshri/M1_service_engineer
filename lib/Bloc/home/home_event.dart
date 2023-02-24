

abstract class HomeEvent {}

class OnServiceRequest extends HomeEvent {

  String userID,offSet,statusID;

  OnServiceRequest({required this.userID,required this.offSet,required this.statusID});

}

