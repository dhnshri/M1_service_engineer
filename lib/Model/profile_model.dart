class ProfileRepo {
  bool? success;
  String? data;

  ProfileRepo({this.success, this.data});

  factory ProfileRepo.fromJson(Map<dynamic, dynamic> json) {
    try {
      return ProfileRepo(
        success: json['success'],
        data: json['data'],
      );
    } catch (error) {
      return ProfileRepo(
        success: json['success'],
        data: json['data'],
      );
    }
  }
}