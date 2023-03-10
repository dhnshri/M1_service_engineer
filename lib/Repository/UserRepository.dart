import 'dart:convert';
import 'package:service_engineer/Bloc/home/block.dart';
import 'package:service_engineer/Model/customer_login.dart';

import '../Api/api.dart';
import '../Model/cart_list_repo.dart';
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
    final params = {"service_user_id":userId,
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
      "qty":quantity,'product_id':prodId};
    return await Api.getAddToCart(params);
  }

  //Cart List
  Future<dynamic> fetchCartList({String? userId}) async {
    final params = {"user_id":userId,};
    return await Api.getCartList(params);
  }

  //Fetch Track Progress List
  Future<dynamic> fetchTrackProgressList({String? userId,String? machineEnquiryId,String? jobWorkWnquiryId,String? transportEnquiryId}) async {
    final params = {"service_user_id":userId,'machine_enquiry_id':machineEnquiryId,'job_work_enquiry_id':jobWorkWnquiryId,'transport_enquiry_id':transportEnquiryId};
    return await Api.getTrackProgressList(params);
  }

  //Create Task
  Future<dynamic> createTask({String? userId,String? machineEnquiryId,String? jobWorkWnquiryId,String? transportEnquiryId,String? heading,String? description,int? status}) async {
    final params = {"service_user_id":userId,'machine_enquiry_id':machineEnquiryId,'job_work_enquiry_id':jobWorkWnquiryId,'transport_enquiry_id':transportEnquiryId,
    "heading":heading,"description":description,'status': status.toString()};
    return await Api.createTask(params);
  }

  //Complete Task
  Future<dynamic> completeTask({String? serviceUserId,String? machineEnquiryId,String? jobWorkWnquiryId,String? transportEnquiryId,String? dailyTaskId,int? status}) async {
    final params = {"service_user_id":serviceUserId,'machine_enquiry_id':machineEnquiryId,'job_work_enquiry_id':jobWorkWnquiryId,'transport_enquiry_id':transportEnquiryId,
      "daily_my_task_id":dailyTaskId,'status': status.toString()};
    return await Api.completeTask(params);
  }

  Future<dynamic> SendQuotationPara({String? serviceUserId,String? workingTime,String? dateOfJoining,String? serviceCharge,String? handlingCharge,String? transportCharge,
    List<ProductListModel>? itemList, List<ProductNotAvailableListModel>? itemNotAvailableList,String? commission,String? machineEnqDate,String? machineEnqId}) async {
    final params = {"service_user_id":serviceUserId,
      'working_time':workingTime,
      'date_of_joining':dateOfJoining,
      'service_charge':serviceCharge,
      "handling_charge":handlingCharge,
      'transport_charge': transportCharge,
      'items_available': itemList,
      'items_not_available': itemNotAvailableList,
      'commission': commission,
      'machine_enquiry_date': machineEnqDate,
      'machine_enquiry_id': machineEnqId,
    };
    return await Api.sendQuotation(params);
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

