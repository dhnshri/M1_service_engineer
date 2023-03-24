class VehicleNumberRepo {
  bool? success;
  dynamic data;

  VehicleNumberRepo({this.success, this.data});

  factory VehicleNumberRepo.fromJson(Map<dynamic, dynamic> json) {
    try {
      return VehicleNumberRepo(
        success: json['success'],
        data: json['data'],
      );
    } catch (error) {
      return VehicleNumberRepo(
        success: false,
        data: null,
      );
    }
  }
}

class VehicleNumberModel {
  int? transportProfileVehicleInformationId;
  String? vehicleNumber;

  VehicleNumberModel({this.transportProfileVehicleInformationId, this.vehicleNumber});

  VehicleNumberModel.fromJson(Map<String, dynamic> json) {
    transportProfileVehicleInformationId =
    json['transport_profile_vehicle_information_id'];
    vehicleNumber = json['vehicle_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['transport_profile_vehicle_information_id'] =
        this.transportProfileVehicleInformationId;
    data['vehicle_number'] = this.vehicleNumber;
    return data;
  }
}