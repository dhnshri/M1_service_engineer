class ServiceRequestDetailRepo {
  bool? success;
  dynamic machineServiceDetails;
  dynamic enquiryDetails;
  dynamic transportDetails;
  String? msg;

  ServiceRequestDetailRepo(
      {this.success,
        this.machineServiceDetails,
        this.enquiryDetails,
        this.transportDetails,
        this.msg});

  factory ServiceRequestDetailRepo.fromJson(Map<dynamic, dynamic> json) {
    try {
      return ServiceRequestDetailRepo(
        success: json['success'],
        machineServiceDetails: json['MachineServiceDetails'],
        enquiryDetails: json['EnquiryDetails'],
        transportDetails: json['TransportDetails'],
        msg:json['msg'],

      );
    } catch (error) {
      return ServiceRequestDetailRepo(
        success: json['success'],
        machineServiceDetails: null,
        enquiryDetails: null,
        transportDetails: null,
        msg:json['msg'],
      );
    }
  }
}

class MachineServiceDetailsModel {
  int? machineEnquiryId;
  int? userId;
  int? categoryId;
  String? serviceCategoryName;
  int? subCategoryId;
  int? deliveryStatusId;
  String? deliveryStatus;
  String? serviceSubCategoryName;
  int? otherInformationId;
  String? otherInfoName;
  String? companyName;
  String? location;
  String? machineName;
  String? machineType;
  String? brand;
  String? systemName;
  String? make;
  String? modelNumber;
  String? machineNumber;
  String? machineSize;
  String? manufacturingDate;
  String? machineProblem;
  String? machineImg;
  List<String>? machineProblemImg;
  String? createdAt;
  String? gstNo;
  String? email;

  MachineServiceDetailsModel(
      {this.machineEnquiryId,
        this.userId,
        this.categoryId,
        this.serviceCategoryName,
        this.subCategoryId,
        this.deliveryStatusId,
        this.deliveryStatus,
        this.serviceSubCategoryName,
        this.otherInformationId,
        this.otherInfoName,
        this.companyName,
        this.location,
        this.machineName,
        this.machineType,
        this.brand,
        this.systemName,
        this.make,
        this.modelNumber,
        this.machineNumber,
        this.machineSize,
        this.manufacturingDate,
        this.machineProblem,
        this.machineImg,
        this.machineProblemImg,
        this.createdAt,
        this.gstNo,
        this.email});

  MachineServiceDetailsModel.fromJson(Map<String, dynamic> json) {
    machineEnquiryId = json['machine_enquiry_id'];
    userId = json['user_id'];
    categoryId = json['category_id'];
    serviceCategoryName = json['service_category_name'];
    subCategoryId = json['sub_category_id'];
    deliveryStatusId = json['delivery_status_id'];
    deliveryStatus = json['delivery_status'];
    serviceSubCategoryName = json['service_sub_category_name'];
    otherInformationId = json['other_information_id'];
    otherInfoName = json['other_info_name'];
    companyName = json['company_name'];
    location = json['location'];
    machineName = json['machine_name'];
    machineType = json['machine_type'];
    brand = json['brand'];
    systemName = json['system_name'];
    make = json['make'];
    modelNumber = json['model_number'];
    machineNumber = json['machine_number'];
    machineSize = json['machine_size'];
    manufacturingDate = json['manufacturing_date'];
    machineProblem = json['machine_problem'];
    machineImg = json['machine_img'];
    machineProblemImg = json['machine_problem_img'].cast<String>();
    createdAt = json['created_at'];
    gstNo = json['gst_no'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['machine_enquiry_id'] = this.machineEnquiryId;
    data['user_id'] = this.userId;
    data['category_id'] = this.categoryId;
    data['service_category_name'] = this.serviceCategoryName;
    data['sub_category_id'] = this.subCategoryId;
    data['delivery_status_id'] = this.deliveryStatusId;
    data['delivery_status'] = this.deliveryStatus;
    data['service_sub_category_name'] = this.serviceSubCategoryName;
    data['other_information_id'] = this.otherInformationId;
    data['other_info_name'] = this.otherInfoName;
    data['company_name'] = this.companyName;
    data['location'] = this.location;
    data['machine_name'] = this.machineName;
    data['machine_type'] = this.machineType;
    data['brand'] = this.brand;
    data['system_name'] = this.systemName;
    data['make'] = this.make;
    data['model_number'] = this.modelNumber;
    data['machine_number'] = this.machineNumber;
    data['machine_size'] = this.machineSize;
    data['manufacturing_date'] = this.manufacturingDate;
    data['machine_problem'] = this.machineProblem;
    data['machine_img'] = this.machineImg;
    data['machine_problem_img'] = this.machineProblemImg;
    data['created_at'] = this.createdAt;
    data['gst_no'] = this.gstNo;
    data['email'] = this.email;
    return data;
  }
}