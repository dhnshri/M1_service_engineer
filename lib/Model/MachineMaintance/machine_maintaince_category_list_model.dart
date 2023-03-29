class MachineMaintenanceCategoryListRepo {
  bool? success;
  dynamic data;

  MachineMaintenanceCategoryListRepo({this.success, this.data});

  factory MachineMaintenanceCategoryListRepo.fromJson(Map<dynamic, dynamic> json) {
    try {
      return MachineMaintenanceCategoryListRepo(
        success: json['success'],
        data: json['data'],
      );
    } catch (error) {
      return MachineMaintenanceCategoryListRepo(
        success: false,
        data: null,
      );
    }
  }
}

class MachineMaintenanceCategoryListModel {
  int? id;
  String? serviceCategoryName;

  MachineMaintenanceCategoryListModel({this.id, this.serviceCategoryName});

  MachineMaintenanceCategoryListModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    serviceCategoryName = json['service_category_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['service_category_name'] = this.serviceCategoryName;
    return data;
  }
}