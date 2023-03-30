class TrackDataModel {
  int? id;
  int? serviceUserId;
  int? transportEnquiryId;
  int? reachedAtPickupLocation;
  int? loadingCompleted;
  int? onTheWayToDropLocation;
  int? reachesOnDropLocation;
  String? createdAt;
  String? updatedAt;

  TrackDataModel(
      {this.id,
        this.serviceUserId,
        this.transportEnquiryId,
        this.reachedAtPickupLocation,
        this.loadingCompleted,
        this.onTheWayToDropLocation,
        this.reachesOnDropLocation,
        this.createdAt,
        this.updatedAt});

  TrackDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    serviceUserId = json['service_user_id'];
    transportEnquiryId = json['transport_enquiry_id'];
    reachedAtPickupLocation = json['reached_at_pickup_location'];
    loadingCompleted = json['loading_completed'];
    onTheWayToDropLocation = json['on_the_way_to_drop_location'];
    reachesOnDropLocation = json['reaches_on_drop_location'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['service_user_id'] = this.serviceUserId;
    data['transport_enquiry_id'] = this.transportEnquiryId;
    data['reached_at_pickup_location'] = this.reachedAtPickupLocation;
    data['loading_completed'] = this.loadingCompleted;
    data['on_the_way_to_drop_location'] = this.onTheWayToDropLocation;
    data['reaches_on_drop_location'] = this.reachesOnDropLocation;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}