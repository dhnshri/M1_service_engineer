class ServiceRequestTranspotationRepo {
  bool? success;
  String? title;
  dynamic data;
  String? msg;

  ServiceRequestTranspotationRepo(
      {this.success, this.title, this.data, this.msg});

  factory ServiceRequestTranspotationRepo.fromJson(Map<dynamic, dynamic> json) {
    try {
      return ServiceRequestTranspotationRepo(
        success: json['success'],
        title: json['title'],
        msg: json['msg'],
        data: json['data'],
      );
    } catch (error) {
      return ServiceRequestTranspotationRepo(
        success: false,
        title: "",
        msg: "",
        data: null,
      );
    }
  }
}

class ServiceRequestTranspotationModel{
  int? enquiryId;
  int? userId;
  String? dateAndTime;

  ServiceRequestTranspotationModel({this.enquiryId, this.userId, this.dateAndTime});

  ServiceRequestTranspotationModel.fromJson(Map<String, dynamic> json) {
    enquiryId = json['enquiry_id'];
    userId = json['user_id'];
    dateAndTime = json['date_and_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['enquiry_id'] = this.enquiryId;
    data['user_id'] = this.userId;
    data['date_and_time'] = this.dateAndTime;
    return data;
  }
}