class TrackProcessRepo {
  bool? success;
  dynamic data;
  String? msg;

  TrackProcessRepo({this.success, this.data, this.msg});

  factory TrackProcessRepo.fromJson(Map<dynamic, dynamic> json) {
    try {
      return TrackProcessRepo(
        success: json['success'],
        // data: json['data'] != null ? new ServiceRequestRepo.fromJson(json['data']) : null,
        data: json['data'],
        msg: json['msg'],
      );
    } catch (error) {
      return TrackProcessRepo(
        success: json['success'],
        data: null,
        msg: json['msg'],
      );
    }
  }
}

class TrackProcessModel {
  int? id;
  int? serviceUserId;
  int? machineEnquiryId;
  int? jobWorkEnquiryId;
  int? transportEnquiryId;
  String? heading;
  String? description;
  String? createdAt;
  String? updatedAt;
  int? status;

  TrackProcessModel(
      {this.id,
        this.serviceUserId,
        this.machineEnquiryId,
        this.jobWorkEnquiryId,
        this.transportEnquiryId,
        this.heading,
        this.description,
        this.createdAt,
        this.updatedAt,
        this.status});

  TrackProcessModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    serviceUserId = json['service_user_id'];
    machineEnquiryId = json['machine_enquiry_id'];
    jobWorkEnquiryId = json['job_work_enquiry_id'];
    transportEnquiryId = json['transport_enquiry_id'];
    heading = json['heading'];
    description = json['description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['service_user_id'] = this.serviceUserId;
    data['machine_enquiry_id'] = this.machineEnquiryId;
    data['job_work_enquiry_id'] = this.jobWorkEnquiryId;
    data['transport_enquiry_id'] = this.transportEnquiryId;
    data['heading'] = this.heading;
    data['description'] = this.description;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['status'] = this.status;
    return data;
  }
}

class CreateTaskRepo {
  bool? success;
  String? msg;

  CreateTaskRepo({this.success, this.msg});

  factory CreateTaskRepo.fromJson(Map<dynamic, dynamic> json) {
    try {
      return CreateTaskRepo(
        success: json['success'],
        msg: json['msg'],
      );
    } catch (error) {
      return CreateTaskRepo(
        success: json['success'],
        msg: json['msg'],
      );
    }
  }
}