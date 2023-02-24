import 'dart:convert';
import 'package:service_engineer/Model/customer_login.dart';

import '../Api/api.dart';
import '../Utils/preferences.dart';
import '../Utils/util_preferences.dart';



class UserRepository {

  Future<dynamic> savePhoneNo(String phoneNo) async {
    return await UtilPreferences.setString(
      Preferences.phoneNo,
      phoneNo,
    );
  }

  dynamic getPhoneNo() {
      return UtilPreferences.getString(Preferences.phoneNo);
    }

  Future<dynamic> saveRole(String role) async {
    return await UtilPreferences.setString(
      Preferences.role,
      role,
    );
  }

  dynamic getRole() {
    return UtilPreferences.getString(Preferences.role);
  }

  // ///Fetch api, required String deviceID login
  Future<dynamic> login({String? username,String? password,String? token,String? deviceID}) async {
    final params = {"username":username,"password":password, "token": token,"device_id": deviceID};
    return await Api.login(params);
  }

  Future<dynamic> registration({String? fullname,String? createPassword,String? reCreatePassword,String? email,String? mobileNo,String? role,String? username}) async {
    final params = {
      'name':fullname,
      'password':createPassword,
      'password_confirmation':reCreatePassword,
      'username':username,
      'email':email,
      'mobile':mobileNo,
      'role':role,};
    return await Api.registration(params);
  }
  // Future<dynamic> fetchCategory({String? perPage, String? startFrom}) async {
  //   final params = {"per_page":perPage,
  //     "start_from":startFrom};
  //   return await Api.getCategory(params);
  // }
  //
  // Future<dynamic> fetchProductCategory({String? ssCatId}) async {
  //   final params = {"sscat_id":ssCatId};
  //   return await Api.getCategoryProduct(params);
  // }
  //
  // //Fetch User Profile
  // Future<dynamic> fetchUserProfile({String? user_id}) async {
  //   final params = {"user_id":user_id,};
  //   return await Api.userProfile(params);
  // }
  //
  // //Contact Us api
  // Future<dynamic> contactUs({String? name,String? email,String? mobileNo,String? message}) async {
  //   final params = {"name":name, "email":email,"mobile_no":mobileNo,"message": message};
  //   return await Api.contactUs(params);
  // }
  //
  // //fetch myOrders
  // Future<dynamic> fetchMyOrdersList({String? userId}) async
  // {
  //   final params = {"user_id":userId};
  //   return await Api.getOrdersList(params);
  // }
  // //fetch myOrders
  // Future<dynamic> fetchOrdersDetail({String? orderId}) async
  // {
  //   final params = {"order_id":orderId};
  //   return await Api.getOrdersList(params);
  // }
  //
  // ///Get Product
  // Future<dynamic> fetchHomeProduct({String? limit}) async {
  //   final params = {"limit":limit};
  //   return await Api.getHomeProduct(params);
  // }
  //
  // ///Search Product
  // Future<dynamic> searchProduct({String? ProductName}) async {
  //   final params = {"product_name":ProductName};
  //   return await Api.searchAllProduct(params);
  // }
  //
  // ///Get Product
  // Future<dynamic> fetchOrderProduct({ String? sscatId}) async {
  //   final params = {"sscatId":sscatId};
  //   return await Api.getCategoryProduct(params);
  // }
  //
  // //track order
  // Future<dynamic> fetchTrackOrdersList({String? orderId}) async
  // {
  //   final params = {"order_id":orderId};
  //   return await Api.getTrackOrderList(params);
  // }
  // ///Get Banner
  // Future<dynamic> fetchHomeBanner() async {
  //   return await Api.getHomeBanner();
  // }
  //
  // ///Get Address list
  // Future<dynamic> fetchAddressList({String? user_id}) async {
  //   final params = {"user_id":user_id};
  //   return await Api.getAddressList(params);
  // }
  //
  // Future<dynamic> addAddress({String? user_id, String? streetAddress, String? city,String? state,String? pincode}) async {
  //   final params = {
  //     "user_id":user_id,
  //     "street_address":streetAddress,
  //     "city":city,
  //     "state":state,
  //     "pincode":pincode,};
  //   return await Api.addAddress(params);
  // }
  //
  // Future<dynamic> editAddress({String? id,String? user_id, String? streetAddress, String? city,String? state,String? pincode}) async {
  //   final params = {
  //     "id": id,
  //     "user_id":user_id,
  //     "street_address":streetAddress,
  //     "city":city,
  //     "state":state,
  //     "pincode":pincode,};
  //   return await Api.editAddress(params);
  // }
  //
  //
  // Future<dynamic> deleteAddress({String? user_id, String? id}) async {
  //   final params = {
  //     "user_id":user_id,
  //     "id":id,
  //     };
  //   return await Api.deleteAddress(params);
  // }
  //
  // /// Add to cart
  // Future<dynamic> addToCart({String? user_id, String? prodId, String? quantity}) async {
  //   final params = {
  //     "user_id":user_id,
  //     "prod_id":prodId,
  //     "quantity":quantity};
  //   return await Api.addToCart(params);
  // }
  //
  // ///Fetch Cart Data
  // Future<dynamic> fetchCartData({String? user_id}) async {
  //   final params = {
  //     "user_id":user_id,
  //     };
  //   return await Api.fetchCart(params);
  // }
  //
  //
  // ///Delete Cart
  // Future<dynamic> deleteCart({String? user_id,String? prodId}) async {
  //   final params = {
  //     "user_id":user_id,
  //     "prod_id":prodId,
  //   };
  //   return await Api.deleteCart(params);
  // }
  //
  //
  // ///CheckOut
  // Future<dynamic> checkOut({String? user_id,String? cart,
  //   dynamic subTotal,
  //   dynamic shippingCharge,
  //   dynamic totalAmount,
  // String? paymentMethod,
  // String? address,}) async {
  //   final params = {
  //     "user_id":user_id,
  //     "sub_total":subTotal,
  //     "shipping_charge":shippingCharge,
  //     "total_amount":totalAmount,
  //     "payment_method":paymentMethod,
  //     "billing_address":address,
  //     "product_details":jsonEncode(cart)
  //   };
  //   return await Api.checkOut(params);
  // }
  //
  //
  // Future<dynamic> fetchCategorypagelist(int? startFrom, {String? perPage}) async {
  //   final params = {"per_page":perPage,
  //     "start_from":startFrom};
  //   return await Api.fetchCategorypage(params);
  // }
  // // //save image
  // // Future<dynamic> saveImage(String image) async {
  // //   return await UtilPreferences.setString(
  // //     Preferences.profilePic,image);
  // // }
  // //
  // //
  //
  // ///Save User
  Future<dynamic> saveUser(CustomerLogin user) async {
    return await UtilPreferences.setString(
      Preferences.user,
      jsonEncode(user.toJson()),
    );
  }
  //
  // ///Get from Storage
  // dynamic getUser() {
  //   return UtilPreferences.getString(Preferences.user);
  // }
  //
  // ///Save address
  // Future<dynamic> saveAddress(AddressModel address) async {
  //   return await UtilPreferences.setString(
  //     Preferences.address,
  //     jsonEncode(address.toJson()),
  //   );
  // }
  //
  // ///Get address
  // dynamic getAddress() {
  //   return UtilPreferences.getString(Preferences.address);
  // }
  //
  //
  // ///Save cartCount
  // Future<dynamic> saveCart(CartListRepo cartData) async {
  //   return await UtilPreferences.setString(
  //     Preferences.cart,
  //     jsonEncode(cartData.toJson()),
  //     // cartData.
  //   );
  // }
  //
  // ///Get cart count
  // dynamic getCart() {
  //   return UtilPreferences.getString(Preferences.cart);
  // }
  // // dynamic getProfile() {
  // //   return UtilPreferences.getString(Preferences.profilePic);
  // // }
  //
  //
  //
  // ///Delete Storage
  // Future<dynamic> deleteUser() async {
  //   return await UtilPreferences.remove(Preferences.user);
  // }


}

