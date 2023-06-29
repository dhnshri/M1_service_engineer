class ItemNotAvailableModel {
  int? id;
  String? itemName;
  String? quantity;
  String? rate;
  String? amount;
  String? gst;
  String? cgst;
  String? sgst;
  String? igst;


  ItemNotAvailableModel({
    this.id,
    this.itemName,
    this.quantity,
    this.rate,
    this.amount,
    this.gst,
    this.cgst,
    this.sgst,
    this.igst
  });

  ItemNotAvailableModel.fromJson(Map<String, dynamic> json) {
    id = json['item_id'];
    itemName = json['item_name'];
    quantity = json['item_qty'];
    rate = json['rate'];
    amount = json['amount'];
    gst = json['gst'];
    cgst = json['cgst'];
    sgst = json['sgst'];
    igst = json['igst'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['item_id'] = this.id;
    data['item_name'] = this.itemName;
    data['item_qty'] = this.quantity;
    data['rate'] = this.rate;
    data['amount'] = this.amount;
    data['gst'] = this.gst;
    data['cgst'] = this.cgst;
    data['sgst'] = this.sgst;
    data['igst'] = this.igst;

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