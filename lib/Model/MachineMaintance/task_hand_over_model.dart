class MachineMaintanceTaskHandOverRepo {
  bool? success;
  dynamic data;

  MachineMaintanceTaskHandOverRepo({this.success, this.data});

  factory MachineMaintanceTaskHandOverRepo.fromJson(Map<dynamic, dynamic> json) {
    try {
      return MachineMaintanceTaskHandOverRepo(
        success: json['success'],
        data: json['data'],
      );
    } catch (error) {
      return MachineMaintanceTaskHandOverRepo(
        success: false,
        data: null,
      );
    }
  }
}

class MachineMaintanceTaskHandOverModel {
  int? serviceUser;
  String? username;
  int? serviceCategoriesId;
  String? serviceCategoryName;
  String? serviceSubCategoryName;
  int? serviceSubCategoriesId;
  int? yearOfExperience;
  int? monthOfExperience;
  int? role;

  MachineMaintanceTaskHandOverModel(
      {this.serviceUser,
        this.username,
        this.serviceCategoriesId,
        this.serviceCategoryName,
        this.serviceSubCategoryName,
        this.serviceSubCategoriesId,
        this.yearOfExperience,
        this.monthOfExperience,
        this.role});

  MachineMaintanceTaskHandOverModel.fromJson(Map<String, dynamic> json) {
    serviceUser = json['service_user'];
    username = json['username'];
    serviceCategoriesId = json['service_categories_id'];
    serviceCategoryName = json['service_category_name'];
    serviceSubCategoryName = json['service_sub_category_name'];
    serviceSubCategoriesId = json['service_sub_categories_id'];
    yearOfExperience = json['year_of_experience'];
    monthOfExperience = json['month_of_experience'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['service_user'] = this.serviceUser;
    data['username'] = this.username;
    data['service_categories_id'] = this.serviceCategoriesId;
    data['service_category_name'] = this.serviceCategoryName;
    data['service_sub_category_name'] = this.serviceSubCategoryName;
    data['service_sub_categories_id'] = this.serviceSubCategoriesId;
    data['year_of_experience'] = this.yearOfExperience;
    data['month_of_experience'] = this.monthOfExperience;
    data['role'] = this.role;
    return data;
  }
}