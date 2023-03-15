class QuotaionReplyDetailRepo {
  bool? success;
  dynamic quotationRequiredItems;
  dynamic quotationOtherItems;
  dynamic quotationCharges;
  dynamic customerReplyMsg;

  QuotaionReplyDetailRepo(
      {this.success,
        this.quotationRequiredItems,
        this.quotationOtherItems,
        this.quotationCharges,
        this.customerReplyMsg});

  factory QuotaionReplyDetailRepo.fromJson(Map<dynamic, dynamic> json) {
    try {
      return QuotaionReplyDetailRepo(
        success: json['success'],
        quotationRequiredItems: json['Quotation_required_items'],
        quotationOtherItems: json['Quotation_Other_items'],
        quotationCharges: json['QuotationCharges'],
        customerReplyMsg: json['customer_reply_msg'],
      );
    } catch (error) {
      return QuotaionReplyDetailRepo(
        success: json['success'],
        quotationRequiredItems: null,
        quotationOtherItems: null,
        quotationCharges: null,
        customerReplyMsg: null,

      );
    }
  }

}

class JobWorkQuotaionReplyDetailRepo {
  bool? success;
  dynamic quotationRequiredItems;
  dynamic quotationCharges;
  dynamic customerReplyMsg;

  JobWorkQuotaionReplyDetailRepo(
      {this.success,
        this.quotationRequiredItems,
        this.quotationCharges,
        this.customerReplyMsg});

  factory JobWorkQuotaionReplyDetailRepo.fromJson(Map<dynamic, dynamic> json) {
    try {
      return JobWorkQuotaionReplyDetailRepo(
        success: json['success'],
        quotationRequiredItems: json['JobWorkQuotation'],
        quotationCharges: json['QuotationCharges'],
        customerReplyMsg: json['customer_reply_msg'],
      );
    } catch (error) {
      return JobWorkQuotaionReplyDetailRepo(
        success: json['success'],
        quotationRequiredItems: null,
        quotationCharges: null,
        customerReplyMsg: null,

      );
    }
  }

}

class TransportQuotaionReplyDetailRepo {
  bool? success;
  dynamic vehicleDetails;
  dynamic quotationDetails;
  dynamic quotationCharges;
  dynamic customerReplyMsg;

  TransportQuotaionReplyDetailRepo(
      {this.success,
        this.vehicleDetails,
        this.quotationDetails,
        this.quotationCharges,
        this.customerReplyMsg});

  factory TransportQuotaionReplyDetailRepo.fromJson(Map<dynamic, dynamic> json) {
    try {
      return TransportQuotaionReplyDetailRepo(
        success: json['success'],
        vehicleDetails: json['VehicleDetails'],
        quotationDetails: json['QuotationDetails'],
        quotationCharges: json['Quotation'],
        customerReplyMsg: json['customer_reply_msg'],
      );
    } catch (error) {
      return TransportQuotaionReplyDetailRepo(
        success: json['success'],
        vehicleDetails: null,
        quotationDetails: null,
        quotationCharges: null,
        customerReplyMsg: null,

      );
    }
  }

}

class VehicleDetails {
  String? vehicleName;
  String? vehicleNumber;
  String? vehicleType;
  String? gstNo;

  VehicleDetails(
      {this.vehicleName, this.vehicleNumber, this.vehicleType, this.gstNo});

  VehicleDetails.fromJson(Map<String, dynamic> json) {
    vehicleName = json['vehicle_name'];
    vehicleNumber = json['vehicle_number'];
    vehicleType = json['vehicle_type'];
    gstNo = json['gst_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['vehicle_name'] = this.vehicleName;
    data['vehicle_number'] = this.vehicleNumber;
    data['vehicle_type'] = this.vehicleType;
    data['gst_no'] = this.gstNo;
    return data;
  }
}

class QuotationRequiredItems {
  int? machineMaintenanceQuotationsId;
  int? machineEnquiryId;
  int? jobWorkItemId;
  int? serviceCharge;
  int? handlingCharge;
  int? transportCharge;
  int? packingCharge;
  int? testingCharge;
  String? itemName;
  int? itemQty;
  int? rate;
  int? amount;
  int? commission;
  int? gst;
  int? cgst;
  int? igst;
  int? sgst;
  String? dateAndTime;

  QuotationRequiredItems(
      {this.machineMaintenanceQuotationsId,
        this.machineEnquiryId,
        this.serviceCharge,
        this.handlingCharge,
        this.transportCharge,
        this.itemName,
        this.itemQty,
        this.rate,
        this.amount,
        this.commission,
        this.gst,
        this.dateAndTime,
        this.jobWorkItemId,
        this.igst,
        this.sgst,
        this.cgst,
        this.testingCharge,
        this.packingCharge});

  QuotationRequiredItems.fromJson(Map<String, dynamic> json) {
    machineMaintenanceQuotationsId = json['machine_maintenance_quotations_id'];
    machineEnquiryId = json['machine_enquiry_id'];
    serviceCharge = json['service_charge'];
    handlingCharge = json['handling_charge'];
    transportCharge = json['transport_charge'];
    itemName = json['item_name'];
    itemQty = json['item_qty'];
    rate = json['rate'];
    amount = json['amount'];
    commission = json['commission'];
    gst = json['gst'];
    dateAndTime = json['date_and_time'];
    jobWorkItemId = json['id'];
    igst = json['igst'];
    sgst = json['sgst'];
    cgst = json['cgst'];
    packingCharge = json['packing_charge'];
    testingCharge = json['testing_charge'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['machine_maintenance_quotations_id'] =
        this.machineMaintenanceQuotationsId;
    data['machine_enquiry_id'] = this.machineEnquiryId;
    data['service_charge'] = this.serviceCharge;
    data['handling_charge'] = this.handlingCharge;
    data['transport_charge'] = this.transportCharge;
    data['item_name'] = this.itemName;
    data['item_qty'] = this.itemQty;
    data['rate'] = this.rate;
    data['amount'] = this.amount;
    data['commission'] = this.commission;
    data['gst'] = this.gst;
    data['date_and_time'] = this.dateAndTime;
    data['id'] = this.jobWorkItemId;
    data['igst'] = this.igst;
    data['sgst'] = this.sgst;
    data['cgst'] = this.cgst;
    data['testing_charge'] = this.testingCharge;
    data['packing_charge'] = this.packingCharge;
    return data;
  }
}

class QuotationCharges {
  int? commission;
  int? serviceCharge;
  int? handlingCharge;
  int? transportCharge;
  int? gst;
  int? igst;
  int? sgst;
  int? cgst;

  QuotationCharges(
      {this.commission,
        this.serviceCharge,
        this.handlingCharge,
        this.transportCharge,
        this.gst,
        this.igst,
        this.cgst,
        this.sgst});

  QuotationCharges.fromJson(Map<String, dynamic> json) {
    commission = json['commission'];
    serviceCharge = json['service_charge'];
    handlingCharge = json['handling_charge'];
    transportCharge = json['transport_charge'];
    gst = json['gst'];
    igst = json['igst'];
    cgst = json['cgst'];
    sgst = json['sgst'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['commission'] = this.commission;
    data['service_charge'] = this.serviceCharge;
    data['handling_charge'] = this.handlingCharge;
    data['transport_charge'] = this.transportCharge;
    data['gst'] = this.gst;
    data['igst'] = this.igst;
    data['cgst'] = this.cgst;
    data['sgst'] = this.sgst;
    return data;
  }
}

class CustomerReplyMsg {
  String? message;

  CustomerReplyMsg({this.message});

  CustomerReplyMsg.fromJson(Map<String, dynamic> json) {
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    return data;
  }
}