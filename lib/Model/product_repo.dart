class ProductRepo {
  bool? success;
  dynamic data;
  String? msg;

  ProductRepo({this.success, this.data,this.msg});

  factory ProductRepo.fromJson(Map<dynamic, dynamic> json) {
    try {
      return ProductRepo(
        success: json['success'],
        // data: json['data'] != null ? new ServiceRequestRepo.fromJson(json['data']) : null,
        data: json['data'],
        msg: json['msg'],


      );
    } catch (error) {
      return ProductRepo(
        success: json['success'],
        msg: json['msg'],
        data: null,

      );
    }
  }
}

class ProductListRepo {
  dynamic productDetails;
  dynamic productSize;
  dynamic productImage;

  ProductListRepo({this.productDetails, this.productSize, this.productImage});

    factory ProductListRepo.fromJson(Map<dynamic, dynamic> json) {
      try {
        return ProductListRepo(
          productDetails: json['product_details'],
          // data: json['data'] != null ? new ServiceRequestRepo.fromJson(json['data']) : null,
          productSize: json['product_size'],
          productImage: json['product_image'],


        );
      } catch (error) {
        return ProductListRepo(
          productDetails: null,
          productSize: json['product_size'],
          productImage: json['product_image'],

        );
      }
    }
  }

class ProductDetails {
  int? id;
  String? productName;
  int? categoryId;
  int? brandId;
  int? shopId;
  String? price;
  String? discountPrice;
  String? gst;
  int? productQty;
  String? aboutProduct;
  String? offerCoupon;
  String? batteryVoltage;
  String? warranty;
  String? brandName;
  String? categoryName;
  String? shopName;
  int? cartQuantity;
  String? prodImg;

  ProductDetails(
      {this.id,
        this.productName,
        this.categoryId,
        this.brandId,
        this.shopId,
        this.price,
        this.discountPrice,
        this.gst,
        this.productQty,
        this.aboutProduct,
        this.offerCoupon,
        this.batteryVoltage,
        this.warranty,
        this.brandName,
        this.categoryName,
        this.shopName,
        this.cartQuantity,
        this.prodImg});

  ProductDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productName = json['product_name'];
    categoryId = json['category_id'];
    brandId = json['brand_id'];
    shopId = json['shop_id'];
    price = json['price'];
    discountPrice = json['discount_price'];
    gst = json['gst'];
    productQty = json['product_qty'];
    aboutProduct = json['about_product'];
    offerCoupon = json['offer_coupon'];
    batteryVoltage = json['battery_voltage'];
    warranty = json['warranty'];
    brandName = json['brand_name'];
    categoryName = json['category_name'];
    shopName = json['shop_name'];
    cartQuantity = json['cart_qty'];
    prodImg = json['product_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_name'] = this.productName;
    data['category_id'] = this.categoryId;
    data['brand_id'] = this.brandId;
    data['shop_id'] = this.shopId;
    data['price'] = this.price;
    data['discount_price'] = this.discountPrice;
    data['gst'] = this.gst;
    data['product_qty'] = this.productQty;
    data['about_product'] = this.aboutProduct;
    data['offer_coupon'] = this.offerCoupon;
    data['battery_voltage'] = this.batteryVoltage;
    data['warranty'] = this.warranty;
    data['brand_name'] = this.brandName;
    data['category_name'] = this.categoryName;
    data['shop_name'] = this.shopName;
    data['cart_qty'] = this.cartQuantity;
    data['product_image'] = this.prodImg;
    return data;
  }
}