import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:service_engineer/Screen/Home/ServiceRequest/serviceRequest.dart';
import 'package:service_engineer/Screen/Home/home.dart';
import 'package:service_engineer/Screen/Quotations/preview.dart';
import 'package:service_engineer/Screen/Quotations/service_charges.dart';
import 'package:service_engineer/app.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

import '../../../Config/font.dart';
import '../../../Widget/app_button.dart';
import '../../../Widget/function_button.dart';
import '../../Widget/app_small_button.dart';
import '../../Widget/common.dart';
import '../../Widget/stepper_button.dart';
import '../Home/ServiceRequest/serviceRequestDetails.dart';
import '../bottom_navbar.dart';
import 'item_required.dart';




class MakeQuotationScreen extends StatefulWidget {
  const MakeQuotationScreen({Key? key}) : super(key: key);

  @override
  _MakeQuotationScreenState createState() => _MakeQuotationScreenState();
}

class _MakeQuotationScreenState extends State<MakeQuotationScreen> {


  int _currentStep = 0;
  bool loading = true;
  final _formKey = GlobalKey<FormState>();

 // int _activeCurrentStep = 0;

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController pincode = TextEditingController();

  List<Step> stepList() => [
    // Step(
    //   state: _activeCurrentStep <= 0 ? StepState.editing : StepState.complete,
    //   isActive: _activeCurrentStep >= 0,
    //   title: const Text('Account'),
    //   content: ServiceChargesScreen(),
    // ),
    // Step(
    //     state:
    //     _activeCurrentStep <= 1 ? StepState.editing : StepState.complete,
    //     isActive: _activeCurrentStep >= 1,
    //     title: const Text('Address'),
    //     content: ItemRequiredScreen()),
    // Step(
    //     state: StepState.complete,
    //     isActive: _activeCurrentStep >= 2,
    //     title: const Text('Confirm'),
    //     content: PreviewScreen())

    Step(

      state: _currentStep <= 0 ? StepState.editing : StepState.complete,
     // state: _currentStep <= 0 ? Icon(Icons.circle): StepState.complete,
      isActive: _currentStep >= 0,
      title: Text('Service Charges',style:  StepperHeadingStyle,),
      content: _ServiceCharges(),
    ),
    Step(
      state: _currentStep <= 1 ? StepState.editing : StepState.complete,
      isActive: _currentStep >= 1,
      title: Text('Item Required',style:  StepperHeadingStyle,),
      content: _ItemRequired(),
    ),
    Step(
      state: StepState.complete,
      isActive: _currentStep >= 2,
      title: Text('Preview',style: StepperHeadingStyle,),
      content: _Preview(),
    )
  ];


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
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ServiceRequestDetailsScreen()));
              },
              child: Icon(Icons.arrow_back_ios)),
          title: Text('Quotation for #102GRDSA36987',style:appBarheadingStyle ,),
        ),
        body:Stepper(
          type: StepperType.horizontal,
          currentStep: _currentStep,
          steps: stepList(),
          controlsBuilder: (BuildContext context, ControlsDetails controls) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 18.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  StepperButton(
                    onPressed: () async {
                      if (_currentStep < (stepList().length - 1)) {
                        setState(() {
                          _currentStep += 1;
                        });
                      }
                    },
                    shape: const RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.all(Radius.circular(50))),
                    text: 'Next',
                    loading: loading,
                  ),
                  if (_currentStep != 0)
                    StepperButton(
                      onPressed: () async {
                        if (_currentStep == 0) {
                          return;
                        }

                        setState(() {
                          _currentStep -= 1;
                        });
                      },
                      shape: const RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.all(Radius.circular(50))),
                      text: 'Back',
                      loading: loading,
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
// Service Charges Class
class _ServiceCharges extends StatefulWidget {
  const _ServiceCharges({Key? key}) : super(key: key);

  @override
  State<_ServiceCharges> createState() => _ServiceChargesState();
}

class _ServiceChargesState extends State<_ServiceCharges> {
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
        padding: const EdgeInsets.all(18.0),
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

// Item Required Class
class _ItemRequired extends StatefulWidget {
  const _ItemRequired({Key? key}) : super(key: key);

  @override
  State<_ItemRequired> createState() => _ItemRequiredState();
}

class _ItemRequiredState extends State<_ItemRequired> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Card number',
          ),
        ),
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Expiry date',
          ),
        ),
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'CVV',
          ),
        ),
      ],
    );
  }
}

class _Preview extends StatelessWidget {
  const _Preview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Center(child: Text('Thank you for your order!')),
      ],
    );
  }
}