import 'package:cached_network_image/cached_network_image.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:service_engineer/Screen/Transportation/ServiceRequest/MakeQuotationTransportation/quotation_for.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../Config/font.dart';
import '../../../../Widget/function_button.dart';
import '../../../bottom_navbar.dart';
import 'package:dropdown_button2/dropdown_button2.dart';


class MakeQuotationTransposationScreen extends StatefulWidget {
  const MakeQuotationTransposationScreen({Key? key}) : super(key: key);

  @override
  _MakeQuotationTransposationScreenState createState() => _MakeQuotationTransposationScreenState();
}

class _MakeQuotationTransposationScreenState extends State<MakeQuotationTransposationScreen> {
  final TextEditingController _phoneNumberController = TextEditingController();
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
        title: Text('Quotation for #102GRDSA36987',style:appBarheadingStyle ,),
      ),
      bottomNavigationBar:Padding(
        padding: const EdgeInsets.all(10.0),
        child: FunctionButton(
          onPressed: () async {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => QuotationFor()));
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
          text: 'Next',
          loading: loading,


        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Container(
                width:
                MediaQuery.of(context).size.width * 0.9,
                height: 40,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                    BorderRadius.circular(8.0)),
                child: DropdownButtonHideUnderline(
                    child: DropdownButton2(
                      items: <String>[
                        'Vehicle Type',
                        'Van',
                        'Motorcycle',
                        'Dump truck'

                      ].map((item) =>
                          DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                              item,
                              style: const TextStyle(
                                  fontFamily: 'Poppins-Medium',
                                  fontSize: 15,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500
                              ),
                            ),
                          ))
                          .toList(),
                      value: dropdownValue,
                      onChanged: (value) {
                        setState(() {
                          dropdownValue = value as String;
                        });
                      },
                      buttonHeight: 40,
                      buttonWidth: 140,
                      itemHeight: 40,
                      buttonPadding: const EdgeInsets.only(left: 14, right: 14),
                      dropdownPadding: const EdgeInsets.symmetric(vertical: 6),
                      dropdownDecoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        // color: Colors.redAccent,
                      ),
                      // itemWidth: 140,
                    )
                  // DropdownButton<String>(
                  //   isExpanded: true,
                  //   value: dropdownValue,
                  //   icon: Padding(
                  //     padding: const EdgeInsets.only(left:100.0),
                  //     child: const Icon(Icons.arrow_drop_down_sharp),
                  //   ),
                  //   iconSize: 24,
                  //   elevation: 16,
                  //   iconEnabledColor: primaryAppColor,
                  //   borderRadius:
                  //   BorderRadius.circular(8.0),
                  //   style: TextStyle(
                  //       color: Colors.black,
                  //       fontSize: 16,
                  //       fontWeight: FontWeight.normal),
                  //   onChanged: (String? newValue) {
                  //     setState(() {
                  //       dropdownValue = newValue!;
                  //     });
                  //   },
                  //   items: <String>[
                  //     'Machine Maintenance',
                  //     'Job Work Enquiry',
                  //     'Transportation',
                  //
                  //   ].map<DropdownMenuItem<String>>(
                  //           (String value) {
                  //         return DropdownMenuItem<String>(
                  //           value: value,
                  //           child: Center(child: Text(value)),
                  //         );
                  //       }).toList(),
                  // )),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Container(
                width:
                MediaQuery.of(context).size.width * 0.9,
                height: 40,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                    BorderRadius.circular(8.0)),
                child: DropdownButtonHideUnderline(
                    child: DropdownButton2(
                      items: <String>[
                        'Vehicle Name',
                        'ABC',
                        'XYZ',
                        'MNO'

                      ].map((item) =>
                          DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                              item,
                              style: const TextStyle(
                                  fontFamily: 'Poppins-Medium',
                                  fontSize: 15,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500
                              ),
                            ),
                          ))
                          .toList(),
                      value: dropdownValue2,
                      onChanged: (value) {
                        setState(() {
                          dropdownValue2 = value as String;
                        });
                      },
                      buttonHeight: 40,
                      buttonWidth: 140,
                      itemHeight: 40,
                      buttonPadding: const EdgeInsets.only(left: 14, right: 14),
                      dropdownPadding: const EdgeInsets.symmetric(vertical: 6),
                      dropdownDecoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        // color: Colors.redAccent,
                      ),
                      // itemWidth: 140,
                    )
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Container(
                width:
                MediaQuery.of(context).size.width * 0.9,
                height: 40,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                    BorderRadius.circular(8.0)),
                child: DropdownButtonHideUnderline(
                    child: DropdownButton2(
                      items: <String>[
                        'Vehicle Number',
                        '123456',
                        '789123',
                        '456789'

                      ].map((item) =>
                          DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                              item,
                              style: const TextStyle(
                                  fontFamily: 'Poppins-Medium',
                                  fontSize: 15,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500
                              ),
                            ),
                          ))
                          .toList(),
                      value: dropdownValue3,
                      onChanged: (value) {
                        setState(() {
                          dropdownValue3 = value as String;
                        });
                      },
                      buttonHeight: 40,
                      buttonWidth: 140,
                      itemHeight: 40,
                      buttonPadding: const EdgeInsets.only(left: 14, right: 14),
                      dropdownPadding: const EdgeInsets.symmetric(vertical: 6),
                      dropdownDecoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        // color: Colors.redAccent,
                      ),
                      // itemWidth: 140,
                    )
                ),
              ),
            ),
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
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Container(
                width:
                MediaQuery.of(context).size.width * 0.9,
                height: 40,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                    BorderRadius.circular(8.0)),
                child: DropdownButtonHideUnderline(
                    child: DropdownButton2(
                      items: <String>[
                        'GST',
                        'AB3456',
                        'CD9123',
                        'EF6789'

                      ].map((item) =>
                          DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                              item,
                              style: const TextStyle(
                                  fontFamily: 'Poppins-Medium',
                                  fontSize: 15,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500
                              ),
                            ),
                          ))
                          .toList(),
                      value: dropdownValue4,
                      onChanged: (value) {
                        setState(() {
                          dropdownValue4 = value as String;
                        });
                      },
                      buttonHeight: 40,
                      buttonWidth: 140,
                      itemHeight: 40,
                      buttonPadding: const EdgeInsets.only(left: 14, right: 14),
                      dropdownPadding: const EdgeInsets.symmetric(vertical: 6),
                      dropdownDecoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        // color: Colors.redAccent,
                      ),
                      // itemWidth: 140,
                    )
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
