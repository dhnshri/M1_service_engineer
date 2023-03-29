import 'package:cached_network_image/cached_network_image.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:service_engineer/Screen/Transportation/ServiceRequest/MakeQuotationTransportation/quotation_for.dart';
import 'package:service_engineer/Widget/custom_snackbar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../Config/font.dart';
import '../../../../Constant/theme_colors.dart';
import '../../../../Model/Transpotation/serviceRequestDetailModel.dart';
import '../../../../Model/Transpotation/vehicle_name_model.dart';
import '../../../../Model/Transpotation/vehicle_number_model.dart';
import '../../../../Model/Transpotation/vehicle_type_model.dart';
import '../../../../NetworkFunction/fetchVehicleName.dart';
import '../../../../NetworkFunction/fetchVehicleNumber.dart';
import '../../../../NetworkFunction/fetchVehicleType.dart';
import '../../../../Widget/function_button.dart';
import '../../../bottom_navbar.dart';
import 'package:dropdown_button2/dropdown_button2.dart';


class MakeQuotationTransposationScreen extends StatefulWidget {
  TransportDetailsModel serviceRequestData;
  MakeQuotationTransposationScreen({Key? key,required this.serviceRequestData}) : super(key: key);

  @override
  _MakeQuotationTransposationScreenState createState() => _MakeQuotationTransposationScreenState();
}

class _MakeQuotationTransposationScreenState extends State<MakeQuotationTransposationScreen> {
  final TextEditingController _phoneNumberController = TextEditingController();
  List<VehicleNameModel> addVehicleNameList = [];
  List<VehicleTypeModel> addVehicleTypeList = [];
  VehicleNameModel? vehicleNameselected;
  VehicleTypeModel? vehicleTypeselected;
  VehicleNumberModel? vehicleNumberselected;
  String? phoneNum;
  String? role;
  bool loading = true;
  String dropdownValue = 'Vehicle Type';
  String dropdownValue2 = 'Vehicle Name';
  String dropdownValue3 = 'Vehicle Number';
  String dropdownValue4 = 'GST';
  // String? smsCode;
  // bool smsCodeSent = false;
  // String? verificationId;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController ServiceCallChargesController = TextEditingController();
  final TextEditingController HandlingChargesController = TextEditingController();
  final TextEditingController gstController = TextEditingController();


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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: InkWell(
            onTap: (){
              Navigator.pop(context);
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => BottomNavigation (index:0,dropValue:"Transportation")));
            },
            child: Icon(Icons.arrow_back_ios)),
        title: Text('Quotation for #${widget.serviceRequestData.transportEnquiryId}',style:appBarheadingStyle ,),
      ),
      bottomNavigationBar:Padding(
        padding: const EdgeInsets.all(10.0),
        child: FunctionButton(
          onPressed: () async {
            if(vehicleNameselected==null){
              showCustomSnackBar(context,'Please select Vehicle Name.',isError: true);
            }else if(vehicleTypeselected==null){
              showCustomSnackBar(context,'Please select Vehicle Type.',isError: true);
            }else if(vehicleNumberselected==null){
              showCustomSnackBar(context,'Please select Vehicle Number.',isError: true);
            }else if(HandlingChargesController.text==""){
              showCustomSnackBar(context,'Please add Handling Charges.',isError: true);
            }else if(ServiceCallChargesController.text==""){
              showCustomSnackBar(context,'Please add Service Charges.',isError: true);
            }else if(gstController.text==""){
              showCustomSnackBar(context,'Please add GST Charges.',isError: true);
            }else
            {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (contex) => QuotationFor(
                            vehicleNameselected: vehicleNameselected,
                            vehicleNumberselected: vehicleNumberselected,
                            vehicleTypeselected: vehicleTypeselected,
                            HandlingChargesController:
                                HandlingChargesController,
                            ServiceCallChargesController:
                                ServiceCallChargesController,
                            gstController: gstController,
                            requestDetailList: widget.serviceRequestData,
                          )));
            }
          },
          shape: const RoundedRectangleBorder(
              borderRadius:
              BorderRadius.all(Radius.circular(50))),
          text: 'Next',
          loading: loading,


        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView(
          children: [
          // For Vehicle Name
            Padding(
                padding: EdgeInsets.only(top: 8.0, bottom: 0.0),
                //to hide underline
                child: FutureBuilder<List<VehicleNameModel>>(
                    future: fetchVehicleName(vehicleNameselected!=null?vehicleNameselected!.transportProfileVehicleInformationId.toString():""),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<VehicleNameModel>> snapshot) {
                      if (!snapshot.hasData) return Container();

                      return DropdownButtonHideUnderline(
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              // color: Theme.of(context).dividerColor,
                                color: Color(0xffF5F5F5),
                                borderRadius: BorderRadius.circular(10.0),
                                border: Border.all(
                                    color: ThemeColors.textFieldBgColor)),
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: 15.0, top: 0.0, right: 5.0, bottom: 0.0),
                              child:
                              //updated on 15/06/2021 to change background colour of dropdownbutton
                              new Theme(
                                  data: Theme.of(context)
                                      .copyWith(canvasColor: Colors.white),
                                  child: DropdownButton(
                                      items: snapshot.data!
                                          .map((vehiclename) =>
                                          DropdownMenuItem<VehicleNameModel>(
                                            value: vehiclename,
                                            child: Text(
                                              vehiclename.vehicleName.toString(),
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                          ))
                                          .toList(),
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600),
                                      isExpanded: true,
                                      hint: Text('Select Vehicle Name',
                                          style: TextStyle(
                                              color: Color(0xFF3F4141))),
                                      value: vehicleNameselected == null
                                          ? vehicleNameselected
                                          : snapshot.data!
                                          .where((i) =>
                                      i.vehicleName ==
                                          vehicleNameselected!
                                              .vehicleName)
                                          .first as VehicleNameModel,
                                      onChanged: (VehicleNameModel? vehiclename) {
                                        setState(() {
                                          vehicleNameselected = vehiclename;
                                        });
                                      })),
                            ),
                          ));
                    })),

            // For Vehicle Type
            Padding(
                padding: EdgeInsets.only(top: 8.0, bottom: 0.0),
                //to hide underline
                child: FutureBuilder<List<VehicleTypeModel>>(
                    future: fetchVehicleType(vehicleTypeselected!=null?vehicleTypeselected!.transportProfileVehicleInformationId.toString():""),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<VehicleTypeModel>> snapshot) {
                      if (!snapshot.hasData) return Container();

                      return DropdownButtonHideUnderline(
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              // color: Theme.of(context).dividerColor,
                                color: Color(0xffF5F5F5),
                                borderRadius: BorderRadius.circular(10.0),
                                border: Border.all(
                                    color: ThemeColors.textFieldBgColor)),
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: 15.0, top: 0.0, right: 5.0, bottom: 0.0),
                              child:
                              //updated on 15/06/2021 to change background colour of dropdownbutton
                              Theme(
                                  data: Theme.of(context)
                                      .copyWith(canvasColor: Colors.white),
                                  child: DropdownButton(
                                      items: snapshot.data!
                                          .map((vehicletype) =>
                                          DropdownMenuItem<VehicleTypeModel>(
                                            value: vehicletype,
                                            child: Text(
                                              vehicletype.vehicleType.toString(),
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                          ))
                                          .toList(),
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600),
                                      isExpanded: true,
                                      hint: Text('Select Vehicle Type',
                                          style: TextStyle(
                                              color: Color(0xFF3F4141))),
                                      value: vehicleTypeselected == null
                                          ? vehicleTypeselected
                                          : snapshot.data!
                                          .where((i) =>
                                      i.vehicleType ==
                                          vehicleTypeselected!
                                              .vehicleType)
                                          .first as VehicleTypeModel,
                                      onChanged: (VehicleTypeModel? vehicletype) {
                                        setState(() {
                                          vehicleTypeselected = vehicletype;
                                        });
                                      })),
                            ),
                          ));
                    })),

           // For Vehicle Number
            Padding(
                padding: EdgeInsets.only(top: 8.0, bottom: 0.0),
                //to hide underline
                child: FutureBuilder<List<VehicleNumberModel>>(
                    future: fetchVehicleNumber(vehicleNumberselected!=null?vehicleNumberselected!.transportProfileVehicleInformationId.toString():""),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<VehicleNumberModel>> snapshot) {
                      if (!snapshot.hasData) return Container();

                      return DropdownButtonHideUnderline(
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              // color: Theme.of(context).dividerColor,
                                color: Color(0xffF5F5F5),
                                borderRadius: BorderRadius.circular(10.0),
                                border: Border.all(
                                    color: ThemeColors.textFieldBgColor)),
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: 15.0, top: 0.0, right: 5.0, bottom: 0.0),
                              child:
                              //updated on 15/06/2021 to change background colour of dropdownbutton
                              Theme(
                                  data: Theme.of(context)
                                      .copyWith(canvasColor: Colors.white),
                                  child: DropdownButton(
                                      items: snapshot.data!
                                          .map((vehiclenumber) =>
                                          DropdownMenuItem<VehicleNumberModel>(
                                            value: vehiclenumber,
                                            child: Text(
                                              vehiclenumber.vehicleNumber.toString(),
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                          ))
                                          .toList(),
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600),
                                      isExpanded: true,
                                      hint: Text('Select Vehicle Number',
                                          style: TextStyle(
                                              color: Color(0xFF3F4141))),
                                      value: vehicleNumberselected == null
                                          ? vehicleNumberselected
                                          : snapshot.data!
                                          .where((i) =>
                                      i.vehicleNumber ==
                                          vehicleNumberselected!
                                              .vehicleNumber)
                                          .first as VehicleNumberModel,
                                      onChanged: (VehicleNumberModel? vehiclenumber) {
                                        setState(() {
                                          vehicleNumberselected = vehiclenumber;
                                        });
                                      })),
                            ),
                          ));
                    })),

            SizedBox(height: 10,),
            SizedBox(
              width:
              MediaQuery.of(context).size.width * 0.8,
              height: 60,
              child: TextFormField(
                controller: ServiceCallChargesController,
                keyboardType: TextInputType.number,
                // maxLength: 10,
                cursorColor: primaryAppColor,
                decoration: InputDecoration(
                  disabledBorder: OutlineInputBorder(
                    borderRadius:
                    BorderRadius.circular(8.0),
                    borderSide: const BorderSide(
                      color: Colors.white,
                      width: 1.0,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius:
                    BorderRadius.circular(8.0),
                    borderSide: const BorderSide(
                      color: Colors.red,
                      width: 1.0,
                    ),
                  ),
                  fillColor: Color(0xffF5F5F5),
                  filled: true,
                  focusedBorder: OutlineInputBorder(
                    borderRadius:
                    BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                        color: Colors.white, width: 1.0),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                      borderRadius:
                      BorderRadius.circular(8.0),
                      borderSide: const BorderSide(
                        color: Colors.white,
                        width: 1.0,
                      )),
                  enabledBorder: OutlineInputBorder(
                    borderRadius:
                    BorderRadius.circular(8.0),
                    borderSide: const BorderSide(
                      color: Colors.white,
                      width: 1.0,
                    ),
                  ),
                  hintText: 'Service/Call Charges',
                  contentPadding: const EdgeInsets.fromLTRB(
                      20.0, 20.0, 0.0, 0.0),
                  hintStyle: GoogleFonts.poppins(
                      color: Colors.grey,
                      fontSize: 12.0,
                      fontWeight: FontWeight.w500),
                ),
                onChanged: (val) {
                  setState(() {
                    phoneNum = val;
                    // _phoneNumberController.text = val;
                  });
                },
              ),
            ),
            SizedBox(
              width:
              MediaQuery.of(context).size.width * 0.8,
              height: 60,
              child: TextFormField(
                controller: HandlingChargesController,
                keyboardType: TextInputType.number,
                // maxLength: 10,
                cursorColor: primaryAppColor,
                decoration: InputDecoration(
                  disabledBorder: OutlineInputBorder(
                    borderRadius:
                    BorderRadius.circular(8.0),
                    borderSide: const BorderSide(
                      color: Colors.white,
                      width: 1.0,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius:
                    BorderRadius.circular(8.0),
                    borderSide: const BorderSide(
                      color: Colors.red,
                      width: 1.0,
                    ),
                  ),
                  fillColor: Color(0xffF5F5F5),
                  filled: true,
                  focusedBorder: OutlineInputBorder(
                    borderRadius:
                    BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                        color: Colors.white, width: 1.0),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                      borderRadius:
                      BorderRadius.circular(8.0),
                      borderSide: const BorderSide(
                        color: Colors.white,
                        width: 1.0,
                      )),
                  enabledBorder: OutlineInputBorder(
                    borderRadius:
                    BorderRadius.circular(8.0),
                    borderSide: const BorderSide(
                      color: Colors.white,
                      width: 1.0,
                    ),
                  ),
                  hintText: 'Handling Charges',
                  contentPadding: const EdgeInsets.fromLTRB(
                      20.0, 20.0, 0.0, 0.0),
                  hintStyle: GoogleFonts.poppins(
                      color: Colors.grey,
                      fontSize: 12.0,
                      fontWeight: FontWeight.w500),
                ),
                onChanged: (val) {
                  setState(() {
                    phoneNum = val;
                    // _phoneNumberController.text = val;
                  });
                },
              ),
            ),
            SizedBox(
              width:
              MediaQuery.of(context).size.width * 0.8,
              height: 60,
              child: TextFormField(
                controller: gstController,
                keyboardType: TextInputType.number,
                // maxLength: 10,
                cursorColor: primaryAppColor,
                decoration: InputDecoration(
                  disabledBorder: OutlineInputBorder(
                    borderRadius:
                    BorderRadius.circular(8.0),
                    borderSide: const BorderSide(
                      color: Colors.white,
                      width: 1.0,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius:
                    BorderRadius.circular(8.0),
                    borderSide: const BorderSide(
                      color: Colors.red,
                      width: 1.0,
                    ),
                  ),
                  fillColor: Color(0xffF5F5F5),
                  filled: true,
                  focusedBorder: OutlineInputBorder(
                    borderRadius:
                    BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                        color: Colors.white, width: 1.0),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                      borderRadius:
                      BorderRadius.circular(8.0),
                      borderSide: const BorderSide(
                        color: Colors.white,
                        width: 1.0,
                      )),
                  enabledBorder: OutlineInputBorder(
                    borderRadius:
                    BorderRadius.circular(8.0),
                    borderSide: const BorderSide(
                      color: Colors.white,
                      width: 1.0,
                    ),
                  ),
                  hintText: 'GST Charges',
                  contentPadding: const EdgeInsets.fromLTRB(
                      20.0, 20.0, 0.0, 0.0),
                  hintStyle: GoogleFonts.poppins(
                      color: Colors.grey,
                      fontSize: 12.0,
                      fontWeight: FontWeight.w500),
                ),
                onChanged: (val) {
                  setState(() {
                    phoneNum = val;
                    // _phoneNumberController.text = val;
                  });
                },
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.only(bottom: 20.0),
            //   child: Container(
            //     width:
            //     MediaQuery.of(context).size.width * 0.9,
            //     height: 40,
            //     decoration: BoxDecoration(
            //         color: Colors.white,
            //         borderRadius:
            //         BorderRadius.circular(8.0)),
            //     child: DropdownButtonHideUnderline(
            //         child: DropdownButton2(
            //           items: <String>[
            //             'GST',
            //             '12',
            //             '18',
            //             '21'
            //
            //           ].map((item) =>
            //               DropdownMenuItem<String>(
            //                 value: item,
            //                 child: Text(
            //                   item,
            //                   style: const TextStyle(
            //                       fontFamily: 'Poppins',
            //                       fontSize: 15,
            //                       color: Colors.black,
            //                       fontWeight: FontWeight.w500
            //                   ),
            //                 ),
            //               ))
            //               .toList(),
            //           value: dropdownValue4,
            //           onChanged: (value) {
            //             setState(() {
            //               dropdownValue4 = value as String;
            //             });
            //           },
            //           buttonHeight: 40,
            //           buttonWidth: 140,
            //           itemHeight: 40,
            //           buttonPadding: const EdgeInsets.only(left: 14, right: 14),
            //           dropdownPadding: const EdgeInsets.symmetric(vertical: 6),
            //           dropdownDecoration: BoxDecoration(
            //             borderRadius: BorderRadius.circular(10),
            //             // color: Colors.redAccent,
            //           ),
            //           // itemWidth: 140,
            //         )
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
