
import '../../Model/customer_login.dart';

abstract class AuthenticationEvent {}

class OnAuthCheck extends AuthenticationEvent {}

class OnSaveUser extends AuthenticationEvent {
  final CustomerLogin user;
  OnSaveUser(this.user);
}

class OnSaveMaintainenceTotalAmount extends AuthenticationEvent {
   double? totalAmount;
   OnSaveMaintainenceTotalAmount(this.totalAmount);
}

class OnSaveMaintainenceRevisedTotalAmount extends AuthenticationEvent {
  double? totalAmount;
  OnSaveMaintainenceRevisedTotalAmount(this.totalAmount);
}

class OnSaveCart extends AuthenticationEvent {
  // CartListRepo cart;
  // OnSaveCart(this.cart);

}





class OnClear extends AuthenticationEvent {}
