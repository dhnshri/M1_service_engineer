class QuotationReplyJWERepo {
  bool? success;
  String? title;
  dynamic data;
  String? msg;

  QuotationReplyJWERepo({this.success, this.title, this.data, this.msg});

  factory QuotationReplyJWERepo.fromJson(Map<dynamic, dynamic> json) {
    try {
      return QuotationReplyJWERepo(
        success: json['success'],
        title: json['title'],
        msg: json['msg'],
        data: json['data'],
      );
    } catch (error) {
      return QuotationReplyJWERepo(
        success: false,
        title: "",
        msg: "",
        data: null,
      );
    }
  }
}

class QuotationReplyJobWorkEnquiryModel{
  int? id;
  int? enquiryId;
  int? userId;
  String? dateAndTime;

  QuotationReplyJobWorkEnquiryModel({this.id, this.enquiryId, this.userId, this.dateAndTime});

  QuotationReplyJobWorkEnquiryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    enquiryId = json['enquiry_id'];
    userId = json['user_id'];
    dateAndTime = json['date_and_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['enquiry_id'] = this.enquiryId;
    data['user_id'] = this.userId;
    data['date_and_time'] = this.dateAndTime;
    return data;
  }
}