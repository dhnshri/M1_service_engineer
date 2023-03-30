class OrderRepo {
  bool? success;
  dynamic data;
  String? msg;

  OrderRepo({this.success, this.data, this.msg});

  factory OrderRepo.fromJson(Map<dynamic, dynamic> json) {
    try {
      return OrderRepo(
        success: json['success'],
        data: json['data'],
          msg : json['msg'],


      );
    } catch (error) {
      return OrderRepo(
        success: json['success'],
        data: json['data'],
          msg :json['msg'],
      );
    }
  }
}

class OrderModel {
  int? serviceUserId;
  int? machineMaintenanceQuotationsId;
  int? machineEnquiryId;
  int? serviceCharge;
  int? handlingCharge;
  int? transportCharge;
  String? itemName;
  int? itemId;
  int? itemQty;
  int? rate;
  int? amount;
  int? totalAmount;
  int? commission;
  int? gst;
  int? itemStatus;
  int? orderTrackingStatus;
  String? status;
  String? prodImage;

  OrderModel(
      {this.serviceUserId,
        this.machineMaintenanceQuotationsId,
        this.machineEnquiryId,
        this.serviceCharge,
        this.handlingCharge,
        this.transportCharge,
        this.itemName,
        this.itemId,
        this.itemQty,
        this.rate,
        this.amount,
        this.totalAmount,
        this.commission,
        this.gst,
        this.itemStatus,
        this.orderTrackingStatus,
        this.status,
        this.prodImage});

  OrderModel.fromJson(Map<String, dynamic> json) {
    serviceUserId = json['service_user_id'];
    machineMaintenanceQuotationsId = json['machine_maintenance_quotations_id'];
    machineEnquiryId = json['machine_enquiry_id'];
    serviceCharge = json['service_charge'];
    handlingCharge = json['handling_charge'];
    transportCharge = json['transport_charge'];
    itemName = json['item_name'];
    itemId = json['item_id'];
    itemQty = json['item_qty'];
    rate = json['rate'];
    amount = json['amount'];
    totalAmount = json['total_amount'];
    commission = json['commission'];
    gst = json['gst'];
    itemStatus = json['item_status'];
    orderTrackingStatus = json['order_tracking_status'];
    status = json['status'];
    prodImage = json['product_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['service_user_id'] = this.serviceUserId;
    data['machine_maintenance_quotations_id'] =
        this.machineMaintenanceQuotationsId;
    data['machine_enquiry_id'] = this.machineEnquiryId;
    data['service_charge'] = this.serviceCharge;
    data['handling_charge'] = this.handlingCharge;
    data['transport_charge'] = this.transportCharge;
    data['item_name'] = this.itemName;
    data['item_id'] = this.itemId;
    data['item_qty'] = this.itemQty;
    data['rate'] = this.rate;
    data['amount'] = this.amount;
    data['total_amount'] = this.totalAmount;
    data['commission'] = this.commission;
    data['gst'] = this.gst;
    data['item_status'] = this.itemStatus;
    data['order_tracking_status'] = this.orderTrackingStatus;
    data['status'] = this.status;
    data['product_image'] = this.prodImage;
    return data;
  }
}