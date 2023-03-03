import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:service_engineer/Model/MachineMaintance/myTaskModel.dart';
import 'package:service_engineer/Model/customer_registration.dart';
import 'package:service_engineer/Model/product_repo.dart';
import 'package:service_engineer/Model/service_request_detail_repo.dart';
import 'package:service_engineer/Model/service_request_repo.dart';
import 'dart:convert';

import '../Model/JobWorkEnquiry/my_task_model.dart';
import '../Model/JobWorkEnquiry/service_request_model.dart';
import '../Model/customer_login.dart';



class Api {

  // static const String HOST_URL="http://93.188.162.210:3000/";//updated on 23/12/2020
  static const String HOST_URL="http://mone.ezii.live/service_engineer/";
  // static const String HOST_URL="http://unstoppabletrade.ezii.live/App_details/";
  static const String CUSTOMER_LOGIN="login";
  static const String SERVICE_REQUEST_LIST="machine_service_request_list";
  static const String SERVICE_REQUEST_LIST_JWE="job_work_enquiry_service_request_list";
  static const String SERVICE_REQUEST_DETAIL="service_request_details";
  static const String CUSTOMER_REGISTER="register_service";
  static const String MY_TASK_LIST="machine_service_my_task_list";
  static const String JOB_WORK_ENQUIRY_MY_TASK_LIST="job_work_enquiry_service_my_task_list";
  static const String PRODUCT_LIST="get_product_list";



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

  static Future<dynamic> getServiceRequestJobWorkEnquiryList(params) async {
    final response = await http.post(
      Uri.parse(HOST_URL+SERVICE_REQUEST_LIST_JWE),
      body: params,
    );
    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body);
      print(responseJson);
      return JobWorkEnquiryServiceRequestRepo.fromJson(responseJson);
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

  static Future<dynamic> getMyTaskJWEList(params) async {
    final response = await http.post(
      Uri.parse(HOST_URL+JOB_WORK_ENQUIRY_MY_TASK_LIST),
      body: params,
    );
    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body);
      print(responseJson);
      return JobWorkEnquiryMyTaskRepo.fromJson(responseJson);
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


}