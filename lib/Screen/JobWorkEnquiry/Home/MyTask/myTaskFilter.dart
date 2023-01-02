import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:service_engineer/Screen/Home/ServiceRequest/serviceRequest.dart';
import 'package:service_engineer/Screen/Home/home.dart';
import 'package:service_engineer/Widget/function_button.dart';
import 'package:service_engineer/app.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';


class EnquiryMyTaskFilterScreen extends StatefulWidget {
  const EnquiryMyTaskFilterScreen({Key? key}) : super(key: key);

  @override
  _EnquiryMyTaskFilterScreenState createState() => _EnquiryMyTaskFilterScreenState();
}

class _EnquiryMyTaskFilterScreenState extends State<EnquiryMyTaskFilterScreen> {

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
          title: Text('Filter for Task',),
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
