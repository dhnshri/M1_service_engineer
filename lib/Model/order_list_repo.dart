class OrderListRepo {
  bool? success;
  dynamic data;
  String? msg;

  OrderListRepo({this.success, this.data, this.msg});

  factory OrderListRepo.fromJson(Map<dynamic, dynamic> json) {
    try {
      return OrderListRepo(
        success: json['success'],
        data: json['data'],
        msg : json['msg'],


      );
    } catch (error) {
      return OrderListRepo(
        success: json['success'],
        data: null,
        msg :json['msg'],
      );
    }
  }
}

class OrderList {
  int? serviceUserId;
  int? machineMaintenanceQuotationsId;
  int? machineEnquiryId;
  String? itemName;
  int? itemId;
  int? itemStatus;
  int? orderTrackingStatus;
  String? status;
  String? orderPlacedOn;
  int? cancelOrder;
  String? productImage;

  OrderList(
      {this.serviceUserId,
        this.machineMaintenanceQuotationsId,
        this.machineEnquiryId,
        this.itemName,
        this.itemId,
        this.itemStatus,
        this.orderTrackingStatus,
        this.status,
        this.orderPlacedOn,
        this.cancelOrder,
        this.productImage});

  OrderList.fromJson(Map<String, dynamic> json) {
    serviceUserId = json['service_user_id'];
    machineMaintenanceQuotationsId = json['machine_maintenance_quotations_id'];
    machineEnquiryId = json['machine_enquiry_id'];
    itemName = json['item_name'];
    itemId = json['item_id'];
    itemStatus = json['item_status'];
    orderTrackingStatus = json['order_tracking_status'];
    status = json['status'];
    orderPlacedOn = json['order_placed_on'];
    cancelOrder = json['cancel_order'];
    productImage = json['product_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['service_user_id'] = this.serviceUserId;
    data['machine_maintenance_quotations_id'] =
        this.machineMaintenanceQuotationsId;
    data['machine_enquiry_id'] = this.machineEnquiryId;
    data['item_name'] = this.itemName;
    data['item_id'] = this.itemId;
    data['item_status'] = this.itemStatus;
    data['order_tracking_status'] = this.orderTrackingStatus;
    data['status'] = this.status;
    data['order_placed_on'] = this.orderPlacedOn;
    data['cancel_order'] = this.cancelOrder;
    data['product_image'] = this.productImage;
    return data;
  }
}