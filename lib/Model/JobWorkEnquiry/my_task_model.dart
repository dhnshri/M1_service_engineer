class JobWorkEnquiryMyTaskRepo {
  bool? success;
  String? title;
  dynamic data;
  String? msg;

  JobWorkEnquiryMyTaskRepo({this.success, this.title, this.data, this.msg});

  factory JobWorkEnquiryMyTaskRepo.fromJson(Map<dynamic, dynamic> json) {
    try {
      return JobWorkEnquiryMyTaskRepo(
        success: json['success'],
        title: json['title'],
        msg: json['msg'],
        data: json['data'],
      );
    } catch (error) {
      return JobWorkEnquiryMyTaskRepo(
        success: false,
        title: "",
        msg: "",
        data: null,
      );
    }
  }
}

class JobWorkEnquiryMyTaskModel {
  int? enquiryId;
  int? userId;
  String? itemName;
  String? dateAndTime;
  int? assignUserId;

  JobWorkEnquiryMyTaskModel({this.enquiryId, this.userId, this.itemName, this.dateAndTime});

  JobWorkEnquiryMyTaskModel.fromJson(Map<String, dynamic> json) {
    enquiryId = json['enquiry_id'];
    userId = json['user_id'];
    itemName = json['item_name'];
    dateAndTime = json['date_and_time'];
    assignUserId = json['asign_user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['enquiry_id'] = this.enquiryId;
    data['user_id'] = this.userId;
    data['item_name'] = this.itemName;
    data['date_and_time'] = this.dateAndTime;
    data['asign_user_id'] = this.assignUserId;
    return data;
  }
}