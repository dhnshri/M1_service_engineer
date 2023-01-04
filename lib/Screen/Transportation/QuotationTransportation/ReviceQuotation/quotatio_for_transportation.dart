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
import 'next_quotation_for_transportation.dart';


class ReviceQuotationTransposationScreen extends StatefulWidget {
  const ReviceQuotationTransposationScreen({Key? key}) : super(key: key);

  @override
  _ReviceQuotationTransposationScreenState createState() => _ReviceQuotationTransposationScreenState();
}

class _ReviceQuotationTransposationScreenState extends State<ReviceQuotationTransposationScreen> {
  final TextEditingController _phoneNumberController = TextEditingController();
  String dropdownValue = '+ 91';
  String? phoneNum;
  String? role;
  bool loading = true;

  // String? smsCode;
  // bool smsCodeSent = false;
  // String? verificationId;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController ServiceCallChargesController = TextEditingController();
  final TextEditingController HandlingChargesController = TextEditingController();

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
            onTap: (){
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => BottomNavigation (index:0,dropValue:"Transportation")));
            },
            child: Icon(Icons.arrow_back_ios)),
        title: Text('Quotation for #102GRDSA36987',style:appBarheadingStyle ,),
      ),
      bottomNavigationBar:Padding(
        padding: const EdgeInsets.all(10.0),
        child: FunctionButton(
          onPressed: () async {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => NextQuotationFor()));
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
      body: ListView(
        children: [
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
                hintText: '₹20,000',
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
                hintText: '₹5,000',
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
          ExpansionTileCard(
            key: cardMessage,
            initiallyExpanded: true,
            leading: Text("Message from Client"),
            title: SizedBox(),
            subtitle:SizedBox(),
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 16.0,left: 16.0,bottom: 16.0),
                child: Container(
                  height: 200,
                  color: Color(0xffF5F5F5),
                ),
              ),
            ],
          ),

        ],
      ),
    );
  }
}
