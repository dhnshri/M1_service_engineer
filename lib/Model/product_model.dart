class AvailableProductModel{
  String? id;
  String? name;
  int? quantity;
  bool? ShouldVisible;

  AvailableProductModel({
     this.id,
     this.name,
     this.quantity,
     this.ShouldVisible
  });
}

class ItemModel{
  String? rate;
  String? volume;

  ItemModel({
    this.rate,
    this.volume,
  });
}

