import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:service_engineer/app.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

import '../../../Config/font.dart';
import '../../../Widget/app_button.dart';
import '../../../Widget/function_button.dart';
import 'make_quotatons.dart';




class ItemRequiredFilterScreen extends StatefulWidget {
  const ItemRequiredFilterScreen({Key? key}) : super(key: key);

  @override
  _ItemRequiredFilterScreenState createState() => _ItemRequiredFilterScreenState();
}

class _ItemRequiredFilterScreenState extends State<ItemRequiredFilterScreen> {

  final _formKey = GlobalKey<FormState>();
  String priceBtnType = "Price";
  int priceId = 1;
  String  brandsBtnType = "Brands";
  int brandsId = 1;

  String  discountBtnType = 'Discount';
  int discountId = 1;

  String ratingBtnType = 'Rating';
  int ratingId = 1;



  bool loading = true;


  @override
  void initState() {
    // TODO: implement initState
    //saveDeviceTokenAndId();
    super.initState();


  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: InkWell(
              onTap: (){
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MakeQuotationScreen  ()));
              },
              child: Icon(Icons.arrow_back_ios)),
          title: Text('Service Request Filter',style:appBarheadingStyle ,),
        ),
        bottomNavigationBar:Padding(
          padding: const EdgeInsets.all(10.0),
          child: FunctionButton(
            onPressed: () async {
              // Navigator.of(context).push(
              //     MaterialPageRoute(builder: (context) => VerifyMobileNumberScreen()));
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
            text: 'Apply',
            loading: loading,


          ),
        ),
        body: ListView(
          children: [

            Padding(
              padding: const EdgeInsets.only(top:8.0),
              child: Container(
                child: Column(
                  children: [
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.only(top:5.0,bottom: 5.0),
                        child: Container(
                          //decoration: BoxDecoration(
                          // border: Border.all(color: Colors.black12),
                          // borderRadius: BorderRadius.circular(12),
                          // ),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Column(
                              children: [
                                Align(
                                    alignment: Alignment.topLeft,
                                    child: Text('Price',style:filterHeadingRadiobtnStyle,)),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(children: [
                                  Radio(
                                    value: 1,
                                    groupValue: priceId,
                                    onChanged: (val) {
                                      setState(() {
                                        priceBtnType = '₹150 - ₹ 500';
                                        priceId = 1;
                                      });
                                    },
                                  ),
                                  Text(
                                    '₹150 - ₹ 500',
                                    style:filterRadiobtnStyle,
                                  ),
                                ],),
                                Row(
                                  children: [
                                    Radio(
                                      value: 2,
                                      groupValue: priceId,
                                      onChanged: (val) {
                                        setState(() {
                                          priceBtnType =
                                          '₹150 - ₹ 500';
                                          priceId = 2;
                                        });
                                      },
                                    ),
                                    Text(
                                      '₹150 - ₹ 500',
                                      style: filterRadiobtnStyle,
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Radio(
                                      value: 3,
                                      groupValue: priceId,
                                      onChanged: (val) {
                                        setState(() {
                                          priceBtnType = '₹150 - ₹ 500';
                                          priceId = 3;
                                        });
                                      },
                                    ),
                                    Text(
                                      '₹150 - ₹ 500',
                                      style:filterRadiobtnStyle,
                                    ),

                                  ],
                                ),
                                Row(
                                  children: [
                                    Radio(
                                      value: 3,
                                      groupValue: priceId,
                                      onChanged: (val) {
                                        setState(() {
                                          priceBtnType = '₹150 - ₹ 500';
                                          priceId = 4;
                                        });
                                      },
                                    ),
                                    Text(
                                      '₹150 - ₹ 500',
                                      style:filterRadiobtnStyle,
                                    ),

                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.only(top:5.0,bottom: 5.0),
                        child: Container(
                          //decoration: BoxDecoration(
                          // border: Border.all(color: Colors.black12),
                          // borderRadius: BorderRadius.circular(12),
                          // ),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Column(
                              children: [
                                Align(
                                    alignment: Alignment.topLeft,
                                    child: Text('Brands',style:filterHeadingRadiobtnStyle,)),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(children: [
                                  Radio(
                                    value: 1,
                                    groupValue: brandsId,
                                    onChanged: (val) {
                                      setState(() {
                                        brandsBtnType = 'Lorem Ipsum';
                                        brandsId = 1;
                                      });
                                    },
                                  ),
                                  Text(
                                    'Lorem Ipsum',
                                    style:filterRadiobtnStyle,
                                  ),
                                ],),
                                Row(children: [
                                  Radio(
                                    value: 2,
                                    groupValue: brandsId,
                                    onChanged: (val) {
                                      setState(() {
                                        brandsBtnType = 'Lorem Ipsum';
                                        brandsId = 2;
                                      });
                                    },
                                  ),
                                  Text(
                                    'Lorem Ipsum',
                                    style:filterRadiobtnStyle,
                                  ),
                                ],),
                                Row(children: [
                                  Radio(
                                    value: 3,
                                    groupValue: brandsId,
                                    onChanged: (val) {
                                      setState(() {
                                        brandsBtnType = 'Lorem Ipsum';
                                        brandsId = 3;
                                      });
                                    },
                                  ),
                                  Text(
                                    'Lorem Ipsum',
                                    style:filterRadiobtnStyle,
                                  ),
                                ],),
                                Row(children: [
                                  Radio(
                                    value: 4,
                                    groupValue: brandsId,
                                    onChanged: (val) {
                                      setState(() {
                                        brandsBtnType = 'Lorem Ipsum';
                                        brandsId = 4;
                                      });
                                    },
                                  ),
                                  Text(
                                    'Lorem Ipsum',
                                    style:filterRadiobtnStyle,
                                  ),
                                ],),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.only(top:5.0,bottom: 5.0),
                        child: Container(
                          //decoration: BoxDecoration(
                          // border: Border.all(color: Colors.black12),
                          // borderRadius: BorderRadius.circular(12),
                          // ),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Column(
                              children: [
                                Align(
                                    alignment: Alignment.topLeft,
                                    child: Text('Discount',style:filterHeadingRadiobtnStyle,)),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(children: [
                                  Radio(
                                    value: 1,
                                    groupValue: discountId,
                                    onChanged: (val) {
                                      setState(() {
                                        discountBtnType = 'Up To 50% Off';
                                        discountId = 1;
                                      });
                                    },
                                  ),
                                  Text(
                                    'Up To 50% Off',
                                    style:filterRadiobtnStyle,
                                  ),
                                ],),
                                Row(children: [
                                  Radio(
                                    value: 2,
                                    groupValue: discountId,
                                    onChanged: (val) {
                                      setState(() {
                                        discountBtnType = 'Up To 40% Off';
                                        discountId = 2;
                                      });
                                    },
                                  ),
                                  Text(
                                    'Up To 40% Off',
                                    style:filterRadiobtnStyle,
                                  ),
                                ],),
                                Row(children: [
                                  Radio(
                                    value: 3,
                                    groupValue: discountId,
                                    onChanged: (val) {
                                      setState(() {
                                        discountBtnType = 'Up To 40% Off';
                                        discountId = 3;
                                      });
                                    },
                                  ),
                                  Text(
                                    'Up To 40% Off',
                                    style:filterRadiobtnStyle,
                                  ),
                                ],),
                                Row(children: [
                                  Radio(
                                    value: 4,
                                    groupValue: discountId,
                                    onChanged: (val) {
                                      setState(() {
                                        discountBtnType = 'Up To 30% Off';
                                        discountId = 4;
                                      });
                                    },
                                  ),
                                  Text(
                                    'Up To 30% Off',
                                    style:filterRadiobtnStyle,
                                  ),
                                ],),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.only(top:5.0,bottom: 5.0),
                        child: Container(
                          //decoration: BoxDecoration(
                          // border: Border.all(color: Colors.black12),
                          // borderRadius: BorderRadius.circular(12),
                          // ),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Column(
                              children: [
                                Align(
                                    alignment: Alignment.topLeft,
                                    child: Text('Rating',style:filterHeadingRadiobtnStyle,)),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(children: [
                                  Radio(
                                    value: 1,
                                    groupValue: ratingId,
                                    onChanged: (val) {
                                      setState(() {
                                        ratingBtnType = '5 Stars';
                                        ratingId = 1;
                                      });
                                    },
                                  ),
                                  Text(
                                    '5 Stars',
                                    style:filterRadiobtnStyle,
                                  ),
                                ],),
                                Row(children: [
                                  Radio(
                                    value: 2,
                                    groupValue: ratingId,
                                    onChanged: (val) {
                                      setState(() {
                                        ratingBtnType = '4 Stars';
                                        ratingId = 2;
                                      });
                                    },
                                  ),
                                  Text(
                                    '4 Stars',
                                    style:filterRadiobtnStyle,
                                  ),
                                ],),
                                Row(children: [
                                  Radio(
                                    value: 3,
                                    groupValue: ratingId,
                                    onChanged: (val) {
                                      setState(() {
                                        ratingBtnType = '3 Stars';
                                        ratingId = 3;
                                      });
                                    },
                                  ),
                                  Text(
                                    '3 Stars',
                                    style:filterRadiobtnStyle,
                                  ),
                                ],),
                                Row(children: [
                                  Radio(
                                    value: 4,
                                    groupValue: ratingId,
                                    onChanged: (val) {
                                      setState(() {
                                        ratingBtnType = '2 Stars';
                                        ratingId = 1;
                                      });
                                    },
                                  ),
                                  Text(
                                    '2 Stars',
                                    style:filterRadiobtnStyle,
                                  ),
                                ],),
                                Row(children: [
                                  Radio(
                                    value: 5,
                                    groupValue: ratingId,
                                    onChanged: (val) {
                                      setState(() {
                                        ratingBtnType = '1 Stars';
                                        ratingId = 5;
                                      });
                                    },
                                  ),
                                  Text(
                                    '1 Stars',
                                    style:filterRadiobtnStyle,
                                  ),
                                ],),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),

                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
