class CartRepo {
  bool? success;
  dynamic data;

  CartRepo({this.success, this.data});

  factory CartRepo.fromJson(Map<dynamic, dynamic> json) {
    try {
      return CartRepo(
        success: json['success'],
        // data: json['data'] != null ? new ServiceRequestRepo.fromJson(json['data']) : null,
        data: json['data'],


      );
    } catch (error) {
      return CartRepo(
        success: json['success'],
        data: null,

      );
    }
  }
}