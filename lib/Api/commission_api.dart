import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;



Future fetchCommision(String serviceUserId,String roleId) async {
  var response;
  try {
    response =
    await http.post(
        Uri.parse("http://mone.ezii.live/service_engineer/get_commission"),
        body: {'service_user_id':serviceUserId,'role_id':roleId});
    if (response.statusCode == 200) {
      final parsed = json.decode(response.body);
      response = parsed;
      // return parsed;
    }
  } catch (e) {
    log(e.toString());
  }
  return response;
}

class CartRepo {
  bool? success;
  dynamic data;
  String? msg;

  CartRepo({this.success, this.data,this.msg});

  factory CartRepo.fromJson(Map<dynamic, dynamic> json) {
    try {
      return CartRepo(
        success: json['success'],
        data: json['data'],
        msg: json['msg'],
      );
    } catch (error) {
      return CartRepo(
        success: json['success'],
        msg: json['msg'],
        data: null,

      );
    }
  }
}