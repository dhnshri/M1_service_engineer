import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Config/font.dart';
import '../../../Widget/common.dart';
import '../../../Widget/stepper_button.dart';
import 'make_quotatons.dart';

class ServiceChargesScreen extends StatefulWidget {
  const ServiceChargesScreen({Key? key}) : super(key: key);

  @override
  _ServiceChargesScreenState createState() => _ServiceChargesScreenState();
}

class _ServiceChargesScreenState extends State<ServiceChargesScreen > {
  final TextEditingController _workingTimeController = TextEditingController();
  final TextEditingController _dateofJoiningController = TextEditingController();
  final TextEditingController _serviceCallChargesController = TextEditingController();
  final TextEditingController _handlingChargesController = TextEditingController();
  final TextEditingController _otherChargesController = TextEditingController();
  final TextEditingController _transportChargesController = TextEditingController();
  final TextEditingController _serviceTitleController = TextEditingController();

  String dropdownValue = '+ 91';
  String? phoneNum;
  String? role;
  bool loading = true;

  // String? smsCode;
  // bool smsCodeSent = false;
  // String? verificationId;
  final _formKey = GlobalKey<FormState>();

  Future AddOtherCharges() {
    return showModalBottomSheet(
        isScrollControlled: true,

        // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(35.0),
                topRight: Radius.circular(35.0))),
        context: context,
        builder: (BuildContext context) {
          return otherChargesInfo();

        });
  }

  Widget otherChargesInfo()
  {
    return Container(
      height: 250,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Add services",style: showBottomModelHeading,),
            SizedBox(
              width:
              MediaQuery.of(context).size.width * 0.8,
              height: 60,
              child: TextFormField(
                controller: _serviceTitleController,
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
                  hintText: 'Service Title',
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                StepperButton(
                  onPressed: () async {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => MakeQuotationScreen()));
                  },
                  shape: const RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.all(Radius.circular(50))),
                  text: 'Cancel',
                  loading: loading,
                ),
                SizedBox(width: 15,),
                StepperButton(
                  onPressed: () async {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => MakeQuotationScreen()));
                  },
                  shape: const RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.all(Radius.circular(50))),
                  text: 'Done',
                  loading: loading,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width:
          MediaQuery.of(context).size.width * 0.8,
          height: 60,
          child: TextFormField(
            controller: _workingTimeController,
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
              hintText: 'Working Time',
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
            controller: _dateofJoiningController,
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
              suffixIcon: Padding(
                padding: EdgeInsets.all(0.0),
                child: Icon(
                  Icons.calendar_today_rounded,
                  color: Colors.grey,
                ), // icon is 48px widget.
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
              hintText: 'Date of joining',
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
        SizedBox(
          width:
          MediaQuery.of(context).size.width * 0.8,
          height: 60,
          child: TextFormField(
            controller: _otherChargesController,
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
              hintText: 'Other Charges',
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
            controller: _transportChargesController,
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
              hintText: 'Transport Charges',
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(),
            InkWell(
              onTap: (){
                AddOtherCharges();
              },
              child: Row(
                children: [
                  Text("Other Charges"),
                  SizedBox(width: 2,),
                  addIcon(),
                ],
              ),
            )
          ],
        ),

      ],
    );
  }
}
