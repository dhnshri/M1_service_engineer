class TransportTaskHandOverRepo {
  bool? success;
  dynamic data;

  TransportTaskHandOverRepo({this.success, this.data});

  factory TransportTaskHandOverRepo.fromJson(Map<dynamic, dynamic> json) {
    try {
      return TransportTaskHandOverRepo(
        success: json['success'],
        data: json['data'],
      );
    } catch (error) {
      return TransportTaskHandOverRepo(
        success: false,
        data: null,
      );
    }
  }
}

class TransportTaskHandOverModel {
  int? serviceUser;
  String? vehicleName;
  String? vehicleType;
  int? years;
  int? months;
  int? role;

  TransportTaskHandOverModel(
      {this.serviceUser,
        this.vehicleName,
        this.vehicleType,
        this.years,
        this.months,
        this.role});

  TransportTaskHandOverModel.fromJson(Map<String, dynamic> json) {
    serviceUser = json['service_user'];
    vehicleName = json['vehicle_name'];
    vehicleType = json['vehicle_type'];
    years = json['years'];
    months = json['months'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['service_user'] = this.serviceUser;
    data['vehicle_name'] = this.vehicleName;
    data['vehicle_type'] = this.vehicleType;
    data['years'] = this.years;
    data['months'] = this.months;
    data['role'] = this.role;
    return data;
  }
}