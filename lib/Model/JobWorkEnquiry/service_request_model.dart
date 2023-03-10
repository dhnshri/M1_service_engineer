class JobWorkEnquiryServiceRequestRepo {
  bool? success;
  String? title;
  dynamic data;
  String? msg;

  JobWorkEnquiryServiceRequestRepo(
      {this.success, this.title, this.data, this.msg});

  factory JobWorkEnquiryServiceRequestRepo.fromJson(Map<dynamic, dynamic> json) {
    try {
      return JobWorkEnquiryServiceRequestRepo(
        success: json['success'],
        title: json['title'],
        msg: json['msg'],
        data: json['data'],
      );
    } catch (error) {
      return JobWorkEnquiryServiceRequestRepo(
        success: false,
        title: "",
        msg: "",
        data: null,
      );
    }
  }
}

class JobWorkEnquiryServiceRequestModel{
  int? enquiryId;
  int? userId;
  String? itemName;
  String? dateAndTime;

  JobWorkEnquiryServiceRequestModel({this.enquiryId, this.userId, this.itemName, this.dateAndTime});

  JobWorkEnquiryServiceRequestModel.fromJson(Map<String, dynamic> json) {
    enquiryId = json['enquiry_id'];
    userId = json['user_id'];
    itemName = json['item_name'];
    dateAndTime = json['date_and_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['enquiry_id'] = this.enquiryId;
    data['user_id'] = this.userId;
    data['item_name'] = this.itemName;
    data['date_and_time'] = this.dateAndTime;
    return data;
  }
}