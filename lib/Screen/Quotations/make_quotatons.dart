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
import '../Home/ServiceRequest/serviceRequestDetails.dart';
import '../bottom_navbar.dart';
import 'item_required.dart';




class MakeQuotationScreen extends StatefulWidget {
  const MakeQuotationScreen({Key? key}) : super(key: key);

  @override
  _MakeQuotationScreenState createState() => _MakeQuotationScreenState();
}

class _MakeQuotationScreenState extends State<MakeQuotationScreen> {
  int currentStep = 0;
  bool loading = true;
  final _formKey = GlobalKey<FormState>();

  int _activeCurrentStep = 0;

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController pincode = TextEditingController();

  List<Step> stepList() => [
    Step(
      state: _activeCurrentStep <= 0 ? StepState.editing : StepState.complete,
      isActive: _activeCurrentStep >= 0,
      title: const Text('Account'),
      content: ServiceChargesScreen(),
    ),
    Step(
        state:
        _activeCurrentStep <= 1 ? StepState.editing : StepState.complete,
        isActive: _activeCurrentStep >= 1,
        title: const Text('Address'),
        content: ItemRequiredScreen()),
    Step(
        state: StepState.complete,
        isActive: _activeCurrentStep >= 2,
        title: const Text('Confirm'),
        content: PreviewScreen())
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
        bottomNavigationBar:Padding(
          padding: const EdgeInsets.all(10.0),
          child: FunctionButton(
            onPressed: () async {
              if (_activeCurrentStep < (stepList().length - 1)) {
                setState(() {
                  _activeCurrentStep += 1;
                });
              }
              // Navigator.of(context).push(
              //     MaterialPageRoute(builder: (context) => VerifyMobileNumberScreen()));
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
        body:Stepper(
          type: StepperType.horizontal,
          currentStep: _activeCurrentStep,
          steps: stepList(),
          // onStepContinue: () {
          //   if (_activeCurrentStep < (stepList().length - 1)) {
          //     setState(() {
          //       _activeCurrentStep += 1;
          //     });
          //   }
          // },

          onStepCancel: () {
            if (_activeCurrentStep == 0) {
              return;
            }

            setState(() {
              _activeCurrentStep -= 1;
            });
          },
          onStepTapped: (int index) {
            setState(() {
              _activeCurrentStep = index;
            });


          },

        ),
      ),
    );
  }
}
