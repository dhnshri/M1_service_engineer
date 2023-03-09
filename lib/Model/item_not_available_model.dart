class ItemNotAvailableModel {
  int? id;
  String? itemName;
  String? quantity;
  String? rate;
  String? amount;
  String? gst;


  ItemNotAvailableModel({
    this.id,
    this.itemName,
    this.quantity,
    this.rate,
    this.amount,
    this.gst,
  });

  ItemNotAvailableModel.fromJson(Map<String, dynamic> json) {
    id = json['item_id'];
    itemName = json['item_name'];
    quantity = json['item_qty'];
    rate = json['rate'];
    amount = json['amount'];
    gst = json['gst'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['item_id'] = this.id;
    data['item_name'] = this.itemName;
    data['item_qty'] = this.quantity;
    data['rate'] = this.rate;
    data['amount'] = this.amount;
    data['gst'] = this.gst;

    return data;
  }
}

class ItemRequiredAmountModel {
  int? id;
  int? amount;


  ItemRequiredAmountModel({
    this.id,
    this.amount,
  });
}