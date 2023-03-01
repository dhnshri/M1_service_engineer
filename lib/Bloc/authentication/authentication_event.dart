
import '../../Model/customer_login.dart';

abstract class AuthenticationEvent {}

class OnAuthCheck extends AuthenticationEvent {}

class OnSaveUser extends AuthenticationEvent {
  final CustomerLogin user;
  OnSaveUser(this.user);

}

class OnSaveAddress extends AuthenticationEvent {
  // final AddressModel address;
  // OnSaveAddress(this.address);

}

class OnSaveCart extends AuthenticationEvent {
  // CartListRepo cart;
  // OnSaveCart(this.cart);

}





class OnClear extends AuthenticationEvent {}
