import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:service_engineer/Api/commission_api.dart';
import 'package:service_engineer/Model/JobWorkEnquiry/service_request_detail_model.dart';
import 'package:service_engineer/Model/product_model.dart';
import 'package:service_engineer/Screen/JobWorkEnquiry/Quotations/ReviceQuotations/enquiry_previewQuotation.dart';
import 'package:service_engineer/Screen/MachineMaintenance/MakeQuotations/preview.dart';
import 'package:service_engineer/Screen/MachineMaintenance/MakeQuotations/service_charges.dart';
import 'package:service_engineer/Screen/MachineMaintenance/Quotations/ReviceQuotations/revice_item_requirment.dart';
import 'package:service_engineer/Screen/MachineMaintenance/Quotations/ReviceQuotations/revice_preview.dart';
import 'package:service_engineer/Screen/MachineMaintenance/Quotations/ReviceQuotations/revice_quotations.dart';
import 'package:service_engineer/Screen/MachineMaintenance/Quotations/ReviceQuotations/revice_service_charges.dart';
import 'package:service_engineer/Utils/application.dart';
import 'package:service_engineer/app.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../Config/font.dart';
import '../../../../Constant/theme_colors.dart';
import '../../../../Widget/common.dart';
import '../../../../Widget/custom_snackbar.dart';
import '../../../../Widget/stepper_button.dart';
import '../../../bottom_navbar.dart';

class EnquiryMakeQuotationScreen extends StatefulWidget {
  EnquiryMakeQuotationScreen({Key? key,required this.requestDetailList}) : super(key: key);
  List<JobWorkEnquiryDetailsModel>? requestDetailList = [];

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
  List<TextEditingController> itemRateController = [];
  List<TextEditingController> volumeController = [];
  TextEditingController quantityController = TextEditingController();
  TextEditingController transportController = TextEditingController();
  TextEditingController packingController = TextEditingController();
  TextEditingController testingChargesController = TextEditingController();
  TextEditingController cgstController = TextEditingController();
  TextEditingController sgstController = TextEditingController();
  TextEditingController igstController = TextEditingController();
  ValueNotifier<bool> isDialOpen = ValueNotifier(false);
  bool transportValue = false;
  bool packingValue = false;
  bool testingValue = false;
  bool cgstValue = false;
  bool sgstValue = false;
  bool igstValue = false;
  // ItemModel? itemData;
  List<ItemModel> itemData = List.empty(growable: true);
  List<String>? itemList=[];
  List<String>? volumeList=[];
  int commission=0;


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
    transportController.dispose();
    packingController.dispose();
    testingChargesController.dispose();
    // quantityController.dispose();
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
            title: Text('Quotation for #${widget.requestDetailList![0].jobWorkEnquiryId}'),
          ),
          body:SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemCount: widget.requestDetailList!.length,
                    // padding: EdgeInsets.only(top: 10, bottom: 15),
                    itemBuilder: (context, index) {
                      itemRateController.add(new TextEditingController());
                      volumeController.add(new TextEditingController());

                      return  Padding(
                        padding: const EdgeInsets.only(right:0.0,left: 0.0,bottom: 8.0,top: 8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 5,),
                            Text(index.toString(),),

                            SizedBox(height: 5,),
                            ///Item Name
                            TextFormField(
                              enabled: false,
                              initialValue: widget.requestDetailList![index].itemName.toString(),
                              // controller: itemNameController,
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
                                if (value == null || value.isEmpty) {
                                  return 'Please enter Item Name';
                                }

                                return null;
                              },
                              onChanged: (value) {
                                // itemData[index].name = value;
                                setState(() {
                                  // _nameController.text = value;
                                  if (_formKey.currentState!.validate()) {}
                                });
                              },
                            ),

                            SizedBox(height: 20,),
                            ///Quantity
                            TextFormField(
                              enabled: false,
                              initialValue: widget.requestDetailList![index].qty.toString(),
                              // controller: quantityController,
                              textAlign: TextAlign.start,
                              keyboardType: TextInputType.number,
                              style: const TextStyle(
                                fontSize: 18,
                                height: 1.5,
                              ),
                              decoration: const InputDecoration(
                                filled: true,
                                fillColor: ThemeColors.textFieldBackgroundColor,
                                hintText: "Quantity",
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

                                if (value == null || value.isEmpty) {
                                  return 'Please enter Quantity';
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
                            ///Rate
                            SizedBox(height: 20,),
                            TextFormField(
                              // initialValue: Application.customerLogin!.name.toString(),
                              controller: itemRateController[index],
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
                              onSaved: (val) => {
                                itemData[index].rate = val
                              },

                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter Item Rate / Piece';
                                }
                                return null;
                              },
                              onChanged: (value) {
                                setState(() {
                                  // itemData[index].rate = value;
                                  // if (_formKey.currentState!.validate()) {}
                                });
                              },
                            ),
                            SizedBox(height: 20,),
                            ///Volume
                            TextFormField(
                              // initialValue: Application.customerLogin!.name.toString(),
                              controller: volumeController[index],
                              textAlign: TextAlign.start,
                              keyboardType: TextInputType.number,
                              style: const TextStyle(
                                fontSize: 18,
                                height: 1.5,
                              ),
                              decoration: const InputDecoration(
                                filled: true,
                                fillColor: ThemeColors.textFieldBackgroundColor,
                                hintText: "Volume",
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
                              onSaved: (val) => itemData[index].volume = val,

                              validator: (value) {

                                if (value == null || value.isEmpty) {
                                  return 'Please enter Volume';
                                }
                                return null;
                              },
                              onChanged: (value) {
                                setState(() {
                                });
                              },
                            ),
                            SizedBox(height: 20,),
                            Divider(
                              thickness: 2,
                            ),

                          ],
                        ),
                      );
                    },
                  ),


                  SizedBox(height: 20,),

                  transportValue
                      ? Column(
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: InkWell(
                          onTap: () => setState(() => transportValue = false),
                          child: Icon(
                            Icons.clear,
                            color: ThemeColors.buttonColor,
                          ),
                        ),
                      ),
                      SizedBox(
                        // width: MediaQuery.of(context).size.width * 0.8,
                        height: 60,
                        child: TextFormField(
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

                      ),
                    ],
                  )
                      : Container(),

                  ///Handling Charges Field
                  packingValue
                      ? Column(
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: InkWell(
                          onTap: () => setState(() => packingValue = false),
                          child: Icon(
                            Icons.clear,
                            color: ThemeColors.buttonColor,
                          ),
                        ),
                      ),
                      SizedBox(
                        // width: MediaQuery.of(context).size.width * 0.8,
                        height: 60,
                        child: TextFormField(
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
                      ),
                    ],
                  )
                      : Container(),

                  ///Other Charges Field
                  testingValue
                      ? Column(
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: InkWell(
                          onTap: () => setState(() => testingValue = false),
                          child: Icon(
                            Icons.clear,
                            color: ThemeColors.buttonColor,
                          ),
                        ),
                      ),
                      SizedBox(
                        // width: MediaQuery.of(context).size.width * 0.8,
                        height: 60,
                        child: TextFormField(
                          // initialValue: Application.customerLogin!.name.toString(),
                          controller: testingChargesController,
                          textAlign: TextAlign.start,
                          keyboardType: TextInputType.number,
                          style: TextStyle(
                            fontSize: 18,
                            height: 1.5,
                          ),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: ThemeColors.textFieldBackgroundColor,
                            hintText: "Testing Charges",
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

                            if (value == null || value.isEmpty) {
                              return 'Please enter Packing Charges';
                            }
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
                      ),

                    ],
                  )
                      : Container(),

                  ///CGST Charges
                  SizedBox(
                    // width: MediaQuery.of(context).size.width * 0.8,
                    height: 60,
                    child: TextFormField(
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
                        hintText: "Add CGST",
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

                        if (value == null || value.isEmpty) {
                          return 'Please enter CGST Charges';
                        }
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
                  ),

                  ///SGST Charges
                  SizedBox(
                    // width: MediaQuery.of(context).size.width * 0.8,
                    height: 60,
                    child: TextFormField(
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
                        hintText: "Add SGST",
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

                        if (value == null || value.isEmpty) {
                          return 'Please enter SGST Charges';
                        }
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
                  ),

                  ///IGST Charges
                   SizedBox(
                     // width: MediaQuery.of(context).size.width * 0.8,
                     height: 60,
                     child: TextFormField(
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
                         hintText: "Add IGST",
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
                         if (value == null || value.isEmpty) {
                           return 'Please enter IGST Charges';
                         }
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
                   ),


                  ///Speed Dial Button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(),
                      InkWell(
                        onTap: () {},
                        child: Row(
                          children: [
                            Text("Add Charges",
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600)),
                            SizedBox(
                              width: 8,
                            ),
                            // addIcon(),
                            SpeedDial(
                              openCloseDial: isDialOpen,
                              backgroundColor: ThemeColors.buttonColor,
                              foregroundColor: Colors.white,
                              icon: Icons.add,
                              buttonSize: const Size(45.0, 45.0),
                              children: [
                                // SpeedDialChild(
                                //   // child: const Icon(Icons.accessibility) ,
                                //   backgroundColor: Colors.red,
                                //   foregroundColor: Colors.white,
                                //   label: 'IGST',
                                //   labelBackgroundColor: ThemeColors.imageContainerBG,
                                //   labelStyle: TextStyle(color: ThemeColors.buttonColor),
                                //   onTap: () => setState(() => igstValue = true),
                                // ),
                                // SpeedDialChild(
                                //   // child: const Icon(Icons.accessibility) ,
                                //   backgroundColor: Colors.red,
                                //   foregroundColor: Colors.white,
                                //   label: 'SGST',
                                //   labelBackgroundColor: ThemeColors.imageContainerBG,
                                //   labelStyle: TextStyle(color: ThemeColors.buttonColor),
                                //   onTap: () => setState(() => sgstValue = true),
                                // ),
                                // SpeedDialChild(
                                //   // child: const Icon(Icons.accessibility) ,
                                //   backgroundColor: Colors.red,
                                //   foregroundColor: Colors.white,
                                //   label: 'CGST',
                                //   labelBackgroundColor: ThemeColors.imageContainerBG,
                                //   labelStyle: TextStyle(color: ThemeColors.buttonColor),
                                //   onTap: () => setState(() => cgstValue = true),
                                // ),
                                SpeedDialChild(
                                  // child: const Icon(Icons.accessibility) ,
                                  backgroundColor: Colors.red,
                                  foregroundColor: Colors.white,
                                  label: 'Testing Charges',
                                  labelBackgroundColor: ThemeColors.imageContainerBG,
                                  labelStyle: TextStyle(color: ThemeColors.buttonColor),
                                  onTap: () => setState(() => testingValue = true),
                                ),
                                SpeedDialChild(
                                  // child: const Icon(Icons.accessibility) ,
                                  backgroundColor: Colors.red,
                                  foregroundColor: Colors.white,
                                  label: 'Packing Charges',
                                  labelBackgroundColor: ThemeColors.imageContainerBG,
                                  labelStyle: TextStyle(color: ThemeColors.buttonColor),
                                  onTap: () => setState(() => packingValue = true),
                                ),
                                SpeedDialChild(
                                  // child: const Icon(Icons.accessibility) ,
                                  backgroundColor: Colors.red,
                                  foregroundColor: Colors.white,
                                  label: 'Transport Charges',
                                  labelBackgroundColor: ThemeColors.imageContainerBG,
                                  labelStyle: TextStyle(color: ThemeColors.buttonColor),
                                  onTap: () => setState(() => transportValue = true),
                                ),
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),


                  Center(
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: ElevatedButton(
                            onPressed: () async {
                              for(int i = 0; i < itemRateController.length;i++) {
                                if (itemRateController[i].text != "") {
                                  itemList = itemRateController
                                      .map((x) => x.text)
                                      .toList();
                                  volumeList = volumeController
                                      .map((x) => x.text)
                                      .toList();

                                }
                                itemList!.removeWhere((item) => ["", null, false, 0].contains(item));
                                volumeList!.removeWhere((item) => ["", null, false, 0].contains(item));

                              }
                              print(itemList);
                              print(volumeList);

                              if(volumeList!.length != widget.requestDetailList!.length){
                                showCustomSnackBar(context,'Please add volume for all.',isError: true);
                              }
                              else if(cgstController.text == ""){
                                showCustomSnackBar(context,'Please add CGST.',isError: true);
                              }
                              else if(sgstController.text == ""){
                                showCustomSnackBar(context,'Please add SGST.',isError: true);
                              }
                              else if(igstController.text == ""){
                                showCustomSnackBar(context,'Please add IGST.',isError: true);
                              }
                              else if(itemList!.length == widget.requestDetailList!.length){
                                Navigator.push(context, MaterialPageRoute(builder: (contex)=>
                                    EnquiryQuotationsPreviewScreen(requestDetailList: widget.requestDetailList,itemRateController: itemRateController,
                                      cgstController: cgstController,igstController: igstController,packingController: packingController,
                                      sgstController: sgstController,testingChargesController: testingChargesController,transportController: transportController,
                                      volumeController: volumeController,)));
                              }else{
                                showCustomSnackBar(context,'Please add item rate for all.',isError: true);

                              }

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
