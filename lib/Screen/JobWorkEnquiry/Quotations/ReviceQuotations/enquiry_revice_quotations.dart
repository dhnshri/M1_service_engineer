import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:service_engineer/Screen/JobWorkEnquiry/Quotations/ReviceQuotations/enquiry_previewQuotation.dart';
import 'package:service_engineer/Screen/MachineMaintenance/MakeQuotations/preview.dart';
import 'package:service_engineer/Screen/MachineMaintenance/MakeQuotations/service_charges.dart';
import 'package:service_engineer/Screen/MachineMaintenance/Quotations/ReviceQuotations/revice_item_requirment.dart';
import 'package:service_engineer/Screen/MachineMaintenance/Quotations/ReviceQuotations/revice_preview.dart';
import 'package:service_engineer/Screen/MachineMaintenance/Quotations/ReviceQuotations/revice_quotations.dart';
import 'package:service_engineer/Screen/MachineMaintenance/Quotations/ReviceQuotations/revice_service_charges.dart';
import 'package:service_engineer/app.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../Config/font.dart';
import '../../../../Constant/theme_colors.dart';
import '../../../../Widget/common.dart';
import '../../../../Widget/stepper_button.dart';
import '../../../bottom_navbar.dart';

class EnquiryReviceQuotationScreen extends StatefulWidget {
  const EnquiryReviceQuotationScreen({Key? key}) : super(key: key);

  @override
  _EnquiryReviceQuotationScreenState createState() => _EnquiryReviceQuotationScreenState();
}

class _EnquiryReviceQuotationScreenState extends State<EnquiryReviceQuotationScreen> {


  int _currentStep = 0;
  bool loading = true;
  final _formKey = GlobalKey<FormState>();
  bool isCompleted = false;

  // int _activeCurrentStep = 0;

  TextEditingController obj1 = TextEditingController();
  TextEditingController obj2 = TextEditingController();
  TextEditingController obj3 = TextEditingController();
  TextEditingController obj4 = TextEditingController();
  TextEditingController obj5 = TextEditingController();
  TextEditingController _addressController = TextEditingController();


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
                //     MaterialPageRoute(builder: (context) => ServiceRequestDetailsScreen()));
              },
              child: Icon(Icons.arrow_back_ios)),
          title: Text('Quotation for #102GRDSA36987'),
        ),
        body:SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  // initialValue: Application.customerLogin!.name.toString(),
                  controller: obj1,
                  textAlign: TextAlign.start,
                  keyboardType: TextInputType.number,
                  style: TextStyle(
                    fontSize: 18,
                    height: 1.5,
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: ThemeColors.textFieldBackgroundColor,
                    hintText: "₹500",
                    contentPadding: EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 15.0),
                    hintStyle: TextStyle(fontSize: 15),
                    enabledBorder: OutlineInputBorder(
                      borderRadius:
                      BorderRadius.all(Radius.circular(1.0)),
                      borderSide: BorderSide(
                          width: 0.8,
                          color: ThemeColors.textFieldBackgroundColor
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius:
                      BorderRadius.all(Radius.circular(1.0)),
                      borderSide: BorderSide(
                          width: 0.8,
                          color: ThemeColors.textFieldBackgroundColor),
                    ),
                    border: OutlineInputBorder(
                        borderRadius:
                        BorderRadius.all(Radius.circular(1.0)),
                        borderSide: BorderSide(
                            width: 0.8,
                            color: ThemeColors.textFieldBackgroundColor)),
                  ),
                  validator: (value) {
                    // profile.name = value!.trim();
                    // Pattern pattern =
                    //     r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                    // RegExp regex =
                    // new RegExp(pattern.toString());
                    if (value == null || value.isEmpty) {
                      return 'Please enter obj1';
                    }
                    // else if(!regex.hasMatch(value)){
                    //   return 'Please enter valid name';
                    // }
                    return null;
                  },
                  onChanged: (value) {
                    // profile.name = value;
                    setState(() {
                      // _nameController.text = value;
                      if (_formKey.currentState!.validate()) {}
                    });
                  },
                ),
                SizedBox(height: 10,),
                TextFormField(
                  // initialValue: Application.customerLogin!.name.toString(),
                  controller: obj2,
                  textAlign: TextAlign.start,
                  keyboardType: TextInputType.number,
                  style: TextStyle(
                    fontSize: 18,
                    height: 1.5,
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: ThemeColors.textFieldBackgroundColor,
                    hintText: "₹10,000",
                    contentPadding: EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 15.0),
                    hintStyle: TextStyle(fontSize: 15),
                    enabledBorder: OutlineInputBorder(
                      borderRadius:
                      BorderRadius.all(Radius.circular(1.0)),
                      borderSide: BorderSide(
                          width: 0.8,
                          color: ThemeColors.textFieldBackgroundColor
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius:
                      BorderRadius.all(Radius.circular(1.0)),
                      borderSide: BorderSide(
                          width: 0.8,
                          color: ThemeColors.textFieldBackgroundColor),
                    ),
                    border: OutlineInputBorder(
                        borderRadius:
                        BorderRadius.all(Radius.circular(1.0)),
                        borderSide: BorderSide(
                            width: 0.8,
                            color: ThemeColors.textFieldBackgroundColor)),
                  ),
                  validator: (value) {
                    // profile.name = value!.trim();
                    // Pattern pattern =
                    //     r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                    // RegExp regex =
                    // new RegExp(pattern.toString());
                    if (value == null || value.isEmpty) {
                      return 'Please enter obj2';
                    }
                    // else if(!regex.hasMatch(value)){
                    //   return 'Please enter valid name';
                    // }
                    return null;
                  },
                  onChanged: (value) {
                    // profile.name = value;
                    setState(() {
                      // _nameController.text = value;
                      if (_formKey.currentState!.validate()) {}
                    });
                  },
                ),
                SizedBox(height: 10,),
                TextFormField(
                  // initialValue: Application.customerLogin!.name.toString(),
                  controller: obj3,
                  textAlign: TextAlign.start,
                  keyboardType: TextInputType.number,
                  style: TextStyle(
                    fontSize: 18,
                    height: 1.5,
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: ThemeColors.textFieldBackgroundColor,
                    hintText: "₹10,000",
                    contentPadding: EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 15.0),
                    hintStyle: TextStyle(fontSize: 15),
                    enabledBorder: OutlineInputBorder(
                      borderRadius:
                      BorderRadius.all(Radius.circular(1.0)),
                      borderSide: BorderSide(
                          width: 0.8,
                          color: ThemeColors.textFieldBackgroundColor
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius:
                      BorderRadius.all(Radius.circular(1.0)),
                      borderSide: BorderSide(
                          width: 0.8,
                          color: ThemeColors.textFieldBackgroundColor),
                    ),
                    border: OutlineInputBorder(
                        borderRadius:
                        BorderRadius.all(Radius.circular(1.0)),
                        borderSide: BorderSide(
                            width: 0.8,
                            color: ThemeColors.textFieldBackgroundColor)),
                  ),
                  validator: (value) {
                    // profile.name = value!.trim();
                    // Pattern pattern =
                    //     r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                    // RegExp regex =
                    // new RegExp(pattern.toString());
                    if (value == null || value.isEmpty) {
                      return 'Please enter obj2';
                    }
                    // else if(!regex.hasMatch(value)){
                    //   return 'Please enter valid name';
                    // }
                    return null;
                  },
                  onChanged: (value) {
                    // profile.name = value;
                    setState(() {
                      // _nameController.text = value;
                      if (_formKey.currentState!.validate()) {}
                    });
                  },
                ),
                SizedBox(height: 10,),
                TextFormField(
                  // initialValue: Application.customerLogin!.name.toString(),
                  controller: obj4,
                  textAlign: TextAlign.start,
                  keyboardType: TextInputType.number,
                  style: TextStyle(
                    fontSize: 18,
                    height: 1.5,
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: ThemeColors.textFieldBackgroundColor,
                    hintText: "₹10,000",
                    contentPadding: EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 15.0),
                    hintStyle: TextStyle(fontSize: 15),
                    enabledBorder: OutlineInputBorder(
                      borderRadius:
                      BorderRadius.all(Radius.circular(1.0)),
                      borderSide: BorderSide(
                          width: 0.8,
                          color: ThemeColors.textFieldBackgroundColor
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius:
                      BorderRadius.all(Radius.circular(1.0)),
                      borderSide: BorderSide(
                          width: 0.8,
                          color: ThemeColors.textFieldBackgroundColor),
                    ),
                    border: OutlineInputBorder(
                        borderRadius:
                        BorderRadius.all(Radius.circular(1.0)),
                        borderSide: BorderSide(
                            width: 0.8,
                            color: ThemeColors.textFieldBackgroundColor)),
                  ),
                  validator: (value) {
                    // profile.name = value!.trim();
                    // Pattern pattern =
                    //     r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                    // RegExp regex =
                    // new RegExp(pattern.toString());
                    if (value == null || value.isEmpty) {
                      return 'Please enter obj2';
                    }
                    // else if(!regex.hasMatch(value)){
                    //   return 'Please enter valid name';
                    // }
                    return null;
                  },
                  onChanged: (value) {
                    // profile.name = value;
                    setState(() {
                      // _nameController.text = value;
                      if (_formKey.currentState!.validate()) {}
                    });
                  },
                ),
                SizedBox(height: 10,),
                TextFormField(
                  // initialValue: Application.customerLogin!.name.toString(),
                  controller: obj5,
                  textAlign: TextAlign.start,
                  keyboardType: TextInputType.number,
                  style: TextStyle(
                    fontSize: 18,
                    height: 1.5,
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: ThemeColors.textFieldBackgroundColor,
                    hintText: "₹10,000",
                    contentPadding: EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 15.0),
                    hintStyle: TextStyle(fontSize: 15),
                    enabledBorder: OutlineInputBorder(
                      borderRadius:
                      BorderRadius.all(Radius.circular(1.0)),
                      borderSide: BorderSide(
                          width: 0.8,
                          color: ThemeColors.textFieldBackgroundColor
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius:
                      BorderRadius.all(Radius.circular(1.0)),
                      borderSide: BorderSide(
                          width: 0.8,
                          color: ThemeColors.textFieldBackgroundColor),
                    ),
                    border: OutlineInputBorder(
                        borderRadius:
                        BorderRadius.all(Radius.circular(1.0)),
                        borderSide: BorderSide(
                            width: 0.8,
                            color: ThemeColors.textFieldBackgroundColor)),
                  ),
                  validator: (value) {
                    // profile.name = value!.trim();
                    // Pattern pattern =
                    //     r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                    // RegExp regex =
                    // new RegExp(pattern.toString());
                    if (value == null || value.isEmpty) {
                      return 'Please enter obj2';
                    }
                    // else if(!regex.hasMatch(value)){
                    //   return 'Please enter valid name';
                    // }
                    return null;
                  },
                  onChanged: (value) {
                    // profile.name = value;
                    setState(() {
                      // _nameController.text = value;
                      if (_formKey.currentState!.validate()) {}
                    });
                  },
                ),
                SizedBox(height: 20,),

                Divider(
                  thickness: 2,
                ),
                Divider(
                  thickness: 2,
                ),

                Text("Message for Client",
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Poppins-Medium',
                        fontSize: 16,
                        fontWeight: FontWeight.w500
                    )),
                SizedBox(height: 10,),

                ///Address
                TextFormField(
                  controller: _addressController,
                  obscureText: false,
                  textAlign: TextAlign.start,
                  keyboardType:
                  TextInputType.text,
                  maxLines: 6,
                  style: TextStyle(
                    fontSize: 18,
                    height: 1.5,
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: ThemeColors.textFieldBackgroundColor,
                    contentPadding:
                    EdgeInsets.symmetric(
                        vertical: 10.0,
                        horizontal: 15.0),
                    hintStyle:
                    TextStyle(fontSize: 15),
                    enabledBorder:
                    OutlineInputBorder(
                      borderRadius:
                      BorderRadius.all(
                          Radius.circular(
                              10.0)),
                      borderSide: BorderSide(
                          width: 0.8,
                          color: ThemeColors
                              .textFieldBackgroundColor),
                    ),
                    focusedBorder:
                    OutlineInputBorder(
                      borderRadius:
                      BorderRadius.all(
                          Radius.circular(
                              10.0)),
                      borderSide: BorderSide(
                          width: 0.8,
                          color: ThemeColors
                              .textFieldBackgroundColor),
                    ),
                    border: OutlineInputBorder(
                        borderRadius:
                        BorderRadius.all(
                            Radius.circular(
                                10.0)),
                        borderSide: BorderSide(
                            width: 0.8,
                            color: ThemeColors
                                .textFieldBackgroundColor)),
                    hintText: "Add Message for client...",
                  ),
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty) {
                      return 'Please enter message';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      if (_formKey.currentState!
                          .validate()) {}
                    });
                  },
                ),

                SizedBox(height: 20,),

                Divider(
                  thickness: 2,
                ),

                Center(
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: ElevatedButton(
                          onPressed: () async {
                            // Navigator.push(context, MaterialPageRoute(builder: (contex)=>EnquiryQuotationsPreviewScreen()));
                          },
                          style: ElevatedButton.styleFrom(
                            primary: ThemeColors.defaultbuttonColor,
                            shape: StadiumBorder(),
                          ),
                          child: Text(
                            "Next",
                            style: Theme.of(context)
                                .textTheme
                                .button!
                                .copyWith(color: Colors.white, fontWeight: FontWeight.w600),
                          ),

                        ),
                      )),
                )


              ],
            ),
          ),
        )
      ),
    );
  }
}
