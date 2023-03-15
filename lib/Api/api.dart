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

import '../Model/JobWorkEnquiry/daily_Task_Add_model.dart';
import '../Model/JobWorkEnquiry/my_task_detail_model.dart';
import '../Model/JobWorkEnquiry/track_process_report_model.dart';
import '../Model/Transpotation/MyTaskTransportDetailModel.dart';
import '../Model/Transpotation/serviceRequestDetailModel.dart';
import '../Model/cart_list_repo.dart';
import '../Model/JobWorkEnquiry/my_task_model.dart';
import '../Model/JobWorkEnquiry/quotation_reply.dart';
import '../Model/JobWorkEnquiry/service_request_model.dart';
import '../Model/MachineMaintance/quotationReply.dart';
import '../Model/Transpotation/myTaskListModel.dart';
import '../Model/Transpotation/quotationReplyModel.dart';
import '../Model/Transpotation/serviceRequestListModel.dart';
import '../Model/customer_login.dart';
import '../Model/profile_repo.dart';
import '../Model/quotation_reply_detail_repo.dart';



class Api {

  // static const String HOST_URL="http://93.188.162.210:3000/";//updated on 23/12/2020
  static const String HOST_URL="http://mone.ezii.live/service_engineer/";
  // static const String HOST_URL="http://unstoppabletrade.ezii.live/App_details/";
  static const String CUSTOMER_LOGIN="login";
  static const String SERVICE_REQUEST_LIST="machine_service_request_list";
  static const String SERVICE_REQUEST_TRANSPOTATION_LIST="transport_service_request_list";
  static const String QUOTATION_REPLY_LIST="get_machine_quotation_reply_list";
  static const String QUOTATION_REPLY_DETAIL="get_machine_quotation_reply_details_list";
  static const String QUOTATION_REPLY_TRANSPORT_LIST="get_transport_quotation_reply_list";
  static const String TRANSPORT_QUOTATION_REPLY_DETAIL="get_transport_quotation_reply_details_list";
  static const String QUOTATION_REPLY_LIST_JWE="get_job_work_quotation_reply_list";
  static const String jOBWORK_QUOTATION_REPLY_DETAIL="get_job_work_quotation_reply_details_list";
  static const String SERVICE_REQUEST_LIST_JWE="job_work_enquiry_service_request_list";
  static const String SERVICE_REQUEST_DETAIL="service_request_details";
  static const String SERVICE_REQUEST_TRANSPORTATION_DETAIL="service_request_details";
  static const String SERVICE_REQUEST_JOB_WORK_ENQUIRY_DETAIL="service_request_details";
  static const String MY_TASK_JOB_WORK_ENQUIRY_DETAIL="service_request_details";
  static const String MY_TASK_TRANSPORTATION_DETAIL="service_request_details";
  static const String CUSTOMER_REGISTER="register_service";
  static const String MY_TASK_LIST="machine_service_my_task_list";
  static const String MY_TASK_TRANSPOTATION_LIST="transport_service_my_task_list";
  static const String JOB_WORK_ENQUIRY_MY_TASK_LIST="job_work_enquiry_service_my_task_list";
  static const String PRODUCT_LIST="get_product_list";
  static const String CART_API="add_to_cart_list";
  static const String CART_LIST="get_cart_list";
  static const String TRACK_PROGRESS_LIST="get_daily_update_task";
  static const String TRACK_PROGRESS_JWE_LIST="get_daily_update_task";
  static const String CREATE_TASK="add_daily_update_task";
  static const String CREATE_TASK_JWE="add_daily_update_task";
  static const String COMPLETE_TASK="update_daily_my_task_list";
  static const String MACHINE_QUOTATION="machine_maintainence_quatation";
  static const String JOBWORK_PROFILE="get_job_work_enquiry_profile";



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

  static Future<dynamic> getServiceRequestTranspotationList(params) async {
    final response = await http.post(
      Uri.parse(HOST_URL+SERVICE_REQUEST_TRANSPOTATION_LIST),
      body: params,
    );
    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body);
      print(responseJson);
      return ServiceRequestTranspotationRepo.fromJson(responseJson);
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

  static Future<dynamic> getQuotaionReplyList(params) async {
    final response = await http.post(
      Uri.parse(HOST_URL+QUOTATION_REPLY_LIST),
      body: params,
    );
    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body);
      print(responseJson);
      return QuotationReplyRepo.fromJson(responseJson);
    }
  }

  static Future<dynamic> getMachineQuotaionReplyDetail(params) async {
    final response = await http.post(
      Uri.parse(HOST_URL+QUOTATION_REPLY_DETAIL),
      body: params,
    );
    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body);
      print(responseJson);
      return QuotaionReplyDetailRepo.fromJson(responseJson);
    }
  }

  static Future<dynamic> getJobWorkQuotaionReplyDetail(params) async {
    final response = await http.post(
      Uri.parse(HOST_URL+jOBWORK_QUOTATION_REPLY_DETAIL),
      body: params,
    );
    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body);
      print(responseJson);
      return JobWorkQuotaionReplyDetailRepo.fromJson(responseJson);
    }
  }

  static Future<dynamic> getTransportQuotaionReplyDetail(params) async {
    final response = await http.post(
      Uri.parse(HOST_URL+TRANSPORT_QUOTATION_REPLY_DETAIL),
      body: params,
    );
    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body);
      print(responseJson);
      return TransportQuotaionReplyDetailRepo.fromJson(responseJson);
    }
  }

  static Future<dynamic> getJobWorkProfileData(params) async {
    final response = await http.post(
      Uri.parse(HOST_URL+JOBWORK_PROFILE),
      body: params,
    );
    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body);
      print(responseJson);
      return JobWorkProfileRepo.fromJson(responseJson);
    }
  }

  static Future<dynamic> getQuotaionReplyTranspotationList(params) async {
    final response = await http.post(
      Uri.parse(HOST_URL+QUOTATION_REPLY_TRANSPORT_LIST),
      body: params,
    );
    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body);
      print(responseJson);
      return QuotationReplyTransportRepo.fromJson(responseJson);
    }
  }

  static Future<dynamic> getQuotaionReplyJWEList(params) async {
    final response = await http.post(
      Uri.parse(HOST_URL+QUOTATION_REPLY_LIST_JWE),
      body: params,
    );
    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body);
      print(responseJson);
      return QuotationReplyJWERepo .fromJson(responseJson);
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

  static Future<dynamic> getServiceRequestTranspotationDetail(params) async {
    final response = await http.post(
      Uri.parse(HOST_URL+SERVICE_REQUEST_TRANSPORTATION_DETAIL),
      body: params,
    );
    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body);
      print(responseJson);
      return TranspotationServiceRequestDetailRepo.fromJson(responseJson);
    }
  }

  static Future<dynamic> getServiceRequestJobWorkEnquiryDetail(params) async {
    final response = await http.post(
      Uri.parse(HOST_URL+SERVICE_REQUEST_JOB_WORK_ENQUIRY_DETAIL),
      body: params,
    );
    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body);
      print(responseJson);
      return ServiceRequestDetailRepo.fromJson(responseJson);
    }
  }

  static Future<dynamic> getMyTaskJobWorkEnquiryDetail(params) async {
    final response = await http.post(
      Uri.parse(HOST_URL+MY_TASK_JOB_WORK_ENQUIRY_DETAIL),
      body: params,
    );
    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body);
      print(responseJson);
      return JobWorkEnquiryMyTaskDetailRepo.fromJson(responseJson);
    }
  }

  static Future<dynamic> getMyTaskTranspotationDetail(params) async {
    final response = await http.post(
      Uri.parse(HOST_URL+MY_TASK_TRANSPORTATION_DETAIL),
      body: params,
    );
    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body);
      print(responseJson);
      return MyTaskTransportDetailRepo.fromJson(responseJson);
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

  static Future<dynamic> getMyTaskTranspotationList(params) async {
    final response = await http.post(
      Uri.parse(HOST_URL+MY_TASK_TRANSPOTATION_LIST),
      body: params,
    );
    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body);
      print(responseJson);
      return MyTaskTransportationRepo.fromJson(responseJson);
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

  //Track jOB wORK eNQUIRY Progress List
  static Future<dynamic> getTrackProgressJWEList(params) async {
    final response = await http.post(
      Uri.parse(HOST_URL+TRACK_PROGRESS_LIST),
      body: params,
    );
    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body);
      print(responseJson);
      return TrackProgressListJobWorkRepo.fromJson(responseJson);
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

  //Create Task
  static Future<dynamic> createTaskJWE(params) async {
    final response = await http.post(
      Uri.parse(HOST_URL+CREATE_TASK_JWE),
      body: params,
    );
    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body);
      print(responseJson);
      return CreateTaskJWERepo.fromJson(responseJson);
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

  //Complete task JWE
  static Future<dynamic> completeTaskJWE(params) async {
    final response = await http.post(
      Uri.parse(HOST_URL+COMPLETE_TASK),
      body: params,
    );
    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body);
      print(responseJson);
      return CreateTaskJWERepo.fromJson(responseJson);
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