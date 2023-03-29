import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:service_engineer/Model/MachineMaintance/myTaskModel.dart';
import 'package:service_engineer/Model/cart_repo.dart';
import 'package:service_engineer/Model/customer_registration.dart';
import 'package:service_engineer/Model/dashboard_cound_repo.dart';
import 'package:service_engineer/Model/filter_repo.dart';
import 'package:service_engineer/Model/order_list_repo.dart';
import 'package:service_engineer/Model/order_repo.dart';
import 'package:service_engineer/Model/product_repo.dart';
import 'package:service_engineer/Model/quotation_reject_revise_repo.dart';
import 'package:service_engineer/Model/service_request_detail_repo.dart';
import 'package:service_engineer/Model/service_request_repo.dart';
import 'package:service_engineer/Model/track_process_repo.dart';
import 'dart:convert';

import '../Model/JobWorkEnquiry/daily_Task_Add_model.dart';
import '../Model/JobWorkEnquiry/my_task_detail_model.dart';
import '../Model/JobWorkEnquiry/task_hand_over_jwe_model.dart';
import '../Model/JobWorkEnquiry/track_process_report_model.dart';
import '../Model/MachineMaintance/task_hand_over_model.dart';
import '../Model/Transpotation/MyTaskTransportDetailModel.dart';
import '../Model/Transpotation/serviceRequestDetailModel.dart';
import '../Model/Transpotation/transport_task_hand_over_model.dart';
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
  static const String HANDOVER_TASK_DETAIL="service_request_details_list_machine_maintenance_assign_task_to_other";
  static const String HANDOVER_SERVICE_REQUEST_LIST="service_request_list_machine_maintenance_assign_task_to_other";
  static const String JOBWORK_HANDOVER_SERVICE_REQUEST_LIST="service_request_list_job_work_assign_task_to_other";
  static const String HANDOVER_HANDOVER_SERVICE_REQUEST_LIST="service_request_list_transport_assign_task_to_other";
  static const String ACCEPT_REJECT_HANDOVER="machine_maintenance_accept_or_reject_assign_task_to_other";
  static const String JOBWORK_ACCEPT_REJECT_HANDOVER="job_work_accept_or_reject_assign_task_to_other";
  static const String TRANSPORT_ACCEPT_REJECT_HANDOVER="transport_accept_or_reject_assign_task_to_other";
  static const String MACHINE_TASK_HAND_OVER="machine_mainienance_handover_service_user_list";
  static const String JOB_WORK_ENQUIRY_TASK_HAND_OVER="job_work_handover_service_user_list";
  static const String TRANSPORT_TASK_HAND_OVER="transport_handover_service_user_list";
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
  static const String VEHICLE_NAME=HOST_URL+"transport_vehicle_name_list";
  static const String MACHINE_MAINTAINCE_CATEGORY_LIST=HOST_URL+"machine_maintenance_service_category_list";
  static const String JOB_WORK_ENQUIRY_CATEGORY_LIST=HOST_URL+"job_work_categories_list";
  static const String MACHINE_MAINTAINCE_SUB_CATEGORY_LIST=HOST_URL+"machine_maintenance_service_sub_category_list";
  static const String VEHICLE_TYPE=HOST_URL+"transport_vehicle_type_list";
  static const String VEHICLE_NUMBER=HOST_URL+"transport_vehicle_number_list";
  static const String TRANSPORT_PROFILE="get_transport_profile";
  static const String MACHINE_PROFILE="get_machine_maintainence_profile";
  static const String REJECT_REVISE_QUOTATION="service_revise_and_reject_quotations";
  static const String GET_BRAND_LIST="get_brand_list";
  static const String MACHINE_DASHBOARD_COUNT="machine_maintenance_dashboard_count";
  static const String JOBWORK_DASHBOARD_COUNT="job_work_dashboard_count";
  static const String TRANSPORT_DASHBOARD_COUNT="transport_dashboard_count";
  static const String FILTER_CATEGORY_LIST="get_category_list";
  static const String MACHINE_TASK_HANDOVER="add_machine_maintenance_assign_task_to_other";
  static const String JOBWORK_TASK_HANDOVER="add_job_work_assign_task_to_other";
  static const String TRANSPORT_TASK_HANDOVER="add_transport_assign_task_to_other";
  static const String ORDER_LIST="get_order_list";
  static const String ORDER_DETAIL="get_detail_order_list";
  static const String CANCEL_ORDER="cancel_order";


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

  static Future<dynamic> getMachineDashboardCount(params) async {
    final response = await http.post(
      Uri.parse(HOST_URL+MACHINE_DASHBOARD_COUNT),
      body: params,
    );
    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body);
      print(responseJson);
      return DashboardCountRepo.fromJson(responseJson);
    }
  }

  static Future<dynamic> getOrderList(params) async {
    final response = await http.post(
      Uri.parse(HOST_URL+ORDER_LIST),
      body: params,
    );
    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body);
      print(responseJson);
      return OrderListRepo.fromJson(responseJson);
    }
  }

  static Future<dynamic> cancelOrder(params) async {
    final response = await http.post(
      Uri.parse(HOST_URL+CANCEL_ORDER),
      body: params,
    );
    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body);
      print(responseJson);
      return OrderListRepo.fromJson(responseJson);
    }
  }

  static Future<dynamic> getOrderDetail(params) async {
    final response = await http.post(
      Uri.parse(HOST_URL+ORDER_DETAIL),
      body: params,
    );
    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body);
      print(responseJson);
      return OrderRepo.fromJson(responseJson);
    }
  }

  static Future<dynamic> getJobWorkDashboardCount(params) async {
    final response = await http.post(
      Uri.parse(HOST_URL+JOBWORK_DASHBOARD_COUNT),
      body: params,
    );
    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body);
      print(responseJson);
      return DashboardCountRepo.fromJson(responseJson);
    }
  }

  static Future<dynamic> getTransportDashboardCount(params) async {
    final response = await http.post(
      Uri.parse(HOST_URL+TRANSPORT_DASHBOARD_COUNT),
      body: params,
    );
    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body);
      print(responseJson);
      return DashboardCountRepo.fromJson(responseJson);
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

  static Future<dynamic> getMachineHandOverServiceRequestListList(params) async {
    final response = await http.post(
      Uri.parse(HOST_URL+HANDOVER_SERVICE_REQUEST_LIST),
      body: params,
    );
    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body);
      print(responseJson);
      return ServiceRequestRepo.fromJson(responseJson);
    }
  }

  static Future<dynamic> getMachineHandOverTaskDetail(params) async {
    final response = await http.post(
      Uri.parse(HOST_URL+HANDOVER_TASK_DETAIL),
      body: params,
    );
    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body);
      print(responseJson);
      return ServiceRequestRepo.fromJson(responseJson);
    }
  }

  static Future<dynamic> getJobWorkHandOverServiceRequestListList(params) async {
    final response = await http.post(
      Uri.parse(HOST_URL+JOBWORK_HANDOVER_SERVICE_REQUEST_LIST),
      body: params,
    );
    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body);
      print(responseJson);
      return ServiceRequestRepo.fromJson(responseJson);
    }
  }

  static Future<dynamic> getTransportHandOverServiceRequestListList(params) async {
    final response = await http.post(
      Uri.parse(HOST_URL+HANDOVER_HANDOVER_SERVICE_REQUEST_LIST),
      body: params,
    );
    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body);
      print(responseJson);
      return ServiceRequestRepo.fromJson(responseJson);
    }
  }

  static Future<dynamic> acceptRejectHandOver(params) async {
    final response = await http.post(
      Uri.parse(HOST_URL+ACCEPT_REJECT_HANDOVER),
      body: params,
    );
    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body);
      print(responseJson);
      return ServiceRequestRepo.fromJson(responseJson);
    }
  }

  static Future<dynamic> jobworkAcceptRejectHandOver(params) async {
    final response = await http.post(
      Uri.parse(HOST_URL+JOBWORK_ACCEPT_REJECT_HANDOVER),
      body: params,
    );
    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body);
      print(responseJson);
      return ServiceRequestRepo.fromJson(responseJson);
    }
  }

  static Future<dynamic> transportAcceptRejectHandOver(params) async {
    final response = await http.post(
      Uri.parse(HOST_URL+TRANSPORT_ACCEPT_REJECT_HANDOVER),
      body: params,
    );
    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body);
      print(responseJson);
      return ServiceRequestRepo.fromJson(responseJson);
    }
  }

  static Future<dynamic> getTaskHandOverList(params) async {
    final response = await http.post(
      Uri.parse(HOST_URL+MACHINE_TASK_HAND_OVER),
      body: params,
    );
    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body);
      print(responseJson);
      return MachineMaintanceTaskHandOverRepo.fromJson(responseJson);
    }
  }

  static Future<dynamic> getJobWorkEnquiryTaskHandOverList(params) async {
    final response = await http.post(
      Uri.parse(HOST_URL+JOB_WORK_ENQUIRY_TASK_HAND_OVER),
      body: params,
    );
    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body);
      print(responseJson);
      return JobWorkEnquiryTaskHandOverRepo.fromJson(responseJson);
    }
  }

  static Future<dynamic> getTransportTaskHandOverList(params) async {
    final response = await http.post(
      Uri.parse(HOST_URL+TRANSPORT_TASK_HAND_OVER),
      body: params,
    );
    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body);
      print(responseJson);
      return TransportTaskHandOverRepo.fromJson(responseJson);
    }
  }

  static Future<dynamic> getFilterList() async {
    final response = await http.post(
      Uri.parse(HOST_URL+GET_BRAND_LIST),
    );
    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body);
      print(responseJson);
      return FilterRepo.fromJson(responseJson);
    }
  }

  static Future<dynamic> getFilterCategoryList() async {
    final response = await http.post(
      Uri.parse(HOST_URL+FILTER_CATEGORY_LIST),
    );
    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body);
      print(responseJson);
      return FilterRepo.fromJson(responseJson);
    }
  }

  static Future<dynamic> getFilterList() async {
    final response = await http.post(
      Uri.parse(HOST_URL+GET_BRAND_LIST),
    );
    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body);
      print(responseJson);
      return FilterRepo.fromJson(responseJson);
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

  static Future<dynamic> getRejectRevised(params) async {
    final response = await http.post(
      Uri.parse(HOST_URL+REJECT_REVISE_QUOTATION),
      body: params,
    );
    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body);
      print(responseJson);
      return RejectReviseRepo.fromJson(responseJson);
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

  static Future<dynamic> getMachineProfileData(params) async {
    final response = await http.post(
      Uri.parse(HOST_URL+MACHINE_PROFILE),
      body: params,
    );
    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body);
      print(responseJson);
      return JobWorkProfileRepo.fromJson(responseJson);
    }
  }

  static Future<dynamic> sendMachineTaskHandOver(params) async {
    final response = await http.post(
      Uri.parse(HOST_URL+MACHINE_TASK_HANDOVER),
      body: params,
    );
    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body);
      print(responseJson);
      return TrackProcessRepo.fromJson(responseJson);
    }
  }

  static Future<dynamic> sendJobWorkTaskHandOver(params) async {
    final response = await http.post(
      Uri.parse(HOST_URL+JOBWORK_TASK_HANDOVER),
      body: params,
    );
    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body);
      print(responseJson);
      return TrackProcessRepo.fromJson(responseJson);
    }
  }

  static Future<dynamic> sendTransportTaskHandOver(params) async {
    final response = await http.post(
      Uri.parse(HOST_URL+TRANSPORT_TASK_HANDOVER),
      body: params,
    );
    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body);
      print(responseJson);
      return TrackProcessRepo.fromJson(responseJson);
    }
  }


  static Future<dynamic> getTransportProfileData(params) async {
    final response = await http.post(
      Uri.parse(HOST_URL+TRANSPORT_PROFILE),
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