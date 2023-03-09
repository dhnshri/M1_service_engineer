class QuotationReplyTransportRepo {
  bool? success;
  String? title;
  dynamic data;
  String? msg;

  QuotationReplyTransportRepo({this.success, this.title, this.data, this.msg});

  factory QuotationReplyTransportRepo.fromJson(Map<dynamic, dynamic> json) {
    try {
      return QuotationReplyTransportRepo(
        success: json['success'],
        title: json['title'],
        msg: json['msg'],
        data: json['data'],
      );
    } catch (error) {
      return QuotationReplyTransportRepo(
        success: false,
        title: "",
        msg: "",
        data: null,
      );
    }
  }
}

class QuotationReplyTransportModel{
  int? id;
  int? enquiryId;
  int? userId;
  String? dateAndTime;

  QuotationReplyTransportModel({this.id, this.enquiryId, this.userId, this.dateAndTime});

  QuotationReplyTransportModel.fromJson(Map<String, dynamic> json) {
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