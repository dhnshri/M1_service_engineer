class ProfileRepo {
  bool? success;
  String? msg;

  ProfileRepo({this.success, this.msg});

  factory ProfileRepo.fromJson(Map<dynamic, dynamic> json) {
    try {
      return ProfileRepo(
        success: json['success'],
        msg: json['msg'],
      );
    } catch (error) {
      return ProfileRepo(
        success: json['success'],
        msg: json['msg'],
      );
    }
  }
}