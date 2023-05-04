import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/foundation.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:service_engineer/Config/font.dart';
import 'package:service_engineer/Screen/JobWorkEnquiry/Home/ServiceRequest/enquiry_makeQuotation.dart';
import 'package:service_engineer/Widget/app_button.dart';
import 'package:service_engineer/Widget/app_small_button.dart';
import 'package:service_engineer/Widget/pdf.dart';
import 'package:service_engineer/Widget/pdfViewer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../Bloc/home/home_bloc.dart';
import '../../../../Bloc/home/home_event.dart';
import '../../../../Bloc/home/home_state.dart';
import '../../../../Constant/theme_colors.dart';
import '../../../../Model/JobWorkEnquiry/service_request_detail_model.dart';
import '../../../../Model/JobWorkEnquiry/service_request_model.dart';
import '../../../../Model/service_request_repo.dart';
import '../../../../Widget/image_view_screen.dart';




class EnquiryServiceRequestDetailsScreen extends StatefulWidget {
  JobWorkEnquiryServiceRequestModel serviceRequestData;
  EnquiryServiceRequestDetailsScreen({Key? key,required this.serviceRequestData}) : super(key: key);

  @override
  _EnquiryServiceRequestDetailsScreenState createState() => _EnquiryServiceRequestDetailsScreenState();
}

class _EnquiryServiceRequestDetailsScreenState extends State<EnquiryServiceRequestDetailsScreen> {
  final TextEditingController _phoneNumberController = TextEditingController();
  String dropdownValue = '+ 91';
  String? phoneNum;
  String? role;
  bool loading = true;
  bool _isLoading = false;

  HomeBloc? _homeBloc;
  List<JobWorkEnquiryDetailsModel>? serviceRequestDetailData = [];

  String? url =
      "http://www.africau.edu/images/default/sample.pdf";
  File? pdfUrl;

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
    _homeBloc = BlocProvider.of<HomeBloc>(this.context);
    _homeBloc!.add(OnServiceRequestJobWorkEnquiryDetail(userID:'100', machineEnquiryId: '0',jobWorkEnquiryId: '13',transportEnquiryId: '0'));

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
        title: Text('${widget.serviceRequestData.enquiryId.toString()}'),
      ),
      bottomNavigationBar:Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: AppButton(
                onPressed: () async {
                  Navigator.of(context).pop();
                },
                shape: const RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.all(Radius.circular(50))),
                text: 'Ignore',
                loading: loading,
                color: ThemeColors.whiteTextColor,
                borderColor: ThemeColors.defaultbuttonColor,textColor: ThemeColors.defaultbuttonColor,
              ),
            ),
            const SizedBox(width:10),
            Flexible(
              child: AppButton(
                onPressed: () async {
                  serviceRequestDetailData!.isEmpty ? null:
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => EnquiryMakeQuotationScreen (requestDetailList: serviceRequestDetailData,)));
                },
                shape: const RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.all(Radius.circular(50))),
                text: 'Make Quotation',
                loading: loading,
                color: ThemeColors.defaultbuttonColor,
              ),
            ),
          ],
        ),
      ),
        body: BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
          return BlocListener<HomeBloc, HomeState>(
              listener: (context, state) {
                if(state is ServiceRequestJobWorkEnquryDetailLoading){
                  _isLoading = state.isLoading;
                }
                if(state is ServiceRequestJobWorkEnquryDetailSuccess){
                  serviceRequestDetailData = state.jobWorkEnquryServiceDetail;
                }
                if(state is ServiceRequestJobWorkEnquryDetailFail){
                  // Fluttertoast.showToast(msg: state.msg.toString());
                }
              },
              child: _isLoading ? serviceRequestDetailData!.length <=0 ? Center(child: CircularProgressIndicator(),):
              ListView(
                children: [
                  SizedBox(height: 7,),
                  //Basic Info
                  ExpansionTileCard(
                    key: cardA,
                    initiallyExpanded: true,
                    title:  Text("Basic Info",
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Poppins',
                            fontSize: 16,
                            fontWeight: FontWeight.w500
                        )),
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(right:16.0,left: 16.0,bottom: 8.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Enquiry ID",style: ExpanstionTileLeftDataStyle,),
                                Text(serviceRequestDetailData![0].jobWorkEnquiryId.toString(),style: ExpanstionTileRightDataStyle,),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Enquiry Date:",style: ExpanstionTileLeftDataStyle,),
                                Text(serviceRequestDetailData![0].createdAt.toString(),style: ExpanstionTileRightDataStyle,),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Enquiry Last Date Closed:",style: ExpanstionTileLeftDataStyle,),
                                Text(serviceRequestDetailData![0].projectComplitionDate.toString(),style: ExpanstionTileRightDataStyle,),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Project Cost(Aprox):",style: ExpanstionTileLeftDataStyle,),
                                Text(serviceRequestDetailData![0].approximateCost.toString(),style: ExpanstionTileRightDataStyle,),
                              ],
                            ),

                          ],
                        ),
                      ),
                    ],
                  ),
                  ///Item Required
                      ExpansionTileCard(
                        initiallyExpanded: true,
                        key: cardB,
                        title: Text("Item Required",
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Poppins',
                                fontSize: 16,
                                fontWeight: FontWeight.w500
                            )),
                        children: <Widget>[
                          ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            itemCount: serviceRequestDetailData!.length,
                            // padding: EdgeInsets.only(top: 10, bottom: 15),
                            itemBuilder: (context, index) {
                              int itemIndex = index +1;
                              return Padding(
                                padding: const EdgeInsets.only(right:16.0,left: 16.0,bottom: 8.0),
                                child: Column(
                                  children: [
                                    Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(itemIndex.toString())),
                                    SizedBox(height: 10,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Item Name:",style: ExpanstionTileLeftDataStyle,),
                                        Text(serviceRequestDetailData![index].itemName.toString(),style: ExpanstionTileRightDataStyle,),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Quantity Required:",style: ExpanstionTileLeftDataStyle,),
                                        Text(serviceRequestDetailData![index].qty.toString(),style: ExpanstionTileRightDataStyle,),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Delivery Location:",style: ExpanstionTileLeftDataStyle,),
                                        Text(serviceRequestDetailData![index].cityName.toString(),style: ExpanstionTileRightDataStyle,),
                                      ],
                                    ),
                                    SizedBox(height: 10,),
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Text("Drawing Attachment:",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: 'Poppins',
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500
                                          )),
                                    ),
                                    SizedBox(height: 5,),
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: ThemeColors.imageContainerBG
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(right:16.0,left: 16.0,bottom: 8.0,top: 8.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width:200,
                                            child: Text(serviceRequestDetailData![0].drawingAttachment.toString(),
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    color: ThemeColors.buttonColor,
                                                    fontFamily: 'Poppins',
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w400
                                                )),
                                          ),
                                          InkWell(
                                            onTap: () async {
                                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>
                                                  ImageViewerScreen(url: serviceRequestDetailData![index].drawingAttachment.toString())));
                                            },
                                            child: Container(
                                              child: Text('View',
                                                  style: TextStyle(
                                                      color: ThemeColors.buttonColor,
                                                      fontFamily: 'Poppins',
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.w500
                                                  )),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                  ],
                                ),
                              );
                            },
                          ),

                        ],
                      ),


                  // Other Info
                ],
              )
                  : Center(
                child: CircularProgressIndicator(),
              )

          );


        })
    );
  }
}
