class JobWorkEnquiryMyTaskDetailRepo {
  bool? success;
  dynamic machineServiceDetails;
  dynamic enquiryDetails;
  dynamic transportDetails;
  String? msg;

  JobWorkEnquiryMyTaskDetailRepo(
      {this.success,
        this.machineServiceDetails,
        this.enquiryDetails,
        this.transportDetails,
        this.msg});

  factory JobWorkEnquiryMyTaskDetailRepo.fromJson(Map<dynamic, dynamic> json) {
    try {
      return JobWorkEnquiryMyTaskDetailRepo(
        success: json['success'],
        machineServiceDetails: json['MachineServiceDetails'],
        enquiryDetails: json['EnquiryDetails'],
        transportDetails: json['TransportDetails'],
        msg:json['msg'],

      );
    } catch (error) {
      return JobWorkEnquiryMyTaskDetailRepo(
        success: json['success'],
        machineServiceDetails: null,
        enquiryDetails: null,
        transportDetails: null,
        msg:json['msg'],
      );
    }
  }
}

class MyTaskEnquiryDetails {
  int? id;
  int? jobWorkEnquiryId;
  int? userId;
  int? categoryId;
  int? deliveryStatusId;
  String? deliveryStatus;
  String? enquiryDetailsCategory;
  String? itemName;
  int? qty;
  String? currentAddress;
  String? pincode;
  int? cityId;
  String? cityName;
  int? stateId;
  String? stateName;
  String? country;
  int? approximateCost;
  String? approximateCostNecessary;
  String? projectComplitionDate;
  String? about;
  String? drawingAttachment;
  String? createdAt;
  String? gstNo;
  String? email;

  MyTaskEnquiryDetails(
      {this.id,
        this.jobWorkEnquiryId,
        this.userId,
        this.categoryId,
        this.deliveryStatusId,
        this.deliveryStatus,
        this.enquiryDetailsCategory,
        this.itemName,
        this.qty,
        this.currentAddress,
        this.pincode,
        this.cityId,
        this.cityName,
        this.stateId,
        this.stateName,
        this.country,
        this.approximateCost,
        this.approximateCostNecessary,
        this.projectComplitionDate,
        this.about,
        this.drawingAttachment,
        this.createdAt,
        this.gstNo,
        this.email});

  MyTaskEnquiryDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    jobWorkEnquiryId = json['job_work_enquiry_id'];
    userId = json['user_id'];
    categoryId = json['category_id'];
    deliveryStatusId = json['delivery_status_id'];
    deliveryStatus = json['delivery_status'];
    enquiryDetailsCategory = json['enquiry_details_category'];
    itemName = json['item_name'];
    qty = json['qty'];
    currentAddress = json['current_address'];
    pincode = json['pincode'];
    cityId = json['city_id'];
    cityName = json['city_name'];
    stateId = json['state_id'];
    stateName = json['state_name'];
    country = json['country'];
    approximateCost = json['approximate_cost'];
    approximateCostNecessary = json['approximate_cost_necessary'];
    projectComplitionDate = json['project_complition_date'];
    about = json['about'];
    drawingAttachment = json['drawing_attachment'];
    createdAt = json['created_at'];
    gstNo = json['gst_no'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['job_work_enquiry_id'] = this.jobWorkEnquiryId;
    data['user_id'] = this.userId;
    data['category_id'] = this.categoryId;
    data['delivery_status_id'] = this.deliveryStatusId;
    data['delivery_status'] = this.deliveryStatus;
    data['enquiry_details_category'] = this.enquiryDetailsCategory;
    data['item_name'] = this.itemName;
    data['qty'] = this.qty;
    data['current_address'] = this.currentAddress;
    data['pincode'] = this.pincode;
    data['city_id'] = this.cityId;
    data['city_name'] = this.cityName;
    data['state_id'] = this.stateId;
    data['state_name'] = this.stateName;
    data['country'] = this.country;
    data['approximate_cost'] = this.approximateCost;
    data['approximate_cost_necessary'] = this.approximateCostNecessary;
    data['project_complition_date'] = this.projectComplitionDate;
    data['about'] = this.about;
    data['drawing_attachment'] = this.drawingAttachment;
    data['created_at'] = this.createdAt;
    data['gst_no'] = this.gstNo;
    data['email'] = this.email;
    return data;
  }
}