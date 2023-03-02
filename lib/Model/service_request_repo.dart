class ServiceRequestRepo {
  bool? success;
  String? title;
  dynamic data;
  String? msg;

  ServiceRequestRepo({this.success, this.title, this.data, this.msg});

  factory ServiceRequestRepo.fromJson(Map<dynamic, dynamic> json) {
    try {
      return ServiceRequestRepo(
        success: json['success'],
        // data: json['data'] != null ? new ServiceRequestRepo.fromJson(json['data']) : null,
        data: json['data'],
        title: json['title'],
        msg:json['msg'],

      );
    } catch (error) {
      return ServiceRequestRepo(
        success: json['success'],
        data: null,
        title: json['title'],
        msg:json['msg'],
      );
    }
  }
}

class ServiceRequestModel {
  int? enquiryId;
  int? userId;
  String? machineName;
  String? machineImg;
  String? machineProblemImg;
  String? dateAndTime;

  ServiceRequestModel(
      {this.enquiryId,
        this.userId,
        this.machineName,
        this.machineImg,
        this.machineProblemImg,
        this.dateAndTime});

  ServiceRequestModel.fromJson(Map<String, dynamic> json) {
    enquiryId = json['enquiry_id'];
    userId = json['user_id'];
    machineName = json['machine_name'];
    machineImg = json['machine_img'];
    machineProblemImg = json['machine_problem_img'];
    dateAndTime = json['date_and_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['enquiry_id'] = this.enquiryId;
    data['user_id'] = this.userId;
    data['machine_name'] = this.machineName;
    data['machine_img'] = this.machineImg;
    data['machine_problem_img'] = this.machineProblemImg;
    data['date_and_time'] = this.dateAndTime;
    return data;
  }
}