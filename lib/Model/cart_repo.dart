class CartRepo {
  bool? success;
  dynamic data;
  String? msg;

  CartRepo({this.success, this.data,this.msg});

  factory CartRepo.fromJson(Map<dynamic, dynamic> json) {
    try {
      return CartRepo(
        success: json['success'],
        // data: json['data'] != null ? new ServiceRequestRepo.fromJson(json['data']) : null,
        data: json['data'],
        msg: json['msg'],
      );
    } catch (error) {
      return CartRepo(
        success: json['success'],
        msg: json['msg'],
        data: null,

      );
    }
  }
}