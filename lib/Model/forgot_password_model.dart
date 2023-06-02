class ForgotPasswordRepo {
  bool? success;
  String? message;

  ForgotPasswordRepo({this.success, this.message});

  factory ForgotPasswordRepo.fromJson(Map<dynamic, dynamic> json) {
    try {
      return ForgotPasswordRepo(
        success: json['success'],
        message: json['message'],


      );
    } catch (error) {
      return ForgotPasswordRepo(
        success: json['success'],
        message: json['message'],
      );
    }
  }
}

class ForgotPasswordModel {

  String? email;

  ForgotPasswordModel(
      {
        this.email,
      });

  ForgotPasswordModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    return data;
  }
}