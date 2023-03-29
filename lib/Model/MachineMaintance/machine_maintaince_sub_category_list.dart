class MachineMaintenanceSubCategoryListRepo {
  bool? success;
  dynamic data;

  MachineMaintenanceSubCategoryListRepo({this.success, this.data});

  factory MachineMaintenanceSubCategoryListRepo.fromJson(Map<dynamic, dynamic> json) {
    try {
      return MachineMaintenanceSubCategoryListRepo(
        success: json['success'],
        data: json['data'],
      );
    } catch (error) {
      return MachineMaintenanceSubCategoryListRepo(
        success: false,
        data: null,
      );
    }
  }
}

class MachineMaintenanceSubCategoryListModel {
  int? id;
  int? serviceCategoryId;
  String? serviceSubCategoryName;

  MachineMaintenanceSubCategoryListModel({this.id, this.serviceCategoryId, this.serviceSubCategoryName});

  MachineMaintenanceSubCategoryListModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    serviceCategoryId = json['service_category_id'];
    serviceSubCategoryName = json['service_sub_category_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['service_category_id'] = this.serviceCategoryId;
    data['service_sub_category_name'] = this.serviceSubCategoryName;
    return data;
  }
}