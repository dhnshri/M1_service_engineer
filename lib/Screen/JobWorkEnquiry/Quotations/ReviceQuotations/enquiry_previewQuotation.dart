import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:service_engineer/Config/font.dart';
import 'package:service_engineer/Constant/theme_colors.dart';
import 'package:service_engineer/Screen/bottom_navbar.dart';

class EnquiryQuotationsPreviewScreen extends StatefulWidget {
  const EnquiryQuotationsPreviewScreen({Key? key}) : super(key: key);

  @override
  _EnquiryQuotationsPreviewScreenState createState() =>
      _EnquiryQuotationsPreviewScreenState();
}

class _EnquiryQuotationsPreviewScreenState
    extends State<EnquiryQuotationsPreviewScreen> {
  final TextEditingController _phoneNumberController = TextEditingController();
  String dropdownValue = '+ 91';
  String? phoneNum;
  String? role;
  bool loading = true;

  // String? smsCode;
  // bool smsCodeSent = false;
  // String? verificationId;
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ExpansionTileCardState> cardItemRequired = new GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardOtherItemRequired =
      new GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardQuotations = new GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardTermsConditions = new GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardMessage = new GlobalKey();

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
            onTap: () {
              Navigator.of(context).pop();
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => BottomNavigation (index:0,dropValue:"Machine Maintenance")));
            },
            child: Icon(Icons.arrow_back_ios)),
        title: Text(
          '#102GRDSA36987',
          style: appBarheadingStyle,
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 7,
          ),

          ///Quotation
          ExpansionTileCard(
            initiallyExpanded: true,
            key: cardQuotations,
            title: Text("Quotation",
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Poppins-Medium',
                    fontSize: 16,
                    fontWeight: FontWeight.w500)),
            children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.only(right: 8.0, left: 8.0, bottom: 8.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Item Rate/Piece"),
                        Text("₹ 20"),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Required Quantity"),
                        Text("₹ 15000 pieces"),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Transport charges"),
                        Text("₹ 1500"),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("M1 Commission"),
                        Text("₹ 550"),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("CGST %"),
                        Text("9%"),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("SGST %"),
                        Text("5%"),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("IGST %"),
                        Text("28%"),
                      ],
                    ),
                    Divider(
                      thickness: 1.5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Total",
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Poppins-Medium',
                                fontSize: 16,
                                fontWeight: FontWeight.w500)),
                        Text("₹20000",
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Poppins-Medium',
                                fontSize: 16,
                                fontWeight: FontWeight.w500)),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),

          ///Terms and Condition
          ExpansionTileCard(
            initiallyExpanded: true,
            key: cardTermsConditions,
            title: Text("Terms and Conditions",
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Poppins-Medium',
                    fontSize: 16,
                    fontWeight: FontWeight.w500)),
            children: <Widget>[],
          ),

          ///Message from client
          ExpansionTileCard(
            initiallyExpanded: true,
            key: cardMessage,
            title: Text("Message from Client",
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Poppins-Medium',
                    fontSize: 16,
                    fontWeight: FontWeight.w500)),
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                    right: 16.0, left: 16.0, bottom: 16.0),
                child: Text(
                    "Lorem Ipsum is simply dummy text of the printing and typesetting industry."
                    " Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, "
                    "when an unknown printer"),
              ),
            ],
          ),

          SizedBox(
            height: 40,
          ),

          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      onPressed: () async {
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  title: new Text("Are you sure, you want to send this quotation?"),



                                  // content: new Text(""),
                                  actions: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        TextButton(
                                            child: new Text(
                                              "No",
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            style: TextButton.styleFrom(
                                              fixedSize: const Size(120, 30),
                                              shape:
                                                  const RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  25))),
                                              side: BorderSide(
                                                  color: ThemeColors
                                                      .defaultbuttonColor,
                                                  width: 1.5),
                                            )),
                                        SizedBox(
                                          width: 7,
                                        ),
                                        TextButton(
                                          child: new Text(
                                            "Yes",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        BottomNavigation(
                                                          index: 0,
                                                          dropValue:
                                                              'Job Work Enquiry',
                                                        )));
                                          },
                                          style: TextButton.styleFrom(
                                              fixedSize: const Size(120, 30),
                                              backgroundColor: ThemeColors
                                                  .defaultbuttonColor,
                                            shape:
                                            const RoundedRectangleBorder(
                                                borderRadius:
                                                BorderRadius.all(
                                                    Radius.circular(
                                                        25))),),

                                        ),
                                      ],
                                    ),
                                  ],
                                ));
                        // Navigator.push(context, MaterialPageRoute(builder: (contex)=>EnquiryQuotationsPreviewScreen()));
                      },
                      style: ElevatedButton.styleFrom(
                        primary: ThemeColors.defaultbuttonColor,
                        shape: StadiumBorder(),
                      ),
                      child: Text(
                        "Next",
                        style: Theme.of(context).textTheme.button!.copyWith(
                            color: Colors.white, fontWeight: FontWeight.w600),
                      ),
                    ),
                  )),
            ),
          )
        ],
      ),
    );
  }
}
