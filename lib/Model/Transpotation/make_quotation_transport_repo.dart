class TransportQuotationRepo {
  bool? success;
  String? msg;

  TransportQuotationRepo({this.success, this.msg});

  factory TransportQuotationRepo.fromJson(Map<dynamic, dynamic> json) {
    try {
      return TransportQuotationRepo(
        success: json['success'],
        msg: json['msg'],
      );
    } catch (error) {
      return TransportQuotationRepo(
        success:false,
        msg: null,
      );
    }
  }
}