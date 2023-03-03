class ItemNotAvailableModel {
  int? id;
  String? itemName;
  String? quantity;
  String? rate;
  String? amount;


  ItemNotAvailableModel({
    this.id,
    this.itemName,
    this.quantity,
    this.rate,
    this.amount,
  });
}

class ItemRequiredAmountModel {
  int? id;
  int? amount;


  ItemRequiredAmountModel({
    this.id,
    this.amount,
  });
}