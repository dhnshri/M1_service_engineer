

abstract class HomeEvent {}

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

class AddToCart extends HomeEvent {

  String prodId,quantity,userId;

  AddToCart({required this.prodId,required this.quantity, required this.userId});

}

class CartList extends HomeEvent {

  String userId;

  CartList({ required this.userId});

}