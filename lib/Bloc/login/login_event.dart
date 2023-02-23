

import '../../image_file.dart';

abstract class LoginEvent {}

class OnLogin extends LoginEvent {

  var mobile,password;

  OnLogin({this.mobile,this.password});

}

class OnRegistration extends LoginEvent {

var fullname,email,mobileNo,createPassword,reCreatePassword,role;

OnRegistration({this.fullname,this.email,this.createPassword,this.mobileNo,this.reCreatePassword,this.role});

}



class OnLogout extends LoginEvent {
  OnLogout();
}
