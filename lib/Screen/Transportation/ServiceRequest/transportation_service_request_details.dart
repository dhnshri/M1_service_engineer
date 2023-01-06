import 'package:cached_network_image/cached_network_image.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

import '../../../Config/font.dart';
import '../../../Widget/app_small_button.dart';
import '../../bottom_navbar.dart';
import 'MakeQuotationTransportation/make_quotation_transposation.dart';




class TransportationServiceRequestDetailsScreen extends StatefulWidget {
  const TransportationServiceRequestDetailsScreen({Key? key}) : super(key: key);

  @override
  _TransportationServiceRequestDetailsScreenState createState() => _TransportationServiceRequestDetailsScreenState();
}

class _TransportationServiceRequestDetailsScreenState extends State<TransportationServiceRequestDetailsScreen> {
  final TextEditingController _phoneNumberController = TextEditingController();
  String dropdownValue = '+ 91';
  String? phoneNum;
  String? role;
  bool loading = true;

  // String? smsCode;
  // bool smsCodeSent = false;
  // String? verificationId;
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ExpansionTileCardState> cardA = new GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardB = new GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardC = new GlobalKey();


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
        title: Text('#102GRDSA36987',style:appBarheadingStyle ,),
      ),
      bottomNavigationBar:Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            AppSmallButton(
              onPressed: () async {
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
              text: 'Ignore',
              loading: loading,


            ),
            SizedBox(width:8),
            AppSmallButton(
              onPressed: () async {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MakeQuotationTransposationScreen()));
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
              text: 'Make Quotation',
              loading: loading,


            ),
          ],
        ),
      ),
      body: ListView(
        children: [
          SizedBox(height: 7,),
          //Basic Info
          ExpansionTileCard(
            key: cardA,
            leading: Text("Basic Info",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
            initiallyExpanded: true,
            title: SizedBox(),
            subtitle:SizedBox(),
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right:16.0,left: 16.0,bottom: 8.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Enquiry ID:",style: ExpanstionTileLeftDataStyle,),
                        Text("#102GRDSA36987",style: ExpanstionTileRightDataStyle,),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Enquiry Date:",style: ExpanstionTileLeftDataStyle,),
                        Text("24-Sep-2022",style: ExpanstionTileRightDataStyle,),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Timing:",style: ExpanstionTileLeftDataStyle,),
                        Text("10AM",style: ExpanstionTileRightDataStyle,),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Approx Distance :",style: ExpanstionTileLeftDataStyle,),
                        Text("10 KM",style: ExpanstionTileRightDataStyle,),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          //Load Detail
          ExpansionTileCard(
            key: cardB,
            leading: Text("Load Details",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
            initiallyExpanded: true,
            title: SizedBox(),
            subtitle:SizedBox(),
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right:16.0,left: 16.0,bottom: 8.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Load Type",style: ExpanstionTileLeftDataStyle,),
                        Text("Machine",style: ExpanstionTileRightDataStyle,),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Load Weight",style: ExpanstionTileLeftDataStyle,),
                        Text("10 tonne",style: ExpanstionTileRightDataStyle,),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Load Size",style: ExpanstionTileLeftDataStyle,),
                        Text("12 x 12 x 12",style: ExpanstionTileRightDataStyle,),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Pickup Location",style: ExpanstionTileLeftDataStyle,),
                        Text("Pune Railway Station",style: ExpanstionTileRightDataStyle,),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Drop Location",style: ExpanstionTileLeftDataStyle,),
                        Text("Pune factory",style: ExpanstionTileRightDataStyle,),
                      ],
                    ),
                    SizedBox(height: 10,),
                    Text("Vestibulum blandit viverra convallis. Pellentesque ligula urna, "
                        "fermentum ut semper in, tincidunt nec dui. Morbi mauris lacus, "
                        "consequat eget justo in, semper gravida enim. Donec ultrices varius ligula."
                        " Ut non pretium augue. Etiam non rutrum metus. In varius sit amet lorem tempus sagittis."
                        " Cras sed maximus enim, vel ultricies tortor. Pellentesque consectetur tellus ornare felis",
                          style: ExpanstionTileLeftDataStyle,),
                  ],
                ),
              ),
            ],
          ),

        ],
      ),
    );
  }
}
