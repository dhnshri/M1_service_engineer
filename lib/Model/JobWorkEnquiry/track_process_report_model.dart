class TrackProgressListJobWorkRepo {
  bool? success;
  dynamic data;
  String? msg;

  TrackProgressListJobWorkRepo({this.success, this.data, this.msg});

  factory TrackProgressListJobWorkRepo.fromJson(Map<dynamic, dynamic> json) {
    try {
      return TrackProgressListJobWorkRepo(
        success: json['success'],
        // data: json['data'] != null ? new ServiceRequestRepo.fromJson(json['data']) : null,
        data: json['data'],
        msg: json['msg'],
      );
    } catch (error) {
      return TrackProgressListJobWorkRepo(
        success: json['success'],
        data: null,
        msg: json['msg'],
      );
    }
  }
}

class TrackProcessJobWorkEnquiryModel {
  int? id;
  int? serviceUserId;
  int? machineEnquiryId;
  int? jobWorkEnquiryId;
  int? transportEnquiryId;
  String? heading;
  String? description;
  int? status;
  String? createdAt;
  String? updatedAt;

  TrackProcessJobWorkEnquiryModel(
      {this.id,
        this.serviceUserId,
        this.machineEnquiryId,
        this.jobWorkEnquiryId,
        this.transportEnquiryId,
        this.heading,
        this.description,
        this.status,
        this.createdAt,
        this.updatedAt});

  TrackProcessJobWorkEnquiryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    serviceUserId = json['service_user_id'];
    machineEnquiryId = json['machine_enquiry_id'];
    jobWorkEnquiryId = json['job_work_enquiry_id'];
    transportEnquiryId = json['transport_enquiry_id'];
    heading = json['heading'];
    description = json['description'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
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
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}