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
  String? gstNo;
  int? workCategoryId;
  int? workSubCategoryId;
  int? age;
  String? gender;
  String? location;
  String? currentAddress;
  String? pincode;
  String? city;
  String? state;
  String? country;
  String? companyName;
  String? companyProfilePic;
  String? userProfilePic;
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
      {this.id,
        this.name,
        this.email,
        this.mobile,
        this.gstNo,
        this.workCategoryId,
        this.workSubCategoryId,
        this.age,
        this.gender,
        this.location,
        this.currentAddress,
        this.pincode,
        this.city,
        this.state,
        this.country,
        this.companyName,
        this.companyProfilePic,
        this.userProfilePic,
        this.username,
        this.password,
        this.rememberToken,
        this.role,
        this.status,
        this.deviceId,
        this.fcmId,
        this.createdAt,
        this.updatedAt});

  CustomerLogin.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    mobile = json['mobile'];
    gstNo = json['gst_no'];
    workCategoryId = json['work_category_id'];
    workSubCategoryId = json['work_sub_category_id'];
    age = json['age'];
    gender = json['gender'];
    location = json['location'];
    currentAddress = json['current_address'];
    pincode = json['pincode'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
    companyName = json['company_name'];
    companyProfilePic = json['company_profile_pic'];
    userProfilePic = json['user_profile_pic'];
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
    data['gst_no'] = this.gstNo;
    data['work_category_id'] = this.workCategoryId;
    data['work_sub_category_id'] = this.workSubCategoryId;
    data['age'] = this.age;
    data['gender'] = this.gender;
    data['location'] = this.location;
    data['current_address'] = this.currentAddress;
    data['pincode'] = this.pincode;
    data['city'] = this.city;
    data['state'] = this.state;
    data['country'] = this.country;
    data['company_name'] = this.companyName;
    data['company_profile_pic'] = this.companyProfilePic;
    data['user_profile_pic'] = this.userProfilePic;
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