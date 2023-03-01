class MyTaskRepo {
  bool? success;
  String? title;
  dynamic data;
  String? msg;

  MyTaskRepo({this.success, this.title, this.data, this.msg});

  factory MyTaskRepo.fromJson(Map<dynamic, dynamic> json) {
    try {
      return MyTaskRepo(
        success: json['success'],
        title: json['title'],
        msg: json['msg'],
        data: json['data'],
      );
    } catch (error) {
      return MyTaskRepo(
        success: false,
        title: "",
        msg: "",
        data: null,
      );
    }
  }
}

class MyTaskModel {
  int? enquiryId;
  int? userId;
  int? taskStatusId;
  String? taskStatus;
  String? machineName;
  String? machineImg;
  String? machineProblemImg;
  String? dateAndTime;

  MyTaskModel(
      {this.enquiryId,
        this.userId,
        this.taskStatusId,
        this.taskStatus,
        this.machineName,
        this.machineImg,
        this.machineProblemImg,
        this.dateAndTime});

  MyTaskModel.fromJson(Map<String, dynamic> json) {
    enquiryId = json['enquiry_id'];
    userId = json['user_id'];
    taskStatusId = json['task_status_id'];
    taskStatus = json['task_status'];
    machineName = json['machine_name'];
    machineImg = json['machine_img'];
    machineProblemImg = json['machine_problem_img'];
    dateAndTime = json['date_and_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['enquiry_id'] = this.enquiryId;
    data['user_id'] = this.userId;
    data['task_status_id'] = this.taskStatusId;
    data['task_status'] = this.taskStatus;
    data['machine_name'] = this.machineName;
    data['machine_img'] = this.machineImg;
    data['machine_problem_img'] = this.machineProblemImg;
    data['date_and_time'] = this.dateAndTime;
    return data;
  }
}