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
      );
    } catch (error) {
      return ServiceRequestRepo(
        success: json['success'],
        data: null,
      );
    }
  }
}

class ServiceRequestModel {
  int? machineServiceId;
  int? machineServiceDetailsUserId;
  int? deliveryStatusId;
  String? deliveryStatus;
  String? machineName;
  String? machineImg;
  String? machineProblemImg;
  String? machineServiceDate;

  ServiceRequestModel(
      {this.machineServiceId,
        this.machineServiceDetailsUserId,
        this.deliveryStatusId,
        this.deliveryStatus,
        this.machineName,
        this.machineImg,
        this.machineProblemImg,
        this.machineServiceDate});

  ServiceRequestModel.fromJson(Map<String, dynamic> json) {
    machineServiceId = json['machine_service_id'];
    machineServiceDetailsUserId = json['machine_service_details_user_id'];
    deliveryStatusId = json['delivery_status_id'];
    deliveryStatus = json['delivery_status'];
    machineName = json['machine_name'];
    machineImg = json['machine_img'];
    machineProblemImg = json['machine_problem_img'];
    machineServiceDate = json['machine_service_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['machine_service_id'] = this.machineServiceId;
    data['machine_service_details_user_id'] = this.machineServiceDetailsUserId;
    data['delivery_status_id'] = this.deliveryStatusId;
    data['delivery_status'] = this.deliveryStatus;
    data['machine_name'] = this.machineName;
    data['machine_img'] = this.machineImg;
    data['machine_problem_img'] = this.machineProblemImg;
    data['machine_service_date'] = this.machineServiceDate;
    return data;
  }
}