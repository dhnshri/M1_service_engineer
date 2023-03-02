import 'dart:convert';
import 'package:service_engineer/Model/customer_login.dart';

import '../Api/api.dart';
import '../Utils/preferences.dart';
import '../Utils/util_preferences.dart';



class UserRepository {

  Future<dynamic> savePhoneNo(String phoneNo) async {
    return await UtilPreferences.setString(
      Preferences.phoneNo,
      phoneNo,
    );
  }

  dynamic getPhoneNo() {
      return UtilPreferences.getString(Preferences.phoneNo);
    }

  Future<dynamic> saveRole(String role) async {
    return await UtilPreferences.setString(
      Preferences.role,
      role,
    );
  }

  dynamic getRole() {
    return UtilPreferences.getString(Preferences.role);
  }

  // ///Fetch api login
  Future<dynamic> login({String? username,String? password,String? token,String? deviceID}) async {
    final params = {"username":username,"password":password, "token": 'Bearer $token',"device_id": deviceID};
    return await Api.login(params);
  }

  Future<dynamic> registration({String? fullname,String? createPassword,String? reCreatePassword,String? email,String? mobileNo,String? role,String? username}) async {
    final params = {
      'name':fullname,
      'password':createPassword,
      'password_confirmation':reCreatePassword,
      'username':username,
      'email':email,
      'mobile':mobileNo,
      'role':role,};
    return await Api.registration(params);
  }
  // Future<dynamic> fetchCategory({String? perPage, String? startFrom}) async {
  //   final params = {"per_page":perPage,
  //     "start_from":startFrom};
  //   return await Api.getCategory(params);
  // }

  //Service Request Api
  Future<dynamic> fetchServiceRequestList({String? userID, String? offSet}) async {
    final params = {"user_id":userID, "offset":offSet};
    return await Api.getServiceRequestList(params);
  }

  //Service Request Detail Api
  Future<dynamic> fetchServiceRequestDetail({String? userID, String? machineEnquiryId,
    String? jobWorkEnquiryId, String? transportEnquiryId  }) async {
    final params = {"user_id":userID, "machine_enquiry_id":machineEnquiryId,
    'job_work_enquiry_id':jobWorkEnquiryId,'transport_enquiry_id':transportEnquiryId};
    return await Api.getServiceRequestDetail(params);
  }

  //MachineMaintainceMyTaskList
  Future<dynamic> fetchMachineMaintainceMyTaskList({String? userId,String? offset}) async {
    final params = {"user_id":userId,
      "offset":offset};
    return await Api.getMyTaskList(params);
  }

  //Fetch Product List
  Future<dynamic> fetchProductList({String? prodId,String? offset}) async {
    final params = {"user_id":prodId,
      "offset":offset};
    return await Api.getProductList(params);
  }

  //Add To Cart
  Future<dynamic> addToCart({String? prodId,String? userId, String? quantity}) async {
    final params = {"user_id":userId,
      "qty":userId,'product_id':prodId};
    return await Api.getAddToCart(params);
  }

  //Save User
  Future<dynamic> saveUser(CustomerLogin user) async {
    return await UtilPreferences.setString(
      Preferences.user,
      jsonEncode(user.toJson()),
    );
  }
  //
  ///Get from Storage
  dynamic getUser() {
    return UtilPreferences.getString(Preferences.user);
  }
  //
  // ///Save address
  // Future<dynamic> saveAddress(AddressModel address) async {
  //   return await UtilPreferences.setString(
  //     Preferences.address,
  //     jsonEncode(address.toJson()),
  //   );
  // }
  //
  // ///Get address
  // dynamic getAddress() {
  //   return UtilPreferences.getString(Preferences.address);
  // }
  //
  //
  // ///Save cartCount
  // Future<dynamic> saveCart(CartListRepo cartData) async {
  //   return await UtilPreferences.setString(
  //     Preferences.cart,
  //     jsonEncode(cartData.toJson()),
  //     // cartData.
  //   );
  // }
  //
  // ///Get cart count
  // dynamic getCart() {
  //   return UtilPreferences.getString(Preferences.cart);
  // }
  // // dynamic getProfile() {
  // //   return UtilPreferences.getString(Preferences.profilePic);
  // // }
  //
  //
  //
  // ///Delete Storage
  // Future<dynamic> deleteUser() async {
  //   return await UtilPreferences.remove(Preferences.user);
  // }


}

