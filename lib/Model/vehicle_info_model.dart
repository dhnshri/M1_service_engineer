class VehicleInfoModel {
  int? id;
  String? vehicleName;
  String? vehicleType;
  String? chasisNumber;
  String? registrationUpto;
  String? vehicleNumber;
  String? vehicleImg;
  String? vehicleRcImage;
  String? vehiclePucImg;

  VehicleInfoModel({
    this.id,
    this.vehicleName,
    this.vehicleType,
    this.chasisNumber,
    this.registrationUpto,
    this.vehicleNumber,
    this.vehicleImg,
    this.vehiclePucImg,
    this.vehicleRcImage
  });

  VehicleInfoModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    vehicleName = json['vehicle_name'];
    vehicleType = json['vehicle_type'];
    chasisNumber = json['chassis_number'];
    registrationUpto = json['registration_upto'];
    vehicleNumber = json['vehicle_number'];
    vehicleImg = json['vehicle_img'];
    vehiclePucImg = json['vehicle_puc'];
    vehicleRcImage = json['vehicle_rc'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['vehicle_name'] = this.vehicleName;
    data['vehicle_type'] = this.vehicleType;
    data['chassis_number'] = this.chasisNumber;
    data['registration_upto'] = this.registrationUpto;
    data['vehicle_number'] = this.vehicleNumber;
    data['vehicle_img'] = this.vehicleImg;
    data['vehicle_puc'] = this.vehiclePucImg;
    data['vehicle_rc'] = this.vehicleRcImage;

    return data;
  }

}

class VehicleImageModel {
  int? id;
  String? vehicleImage;


  VehicleImageModel({
    this.id,
    this.vehicleImage
  });

  VehicleImageModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    vehicleImage = json['vehicle_image'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['vehicle_image'] = this.vehicleImage;
    return data;
  }

}

class VehicleRCImageModel {
  int? id;
  String? vehicleRCImage;


  VehicleRCImageModel({
    this.id,
    this.vehicleRCImage
  });

  VehicleRCImageModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    vehicleRCImage = json['vehicle_rc_image'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['vehicle_rc_image'] = this.vehicleRCImage;
    return data;
  }

}

class VehiclePUCImageModel {
  int? id;
  String? vehiclePUCImage;


  VehiclePUCImageModel({
    this.id,
    this.vehiclePUCImage
  });

  VehiclePUCImageModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    vehiclePUCImage = json['vehicle_puc_image'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['vehicle_puc_image'] = this.vehiclePUCImage;
    return data;
  }

}