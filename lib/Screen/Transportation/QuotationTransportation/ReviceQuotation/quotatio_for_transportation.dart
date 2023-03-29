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
import '../../../../Model/Transpotation/quotationReplyModel.dart';
import '../../../../Model/Transpotation/serviceRequestDetailModel.dart';
import '../../../../Model/Transpotation/vehicle_name_model.dart';
import '../../../../Model/Transpotation/vehicle_number_model.dart';
import '../../../../Model/Transpotation/vehicle_type_model.dart';
import '../../../../Model/quotation_reply_detail_repo.dart';
import '../../../../NetworkFunction/fetchVehicleName.dart';
import '../../../../NetworkFunction/fetchVehicleNumber.dart';
import '../../../../NetworkFunction/fetchVehicleType.dart';
import '../../../../Widget/function_button.dart';
import '../../../bottom_navbar.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

import 'next_quotation_for_transportation.dart';


class ReviceQuotationTransposationScreen extends StatefulWidget {
  QuotationReplyTransportModel serviceRequestData;
  List<VehicleDetails>? vehicleList;
  List<QuotationCharges>? quotationDetailList;
  List<QuotationCharges>? quotationChargesList;
  List<CustomerReplyMsg>? quotationMsgList;
  ReviceQuotationTransposationScreen({Key? key,required this.serviceRequestData,required this.vehicleList,required this.quotationMsgList
  ,required this.quotationChargesList,required this.quotationDetailList}) : super(key: key);

  @override
  _ReviceQuotationTransposationScreenState createState() => _ReviceQuotationTransposationScreenState();
}

class _ReviceQuotationTransposationScreenState extends State<ReviceQuotationTransposationScreen> {
  final TextEditingController _phoneNumberController = TextEditingController();
  List<VehicleNameModel> addVehicleNameList = [];
  List<VehicleTypeModel> addVehicleTypeList = [];
  VehicleNameModel? vehicleNameselected;
  VehicleTypeModel? vehicleTypeselected;
  VehicleNumberModel? vehicleNumberselected;
  String? phoneNum;
  String? role;
  bool loading = true;
  String dropdownValue4 = 'GST';
  // String? smsCode;
  // bool smsCodeSent = false;
  // String? verificationId;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _serviceCallChargesController = TextEditingController();
  final TextEditingController _clientMessageController = TextEditingController();
  final TextEditingController _handlingChargesController = TextEditingController();
  final TextEditingController _gstChargesController = TextEditingController();
   final GlobalKey<ExpansionTileCardState> cardMessage = new GlobalKey();

  getData()
  {
    _serviceCallChargesController.text = widget.quotationDetailList![0].serviceCharge.toString();
    _handlingChargesController.text = widget.quotationDetailList![0].handlingCharge.toString();
    _gstChargesController.text = widget.quotationChargesList![0].gst.toString();
  //  _clientMessageController.text = widget.quotationMsgList![0].message.toString();
    //vehicleNameselected!.vehicleName= widget.vehicleList![0].vehicleName.toString();
    //getVehicleNameData();
  }

  void getVehicleNameData()
  {
    VehicleNameModel vehiclenamemodel=VehicleNameModel();
    vehiclenamemodel.vehicleName=widget.vehicleList![0].vehicleName;
    vehicleNameselected=vehiclenamemodel;
  }


  @override
  void initState() {
    // TODO: implement initState
    //saveDeviceTokenAndId();
    super.initState();
    _phoneNumberController.clear();
    getData();
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
        title: Text('Quotation for #${widget.serviceRequestData.enquiryId}',style:appBarheadingStyle ,),
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
            }else if(_handlingChargesController.text==""){
              showCustomSnackBar(context,'Please add Handling Charges.',isError: true);
            }else if(_serviceCallChargesController.text==""){
              showCustomSnackBar(context,'Please add Service Charges.',isError: true);
            }else if(_gstChargesController.text==""){
              showCustomSnackBar(context,'Please add GST Charges.',isError: true);
            }else {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (contex) => NextQuotationFor(
                            vehicleNameselected: vehicleNameselected,
                            vehicleNumberselected: vehicleNumberselected,
                            vehicleTypeselected: vehicleTypeselected,
                            HandlingChargesController:
                                _handlingChargesController,
                            ServiceCallChargesController:
                                _serviceCallChargesController,
                        gstChargesController: _gstChargesController,
                            requestDetailList: widget.serviceRequestData,
                            quotationMsgList: widget.quotationMsgList,
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

            Padding(
              padding: const EdgeInsets.only(left: 0.0, bottom: 10),
              child: Text("Service Charges",
                style: TextStyle(fontFamily: 'Poppins', fontSize: 14,fontWeight: FontWeight.w400,color: Colors.black.withOpacity(0.5)),
                textAlign: TextAlign.start, maxLines: 2, overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(
              width:
              MediaQuery.of(context).size.width * 0.8,
              height: 60,
              child: TextFormField(
                controller: _serviceCallChargesController,
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

            Padding(
              padding: const EdgeInsets.only(left: 0.0, bottom: 10),
              child: Text("Handling Charges",
                style: TextStyle(fontFamily: 'Poppins', fontSize: 14,fontWeight: FontWeight.w400,color: Colors.black.withOpacity(0.5)),
                textAlign: TextAlign.start, maxLines: 2, overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(
              width:
              MediaQuery.of(context).size.width * 0.8,
              height: 60,
              child: TextFormField(
                controller: _handlingChargesController,
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

            Padding(
              padding: const EdgeInsets.only(left: 0.0, bottom: 10),
              child: Text("GST",
                style: TextStyle(fontFamily: 'Poppins', fontSize: 14,fontWeight: FontWeight.w400,color: Colors.black.withOpacity(0.5)),
                textAlign: TextAlign.start, maxLines: 2, overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(
              width:
              MediaQuery.of(context).size.width * 0.8,
              height: 60,
              child: TextFormField(
                controller: _gstChargesController,
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

            widget.quotationMsgList!.length <= 0 ? Container():
            ExpansionTileCard(
              key: cardMessage,
              initiallyExpanded: true,
              title:  Text("Message from Client",
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Poppins',
                      fontSize: 16,
                      fontWeight: FontWeight.w500
                  )),
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 16.0,left: 16.0,bottom: 16.0),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child:
                      Text(widget.quotationMsgList![0].message.toString(),textAlign: TextAlign.start,)

                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
