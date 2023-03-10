class ExpCompanyModel {
  int? id;
  String? companyName;
  String? jobPost;
  String? desciption;
  String? fromYear;
  String? fromMonth;
  String? tillYear;
  String? tillMonth;

  ExpCompanyModel({
     this.id,
     this.companyName,
     this.jobPost,
     this.desciption,
     this.fromYear,
     this.fromMonth,
     this.tillYear,
     this.tillMonth,
  });

  ExpCompanyModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    companyName = json['company_name'];
    jobPost = json['job_post'];
    desciption = json['description'];
    fromYear = json['work_from'];
    fromMonth = json['work_from_month'];
    tillYear = json['work_till'];
    tillMonth = json['work_till_month'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['company_name'] = this.companyName;
    data['job_post'] = this.jobPost;
    data['description'] = this.desciption;
    data['work_from'] = this.fromYear;
    data['work_from_month'] = this.fromMonth;
    data['work_till'] = this.tillYear;
    data['work_till_month'] = this.tillMonth;

    return data;
  }
}