class TranspotationServiceRequestDetailRepo {
  bool? success;
  dynamic machineServiceDetails;
  dynamic enquiryDetails;
  dynamic transportDetails;
  String? msg;

  TranspotationServiceRequestDetailRepo(
      {this.success,
        this.machineServiceDetails,
        this.enquiryDetails,
        this.transportDetails,
        this.msg});

  factory TranspotationServiceRequestDetailRepo.fromJson(Map<dynamic, dynamic> json) {
    try {
      return TranspotationServiceRequestDetailRepo(
        success: json['success'],
        machineServiceDetails: json['MachineServiceDetails'],
        enquiryDetails: json['EnquiryDetails'],
        transportDetails: json['TransportDetails'],
        msg:json['msg'],

      );
    } catch (error) {
      return TranspotationServiceRequestDetailRepo(
        success: json['success'],
        machineServiceDetails: null,
        enquiryDetails: null,
        transportDetails: null,
        msg:json['msg'],
      );
    }
  }
}

class TransportDetailsModel {
  int? transportEnquiryId;
  int? userId;
  int? vehicleTypeId;
  String? vehicleType;
  int? deliveryStatusId;
  String? deliveryStatus;
  String? pickupLocation;
  String? dropLocation;
  String? loadType;
  String? loadWeight;
  String? loadSize;
  String? about;
  String? createdAt;
  String? gstNo;
  String? email;

  TransportDetailsModel(
      {this.transportEnquiryId,
        this.userId,
        this.vehicleTypeId,
        this.vehicleType,
        this.deliveryStatusId,
        this.deliveryStatus,
        this.pickupLocation,
        this.dropLocation,
        this.loadType,
        this.loadWeight,
        this.loadSize,
        this.about,
        this.createdAt,
        this.gstNo,
        this.email});

  TransportDetailsModel.fromJson(Map<String, dynamic> json) {
    transportEnquiryId = json['transport_enquiry_id'];
    userId = json['user_id'];
    vehicleTypeId = json['vehicle_type_id'];
    vehicleType = json['vehicle_type'];
    deliveryStatusId = json['delivery_status_id'];
    deliveryStatus = json['delivery_status'];
    pickupLocation = json['pickup_location'];
    dropLocation = json['drop_location'];
    loadType = json['load_type'];
    loadWeight = json['load_weight'];
    loadSize = json['load_size'];
    about = json['about'];
    createdAt = json['created_at'];
    gstNo = json['gst_no'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['transport_enquiry_id'] = this.transportEnquiryId;
    data['user_id'] = this.userId;
    data['vehicle_type_id'] = this.vehicleTypeId;
    data['vehicle_type'] = this.vehicleType;
    data['delivery_status_id'] = this.deliveryStatusId;
    data['delivery_status'] = this.deliveryStatus;
    data['pickup_location'] = this.pickupLocation;
    data['drop_location'] = this.dropLocation;
    data['load_type'] = this.loadType;
    data['load_weight'] = this.loadWeight;
    data['load_size'] = this.loadSize;
    data['about'] = this.about;
    data['created_at'] = this.createdAt;
    data['gst_no'] = this.gstNo;
    data['email'] = this.email;
    return data;
  }
}