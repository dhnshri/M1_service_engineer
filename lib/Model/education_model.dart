class EducationModel {
  int? id;
  String? schoolName;
  String? courseName;
  String? passYear;
  String? certificateImg;


  EducationModel({
    this.id,
    this.schoolName,
    this.courseName,
    this.passYear,
    this.certificateImg
  });

  EducationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    schoolName = json['school_name'];
    courseName = json['course_name'];
    passYear = json['passing_year'];
    certificateImg = json['certificate'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['school_name'] = this.schoolName;
    data['course_name'] = this.courseName;
    data['passing_year'] = this.passYear;
    data['certificate'] = this.certificateImg;

    return data;
  }

}

class EducationCertificateModel {
  int? id;
  String? certificateImg;


  EducationCertificateModel({
    this.id,
    this.certificateImg
  });

  EducationCertificateModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    certificateImg = json['certificate'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['certificate'] = this.certificateImg;
    return data;
  }

}