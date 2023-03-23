class JobWorkEnquiryTaskHandOverRepo {
  bool? success;
  dynamic data;

  JobWorkEnquiryTaskHandOverRepo({this.success, this.data});

  factory JobWorkEnquiryTaskHandOverRepo.fromJson(Map<dynamic, dynamic> json) {
    try {
      return JobWorkEnquiryTaskHandOverRepo(
        success: json['success'],
        data: json['data'],
      );
    } catch (error) {
      return JobWorkEnquiryTaskHandOverRepo(
        success: false,
        data: null,
      );
    }
  }
}

class JobWorkEnquiryTaskHandOverModel {
  int? serviceUser;
  String? username;
  String? enquiryDetailsCategory;
  int? enquiryCategoryId;
  int? role;

  JobWorkEnquiryTaskHandOverModel(
      {this.serviceUser,
        this.username,
        this.enquiryDetailsCategory,
        this.enquiryCategoryId,
        this.role});

  JobWorkEnquiryTaskHandOverModel.fromJson(Map<String, dynamic> json) {
    serviceUser = json['service_user'];
    username = json['username'];
    enquiryDetailsCategory = json['enquiry_details_category'];
    enquiryCategoryId = json['enquiry_category_id'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['service_user'] = this.serviceUser;
    data['username'] = this.username;
    data['enquiry_details_category'] = this.enquiryDetailsCategory;
    data['enquiry_category_id'] = this.enquiryCategoryId;
    data['role'] = this.role;
    return data;
  }
}