class DashboardCountRepo {
  bool? success;
  int? totalServiceDoneCount;
  int? totalEarningCount;
  int? totalPendingPaymentCount;
  int? totalReceicedPaymentCount;
  String? msg;

  DashboardCountRepo({this.success,
    this.totalServiceDoneCount,
    this.totalEarningCount,
    this.totalPendingPaymentCount,
    this.totalReceicedPaymentCount,
    this.msg});

  factory DashboardCountRepo.fromJson(Map<dynamic, dynamic> json) {
    try {
      return DashboardCountRepo(
        success: json['success'],
        totalServiceDoneCount: json['total_service_done_count'],
        totalEarningCount: json['total_earning_count'],
        totalPendingPaymentCount: json['total_pending_payment_count'],
        totalReceicedPaymentCount: json['total_receiced_payment_count'],


      );
    } catch (error) {
      return DashboardCountRepo(
        msg: json['msg'],
        success: json['success'],
        totalServiceDoneCount: null,
        totalEarningCount: null,
        totalPendingPaymentCount: null,
        totalReceicedPaymentCount: null,

      );
    }
  }

}