

import '../../image_file.dart';

abstract class LoginEvent {}

class OnLogin extends LoginEvent {

  var username,password;

  OnLogin({this.username,this.password});

}

class OnRegistration extends LoginEvent {

var fullname,email,mobileNo,createPassword,reCreatePassword,role,username;

OnRegistration({this.fullname,this.email,this.createPassword,this.mobileNo,this.reCreatePassword,this.role,this.username});

}



class OnLogout extends LoginEvent {
  OnLogout();
}
