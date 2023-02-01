import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:service_engineer/Screen/MachineMaintenance/MakeQuotations/preview.dart';
import 'package:service_engineer/Screen/MachineMaintenance/MakeQuotations/service_charges.dart';
import 'package:service_engineer/app.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

import '../../../Config/font.dart';
import '../../../Constant/theme_colors.dart';
import '../../../Widget/app_button.dart';
import '../../../Widget/common.dart';
import '../../../Widget/function_button.dart';
import '../../../Widget/stepper_button.dart';
import '../../bottom_navbar.dart';
import '../ServiceRequest/serviceRequestDetails.dart';
import 'item_required.dart';
import 'item_required_filter.dart';




class MakeQuotationScreen extends StatefulWidget {
  const MakeQuotationScreen({Key? key}) : super(key: key);

  @override
  _MakeQuotationScreenState createState() => _MakeQuotationScreenState();
}

class _MakeQuotationScreenState extends State<MakeQuotationScreen> {


  int _currentStep = 0;
  bool loading = true;
  final _formKey = GlobalKey<FormState>();
  bool isCompleted = false;

 // int _activeCurrentStep = 0;

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController pincode = TextEditingController();

  List<Step> stepList() => [

    Step(

      state: _currentStep <= 0 ? StepState.editing : StepState.complete,
      // state: _currentStep <= 0 ? Icon(Icons.circle): StepState.complete,
      isActive: _currentStep >= 0,
      title: Text('Service Charges',style:  StepperHeadingStyle,),
      content: ServiceChargesScreen(),
    ),
    Step(
      state: _currentStep <= 1 ? StepState.editing : StepState.complete,
      isActive: _currentStep >= 1,
      title: Text('Item Required',style:  StepperHeadingStyle,),
      content: ItemRequired(),
    ),
    Step(
      state: StepState.complete,
      isActive: _currentStep >= 2,
      title: Text('Preview',style: StepperHeadingStyle,),
      content: PreviewScreen(),
    ),
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
        body:isCompleted
        ? AlertDialog(
          title: new Text(""),
          content: new Text("Are you sure, you want to send this quotation ?"),
          actions: <Widget>[
            Row(
              children: [
                TextButton(
                  child: new Text("No"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                SizedBox(width: 7,),
                TextButton(
                  child: new Text("Yes"),
                  onPressed: () {
                    // AlertDialog(
                    //   title: new Text(""),
                    //   content: new Text("Quotation sent Successfully"),
                    //   actions: <Widget>[
                    //     Row(
                    //       children: [
                    //         TextButton(
                    //           child: new Text("Done"),
                    //           onPressed: () {
                    //             Navigator.push(context,
                    //                 MaterialPageRoute(builder: (context) => BottomNavigation(index: 0)));
                    //           },
                    //         ),
                    //       ],
                    //     ),
                    //   ],
                    // );
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => BottomNavigation(index: 0,dropValue:"Machine Maintenance",)));
                  },
                ),
              ],
            ),
          ],
        )
        :Stepper(
          type: StepperType.horizontal,
          currentStep: _currentStep,
          steps: stepList(),
          controlsBuilder: (BuildContext context, ControlsDetails controls) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[

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
                  StepperButton(

                    onPressed: () async {
                      final isLastStep = _currentStep == stepList().length - 1;
                      if(isLastStep)
                      {
                        setState(() {
                          isCompleted = true;
                        });
                      }
                      else
                      {
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
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
// // Service Charges Class
// class _ServiceCharges extends StatefulWidget {
//   const _ServiceCharges({Key? key}) : super(key: key);
//
//   @override
//   State<_ServiceCharges> createState() => _ServiceChargesState();
// }
//
// class _ServiceChargesState extends State<_ServiceCharges> {
//   final TextEditingController _workingTimeController = TextEditingController();
//   final TextEditingController _dateofJoiningController = TextEditingController();
//   final TextEditingController _serviceCallChargesController = TextEditingController();
//   final TextEditingController _handlingChargesController = TextEditingController();
//   final TextEditingController _otherChargesController = TextEditingController();
//   final TextEditingController _transportChargesController = TextEditingController();
//   final TextEditingController _serviceTitleController = TextEditingController();
//
//   String dropdownValue = '+ 91';
//   String? phoneNum;
//   String? role;
//   bool loading = true;
//
//   // String? smsCode;
//   // bool smsCodeSent = false;
//   // String? verificationId;
//   final _formKey = GlobalKey<FormState>();
//
//   Future AddOtherCharges() {
//     return showModalBottomSheet(
//         isScrollControlled: true,
//
//         // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//         shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(35.0),
//                 topRight: Radius.circular(35.0))),
//         context: context,
//         builder: (BuildContext context) {
//           return otherChargesInfo();
//
//         });
//   }
//
//   Widget otherChargesInfo()
//   {
//     return Container(
//       height: 250,
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text("Add services",style: showBottomModelHeading,),
//             SizedBox(
//               width:
//               MediaQuery.of(context).size.width * 0.8,
//               height: 60,
//               child: TextFormField(
//                 controller: _serviceTitleController,
//                 keyboardType: TextInputType.number,
//                 // maxLength: 10,
//                 cursorColor: primaryAppColor,
//                 decoration: InputDecoration(
//                   disabledBorder: OutlineInputBorder(
//                     borderRadius:
//                     BorderRadius.circular(8.0),
//                     borderSide: const BorderSide(
//                       color: Colors.white,
//                       width: 1.0,
//                     ),
//                   ),
//                   errorBorder: OutlineInputBorder(
//                     borderRadius:
//                     BorderRadius.circular(8.0),
//                     borderSide: const BorderSide(
//                       color: Colors.red,
//                       width: 1.0,
//                     ),
//                   ),
//                   fillColor: Color(0xffF5F5F5),
//                   filled: true,
//                   focusedBorder: OutlineInputBorder(
//                     borderRadius:
//                     BorderRadius.circular(10.0),
//                     borderSide: const BorderSide(
//                         color: Colors.white, width: 1.0),
//                   ),
//                   focusedErrorBorder: OutlineInputBorder(
//                       borderRadius:
//                       BorderRadius.circular(8.0),
//                       borderSide: const BorderSide(
//                         color: Colors.white,
//                         width: 1.0,
//                       )),
//                   enabledBorder: OutlineInputBorder(
//                     borderRadius:
//                     BorderRadius.circular(8.0),
//                     borderSide: const BorderSide(
//                       color: Colors.white,
//                       width: 1.0,
//                     ),
//                   ),
//                   hintText: 'Service Title',
//                   contentPadding: const EdgeInsets.fromLTRB(
//                       20.0, 20.0, 0.0, 0.0),
//                   hintStyle: GoogleFonts.poppins(
//                       color: Colors.grey,
//                       fontSize: 12.0,
//                       fontWeight: FontWeight.w500),
//                 ),
//                 onChanged: (val) {
//                   setState(() {
//                     phoneNum = val;
//                     // _phoneNumberController.text = val;
//                   });
//                 },
//               ),
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 StepperButton(
//                   onPressed: () async {
//                     Navigator.of(context).push(
//                                   MaterialPageRoute(builder: (context) => MakeQuotationScreen()));
//                   },
//                   shape: const RoundedRectangleBorder(
//                       borderRadius:
//                       BorderRadius.all(Radius.circular(50))),
//                   text: 'Cancel',
//                   loading: loading,
//                 ),
//                 SizedBox(width: 15,),
//                 StepperButton(
//                   onPressed: () async {
//                     Navigator.of(context).push(
//                         MaterialPageRoute(builder: (context) => MakeQuotationScreen()));
//                   },
//                   shape: const RoundedRectangleBorder(
//                       borderRadius:
//                       BorderRadius.all(Radius.circular(50))),
//                   text: 'Done',
//                   loading: loading,
//                 ),
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         SizedBox(
//           width:
//           MediaQuery.of(context).size.width * 0.8,
//           height: 60,
//           child: TextFormField(
//             controller: _workingTimeController,
//             keyboardType: TextInputType.number,
//            // maxLength: 10,
//             cursorColor: primaryAppColor,
//             decoration: InputDecoration(
//               disabledBorder: OutlineInputBorder(
//                 borderRadius:
//                 BorderRadius.circular(8.0),
//                 borderSide: const BorderSide(
//                   color: Colors.white,
//                   width: 1.0,
//                 ),
//               ),
//               errorBorder: OutlineInputBorder(
//                 borderRadius:
//                 BorderRadius.circular(8.0),
//                 borderSide: const BorderSide(
//                   color: Colors.red,
//                   width: 1.0,
//                 ),
//               ),
//               fillColor: Color(0xffF5F5F5),
//               filled: true,
//               focusedBorder: OutlineInputBorder(
//                 borderRadius:
//                 BorderRadius.circular(10.0),
//                 borderSide: const BorderSide(
//                     color: Colors.white, width: 1.0),
//               ),
//               focusedErrorBorder: OutlineInputBorder(
//                   borderRadius:
//                   BorderRadius.circular(8.0),
//                   borderSide: const BorderSide(
//                     color: Colors.white,
//                     width: 1.0,
//                   )),
//               enabledBorder: OutlineInputBorder(
//                 borderRadius:
//                 BorderRadius.circular(8.0),
//                 borderSide: const BorderSide(
//                   color: Colors.white,
//                   width: 1.0,
//                 ),
//               ),
//               hintText: 'Working Time',
//               contentPadding: const EdgeInsets.fromLTRB(
//                   20.0, 20.0, 0.0, 0.0),
//               hintStyle: GoogleFonts.poppins(
//                   color: Colors.grey,
//                   fontSize: 12.0,
//                   fontWeight: FontWeight.w500),
//             ),
//             onChanged: (val) {
//               setState(() {
//                 phoneNum = val;
//                 // _phoneNumberController.text = val;
//               });
//             },
//           ),
//         ),
//         SizedBox(
//           width:
//           MediaQuery.of(context).size.width * 0.8,
//           height: 60,
//           child: TextFormField(
//             controller: _dateofJoiningController,
//             keyboardType: TextInputType.number,
//             // maxLength: 10,
//             cursorColor: primaryAppColor,
//             decoration: InputDecoration(
//               disabledBorder: OutlineInputBorder(
//                 borderRadius:
//                 BorderRadius.circular(8.0),
//                 borderSide: const BorderSide(
//                   color: Colors.white,
//                   width: 1.0,
//                 ),
//               ),
//               errorBorder: OutlineInputBorder(
//                 borderRadius:
//                 BorderRadius.circular(8.0),
//                 borderSide: const BorderSide(
//                   color: Colors.red,
//                   width: 1.0,
//                 ),
//               ),
//               suffixIcon: Padding(
//                 padding: EdgeInsets.all(0.0),
//                 child: Icon(
//                   Icons.calendar_today_rounded,
//                   color: Colors.grey,
//                 ), // icon is 48px widget.
//               ),
//               fillColor: Color(0xffF5F5F5),
//               filled: true,
//               focusedBorder: OutlineInputBorder(
//                 borderRadius:
//                 BorderRadius.circular(10.0),
//                 borderSide: const BorderSide(
//                     color: Colors.white, width: 1.0),
//               ),
//               focusedErrorBorder: OutlineInputBorder(
//                   borderRadius:
//                   BorderRadius.circular(8.0),
//                   borderSide: const BorderSide(
//                     color: Colors.white,
//                     width: 1.0,
//                   )),
//               enabledBorder: OutlineInputBorder(
//                 borderRadius:
//                 BorderRadius.circular(8.0),
//                 borderSide: const BorderSide(
//                   color: Colors.white,
//                   width: 1.0,
//                 ),
//               ),
//               hintText: 'Date of joining',
//               contentPadding: const EdgeInsets.fromLTRB(
//                   20.0, 20.0, 0.0, 0.0),
//               hintStyle: GoogleFonts.poppins(
//                   color: Colors.grey,
//                   fontSize: 12.0,
//                   fontWeight: FontWeight.w500),
//             ),
//             onChanged: (val) {
//               setState(() {
//                 phoneNum = val;
//                 // _phoneNumberController.text = val;
//               });
//             },
//           ),
//         ),
//         SizedBox(
//           width:
//           MediaQuery.of(context).size.width * 0.8,
//           height: 60,
//           child: TextFormField(
//             controller: _serviceCallChargesController,
//             keyboardType: TextInputType.number,
//             // maxLength: 10,
//             cursorColor: primaryAppColor,
//             decoration: InputDecoration(
//               disabledBorder: OutlineInputBorder(
//                 borderRadius:
//                 BorderRadius.circular(8.0),
//                 borderSide: const BorderSide(
//                   color: Colors.white,
//                   width: 1.0,
//                 ),
//               ),
//               errorBorder: OutlineInputBorder(
//                 borderRadius:
//                 BorderRadius.circular(8.0),
//                 borderSide: const BorderSide(
//                   color: Colors.red,
//                   width: 1.0,
//                 ),
//               ),
//               fillColor: Color(0xffF5F5F5),
//               filled: true,
//               focusedBorder: OutlineInputBorder(
//                 borderRadius:
//                 BorderRadius.circular(10.0),
//                 borderSide: const BorderSide(
//                     color: Colors.white, width: 1.0),
//               ),
//               focusedErrorBorder: OutlineInputBorder(
//                   borderRadius:
//                   BorderRadius.circular(8.0),
//                   borderSide: const BorderSide(
//                     color: Colors.white,
//                     width: 1.0,
//                   )),
//               enabledBorder: OutlineInputBorder(
//                 borderRadius:
//                 BorderRadius.circular(8.0),
//                 borderSide: const BorderSide(
//                   color: Colors.white,
//                   width: 1.0,
//                 ),
//               ),
//               hintText: 'Service/Call Charges',
//               contentPadding: const EdgeInsets.fromLTRB(
//                   20.0, 20.0, 0.0, 0.0),
//               hintStyle: GoogleFonts.poppins(
//                   color: Colors.grey,
//                   fontSize: 12.0,
//                   fontWeight: FontWeight.w500),
//             ),
//             onChanged: (val) {
//               setState(() {
//                 phoneNum = val;
//                 // _phoneNumberController.text = val;
//               });
//             },
//           ),
//         ),
//         SizedBox(
//           width:
//           MediaQuery.of(context).size.width * 0.8,
//           height: 60,
//           child: TextFormField(
//             controller: _handlingChargesController,
//             keyboardType: TextInputType.number,
//             // maxLength: 10,
//             cursorColor: primaryAppColor,
//             decoration: InputDecoration(
//               disabledBorder: OutlineInputBorder(
//                 borderRadius:
//                 BorderRadius.circular(8.0),
//                 borderSide: const BorderSide(
//                   color: Colors.white,
//                   width: 1.0,
//                 ),
//               ),
//               errorBorder: OutlineInputBorder(
//                 borderRadius:
//                 BorderRadius.circular(8.0),
//                 borderSide: const BorderSide(
//                   color: Colors.red,
//                   width: 1.0,
//                 ),
//               ),
//               fillColor: Color(0xffF5F5F5),
//               filled: true,
//               focusedBorder: OutlineInputBorder(
//                 borderRadius:
//                 BorderRadius.circular(10.0),
//                 borderSide: const BorderSide(
//                     color: Colors.white, width: 1.0),
//               ),
//               focusedErrorBorder: OutlineInputBorder(
//                   borderRadius:
//                   BorderRadius.circular(8.0),
//                   borderSide: const BorderSide(
//                     color: Colors.white,
//                     width: 1.0,
//                   )),
//               enabledBorder: OutlineInputBorder(
//                 borderRadius:
//                 BorderRadius.circular(8.0),
//                 borderSide: const BorderSide(
//                   color: Colors.white,
//                   width: 1.0,
//                 ),
//               ),
//               hintText: 'Handling Charges',
//               contentPadding: const EdgeInsets.fromLTRB(
//                   20.0, 20.0, 0.0, 0.0),
//               hintStyle: GoogleFonts.poppins(
//                   color: Colors.grey,
//                   fontSize: 12.0,
//                   fontWeight: FontWeight.w500),
//             ),
//             onChanged: (val) {
//               setState(() {
//                 phoneNum = val;
//                 // _phoneNumberController.text = val;
//               });
//             },
//           ),
//         ),
//         SizedBox(
//           width:
//           MediaQuery.of(context).size.width * 0.8,
//           height: 60,
//           child: TextFormField(
//             controller: _otherChargesController,
//             keyboardType: TextInputType.number,
//             // maxLength: 10,
//             cursorColor: primaryAppColor,
//             decoration: InputDecoration(
//               disabledBorder: OutlineInputBorder(
//                 borderRadius:
//                 BorderRadius.circular(8.0),
//                 borderSide: const BorderSide(
//                   color: Colors.white,
//                   width: 1.0,
//                 ),
//               ),
//               errorBorder: OutlineInputBorder(
//                 borderRadius:
//                 BorderRadius.circular(8.0),
//                 borderSide: const BorderSide(
//                   color: Colors.red,
//                   width: 1.0,
//                 ),
//               ),
//               fillColor: Color(0xffF5F5F5),
//               filled: true,
//               focusedBorder: OutlineInputBorder(
//                 borderRadius:
//                 BorderRadius.circular(10.0),
//                 borderSide: const BorderSide(
//                     color: Colors.white, width: 1.0),
//               ),
//               focusedErrorBorder: OutlineInputBorder(
//                   borderRadius:
//                   BorderRadius.circular(8.0),
//                   borderSide: const BorderSide(
//                     color: Colors.white,
//                     width: 1.0,
//                   )),
//               enabledBorder: OutlineInputBorder(
//                 borderRadius:
//                 BorderRadius.circular(8.0),
//                 borderSide: const BorderSide(
//                   color: Colors.white,
//                   width: 1.0,
//                 ),
//               ),
//               hintText: 'Other Charges',
//               contentPadding: const EdgeInsets.fromLTRB(
//                   20.0, 20.0, 0.0, 0.0),
//               hintStyle: GoogleFonts.poppins(
//                   color: Colors.grey,
//                   fontSize: 12.0,
//                   fontWeight: FontWeight.w500),
//             ),
//             onChanged: (val) {
//               setState(() {
//                 phoneNum = val;
//                 // _phoneNumberController.text = val;
//               });
//             },
//           ),
//         ),
//         SizedBox(
//           width:
//           MediaQuery.of(context).size.width * 0.8,
//           height: 60,
//           child: TextFormField(
//             controller: _transportChargesController,
//             keyboardType: TextInputType.number,
//             // maxLength: 10,
//             cursorColor: primaryAppColor,
//             decoration: InputDecoration(
//               disabledBorder: OutlineInputBorder(
//                 borderRadius:
//                 BorderRadius.circular(8.0),
//                 borderSide: const BorderSide(
//                   color: Colors.white,
//                   width: 1.0,
//                 ),
//               ),
//               errorBorder: OutlineInputBorder(
//                 borderRadius:
//                 BorderRadius.circular(8.0),
//                 borderSide: const BorderSide(
//                   color: Colors.red,
//                   width: 1.0,
//                 ),
//               ),
//               fillColor: Color(0xffF5F5F5),
//               filled: true,
//               focusedBorder: OutlineInputBorder(
//                 borderRadius:
//                 BorderRadius.circular(10.0),
//                 borderSide: const BorderSide(
//                     color: Colors.white, width: 1.0),
//               ),
//               focusedErrorBorder: OutlineInputBorder(
//                   borderRadius:
//                   BorderRadius.circular(8.0),
//                   borderSide: const BorderSide(
//                     color: Colors.white,
//                     width: 1.0,
//                   )),
//               enabledBorder: OutlineInputBorder(
//                 borderRadius:
//                 BorderRadius.circular(8.0),
//                 borderSide: const BorderSide(
//                   color: Colors.white,
//                   width: 1.0,
//                 ),
//               ),
//               hintText: 'Transport Charges',
//               contentPadding: const EdgeInsets.fromLTRB(
//                   20.0, 20.0, 0.0, 0.0),
//               hintStyle: GoogleFonts.poppins(
//                   color: Colors.grey,
//                   fontSize: 12.0,
//                   fontWeight: FontWeight.w500),
//             ),
//             onChanged: (val) {
//               setState(() {
//                 phoneNum = val;
//                 // _phoneNumberController.text = val;
//               });
//             },
//           ),
//         ),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             SizedBox(),
//             InkWell(
//               onTap: (){
//                 AddOtherCharges();
//               },
//               child: Row(
//                 children: [
//                   Text("Other Charges"),
//                   SizedBox(width: 2,),
//                   addIcon(),
//                 ],
//               ),
//             )
//           ],
//         ),
//
//       ],
//     );
//   }
// }

// Item Required Class
class _ItemRequired extends StatefulWidget {
  const _ItemRequired({Key? key}) : super(key: key);

  @override
  State<_ItemRequired> createState() => _ItemRequiredState();
}

class _ItemRequiredState extends State<_ItemRequired> {
  final TextEditingController _itemNameController = TextEditingController();
  final TextEditingController _itemPriceController = TextEditingController();

  String dropdownValue = '+ 91';
  String? phoneNum;
  String? role;
  bool loading = true;
  bool isSwitched = false;

  var mainHeight, mainWidth;
  var quantity = 0;
  var totalValue = 0;
  int prodValue = 15000;



  final _formKey = GlobalKey<FormState>();

  Widget builditemRequredCardList() {
    // if (productList.length <= 0) {
    //   return ListView.builder(
    //     scrollDirection: Axis.vertical,
    //     // padding: EdgeInsets.only(left: 5, right: 20, top: 10, bottom: 15),
    //     itemBuilder: (context, index) {
    //       return Shimmer.fromColors(
    //         baseColor: Theme.of(context).hoverColor,
    //         highlightColor: Theme.of(context).highlightColor,
    //         enabled: true,
    //         child: Padding(
    //           padding: const EdgeInsets.all(8.0),
    //           child: Container(
    //             width: MediaQuery.of(context).size.width,
    //             child: ListTile(
    //               contentPadding: EdgeInsets.zero,
    //               //visualDensity: VisualDensity(horizontal: 0, vertical: -4),
    //               // leading: nameIcon(),
    //               leading: CachedNetworkImage(
    //                 filterQuality: FilterQuality.medium,
    //                 // imageUrl: Api.PHOTO_URL + widget.users.avatar,
    //                 imageUrl: "https://picsum.photos/250?image=9",
    //                 // imageUrl: model.cart[index].productImg == null
    //                 //     ? "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1050&q=80"
    //                 //     : model.cart[index].productImg,
    //                 placeholder: (context, url) {
    //                   return Shimmer.fromColors(
    //                     baseColor: Theme.of(context).hoverColor,
    //                     highlightColor: Theme.of(context).highlightColor,
    //                     enabled: true,
    //                     child: Container(
    //                       height: 80,
    //                       width: 80,
    //                       decoration: BoxDecoration(
    //                         color: Colors.white,
    //                         borderRadius: BorderRadius.circular(8),
    //                       ),
    //                     ),
    //                   );
    //                 },
    //                 imageBuilder: (context, imageProvider) {
    //                   return Container(
    //                     height: 80,
    //                     width: 80,
    //                     decoration: BoxDecoration(
    //                       image: DecorationImage(
    //                         image: imageProvider,
    //                         fit: BoxFit.cover,
    //                       ),
    //                       borderRadius: BorderRadius.circular(8),
    //                     ),
    //                   );
    //                 },
    //                 errorWidget: (context, url, error) {
    //                   return Shimmer.fromColors(
    //                     baseColor: Theme.of(context).hoverColor,
    //                     highlightColor: Theme.of(context).highlightColor,
    //                     enabled: true,
    //                     child: Container(
    //                       height: 80,
    //                       width: 80,
    //                       decoration: BoxDecoration(
    //                         color: Colors.white,
    //                         borderRadius: BorderRadius.circular(8),
    //                       ),
    //                       child: Icon(Icons.error),
    //                     ),
    //                   );
    //                 },
    //               ),
    //               title: Column(
    //                 children: [
    //                   Align(
    //                     alignment: Alignment.centerLeft,
    //                     child: Text(
    //                       "Loading...",
    //                       overflow: TextOverflow.clip,
    //                       style: TextStyle(
    //                         fontWeight: FontWeight.bold,
    //                         fontSize: 15.0,
    //                         //color: Theme.of(context).accentColor
    //                       ),
    //                     ),
    //                   ),
    //                   Column(
    //                     crossAxisAlignment: CrossAxisAlignment.start,
    //                     mainAxisAlignment: MainAxisAlignment.spaceAround,
    //                     children: [
    //                       Row(
    //                         children: [
    //                           Text(
    //                             ".......",
    //                             style: TextStyle(
    //                               fontWeight: FontWeight.normal,
    //                               color: Colors.black87,
    //                               fontSize: 14.0,
    //                             ),
    //                           ),
    //                           SizedBox(
    //                             width: 20,
    //                           )
    //                         ],
    //                       ),
    //                     ],
    //                   ),
    //                 ],
    //               ),
    //             ),
    //             decoration: BoxDecoration(
    //                 borderRadius: BorderRadius.all(Radius.circular(20)),
    //                 color: Colors.white),
    //           ),
    //         ),
    //       );
    //     },
    //     itemCount: List.generate(8, (index) => index).length,
    //   );
    // }

    // return ListView.builder(
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      padding: EdgeInsets.only(top: 10, bottom: 15),
      itemBuilder: (context, index) {
        return  itemRequredCard();
      },
      itemCount: 3,
    );
  }

  Widget itemRequredCard()
  {
    mainHeight = MediaQuery.of(context).size.height;
    mainWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(bottom:8.0),
      child: Card(
        elevation: 1,
        child: ListTile(
          leading: CachedNetworkImage(
            filterQuality: FilterQuality.medium,
            // imageUrl: Api.PHOTO_URL + widget.users.avatar,
            // imageUrl: "https://picsum.photos/250?image=9",
            imageUrl: "https://picsum.photos/250?image=9",
            placeholder: (context, url) {
              return Shimmer.fromColors(
                baseColor: Theme.of(context).hoverColor,
                highlightColor: Theme.of(context).highlightColor,
                enabled: true,
                child: Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              );
            },
            imageBuilder: (context, imageProvider) {
              return Container(
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
              );
            },
            errorWidget: (context, url, error) {
              return Shimmer.fromColors(
                baseColor: Theme.of(context).hoverColor,
                highlightColor: Theme.of(context).highlightColor,
                enabled: true,
                child: Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(Icons.error),
                ),
              );
            },
          ),
          title: Column(
            children: [
              Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Item Name",style:itemRequiredCardHeading,),
                      Text("ID: 123456",style: itemRequiredCardSubtitle),
                      Text("₹2000",style:itemRequiredCardSubtitle),
                    ],

                  ),

                  Expanded(
                    child: Container(
                      width: mainWidth / 3,
                      //width: 80,
                      child: Row(
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.remove_circle,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                if (quantity > 1) {
                                  quantity--;
                                  totalValue = prodValue * quantity;
                                }
                              });
                            },
                          ),
                          Text(
                            quantity.toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 18),
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                if (quantity < 10) {
                                  quantity++;
                                  totalValue = prodValue * quantity;
                                }
                                // var qty = cert.cart[index].qty! + 1;
                                // cert.updateProduct(
                                //     cert.cart[index].id,
                                //     cert.cart[index].price.toString(),
                                //     qty);
                              });
                            },
                            icon: Icon(
                              Icons.add_circle,
                              color: ThemeColors.baseThemeColor,
                            ),
                          ),
                        ],
                      ),

                    ),
                  )
            ],
          ),
          Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. "
              "when an unknown printer...Read More.",style: itemRequiredCardSubtitle),
  ]
      ),
    )));
  }

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(Icons.search),
                SizedBox(width: 5,),
                Text("Search all Orders")
              ],
            ),

            InkWell(
              onTap: ()
              {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ItemRequiredFilterScreen()));
              },
              child: Row(
                children: [
                  Icon(Icons.filter_list),
                  SizedBox(width: 5,),
                  Text("Filter")
                ],
              ),
            )

          ],
        ),
        Container(
          height: 275,
          child:SingleChildScrollView(
            child: InkWell(
                onTap: (){
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (context) => ServiceRequestDetailsScreen()));
                },
                child:  builditemRequredCardList()),
          ),
        ),
        SizedBox(height: 10,),
        Align(
          alignment: Alignment.topLeft,
            child: Text("Items not available on app",style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.bold,
                fontFamily: 'Poppins-Medium'
            ),)),
        SizedBox(height: 5,),
        Card(
          elevation: 1,
          child: Padding(
            padding: const EdgeInsets.only(right: 8.0,left: 8.0,top: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("01:"),
                SizedBox(height: 5,),
                SizedBox(
                  width:
                  MediaQuery.of(context).size.width * 0.8,
                  height: 40,
                  child: TextFormField(
                    controller: _itemNameController,
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
                      hintText: 'Item name',
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
                SizedBox(height: 5,),
                SizedBox(
                  width:
                  MediaQuery.of(context).size.width * 0.8,
                  height: 40,
                  child: TextFormField(
                    controller: _itemPriceController,
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
                      hintText: 'Item price',
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
                SizedBox(height: 5,),
              ],
            ),
          ),
        ),
        SizedBox(height: 7,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(),
            InkWell(
              onTap: (){

              },
              child: Row(
                children: [
                  Text("Add More"),
                  SizedBox(width: 5,),
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

class _Preview extends StatelessWidget {
  const _Preview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PreviewScreen();
  }
}