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

class EnquiryMakeQuotationScreen extends StatefulWidget {
  const EnquiryMakeQuotationScreen({Key? key}) : super(key: key);

  @override
  _EnquiryMakeQuotationScreenState createState() => _EnquiryMakeQuotationScreenState();
}

class _EnquiryMakeQuotationScreenState extends State<EnquiryMakeQuotationScreen> {


  int _currentStep = 0;
  bool loading = true;
  final _formKey = GlobalKey<FormState>();
  bool isCompleted = false;

  // int _activeCurrentStep = 0;

  TextEditingController itemNameController = TextEditingController();
  TextEditingController itemRateController = TextEditingController();
  TextEditingController transportController = TextEditingController();
  TextEditingController packingController = TextEditingController();
  TextEditingController cgstController = TextEditingController();
  TextEditingController sgstController = TextEditingController();
  TextEditingController igstController = TextEditingController();


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
                    controller: itemNameController,
                    textAlign: TextAlign.start,
                    keyboardType: TextInputType.number,
                    style: TextStyle(
                      fontSize: 18,
                      height: 1.5,
                    ),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: ThemeColors.textFieldBackgroundColor,
                      hintText: "Item Name",
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
                        return 'Please enter Item Name';
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
                  TextFormField(
                    // initialValue: Application.customerLogin!.name.toString(),
                    controller: itemRateController,
                    textAlign: TextAlign.start,
                    keyboardType: TextInputType.number,
                    style: TextStyle(
                      fontSize: 18,
                      height: 1.5,
                    ),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: ThemeColors.textFieldBackgroundColor,
                      hintText: "Item Rate / Piece",
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
                        return 'Please enter Item Rate / Piece';
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
                  TextFormField(
                    // initialValue: Application.customerLogin!.name.toString(),
                    controller: transportController,
                    textAlign: TextAlign.start,
                    keyboardType: TextInputType.number,
                    style: TextStyle(
                      fontSize: 18,
                      height: 1.5,
                    ),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: ThemeColors.textFieldBackgroundColor,
                      hintText: "Transport Charges",
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
                        return 'Please enter Transport Charges';
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
                  TextFormField(
                    // initialValue: Application.customerLogin!.name.toString(),
                    controller: packingController,
                    textAlign: TextAlign.start,
                    keyboardType: TextInputType.number,
                    style: TextStyle(
                      fontSize: 18,
                      height: 1.5,
                    ),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: ThemeColors.textFieldBackgroundColor,
                      hintText: "Packing Charges",
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
                        return 'Please enter Packing Charges';
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
                  TextFormField(
                    // initialValue: Application.customerLogin!.name.toString(),
                    controller: cgstController,
                    textAlign: TextAlign.start,
                    keyboardType: TextInputType.number,
                    style: TextStyle(
                      fontSize: 18,
                      height: 1.5,
                    ),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: ThemeColors.textFieldBackgroundColor,
                      hintText: "CGST",
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
                        return 'Please enter CGST';
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

                  TextFormField(
                    // initialValue: Application.customerLogin!.name.toString(),
                    controller: sgstController,
                    textAlign: TextAlign.start,
                    keyboardType: TextInputType.number,
                    style: TextStyle(
                      fontSize: 18,
                      height: 1.5,
                    ),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: ThemeColors.textFieldBackgroundColor,
                      hintText: "SGST",
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
                        return 'Please enter SGST';
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

                  TextFormField(
                    // initialValue: Application.customerLogin!.name.toString(),
                    controller: igstController,
                    textAlign: TextAlign.start,
                    keyboardType: TextInputType.number,
                    style: TextStyle(
                      fontSize: 18,
                      height: 1.5,
                    ),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: ThemeColors.textFieldBackgroundColor,
                      hintText: "IGST",
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
                        return 'Please enter IGST';
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

                  SizedBox(
                    height: 20,
                  ),

                  Divider(
                    thickness: 2,
                  ),
                  SizedBox(
                    height: 40,
                  ),

                  Center(
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: ElevatedButton(
                            onPressed: () async {
                              Navigator.push(context, MaterialPageRoute(builder: (contex)=>EnquiryQuotationsPreviewScreen()));
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
