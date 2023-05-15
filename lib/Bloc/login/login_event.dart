import '../../image_file.dart';

abstract class LoginEvent {}

class OnLogin extends LoginEvent {
  String username, password;

  OnLogin({required this.username, required this.password});
}

class OnRegistration extends LoginEvent {
  String fullname,
      email,
      mobileNo,
      createPassword,
      reCreatePassword,
      role,
      username;

  OnRegistration(
      {required this.fullname,
      required this.email,
      required this.createPassword,
      required this.mobileNo,
      required this.reCreatePassword,
      required this.role,
      required this.username});
}

class OnLogout extends LoginEvent {
  OnLogout();
}
