import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:service_engineer/Constant/theme_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Config/font.dart';
import '../../../Widget/common.dart';
import '../../../Widget/stepper_button.dart';
import 'make_quotatons.dart';

class ServiceChargesScreen extends StatefulWidget {
   TextEditingController workingTimeController = TextEditingController();
   TextEditingController dateofJoiningController = TextEditingController();
   TextEditingController serviceCallChargesController = TextEditingController();
   TextEditingController handlingChargesController = TextEditingController();
   TextEditingController otherChargesController = TextEditingController();
   TextEditingController transportChargesController = TextEditingController();
  ServiceChargesScreen({Key? key,required this.dateofJoiningController,
  required this.handlingChargesController,
  required this.otherChargesController,
  required this.serviceCallChargesController,
  required this.transportChargesController,
  required this.workingTimeController}) : super(key: key);

  @override
  _ServiceChargesScreenState createState() => _ServiceChargesScreenState();
}

class _ServiceChargesScreenState extends State<ServiceChargesScreen > {


  ValueNotifier<bool> isDialOpen = ValueNotifier(false);
  bool serviceValue = false;
  bool handlingValue = false;
  bool otherValue = false;
  bool transportValue = false;

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
                controller: widget.serviceCallChargesController,
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
        ///Working Time Field
        SizedBox(
          width:
          MediaQuery.of(context).size.width * 0.8,
          height: 60,
          child: TextFormField(
            controller: widget.workingTimeController,
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

        ///Date of Joining Field
        SizedBox(
          width:
          MediaQuery.of(context).size.width * 0.8,
          height: 60,
          child: TextFormField(
            controller: widget.dateofJoiningController,
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

        ///Service/Call Charges Field
        serviceValue ? Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: InkWell(
                onTap: () => setState(() => serviceValue = false),
                child: Icon(Icons.clear, color: ThemeColors.buttonColor,),
              ),
            ),
            SizedBox(
              width:
              MediaQuery.of(context).size.width * 0.8,
              height: 60,
              child: TextFormField(
                controller: widget.serviceCallChargesController,
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
          ],
        ) : Container(),

        ///Handling Charges Field
        handlingValue ? Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: InkWell(
                onTap: () => setState(() => handlingValue = false),
                child: Icon(Icons.clear, color: ThemeColors.buttonColor,),
              ),
            ),
            SizedBox(
              width:
              MediaQuery.of(context).size.width * 0.8,
              height: 60,
              child: TextFormField(
                controller: widget.handlingChargesController,
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
          ],
        ) : Container(),

        ///Other Charges Field
        otherValue? Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: InkWell(
                onTap: () => setState(() => otherValue = false),
                child: Icon(Icons.clear, color: ThemeColors.buttonColor,),
              ),
            ),
            SizedBox(
              width:
              MediaQuery.of(context).size.width * 0.8,
              height: 60,
              child: TextFormField(
                controller: widget.otherChargesController,
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
          ],
        ) : Container(),

        ///Transport Charges Field
        transportValue? Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: InkWell(
                onTap: () => setState(() => transportValue = false),
                child: Icon(Icons.clear, color: ThemeColors.buttonColor,),
              ),
            ),
            SizedBox(
              width:
              MediaQuery.of(context).size.width * 0.8,
              height: 60,
              child: TextFormField(
                controller: widget.transportChargesController,
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
          ],
        ) : Container(),

        SizedBox(height: 20,),

        ///Addd Charges Button
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(),
            InkWell(
              onTap: (){
              },
              child: Row(
                children: [
                  Text("Add Charges",
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14,
                          fontWeight: FontWeight.w600
                      )),
                  SizedBox(width: 8,),
                  // addIcon(),
                  SpeedDial(
                    openCloseDial: isDialOpen,
                    backgroundColor: ThemeColors.buttonColor,
                    foregroundColor: Colors.white,
                    icon: Icons.add,
                    buttonSize : const Size(45.0, 45.0),
                    children: [
                      SpeedDialChild(
                        // child: const Icon(Icons.accessibility) ,
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        label: 'Transport Charges',
                        labelBackgroundColor: ThemeColors.imageContainerBG,
                        labelStyle: TextStyle(color: ThemeColors.buttonColor),
                        onTap: () => setState(() => transportValue = true),
                      ),
                      SpeedDialChild(
                        // child: const Icon(Icons.accessibility) ,
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        label: 'Other Charges',
                        labelBackgroundColor: ThemeColors.imageContainerBG,
                        labelStyle: TextStyle(color: ThemeColors.buttonColor),
                        onTap: () => setState(() => otherValue = true),
                      ),
                      SpeedDialChild(
                        // child: const Icon(Icons.accessibility) ,
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        label: 'Handling Charges',
                        labelBackgroundColor: ThemeColors.imageContainerBG,
                        labelStyle: TextStyle(color: ThemeColors.buttonColor),
                        onTap: () => setState(() => handlingValue = true),
                      ),
                      SpeedDialChild(
                        // child: const Icon(Icons.accessibility) ,
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        label: 'Service/Call Charges',
                        labelBackgroundColor: ThemeColors.imageContainerBG,
                        labelStyle: TextStyle(color: ThemeColors.buttonColor),
                        onTap: () => setState(() => serviceValue = true),
                      ),



                    ],

                  )
                ],
              ),
            )
          ],
        ),

      ],
    );
  }
}
