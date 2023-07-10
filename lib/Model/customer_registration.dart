class RegistrationRepo {
  dynamic message;
  dynamic user;

  RegistrationRepo({this.message, this.user});

  factory RegistrationRepo.fromJson(Map<dynamic, dynamic> json) {
    try {
      return RegistrationRepo(
        message: json['message'],
        user: json['user'] != null ? new RegistrationModel.fromJson(json['user']) : null,
      );
    } catch (error) {
      return RegistrationRepo(
        message: json['message'],
      );
    }
  }
}

class RegistrationModel {
  String? name;
  String? email;
  String? username;
  String? mobile;
  String? role;
  int? status;
  String? updatedAt;
  String? createdAt;
  int? id;

  RegistrationModel(
      {this.name,
        this.email,
        this.username,
        this.mobile,
        this.role,
        this.status,
        this.updatedAt,
        this.createdAt,
        this.id});

  RegistrationModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    username = json['username'];
    mobile = json['mobile'];
    role = json['role'];
    status = json['status'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['username'] = this.username;
    data['mobile'] = this.mobile;
    data['role'] = this.role;
    data['status'] = this.status;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}