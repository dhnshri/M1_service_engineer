class FilterRepo {
  bool? success;
  dynamic data;

  FilterRepo({this.success, this.data});

  factory FilterRepo.fromJson(Map<dynamic, dynamic> json) {
    try {
      return FilterRepo(
        success: json['success'],
        // data: json['data'] != null ? new ServiceRequestRepo.fromJson(json['data']) : null,
        data: json['data'],


      );
    } catch (error) {
      return FilterRepo(
        success: json['success'],
        data: null,

      );
    }
  }
}

class FilterModule {
  int? brandId;
  String? name;
  int? categoryId;

  FilterModule({this.brandId, this.name});

  FilterModule.fromJson(Map<String, dynamic> json) {
    brandId = json['brand_id'];
    name = json['name'];
    categoryId = json['category_id'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['brand_id'] = this.brandId;
    data['name'] = this.name;
    data['category_id'] = this.categoryId;
    return data;
  }
}