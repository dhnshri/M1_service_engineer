import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:service_engineer/Model/service_request_detail_repo.dart';
import 'package:service_engineer/Model/service_request_repo.dart';
import 'dart:convert';

import '../Model/customer_login.dart';



class Api {

  // static const String HOST_URL="http://93.188.162.210:3000/";//updated on 23/12/2020
  static const String HOST_URL="http://mone.ezii.live/service_engineer/";
  // static const String HOST_URL="http://unstoppabletrade.ezii.live/App_details/";
  static const String CUSTOMER_LOGIN="login";
  static const String SERVICE_REQUEST_LIST="machine_service_request_list";
  static const String SERVICE_REQUEST_DETAIL="service_request_details";



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


}