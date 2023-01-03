import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:service_engineer/Config/font.dart';
import 'package:service_engineer/Screen/bottom_navbar.dart';
import 'package:service_engineer/Widget/function_button.dart';



class EnquiryServiceRequestFilterScreen extends StatefulWidget {
  const EnquiryServiceRequestFilterScreen({Key? key}) : super(key: key);

  @override
  _EnquiryServiceRequestFilterScreenState createState() => _EnquiryServiceRequestFilterScreenState();
}

class _EnquiryServiceRequestFilterScreenState extends State<EnquiryServiceRequestFilterScreen> {

  final _formKey = GlobalKey<FormState>();
  String radioBtnType = "Heavy";
  int machineCategoryId = 1;
  String  locationradioBtnType = "Location";
  int locationId = 1;

  String  productMainCategoryradioBtnType = 'Category 1';
  int productMainCategoryId = 1;

  String productSubCategoryradioBtnType = 'Category 1';
  int productSubCategoryId = 1;

  String statusradioBtnType = 'All';
  int statusId = 1;

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
            },
              child: Icon(Icons.arrow_back_ios)),
          title: Text('Service Request Filter',style:appBarheadingStyle ,),
        ),
        bottomNavigationBar:Padding(
          padding: const EdgeInsets.all(10.0),
          child: FunctionButton(
            onPressed: () async {},
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
                                    child: Text('Machine Category',style:filterHeadingRadiobtnStyle,)),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(children: [
                                  Radio(
                                    value: 1,
                                    groupValue: machineCategoryId,
                                    onChanged: (val) {
                                      setState(() {
                                        radioBtnType = 'Heavy';
                                        machineCategoryId = 1;
                                      });
                                    },
                                  ),
                                  Text(
                                    'Heavy',
                                    style:filterRadiobtnStyle,
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
                                          'Light';
                                          machineCategoryId = 2;
                                        });
                                      },
                                    ),
                                    Text(
                                      'Light',
                                      style: filterRadiobtnStyle,
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
                                          radioBtnType = 'Compact';
                                          machineCategoryId = 3;
                                        });
                                      },
                                    ),
                                    Text(
                                      'Compact',
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
                                    child: Text('Location',style:filterHeadingRadiobtnStyle,)),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(children: [
                                  Radio(
                                    value: 1,
                                    groupValue: locationId,
                                    onChanged: (val) {
                                      setState(() {
                                        locationradioBtnType = 'With in 120 miles';
                                        locationId = 1;
                                      });
                                    },
                                  ),
                                  Text(
                                    'With in 120 miles',
                                    style:filterRadiobtnStyle,
                                  ),
                                ],),
                                Row(
                                  children: [
                                    Radio(
                                      value: 2,
                                      groupValue: locationId,
                                      onChanged: (val) {
                                        setState(() {
                                          radioBtnType =
                                          'With in 200 miles';
                                          locationId = 2;
                                        });
                                      },
                                    ),
                                    Text(
                                      'With in 200 miles',
                                      style: filterRadiobtnStyle,
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Radio(
                                      value: 3,
                                      groupValue: locationId,
                                      onChanged: (val) {
                                        setState(() {
                                          radioBtnType = 'With in 250 miles';
                                          locationId = 3;
                                        });
                                      },
                                    ),
                                    Text(
                                      'With in 250 miles',
                                      style:filterRadiobtnStyle,
                                    ),

                                  ],
                                ),
                                Row(
                                  children: [
                                    Radio(
                                      value: 4,
                                      groupValue: locationId,
                                      onChanged: (val) {
                                        setState(() {
                                          radioBtnType = 'With in 300 miles';
                                          locationId = 4;
                                        });
                                      },
                                    ),
                                    Text(
                                      'With in 300 miles',
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
                                    child: Text('Product Main Category',style:filterHeadingRadiobtnStyle,)),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(children: [
                                  Radio(
                                    value: 1,
                                    groupValue: productMainCategoryId,
                                    onChanged: (val) {
                                      setState(() {
                                        productMainCategoryradioBtnType = 'Category 1';
                                        productMainCategoryId = 1;
                                      });
                                    },
                                  ),
                                  Text(
                                    'Category 1',
                                    style:filterRadiobtnStyle,
                                  ),
                                ],),
                                Row(
                                  children: [
                                    Radio(
                                      value: 2,
                                      groupValue: productMainCategoryId,
                                      onChanged: (val) {
                                        setState(() {
                                          radioBtnType =
                                          'Category 2';
                                          productMainCategoryId = 2;
                                        });
                                      },
                                    ),
                                    Text(
                                      'Category 2',
                                      style: filterRadiobtnStyle,
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Radio(
                                      value: 3,
                                      groupValue: productMainCategoryId,
                                      onChanged: (val) {
                                        setState(() {
                                          radioBtnType = 'Category 3';
                                          productMainCategoryId = 3;
                                        });
                                      },
                                    ),
                                    Text(
                                      'Category 3',
                                      style:filterRadiobtnStyle,
                                    ),

                                  ],
                                ),
                                Row(
                                  children: [
                                    Radio(
                                      value: 4,
                                      groupValue: productMainCategoryId,
                                      onChanged: (val) {
                                        setState(() {
                                          radioBtnType = 'Category 4';
                                          productMainCategoryId = 4;
                                        });
                                      },
                                    ),
                                    Text(
                                      'Category 4',
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
                                    child: Text('Product Sub Category',style:filterHeadingRadiobtnStyle,)),
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
                                    style:filterRadiobtnStyle,
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
                                      style: filterRadiobtnStyle,
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
                                      style:filterRadiobtnStyle,
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
                                    child: Text('Status',style:filterHeadingRadiobtnStyle,)),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(children: [
                                  Radio(
                                    value: 1,
                                    groupValue: statusId,
                                    onChanged: (val) {
                                      setState(() {
                                        statusradioBtnType = 'All';
                                        statusId = 1;
                                      });
                                    },
                                  ),
                                  Text(
                                    'All',
                                    style:filterRadiobtnStyle,
                                  ),
                                ],),
                                Row(
                                  children: [
                                    Radio(
                                      value: 2,
                                      groupValue: statusId,
                                      onChanged: (val) {
                                        setState(() {
                                          radioBtnType =
                                          'Live';
                                          statusId = 2;
                                        });
                                      },
                                    ),
                                    Text(
                                      'Live',
                                      style: filterRadiobtnStyle,
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Radio(
                                      value: 3,
                                      groupValue: statusId,
                                      onChanged: (val) {
                                        setState(() {
                                          radioBtnType = 'Closed';
                                          statusId = 3;
                                        });
                                      },
                                    ),
                                    Text(
                                      'Closed',
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
