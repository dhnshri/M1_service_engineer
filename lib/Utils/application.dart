import 'package:shared_preferences/shared_preferences.dart';

import '../Model/customer_login.dart';


class Application {
  static bool debug = false;
  static String version = '2.0.3';
  static String Iosversion = '2.0.3';
  static String publishableKey="pk_test_51KGJyKSHMcdDIkB864XwME4MINAjLPUDi8jkT1OubzhTczywcrnQiqWFiToYYJ6er2hJOstRtwhE3bCr49jzci7y00cbqfDLBl";
  static String googleMapsKey="AIzaSyC08LZ461W_8xfd0alHTiPz8iLcYYrUdps";
  static SharedPreferences? preferences;

  static CustomerLogin? customerLogin;
  static double? totalAmount;
  static double? revisedTotalAmount;
  static bool? isOnline;

  static String? token;



  ///Singleton factory
  static final Application _instance = Application._internal();

  factory Application() {
    return _instance;
  }

  Application._internal();
}
