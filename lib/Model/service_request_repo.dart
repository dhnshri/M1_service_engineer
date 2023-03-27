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
  int? dailyTaskId;
  int? assignUserId;
  int? serviceUserId;

  ServiceRequestModel(
      {this.enquiryId,
        this.userId,
        this.machineName,
        this.machineImg,
        this.machineProblemImg,
        this.dateAndTime,
        this.dailyTaskId,
        this.assignUserId,
        this.serviceUserId});

  ServiceRequestModel.fromJson(Map<String, dynamic> json) {
    enquiryId = json['enquiry_id'];
    userId = json['user_id'];
    machineName = json['machine_name'];
    machineImg = json['machine_img'];
    machineProblemImg = json['machine_problem_img'];
    dateAndTime = json['date_and_time'];
    dailyTaskId = json['daily_task_id'];
    assignUserId = json['asign_user_id'];
    serviceUserId = json['service_user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['enquiry_id'] = this.enquiryId;
    data['user_id'] = this.userId;
    data['machine_name'] = this.machineName;
    data['machine_img'] = this.machineImg;
    data['machine_problem_img'] = this.machineProblemImg;
    data['date_and_time'] = this.dateAndTime;
    data['daily_task_id'] = this.dailyTaskId;
    data['asign_user_id'] = this.assignUserId;
    data['service_user_id'] = this.serviceUserId;
    return data;
  }
}