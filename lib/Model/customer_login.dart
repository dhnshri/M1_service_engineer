class CustomerLoginRepo {
  dynamic success;
  dynamic data;

  CustomerLoginRepo({this.success, this.data});

  factory CustomerLoginRepo.fromJson(Map<dynamic, dynamic> json) {
    try {
      return CustomerLoginRepo(
        success: json['success'],
        data: json['data'] != null ? new CustomerLogin.fromJson(json['data']) : null,
      );
    } catch (error) {
      return CustomerLoginRepo(
        success: json['success'],
        data: null,
      );
    }
  }

  // CustomerLoginRepo.fromJson(Map<String, dynamic> json) {
  //   success = json['success'];
  //   data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  // }
  //
  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['success'] = this.success;
  //   if (this.data != null) {
  //     data['data'] = this.data.toJson();
  //   }
  //   return data;
  // }
}

class CustomerLogin {
  int? id;
  String? name;
  String? email;
  String? mobile;
  String? username;
  String? password;
  String? rememberToken;
  int? role;
  int? status;
  String? deviceId;
  String? fcmId;
  String? createdAt;
  String? updatedAt;

  CustomerLogin(
      {
        this.id,
        this.name,
        this.email,
        this.mobile,
        this.username,
        this.password,
        this.rememberToken,
        this.role,
        this.status,
        this.deviceId,
        this.fcmId,
        this.createdAt,
        this.updatedAt
      });

  CustomerLogin.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    mobile = json['mobile'];
    username = json['username'];
    password = json['password'];
    rememberToken = json['remember_token'];
    role = json['role'];
    status = json['status'];
    deviceId = json['device_id'];
    fcmId = json['fcm_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    data['username'] = this.username;
    data['password'] = this.password;
    data['remember_token'] = this.rememberToken;
    data['role'] = this.role;
    data['status'] = this.status;
    data['device_id'] = this.deviceId;
    data['fcm_id'] = this.fcmId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}