import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:service_engineer/Model/MachineMaintance/myTaskModel.dart';
import 'package:service_engineer/Model/cart_repo.dart';
import 'package:service_engineer/Model/customer_registration.dart';
import 'package:service_engineer/Model/product_repo.dart';
import 'package:service_engineer/Model/service_request_detail_repo.dart';
import 'package:service_engineer/Model/service_request_repo.dart';
import 'package:service_engineer/Model/track_process_repo.dart';
import 'dart:convert';

import '../Model/cart_list_repo.dart';
import '../Model/customer_login.dart';



class Api {

  // static const String HOST_URL="http://93.188.162.210:3000/";//updated on 23/12/2020
  static const String HOST_URL="http://mone.ezii.live/service_engineer/";
  // static const String HOST_URL="http://unstoppabletrade.ezii.live/App_details/";
  static const String CUSTOMER_LOGIN="login";
  static const String SERVICE_REQUEST_LIST="machine_service_request_list";
  static const String SERVICE_REQUEST_DETAIL="service_request_details";
  static const String CUSTOMER_REGISTER="register_service";
  static const String MY_TASK_LIST="machine_service_my_task_list";
  static const String PRODUCT_LIST="get_product_list";
  static const String CART_API="add_to_cart_list";
  static const String CART_LIST="get_cart_list";
  static const String TRACK_PROGRESS_LIST="get_daily_update_task";
  static const String CREATE_TASK="add_daily_update_task";
  static const String COMPLETE_TASK="update_daily_my_task_list";
  static const String MACHINE_QUOTATION="machine_maintainence_quatation";



  ///Login api
  static Future<dynamic> login(params) async {
    final response = await http.post(
      Uri.parse(HOST_URL+CUSTOMER_LOGIN),
      body: params,
    );
    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body);
      print(responseJson);
      return CustomerLoginRepo.fromJson(responseJson);
    }
  }

  ///Registration api
  static Future<dynamic> registration(params) async {
    final response = await http.post(
      Uri.parse(HOST_URL+CUSTOMER_REGISTER),
      body: params,
    );
    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body);
      print(responseJson);
      return RegistrationRepo.fromJson(responseJson);
    }
  }

  static Future<dynamic> getServiceRequestList(params) async {
    final response = await http.post(
      Uri.parse(HOST_URL+SERVICE_REQUEST_LIST),
      body: params,
    );
    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body);
      print(responseJson);
      return ServiceRequestRepo.fromJson(responseJson);
    }
  }

  static Future<dynamic> getServiceRequestDetail(params) async {
    final response = await http.post(
      Uri.parse(HOST_URL+SERVICE_REQUEST_DETAIL),
      body: params,
    );
    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body);
      print(responseJson);
      return ServiceRequestDetailRepo.fromJson(responseJson);
    }
  }

  static Future<dynamic> getMyTaskList(params) async {
    final response = await http.post(
      Uri.parse(HOST_URL+MY_TASK_LIST),
      body: params,
    );
    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body);
      print(responseJson);
      return MyTaskRepo.fromJson(responseJson);
    }
  }

  static Future<dynamic> getProductList(params) async {
    final response = await http.post(
      Uri.parse(HOST_URL+PRODUCT_LIST),
      body: params,
    );
    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body);
      print(responseJson);
      return ProductRepo.fromJson(responseJson);
    }
  }

  static Future<dynamic> getAddToCart(params) async {
    final response = await http.post(
      Uri.parse(HOST_URL+CART_API),
      body: params,
    );
    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body);
      print(responseJson);
      return CartRepo.fromJson(responseJson);
    }
  }

  static Future<dynamic> getCartList(params) async {
    final response = await http.post(
      Uri.parse(HOST_URL+CART_LIST),
      body: params,
    );
    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body);
      print(responseJson);
      return CartListRepo.fromJson(responseJson);
    }
  }

  //Track Progress List
  static Future<dynamic> getTrackProgressList(params) async {
    final response = await http.post(
      Uri.parse(HOST_URL+TRACK_PROGRESS_LIST),
      body: params,
    );
    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body);
      print(responseJson);
      return TrackProcessRepo.fromJson(responseJson);
    }
  }

  //Create Task
  static Future<dynamic> createTask(params) async {
    final response = await http.post(
      Uri.parse(HOST_URL+CREATE_TASK),
      body: params,
    );
    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body);
      print(responseJson);
      return CreateTaskRepo.fromJson(responseJson);
    }
  }

  //Complete task
  static Future<dynamic> completeTask(params) async {
    final response = await http.post(
      Uri.parse(HOST_URL+COMPLETE_TASK),
      body: params,
    );
    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body);
      print(responseJson);
      return CreateTaskRepo.fromJson(responseJson);
    }
  }

  //Send Quotation
  static Future<dynamic> sendQuotation(params) async {
    var response = await http.MultipartRequest(
      'POST',Uri.parse(HOST_URL+MACHINE_QUOTATION)
    );
    response.fields.addAll(params);
    var _response = await response.send();

    if (_response.statusCode == 200) {
      print(_response);
      // final responseJson = json.decode(response.body);
      // print(responseJson);
      // return CreateTaskRepo.fromJson(responseJson);
    }
  }
}