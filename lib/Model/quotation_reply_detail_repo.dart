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

class QuotationRequiredItems {
  int? machineMaintenanceQuotationsId;
  int? machineEnquiryId;
  int? serviceCharge;
  int? handlingCharge;
  int? transportCharge;
  String? itemName;
  int? itemQty;
  int? rate;
  int? amount;
  int? commission;
  int? gst;
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
        this.dateAndTime});

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
    return data;
  }
}

class QuotationCharges {
  int? commission;
  int? serviceCharge;
  int? handlingCharge;
  int? transportCharge;
  int? gst;

  QuotationCharges(
      {this.commission,
        this.serviceCharge,
        this.handlingCharge,
        this.transportCharge,
        this.gst});

  QuotationCharges.fromJson(Map<String, dynamic> json) {
    commission = json['commission'];
    serviceCharge = json['service_charge'];
    handlingCharge = json['handling_charge'];
    transportCharge = json['transport_charge'];
    gst = json['gst'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['commission'] = this.commission;
    data['service_charge'] = this.serviceCharge;
    data['handling_charge'] = this.handlingCharge;
    data['transport_charge'] = this.transportCharge;
    data['gst'] = this.gst;
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