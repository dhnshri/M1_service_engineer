class CartListRepo {
  bool? success;
  dynamic data;
  String? msg;

  CartListRepo({this.success, this.data, this.msg});

  factory CartListRepo.fromJson(Map<dynamic, dynamic> json) {
    try {
      return CartListRepo(
        success: json['success'],
        // data: json['data'] != null ? new ServiceRequestRepo.fromJson(json['data']) : null,
        data: json['data'],
          msg: json['msg'],



      );
    } catch (error) {
      return CartListRepo(
        success: json['success'],
        data: null,
        msg: json['msg'],


      );
    }
  }

}

class CartListModel {
  String? categoryName;
  String? subCategoriesName;
  String? productName;
  String? qty;
  int? productId;
  int? categoryId;
  int? subcategoryId;
  int? userId;
  String? discountPrice;
  String? price;
  String? gst;
  String? cgst;
  String? sgst;
  String? igst;
  String? volume;

  CartListModel(
      {this.categoryName,
        this.subCategoriesName,
        this.productName,
        this.qty,
        this.productId,
        this.categoryId,
        this.subcategoryId,
        this.userId,
        this.discountPrice,
        this.price,
        this.gst,
        this.cgst,
        this.sgst,
        this.igst,

        this.volume});

  CartListModel.fromJson(Map<String, dynamic> json) {
    categoryName = json['category_name'];
    subCategoriesName = json['sub_categories_name'];
    productName = json['product_name'];
    qty = json['qty'];
    productId = json['product_id'];
    categoryId = json['category_id'];
    subcategoryId = json['subcategory_id'];
    userId = json['user_id'];
    discountPrice = json['discount_price'];
    price = json['price'];
    gst = json['gst'];
    cgst = json['cgst'];
    sgst = json['sgst'];
    igst = json['igst'];
    volume = json['volume'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category_name'] = this.categoryName;
    data['sub_categories_name'] = this.subCategoriesName;
    data['product_name'] = this.productName;
    data['qty'] = this.qty;
    data['product_id'] = this.productId;
    data['category_id'] = this.categoryId;
    data['subcategory_id'] = this.subcategoryId;
    data['user_id'] = this.userId;
    data['discount_price'] = this.discountPrice;
    data['price'] = this.price;
    data['gst'] = this.gst;
    data['cgst'] = this.cgst;
    data['sgst'] = this.sgst;
    data['igst'] = this.igst;
    data['volume'] = this.volume;
    return data;
  }
}

class ProductListModel {
  String? qty;
  String? itemId;
  String? itemSize;
  String? discountPrice;
  String? price;
  String? amount;
  String? gst;
  String? cgst;
  String? sgst;
  String? igst;

  ProductListModel(
      {
        this.qty,
        this.itemId,
        this.itemSize,
        this.discountPrice,
        this.price,
        this.amount,
        this.gst,
      this.igst,
      this.sgst,
      this.cgst});

  ProductListModel.fromJson(Map<String, dynamic> json) {

    qty = json['qty'];
    itemId = json['item_id'];
    itemSize = json['item_size'];
    discountPrice = json['discount_price'];
    price = json['price'];
    amount = json['amount'];
    gst = json['gst'];
    cgst = json['cgst'];
    sgst = json['sgst'];
    igst = json['igst'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['qty'] = this.qty;
    data['item_id'] = this.itemId;
    data['item_size'] = this.itemSize;
    data['discount_price'] = this.discountPrice;
    data['price'] = this.price;
    data['amount'] = this.amount;
    data['gst'] = this.gst;
    data['cgst'] = this.cgst;
    data['sgst'] = this.sgst;
    data['igst'] = this.igst;
    return data;
  }
}

class ProductNotAvailableListModel {
  String? qty;
  String? itemId;
  String? itemSize;
  String? discountPrice;
  String? price;
  String? amount;
  String? gst;
  String? cgst;
  String? sgst;
  String? igst;

  ProductNotAvailableListModel(
      {
        this.qty,
        this.itemId,
        this.itemSize,
        this.discountPrice,
        this.price,
        this.amount,
        this.gst,
        this.cgst,
        this.sgst,
        this.igst,
      });

  ProductNotAvailableListModel.fromJson(Map<String, dynamic> json) {

    qty = json['qty'];
    itemId = json['item_id'];
    itemSize = json['item_size'];
    discountPrice = json['discount_price'];
    price = json['price'];
    amount = json['amount'];
    gst = json['gst'];
    cgst = json['cgst'];
    sgst = json['sgst'];
    igst = json['igst'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['qty'] = this.qty;
    data['item_id'] = this.itemId;
    data['item_size'] = this.itemSize;
    data['discount_price'] = this.discountPrice;
    data['price'] = this.price;
    data['amount'] = this.amount;
    data['gst'] = this.gst;
    data['cgst'] = this.cgst;
    data['sgst'] = this.sgst;
    data['igst'] = this.igst;
    return data;
  }
}