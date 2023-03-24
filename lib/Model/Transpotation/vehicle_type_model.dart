class VehicleTypeRepo {
  bool? success;
  dynamic data;

  VehicleTypeRepo({this.success, this.data});

  factory VehicleTypeRepo.fromJson(Map<dynamic, dynamic> json) {
    try {
      return VehicleTypeRepo(
        success: json['success'],
        data: json['data'],
      );
    } catch (error) {
      return VehicleTypeRepo(
        success: false,
        data: null,
      );
    }
  }
}

class VehicleTypeModel{
  int? transportProfileVehicleInformationId;
  String? vehicleType;

  VehicleTypeModel({this.transportProfileVehicleInformationId, this.vehicleType});

  VehicleTypeModel.fromJson(Map<String, dynamic> json) {
    transportProfileVehicleInformationId =
    json['transport_profile_vehicle_information_id'];
    vehicleType = json['vehicle_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['transport_profile_vehicle_information_id'] =
        this.transportProfileVehicleInformationId;
    data['vehicle_type'] = this.vehicleType;
    return data;
  }
}