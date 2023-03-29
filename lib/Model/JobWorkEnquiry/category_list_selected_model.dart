class JobWorkEnquiryCategoryListRepo {
  bool? success;
  dynamic data;

  JobWorkEnquiryCategoryListRepo({this.success, this.data});

  factory JobWorkEnquiryCategoryListRepo.fromJson(Map<dynamic, dynamic> json) {
    try {
      return JobWorkEnquiryCategoryListRepo(
        success: json['success'],
        data: json['data'],
      );
    } catch (error) {
      return JobWorkEnquiryCategoryListRepo(
        success: false,
        data: null,
      );
    }
  }

}

class JobWorkEnquiryCategoryListModel {
  int? id;
  String? enquiryDetailsCategory;

  JobWorkEnquiryCategoryListModel({this.id, this.enquiryDetailsCategory});

  JobWorkEnquiryCategoryListModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    enquiryDetailsCategory = json['enquiry_details_category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['enquiry_details_category'] = this.enquiryDetailsCategory;
    return data;
  }
}