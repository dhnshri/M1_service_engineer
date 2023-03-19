class VehicleNameRepo {
  bool? success;
  dynamic data;

  VehicleNameRepo({this.success, this.data});

  factory VehicleNameRepo.fromJson(Map<dynamic, dynamic> json) {
    try {
      return VehicleNameRepo(
        success: json['success'],
        data: json['data'],
      );
    } catch (error) {
      return VehicleNameRepo(
        success:false,
        data: null,
      );
    }
  }
}

class VehicleNameModel{
  int? transportProfileVehicleInformationId;
  String? vehicleName;

  VehicleNameModel({this.transportProfileVehicleInformationId, this.vehicleName});

  VehicleNameModel.fromJson(Map<String, dynamic> json) {
    transportProfileVehicleInformationId =
    json['transport_profile_vehicle_information_id'];
    vehicleName = json['vehicle_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['transport_profile_vehicle_information_id'] =
        this.transportProfileVehicleInformationId;
    data['vehicle_name'] = this.vehicleName;
    return data;
  }
}