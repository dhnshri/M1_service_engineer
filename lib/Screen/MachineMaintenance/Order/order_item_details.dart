import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

import '../../../Config/font.dart';
import '../../../Constant/theme_colors.dart';
import '../../../Widget/app_button.dart';

class OrderItemDetailsScreen extends StatefulWidget {
  const OrderItemDetailsScreen({Key? key}) : super(key: key);

  @override
  _OrderItemDetailsScreenState createState() => _OrderItemDetailsScreenState();
}

class _OrderItemDetailsScreenState extends State<OrderItemDetailsScreen> {
  final TextEditingController _phoneNumberController = TextEditingController();
  String dropdownValue = '+ 91';
  String? phoneNum;
  String? role;
  bool loading = true;

  var mainHeight, mainWidth;
  var quantity = 0;
  var totalValue = 0;
  int prodValue = 15000;

  // String? smsCode;
  // bool smsCodeSent = false;
  // String? verificationId;
  final _formKey = GlobalKey<FormState>();



  @override
  void initState() {
    // TODO: implement initState
    //saveDeviceTokenAndId();
    super.initState();
    _phoneNumberController.clear();

  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // getroleofstudent();
  }

  Widget itemRequredCard()
  {
    mainHeight = MediaQuery.of(context).size.height;
    mainWidth = MediaQuery.of(context).size.width;
    return Padding(
        padding: const EdgeInsets.only(bottom:8.0),
        child: Card(
            elevation: 1,
            child: ListTile(
              leading: CachedNetworkImage(
                filterQuality: FilterQuality.medium,
                // imageUrl: Api.PHOTO_URL + widget.users.avatar,
                // imageUrl: "https://picsum.photos/250?image=9",
                imageUrl: "https://picsum.photos/250?image=9",
                placeholder: (context, url) {
                  return Shimmer.fromColors(
                    baseColor: Theme.of(context).hoverColor,
                    highlightColor: Theme.of(context).highlightColor,
                    enabled: true,
                    child: Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  );
                },
                imageBuilder: (context, imageProvider) {
                  return Container(
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  );
                },
                errorWidget: (context, url, error) {
                  return Shimmer.fromColors(
                    baseColor: Theme.of(context).hoverColor,
                    highlightColor: Theme.of(context).highlightColor,
                    enabled: true,
                    child: Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(Icons.error),
                    ),
                  );
                },
              ),
              title: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Item Name",style:itemRequiredCardHeading,),
                            Text("ID: 123456",style: itemRequiredCardSubtitle),
                            Text("₹2000",style:itemRequiredCardSubtitle),
                          ],

                        ),

                        Expanded(
                          child: Container(
                            width: mainWidth / 3,
                            //width: 80,
                            child: Row(
                              children: [
                                IconButton(
                                  icon: Icon(
                                    Icons.remove_circle,
                                    color: Colors.grey,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      if (quantity > 1) {
                                        quantity--;
                                        totalValue = prodValue * quantity;
                                      }
                                    });
                                  },
                                ),
                                Text(
                                  quantity.toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 18),
                                ),
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      if (quantity < 10) {
                                        quantity++;
                                        totalValue = prodValue * quantity;
                                      }
                                      // var qty = cert.cart[index].qty! + 1;
                                      // cert.updateProduct(
                                      //     cert.cart[index].id,
                                      //     cert.cart[index].price.toString(),
                                      //     qty);
                                    });
                                  },
                                  icon: Icon(
                                    Icons.add_circle,
                                    color: ThemeColors.baseThemeColor,
                                  ),
                                ),
                              ],
                            ),

                          ),
                        )
                      ],
                    ),
                    Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. "
                        "when an unknown printer...Read More.",style: itemRequiredCardSubtitle),
                  ]
              ),
            )));
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar:Padding(
          padding: const EdgeInsets.all(10.0),
          child: AppButton(
            onPressed: () async {
              // Navigator.of(context).push(
              //     MaterialPageRoute(builder: (context) => VerifyMobileNumberScreen(dropValue: dropdownValue,)));
              //   isconnectedToInternet = await ConnectivityCheck
              //       .checkInternetConnectivity();
              //   if (isconnectedToInternet == true) {
              //     if (_formKey.currentState!.validate()) {
              //       // setState(() {
              //       //   loading=true;
              //       // });
              //       _userLoginBloc!.add(OnLogin(email: _textEmailController.text,password: _textPasswordController.text));
              //     }
              //   } else {
              //     CustomDialogs.showDialogCustom(
              //         "Internet",
              //         "Please check your Internet Connection!",
              //         context);
              //   }
            },
            shape: const RoundedRectangleBorder(
                borderRadius:
                BorderRadius.all(Radius.circular(50))),
            text: 'Cancel Order',
            loading: loading,


          ),
        ),
        body: Stack(
          children: [
            Center(child: Text("Order Detail")),

          ],
        ),
      ),
    );
  }
}
