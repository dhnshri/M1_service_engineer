class JobWorkEnquiryDailyTaskAddRepo {
  bool? success;
  String? msg;

  JobWorkEnquiryDailyTaskAddRepo({this.success, this.msg});

  JobWorkEnquiryDailyTaskAddRepo.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['msg'] = this.msg;
    return data;
  }
}

class CreateTaskJWERepo {
  bool? success;
  String? msg;

  CreateTaskJWERepo({this.success, this.msg});

  factory CreateTaskJWERepo.fromJson(Map<dynamic, dynamic> json) {
    try {
      return CreateTaskJWERepo(
        success: json['success'],
        msg: json['msg'],
      );
    } catch (error) {
      return CreateTaskJWERepo(
        success: json['success'],
        msg: json['msg'],
      );
    }
  }
}