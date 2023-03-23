class RejectReviseRepo {
  bool? success;
  String? msg;

  RejectReviseRepo({this.success, this.msg});

  factory RejectReviseRepo.fromJson(Map<dynamic, dynamic> json) {
    try {
      return RejectReviseRepo(
        success: json['success'],
        msg: json['msg'],


      );
    } catch (error) {
      return RejectReviseRepo(
        success: json['success'],
        msg: json['msg'],

      );
    }
  }
}