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
import '../MakeQuotations/make_quotatons.dart';



class ServiceRequestDetailsScreen extends StatefulWidget {
  const ServiceRequestDetailsScreen({Key? key}) : super(key: key);

  @override
  _ServiceRequestDetailsScreenState createState() => _ServiceRequestDetailsScreenState();
}

class _ServiceRequestDetailsScreenState extends State<ServiceRequestDetailsScreen> {
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
              Navigator.pop(context);
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => BottomNavigation (index:0)));
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
                
              },
              shape: const RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.all(Radius.circular(50))),
              text: 'Ignore',
              loading: loading,


            ),
            SizedBox(width:8),
            Expanded(
              child: AppSmallButton(
                onPressed: () async {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MakeQuotationScreen ()));
                  
                },
                shape: const RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.all(Radius.circular(50))),
                text: 'Make Quotation',
                loading: loading,


              ),
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
            leading: Text("Basic Info"),

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
                      Text("Company ID",style: ExpanstionTileLeftDataStyle,),
                        Text("#102GRDSA36987",style: ExpanstionTileRightDataStyle,),
                      ],
                    ),
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
                        Text("Location :",style: ExpanstionTileLeftDataStyle,),
                        Text("Pune Railway Station",style: ExpanstionTileRightDataStyle,),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Date & Timing :",style: ExpanstionTileLeftDataStyle,),
                        Text("12 Nov 2022, 10AM - 4PM",style: ExpanstionTileRightDataStyle,),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          // Machin Info
          ExpansionTileCard(
            key: cardB,
            leading: Text("Machine Information"),
            title: SizedBox(),
            subtitle:SizedBox(),
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right:16.0,left: 16.0,bottom: 8.0),
                child: Column(
                  children: [
                    Container(
                      height:180,
                      width: 340,
                      child: CachedNetworkImage(
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
                    ),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Category",style: ExpanstionTileLeftDataStyle,),
                                Text("Heavy",style: ExpanstionTileRightDataStyle,),
                              ],
                            ),
                            SizedBox(height: 7,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Machine Name",style: ExpanstionTileLeftDataStyle,),
                                Text("Grinder 2LA",style: ExpanstionTileRightDataStyle,),
                              ],
                            ),
                            SizedBox(height: 7,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Manufacturer (Brand)",style: ExpanstionTileLeftDataStyle,),
                                Text("John Deer",style: ExpanstionTileRightDataStyle,),
                              ],
                            ),
                            SizedBox(height: 7,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Make",style: ExpanstionTileLeftDataStyle,),
                                Text("Some Value here",style: ExpanstionTileRightDataStyle,),
                              ],
                            ),
                            SizedBox(height: 7,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Machine No.",style: ExpanstionTileLeftDataStyle,),
                                Text("032154CS32",style: ExpanstionTileRightDataStyle,),
                              ],
                            ),
                            SizedBox(height: 7,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Controler",style: ExpanstionTileLeftDataStyle,),
                                Text("Mitsubishi",style: ExpanstionTileRightDataStyle,),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Sub-Category",style: ExpanstionTileLeftDataStyle,),
                                Text("Semi Iron",style: ExpanstionTileRightDataStyle,),
                              ],
                            ),
                            SizedBox(height: 7,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Machine Type",style: ExpanstionTileLeftDataStyle,),
                                Text("Latte",style: ExpanstionTileRightDataStyle,),
                              ],
                            ),
                            SizedBox(height: 7,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("System name",style: ExpanstionTileLeftDataStyle,),
                                Text("MH23GTSF",style: ExpanstionTileRightDataStyle,),
                              ],
                            ),
                            SizedBox(height: 7,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Model no.",style: ExpanstionTileLeftDataStyle,),
                                Text("02GRDSA36",style: ExpanstionTileRightDataStyle,),
                              ],
                            ),
                            SizedBox(height: 7,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Machine Size",style: ExpanstionTileLeftDataStyle,),
                                Text("255m",style: ExpanstionTileRightDataStyle,),
                              ],
                            ),
                            SizedBox(height: 7,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Manufacture Date",style: ExpanstionTileLeftDataStyle,),
                                Text("24-July-2022",style: ExpanstionTileRightDataStyle,),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          // Other Info
          ExpansionTileCard(
            key: cardC,
            leading: Text("Other Info"),
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
                        Text("Priority",style: ExpanstionTileLeftDataStyle,),
                        Text("High",style: ExpanstionTileRightDataStyle,),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Maintenance Type",style: ExpanstionTileLeftDataStyle,),
                        Text("Some Value here",style: ExpanstionTileRightDataStyle,),
                      ],
                    ),
                    SizedBox(height: 10,),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black,width: 1),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Vestibulum blandit viverra convallis. Pellentesque ligula urna,"
                            " fermentum ut semper in, tincidunt nec dui. Morbi mauris lacus, consequat"
                            " eget justo in, semper gravida enim. Donec ultrices varius ligula. "
                            "Ut non pretium augue. Etiam non rutrum metus. In varius sit amet "
                            "lorem tempus sagittis. Cras sed maximus enim, vel ultricies tortor.",
                          style:ExpanstionTileOtherInfoStyle ,),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height:100,
                width: 330,
                child: CachedNetworkImage(
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
              ),
              SizedBox(height: 10,),
              Container(
                height:180,
                width: 340,
                child: CachedNetworkImage(
                  filterQuality: FilterQuality.medium,
                  // imageUrl: Api.PHOTO_URL + widget.users.avatar,
                  // imageUrl: "https://picsum.photos/250?image=9",
                  imageUrl: "https://picsum.photos/250?image=16",
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
              ),
            ],
          ),

        ],
      ),
    );
  }
}
