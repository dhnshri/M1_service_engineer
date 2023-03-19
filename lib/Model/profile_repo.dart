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
  String? name;
  int? age;
  String? gender;

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
        this.role,
        this.name,
        this.age,
        this.gender});

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
    name = json['name'];
    age = json['age'];
    gender = json['gender'];
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
    data['name'] = this.name;
    data['age'] = this.gender;
    return data;
  }
}

class ProfileKYCDetails {
  int? id;
  int? serviceUserId;
  String? bankName;
  String? accountNumber;
  String? ifscCode;
  String? upiId;
  String? branchName;
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
        this.udhyogAdharLicence,
        this.bankName,
        this.accountNumber,
        this.ifscCode,
        this.upiId,
        this.branchName});

  ProfileKYCDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    serviceUserId = json['service_user_id'];
    companyName = json['company_name'];
    companyCertificate = json['company_certificate'];
    gstCertificate = json['gst_certificate'];
    panCard = json['pan_card'];
    shopActLicence = json['shop_act_licence'];
    udhyogAdharLicence = json['udhyog_adhar_licence'];
    bankName = json['bank_name'];
    accountNumber = json['account_number'];
    ifscCode = json['ifsc_code'];
    upiId = json['upi_id'];
    branchName = json['branch_name'];
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
    data['bank_name'] = this.bankName;
    data['account_number'] = this.accountNumber;
    data['upi_id'] = this.upiId;
    data['branch_name'] = this.branchName;
    return data;
  }
}

class DriverProfileDetails {
  int? id;
  int? serviceUserId;
  String? fullName;
  String? mobile;
  String? drivingLicenceValidity;
  String? drivingLicenceNumber;
  String? drivingLicence;
  String? idProof;
  String? driverPic;

  DriverProfileDetails(
      {this.id,
        this.serviceUserId,
        this.fullName,
        this.mobile,
        this.drivingLicenceValidity,
        this.drivingLicenceNumber,
        this.drivingLicence,
        this.idProof,
        this.driverPic});

  DriverProfileDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    serviceUserId = json['service_user_id'];
    fullName = json['full_name'];
    mobile = json['mobile'];
    drivingLicenceValidity = json['driving_licence_validity'];
    drivingLicenceNumber = json['driving_licence_number'];
    drivingLicence = json['driving_licence'];
    idProof = json['id_proof'];
    driverPic = json['driver_pic'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['service_user_id'] = this.serviceUserId;
    data['full_name'] = this.fullName;
    data['mobile'] = this.mobile;
    data['driving_licence_validity'] = this.drivingLicenceValidity;
    data['driving_licence_number'] = this.drivingLicenceNumber;
    data['driving_licence'] = this.drivingLicence;
    data['id_proof'] = this.idProof;
    data['driver_pic'] = this.driverPic;
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

class ProfileVehicleInformation {
  int? id;
  int? serviceUserId;
  String? vehicleName;
  String? vehicleType;
  String? chassisNumber;
  String? registrationUpto;
  String? vehicleNumber;
  String? vehicleImg;
  String? uploadRC;
  String? uploadPOC;

  ProfileVehicleInformation(
      {this.id,
        this.serviceUserId,
        this.vehicleName,
        this.vehicleType,
        this.chassisNumber,
        this.registrationUpto,
        this.vehicleNumber,
        this.vehicleImg,
        this.uploadRC,
        this.uploadPOC});

  ProfileVehicleInformation.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    serviceUserId = json['service_user_id'];
    vehicleName = json['vehicle_name'];
    vehicleType = json['vehicle_type'];
    chassisNumber = json['chassis_number'];
    registrationUpto = json['registration_upto'];
    vehicleNumber = json['vehicle_number'];
    vehicleImg = json['vehicle_img'];
    uploadRC = json['upload_RC'];
    uploadPOC = json['upload_POC'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['service_user_id'] = this.serviceUserId;
    data['vehicle_name'] = this.vehicleName;
    data['vehicle_type'] = this.vehicleType;
    data['chassis_number'] = this.chassisNumber;
    data['registration_upto'] = this.registrationUpto;
    data['vehicle_number'] = this.vehicleNumber;
    data['vehicle_img'] = this.vehicleImg;
    data['upload_RC'] = this.uploadRC;
    data['upload_POC'] = this.uploadPOC;
    return data;
  }
}

class TransportProfileExperience {
  int? serviceUserId;
  int? years;
  int? months;
  String? companyName;
  String? description;
  String? workFrom;
  String? workTill;

  TransportProfileExperience(
      {this.serviceUserId,
        this.years,
        this.months,
        this.companyName,
        this.description,
        this.workFrom,
        this.workTill});

  TransportProfileExperience.fromJson(Map<String, dynamic> json) {
    serviceUserId = json['service_user_id'];
    years = json['years'];
    months = json['months'];
    companyName = json['company_name'];
    description = json['description'];
    workFrom = json['work_from'];
    workTill = json['work_till'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['service_user_id'] = this.serviceUserId;
    data['years'] = this.years;
    data['months'] = this.months;
    data['company_name'] = this.companyName;
    data['description'] = this.description;
    data['work_from'] = this.workFrom;
    data['work_till'] = this.workTill;
    return data;
  }
}

class MachineMaintenanceExperiences {
  int? id;
  int? serviceUserId;
  int? yearOfExperience;
  int? monthOfExperience;
  String? companyName;
  String? jobPost;
  String? description;
  String? workFrom;
  String? workTill;

  MachineMaintenanceExperiences(
      {this.id,
        this.serviceUserId,
        this.yearOfExperience,
        this.monthOfExperience,
        this.companyName,
        this.jobPost,
        this.description,
        this.workFrom,
        this.workTill});

  MachineMaintenanceExperiences.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    serviceUserId = json['service_user_id'];
    yearOfExperience = json['year_of_experience'];
    monthOfExperience = json['month_of_experience'];
    companyName = json['company_name'];
    jobPost = json['job_post'];
    description = json['description'];
    workFrom = json['work_from'];
    workTill = json['work_till'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['service_user_id'] = this.serviceUserId;
    data['year_of_experience'] = this.yearOfExperience;
    data['month_of_experience'] = this.monthOfExperience;
    data['company_name'] = this.companyName;
    data['job_post'] = this.jobPost;
    data['description'] = this.description;
    data['work_from'] = this.workFrom;
    data['work_till'] = this.workTill;
    return data;
  }
}

class MachineMaintenanceEducations {
  int? id;
  int? serviceUserId;
  String? schoolName;
  String? courseName;
  String? passingYear;
  String? certificate;

  MachineMaintenanceEducations(
      {this.id,
        this.serviceUserId,
        this.schoolName,
        this.courseName,
        this.passingYear,
        this.certificate});

  MachineMaintenanceEducations.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    serviceUserId = json['service_user_id'];
    schoolName = json['school_name'];
    courseName = json['course_name'];
    passingYear = json['passing_year'];
    certificate = json['certificate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['service_user_id'] = this.serviceUserId;
    data['school_name'] = this.schoolName;
    data['course_name'] = this.courseName;
    data['passing_year'] = this.passingYear;
    data['certificate'] = this.certificate;
    return data;
  }
}