import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:service_engineer/Screen/Home/ServiceRequest/serviceRequest.dart';
import 'package:service_engineer/Screen/Home/home.dart';
import 'package:service_engineer/app.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

import '../../../Config/font.dart';
import '../../../Widget/app_button.dart';
import '../../../Widget/function_button.dart';
import '../../bottom_navbar.dart';



class ServiceRequestFilterScreen extends StatefulWidget {
  const ServiceRequestFilterScreen({Key? key}) : super(key: key);

  @override
  _ServiceRequestFilterScreenState createState() => _ServiceRequestFilterScreenState();
}

class _ServiceRequestFilterScreenState extends State<ServiceRequestFilterScreen> {

  final _formKey = GlobalKey<FormState>();
  String radioBtnType = "Iron";
  int machineCategoryId = 1;

  String  numberOfItemsType = "0-100 items";
  int numberOfItemsId = 1;

  String  deliveryType = '0-20 KM';
  int deliveryId = 1;

  String  productMainCategoryradioBtnType = 'Category 1';
  int productMainCategoryId = 1;

  String productSubCategoryradioBtnType = 'Category 1';
  int productSubCategoryId = 1;

  String areaType = 'All India';
  int areaId = 1;

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
              Navigator.of(context).pop();
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => BottomNavigation (index:0)));
            },
              child: Icon(Icons.arrow_back_ios)),
          title: Text('Filter for Service Request',),
        ),
        bottomNavigationBar:Padding(
          padding: const EdgeInsets.all(10.0),
          child: FunctionButton(
            onPressed: () async {
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
                                    child: Text('Material for Product',style:TextStyle(
                                            fontFamily: 'Poppins-Medium',
                                            fontSize: 17,
                                            fontWeight: FontWeight.w600
                                    ),)),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(children: [
                                  Radio(
                                    value: 1,
                                    groupValue: machineCategoryId,
                                    onChanged: (val) {
                                      setState(() {
                                        radioBtnType = 'Iron';
                                        machineCategoryId = 1;
                                      });
                                    },
                                  ),
                                  Text(
                                    'Iron',
                                    style:TextStyle(
                                        fontFamily: 'Poppins-Regular',
                                        fontSize: 15,
                                    ),
                                  ),
                                ],),
                                Row(
                                  children: [
                                    Radio(
                                      value: 2,
                                      groupValue: machineCategoryId,
                                      onChanged: (val) {
                                        setState(() {
                                          radioBtnType =
                                          'Steal';
                                          machineCategoryId = 2;
                                        });
                                      },
                                    ),
                                    Text(
                                      'Steal',
                                      style: TextStyle(
                                        fontFamily: 'Poppins-Regular',
                                        fontSize: 15,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Radio(
                                      value: 3,
                                      groupValue: machineCategoryId,
                                      onChanged: (val) {
                                        setState(() {
                                          radioBtnType = 'Copper';
                                          machineCategoryId = 3;
                                        });
                                      },
                                    ),
                                    Text(
                                      'Copper',
                                      style:TextStyle(
                                        fontFamily: 'Poppins-Regular',
                                        fontSize: 15,
                                      ),
                                    ),

                                  ],
                                ),
                                Row(
                                  children: [
                                    Radio(
                                      value: 3,
                                      groupValue: machineCategoryId,
                                      onChanged: (val) {
                                        setState(() {
                                          radioBtnType = 'Aluminum';
                                          machineCategoryId = 3;
                                        });
                                      },
                                    ),
                                    Text(
                                      'Aluminum',
                                      style:TextStyle(
                                        fontFamily: 'Poppins-Regular',
                                        fontSize: 15,
                                      ),
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
                                    child: Text('Number of Items Required',style:TextStyle(
                                        fontFamily: 'Poppins-Medium',
                                        fontSize: 17,
                                        fontWeight: FontWeight.w600
                                    ),)),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(children: [
                                  Radio(
                                    value: 1,
                                    groupValue: numberOfItemsId,
                                    onChanged: (val) {
                                      setState(() {
                                        numberOfItemsType = '0-100 items';
                                        numberOfItemsId = 1;
                                      });
                                    },
                                  ),
                                  Text(
                                    '0-100 items',
                                    style:TextStyle(
                                      fontFamily: 'Poppins-Regular',
                                      fontSize: 15,
                                    ),
                                  ),
                                ],),
                                Row(
                                  children: [
                                    Radio(
                                      value: 2,
                                      groupValue: numberOfItemsId,
                                      onChanged: (val) {
                                        setState(() {
                                          numberOfItemsType =
                                          '100-500 items';
                                          numberOfItemsId = 2;
                                        });
                                      },
                                    ),
                                    Text(
                                      '100-500 items',
                                      style: TextStyle(
                                        fontFamily: 'Poppins-Regular',
                                        fontSize: 15,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Radio(
                                      value: 3,
                                      groupValue: numberOfItemsId,
                                      onChanged: (val) {
                                        setState(() {
                                          numberOfItemsType = '500-1000 items';
                                          numberOfItemsId = 3;
                                        });
                                      },
                                    ),
                                    Text(
                                      '500-1000 items',
                                      style:TextStyle(
                                        fontFamily: 'Poppins-Regular',
                                        fontSize: 15,
                                      ),
                                    ),

                                  ],
                                ),
                                Row(
                                  children: [
                                    Radio(
                                      value: 4,
                                      groupValue: numberOfItemsId,
                                      onChanged: (val) {
                                        setState(() {
                                          numberOfItemsType = '400-500 items';
                                          numberOfItemsId = 4;
                                        });
                                      },
                                    ),
                                    Text(
                                      '400-500 items',
                                      style:TextStyle(
                                        fontFamily: 'Poppins-Regular',
                                        fontSize: 15,
                                      ),
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
                                    child: Text('Delivery Distance',style:TextStyle(
                                        fontFamily: 'Poppins-Medium',
                                        fontSize: 17,
                                        fontWeight: FontWeight.w600
                                    ),)),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(children: [
                                  Radio(
                                    value: 1,
                                    groupValue: deliveryId,
                                    onChanged: (val) {
                                      setState(() {
                                        deliveryType = '0-20 KM';
                                        deliveryId = 1;
                                      });
                                    },
                                  ),
                                  Text(
                                    '0-20 KM',
                                    style:TextStyle(
                                      fontFamily: 'Poppins-Regular',
                                      fontSize: 15,
                                    ),
                                  ),
                                ],),
                                Row(
                                  children: [
                                    Radio(
                                      value: 2,
                                      groupValue: deliveryId,
                                      onChanged: (val) {
                                        setState(() {
                                          deliveryType =
                                          '20-50 KM';
                                          deliveryId = 2;
                                        });
                                      },
                                    ),
                                    Text(
                                      '20-50 KM',
                                      style: TextStyle(
                                        fontFamily: 'Poppins-Regular',
                                        fontSize: 15,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Radio(
                                      value: 3,
                                      groupValue: deliveryId,
                                      onChanged: (val) {
                                        setState(() {
                                          deliveryType = '50-100 KM';
                                          deliveryId = 3;
                                        });
                                      },
                                    ),
                                    Text(
                                      '50-100 KM',
                                      style:TextStyle(
                                        fontFamily: 'Poppins-Regular',
                                        fontSize: 15,
                                      ),
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
                                    child: Text('Product Main Category',style:TextStyle(
                                        fontFamily: 'Poppins-Medium',
                                        fontSize: 17,
                                        fontWeight: FontWeight.w600
                                    ),)),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(children: [
                                  Radio(
                                    value: 1,
                                    groupValue: productSubCategoryId,
                                    onChanged: (val) {
                                      setState(() {
                                        productSubCategoryradioBtnType = 'Category 1';
                                        productSubCategoryId = 1;
                                      });
                                    },
                                  ),
                                  Text(
                                    'Category 1',
                                    style:TextStyle(
                                      fontFamily: 'Poppins-Regular',
                                      fontSize: 15,
                                    ),
                                  ),
                                ],),
                                Row(
                                  children: [
                                    Radio(
                                      value: 2,
                                      groupValue: productSubCategoryId,
                                      onChanged: (val) {
                                        setState(() {
                                          radioBtnType =
                                          'Category 2';
                                          productSubCategoryId = 2;
                                        });
                                      },
                                    ),
                                    Text(
                                      'Category 2',
                                      style: TextStyle(
                                        fontFamily: 'Poppins-Regular',
                                        fontSize: 15,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Radio(
                                      value: 3,
                                      groupValue: productSubCategoryId,
                                      onChanged: (val) {
                                        setState(() {
                                          radioBtnType = 'Category 3';
                                          productSubCategoryId = 3;
                                        });
                                      },
                                    ),
                                    Text(
                                      'Category 3',
                                      style:TextStyle(
                                        fontFamily: 'Poppins-Regular',
                                        fontSize: 15,
                                      ),
                                    ),

                                  ],
                                ),
                                Row(
                                  children: [
                                    Radio(
                                      value: 4,
                                      groupValue: productSubCategoryId,
                                      onChanged: (val) {
                                        setState(() {
                                          radioBtnType = 'Category 4';
                                          productSubCategoryId = 4;
                                        });
                                      },
                                    ),
                                    Text(
                                      'Category 4',
                                      style:TextStyle(
                                        fontFamily: 'Poppins-Regular',
                                        fontSize: 15,
                                      ),
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
                                    child: Text('Product Sub Category',style:TextStyle(
                                        fontFamily: 'Poppins-Medium',
                                        fontSize: 17,
                                        fontWeight: FontWeight.w600
                                    ),)),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(children: [
                                  Radio(
                                    value: 1,
                                    groupValue: productSubCategoryId,
                                    onChanged: (val) {
                                      setState(() {
                                        productSubCategoryradioBtnType = 'Category 1';
                                        productSubCategoryId = 1;
                                      });
                                    },
                                  ),
                                  Text(
                                    'Category 1',
                                    style:TextStyle(
                                      fontFamily: 'Poppins-Regular',
                                      fontSize: 15,
                                    ),
                                  ),
                                ],),
                                Row(
                                  children: [
                                    Radio(
                                      value: 2,
                                      groupValue: productSubCategoryId,
                                      onChanged: (val) {
                                        setState(() {
                                          radioBtnType =
                                          'Category 2';
                                          productSubCategoryId = 2;
                                        });
                                      },
                                    ),
                                    Text(
                                      'Category 2',
                                      style: TextStyle(
                                        fontFamily: 'Poppins-Regular',
                                        fontSize: 15,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Radio(
                                      value: 3,
                                      groupValue: productSubCategoryId,
                                      onChanged: (val) {
                                        setState(() {
                                          radioBtnType = 'Category 3';
                                          productSubCategoryId = 3;
                                        });
                                      },
                                    ),
                                    Text(
                                      'Category 3',
                                      style:TextStyle(
                                        fontFamily: 'Poppins-Regular',
                                        fontSize: 15,
                                      ),
                                    ),

                                  ],
                                ),
                                Row(
                                  children: [
                                    Radio(
                                      value: 4,
                                      groupValue: productSubCategoryId,
                                      onChanged: (val) {
                                        setState(() {
                                          radioBtnType = 'Category 4';
                                          productSubCategoryId = 4;
                                        });
                                      },
                                    ),
                                    Text(
                                      'Category 4',
                                      style:TextStyle(
                                        fontFamily: 'Poppins-Regular',
                                        fontSize: 15,
                                      ),
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
                                    child: Text('Area',style:TextStyle(
                                        fontFamily: 'Poppins-Medium',
                                        fontSize: 17,
                                        fontWeight: FontWeight.w600
                                    ),)),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(children: [
                                  Radio(
                                    value: 1,
                                    groupValue: areaId,
                                    onChanged: (val) {
                                      setState(() {
                                        areaType = 'All India';
                                        areaId = 1;
                                      });
                                    },
                                  ),
                                  Text(
                                    'All India',
                                    style:TextStyle(
                                      fontFamily: 'Poppins-Regular',
                                      fontSize: 15,
                                    ),
                                  ),
                                ],),
                                Row(
                                  children: [
                                    Radio(
                                      value: 2,
                                      groupValue: areaId,
                                      onChanged: (val) {
                                        setState(() {
                                          areaType =
                                          'Punjab';
                                          areaId = 2;
                                        });
                                      },
                                    ),
                                    Text(
                                      'Punjab',
                                      style: TextStyle(
                                        fontFamily: 'Poppins-Regular',
                                        fontSize: 15,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Radio(
                                      value: 3,
                                      groupValue: areaId,
                                      onChanged: (val) {
                                        setState(() {
                                          areaType = 'Haryana';
                                          areaId = 3;
                                        });
                                      },
                                    ),
                                    Text(
                                      'Haryana',
                                      style:TextStyle(
                                        fontFamily: 'Poppins-Regular',
                                        fontSize: 15,
                                      ),
                                    ),

                                  ],
                                ),
                                Row(
                                  children: [
                                    Radio(
                                      value: 3,
                                      groupValue: areaId,
                                      onChanged: (val) {
                                        setState(() {
                                          areaType = 'Himachal';
                                          areaId = 3;
                                        });
                                      },
                                    ),
                                    Text(
                                      'Himachal',
                                      style:TextStyle(
                                        fontFamily: 'Poppins-Regular',
                                        fontSize: 15,
                                      ),
                                    ),

                                  ],
                                ),
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
