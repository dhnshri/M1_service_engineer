class JobWorkProfileRepo {
  bool? success;
  String? title;
  dynamic profileData;
  String? msg;

  JobWorkProfileRepo({this.success, this.title, this.profileData, this.msg});

  factory JobWorkProfileRepo.fromJson(Map<dynamic, dynamic> json) {
    try {
      return JobWorkProfileRepo(
        success: json['success'],
        title: json['title'],
        profileData: json['ProfileData'],
        msg: json['msg'],
      );
    } catch (error) {
      return JobWorkProfileRepo(
        success: json['success'],
        title: null,
        profileData: null,
        msg: null,

      );
    }
  }

}

class ProfileData {
  List<ServiceUserData>? serviceUserData;
  List<ProfileKYCDetails>? profileKYCDetails;
  List<JobWorkMachineList>? jobWorkMachineList;

  ProfileData(
      {this.serviceUserData, this.profileKYCDetails, this.jobWorkMachineList});

  ProfileData.fromJson(Map<String, dynamic> json) {
    if (json['ServiceUserData'] != null) {
      serviceUserData = <ServiceUserData>[];
      json['ServiceUserData'].forEach((v) {
        serviceUserData!.add(new ServiceUserData.fromJson(v));
      });
    }
    if (json['ProfileKYCDetails'] != null) {
      profileKYCDetails = <ProfileKYCDetails>[];
      json['ProfileKYCDetails'].forEach((v) {
        profileKYCDetails!.add(new ProfileKYCDetails.fromJson(v));
      });
    }
    if (json['JobWorkMachineList'] != null) {
      jobWorkMachineList = <JobWorkMachineList>[];
      json['JobWorkMachineList'].forEach((v) {
        jobWorkMachineList!.add(new JobWorkMachineList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.serviceUserData != null) {
      data['ServiceUserData'] =
          this.serviceUserData!.map((v) => v.toJson()).toList();
    }
    if (this.profileKYCDetails != null) {
      data['ProfileKYCDetails'] =
          this.profileKYCDetails!.map((v) => v.toJson()).toList();
    }
    if (this.jobWorkMachineList != null) {
      data['JobWorkMachineList'] =
          this.jobWorkMachineList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ServiceUserData {
  int? serviceUserId;
  String? coordinateName;
  String? email;
  String? mobile;
  String? gstNo;
  int? categoryId;
  int? subCategoryId;
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
  int? role;

  ServiceUserData(
      {this.serviceUserId,
        this.coordinateName,
        this.email,
        this.mobile,
        this.gstNo,
        this.categoryId,
        this.subCategoryId,
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
        this.role});

  ServiceUserData.fromJson(Map<String, dynamic> json) {
    serviceUserId = json['service_user_id'];
    coordinateName = json['coordinate_name'];
    email = json['email'];
    mobile = json['mobile'];
    gstNo = json['gst_no'];
    categoryId = json['category_id'];
    subCategoryId = json['sub_category_id'];
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
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['service_user_id'] = this.serviceUserId;
    data['coordinate_name'] = this.coordinateName;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    data['gst_no'] = this.gstNo;
    data['category_id'] = this.categoryId;
    data['sub_category_id'] = this.subCategoryId;
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
    data['role'] = this.role;
    return data;
  }
}

class ProfileKYCDetails {
  int? id;
  int? serviceUserId;
  String? companyName;
  String? companyCertificate;
  String? gstCertificate;
  String? panCard;
  String? shopActLicence;
  String? udhyogAdharLicence;

  ProfileKYCDetails(
      {this.id,
        this.serviceUserId,
        this.companyName,
        this.companyCertificate,
        this.gstCertificate,
        this.panCard,
        this.shopActLicence,
        this.udhyogAdharLicence});

  ProfileKYCDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    serviceUserId = json['service_user_id'];
    companyName = json['company_name'];
    companyCertificate = json['company_certificate'];
    gstCertificate = json['gst_certificate'];
    panCard = json['pan_card'];
    shopActLicence = json['shop_act_licence'];
    udhyogAdharLicence = json['udhyog_adhar_licence'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['service_user_id'] = this.serviceUserId;
    data['company_name'] = this.companyName;
    data['company_certificate'] = this.companyCertificate;
    data['gst_certificate'] = this.gstCertificate;
    data['pan_card'] = this.panCard;
    data['shop_act_licence'] = this.shopActLicence;
    data['udhyog_adhar_licence'] = this.udhyogAdharLicence;
    return data;
  }
}

class JobWorkMachineList {
  int? id;
  int? serviceUserId;
  String? machineName;
  int? quantity;

  JobWorkMachineList(
      {this.id, this.serviceUserId, this.machineName, this.quantity});

  JobWorkMachineList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    serviceUserId = json['service_user_id'];
    machineName = json['machine_name'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['service_user_id'] = this.serviceUserId;
    data['machine_name'] = this.machineName;
    data['quantity'] = this.quantity;
    return data;
  }
}