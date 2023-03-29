import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:service_engineer/Screen/Transportation/QuotationTransportation/quotation_reply_transportation.dart';
import 'package:service_engineer/Utils/application.dart';
import 'package:service_engineer/Widget/app_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../Config/font.dart';
import '../../../../Constant/theme_colors.dart';
import '../../../../Widget/common.dart';
import '../../../../Widget/function_button.dart';
import '../../../Bloc/quotationReply/quotationReply_bloc.dart';
import '../../../Bloc/quotationReply/quotationReply_event.dart';
import '../../../Bloc/quotationReply/quotationReply_state.dart';
import '../../../Model/Transpotation/quotationReplyModel.dart';
import '../../../Model/Transpotation/serviceRequestDetailModel.dart';
import '../../../Model/quotation_reply_detail_repo.dart';
import '../../../Widget/app_small_button.dart';
import '../../../Widget/custom_snackbar.dart';
import '../../bottom_navbar.dart';
import 'ReviceQuotation/quotatio_for_transportation.dart';



class QuotationForTransportation extends StatefulWidget {
  QuotationReplyTransportModel quotationReplyList;
  QuotationForTransportation({Key? key,required this.quotationReplyList}) : super(key: key);

  @override
  State<QuotationForTransportation> createState() => QuotationForTransportationState();
}

class QuotationForTransportationState extends State<QuotationForTransportation> {

  final TextEditingController _itemNameController = TextEditingController();
  final TextEditingController _itemPriceController = TextEditingController();
  bool loading = true;

  final GlobalKey<ExpansionTileCardState> cardVehicleDetailsTransposation = new GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardOtherItemRequiredTransposation = new GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardQuotationsTransposation = new GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardTermsConditions = new GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardMessage = new GlobalKey();


  bool value = false;
  QuotationReplyBloc? _quotationReplyBloc;
  List<VehicleDetails>? vehicleList;
  List<QuotationCharges>? quotationDetailList;
  List<QuotationCharges>? quotationChargesList;
  List<CustomerReplyMsg>? quotationMsgList;
  double quotationChargesTotal = 0.0;
  double itemOthersTotal = 0.0;
  double grandTotal = 0.0;
  bool isLoading = false;
  bool isRejectLoading = true;
  bool isRevisedLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    //saveDeviceTokenAndId();
    super.initState();
    _quotationReplyBloc = BlocProvider.of<QuotationReplyBloc>(context);
    // _quotationReplyBloc!.add(TransportQuotationReplyDetail(transportEnquiryId: widget.quotationReplyList.enquiryId.toString(),
    //     customerUserId: widget.quotationReplyList.userId.toString()));
    _quotationReplyBloc!.add(TransportQuotationReplyDetail(transportEnquiryId: '2',
        customerUserId: '5'));

  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: InkWell(
            onTap: (){
              Navigator.of(context).pop();
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => BottomNavigation (index:0,dropValue:"Transportation")));
            },
            child: Icon(Icons.arrow_back_ios)),
        title: Text(widget.quotationReplyList.enquiryId == null ?'#${0}':'#${widget.quotationReplyList.enquiryId}',style:appBarheadingStyle ,),
      ),
      bottomNavigationBar:Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: AppButton(
                onPressed: () async {

                  if(value==true) {
                    _quotationReplyBloc!.add(QuotationReject(machineEnquiryId: widget.quotationReplyList.enquiryId!.toInt(),
                        serviceUserId: Application.customerLogin!.id!.toInt(),status: 1,transportEnquiryId: 0,JobWorkEnquiryId: 0));
                  }
                  else{
                    showCustomSnackBar(context,'Please agree the terms and condition.');

                  }
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
                  if(value==true) {
                    _quotationReplyBloc!.add(QuotationRevised(machineEnquiryId: widget.quotationReplyList.enquiryId!.toInt(),
                        serviceUserId: Application.customerLogin!.id!.toInt(),status: 0,transportEnquiryId: 0,JobWorkEnquiryId: 0));
                  }
                  else{
                    showCustomSnackBar(context,'Please agree the terms and condition.');

                  }},
                shape: const RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.all(Radius.circular(50))),
                text: 'Revise Quotation',
                loading: loading,
                color: ThemeColors.defaultbuttonColor,
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<QuotationReplyBloc, QuotationReplyState>(builder: (context, state) {
          return BlocListener<QuotationReplyBloc, QuotationReplyState>(
            listener: (context, state) {
              if(state is TransportQuotationReplyDetailLoading){
                isLoading = state.isLoading;
              }
              if(state is TransportQuotationReplyDetailSuccess){
                vehicleList = state.vehicleDetailsList;
                quotationDetailList = state.quotationDetailsList;
                quotationChargesList = state.quotationChargesList;
                quotationMsgList = state.quotationMsgList;
              }
              if(state is TransportQuotationReplyDetailFail){
                showCustomSnackBar(context,state.msg.toString());

              }
              if(state is QuotationRejectLoading){
                isRejectLoading = state.isLoading;
              }
              if(state is QuotationRejectSuccess){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>QuotationsReplyTransportationScreen()));
                showCustomSnackBar(context,state.msg.toString(),isError: false);
              }
              if(state is QuotationRejectFail){
                showCustomSnackBar(context,state.msg.toString());
              }
              if(state is QuotationRevisedLoading){
                isRevisedLoading = state.isLoading;
              }
              if(state is QuotationRevisedSuccess){
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ReviceQuotationTransposationScreen( serviceRequestData:widget.quotationReplyList!,quotationChargesList:quotationChargesList,
                    quotationDetailList:quotationDetailList,quotationMsgList:quotationMsgList,vehicleList:vehicleList,)));
              }
              if(state is QuotationRevisedFail){
                showCustomSnackBar(context,state.msg.toString());
              }
            },
            child: isLoading ? vehicleList!.length <= 0 ? Center(child: CircularProgressIndicator(),):
            ListView(
              children: [
                SizedBox(height: 7,),
                // Item Required
                vehicleList!.length <= 0 ? Container():
                ExpansionTileCard(
                  key: cardVehicleDetailsTransposation,
                  initiallyExpanded: true,
                  title: Text("Vehicle Details",
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Poppins',
                          fontSize: 16,
                          fontWeight: FontWeight.w500
                      )),
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0,right: 10.0,bottom: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,

                        children: [
                          DataTable(
                            headingRowHeight: 40,
                            headingRowColor: MaterialStateColor.resolveWith(
                                    (states) => Color(0xffE47273)),
                            columnSpacing: 15.0,
                            columns:const [
                              DataColumn(
                                label: Expanded(child: Text('S no')),
                              ),
                              DataColumn(
                                label: Text('Vehicle Name'),
                              ),
                            ],
                            rows: List.generate(vehicleList!.length, (index) {
                              int itemNo = index+1;
                              quotationChargesTotal = double.parse(quotationDetailList![0].handlingCharge.toString()) +
                                  double.parse(quotationDetailList![0].serviceCharge.toString());

                              grandTotal = quotationChargesTotal + double.parse(quotationChargesList![0].commission.toString()) +
                                  double.parse(quotationChargesList![0].gst.toString());

                              return _getVehicleDataRow(vehicleList![index],itemNo);
                            }),),
                        ],
                      ),

                    ),
                  ],
                ),

                // Others Items
                quotationDetailList!.length <= 0 ? Container():
                ExpansionTileCard(
                  key: cardOtherItemRequiredTransposation,
                  initiallyExpanded: true,
                  title: Text("Quotation",
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Poppins',
                          fontSize: 16,
                          fontWeight: FontWeight.w500
                      )),
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0,right: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,

                        children: [
                          DataTable(
                            headingRowHeight: 40,
                            headingRowColor: MaterialStateColor.resolveWith(
                                    (states) => Color(0xffE47273)),
                            columnSpacing: 15.0,
                            columns:const [
                              DataColumn(
                                label: Expanded(child: Text('S no')),
                              ),
                              DataColumn(
                                label: Text('Service Name'),
                              ),
                              DataColumn(
                                label: Text('Amount'),
                              ),
                            ],
                            rows: [
                              DataRow(
                                color: MaterialStateColor.resolveWith((states) {
                                  return Color(0xffFFE4E5); //make tha magic!
                                }),cells: <DataCell>[
                                DataCell(Text(1.toString())),
                                DataCell(Text('Service/Call Charges')),
                                DataCell(Text(quotationDetailList![0].serviceCharge.toString())),
                              ],),
                              DataRow(
                                color: MaterialStateColor.resolveWith((states) {
                                  return Color(0xffFFE4E5); //make tha magic!
                                }),cells: <DataCell>[
                                DataCell(Text(2.toString())),
                                DataCell(Text('Handling Charges')),
                                DataCell(Text(quotationDetailList![0].handlingCharge.toString())),
                              ],)
                            ],),
                        ],
                      ),

                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0,right: 10.0,bottom: 10),
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Color(0xffFFE4E5),
                          border: Border(
                            top: BorderSide(
                              color: Colors.black,
                              width: 1.0,
                            ),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 8.0, right: 40.0, bottom: 8.0),
                              child: Row(
                                children: [
                                  Text(
                                    "Total",
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Text(
                                    "₹ $quotationChargesTotal",
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                Divider(
                  thickness: 2,
                ),

                /// GST
                Padding(
                  padding: const EdgeInsets.only(right: 16.0,left: 16.0,bottom: 8.0,top: 8.0),
                  child: Container(
                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("GST Number",
                              style: TextStyle(fontFamily: 'Poppins',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500)),
                          Container(
                            width: MediaQuery.of(context).size.width*0.4,
                            child: Text(vehicleList![0].gstNo=="" ? "" : vehicleList![0].gstNo!.toString(),
                                maxLines: 2,overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontFamily: 'Poppins',
                                    fontSize: 15,
                                    color: Colors.black,
                                  fontWeight: FontWeight.w500
                                )),
                          ),
                        ],
                      )
                  ),
                ),
                Divider(
                  thickness: 2,
                ),
                Divider(
                  thickness: 2,
                ),

                ///Quotation
                ExpansionTileCard(
                  key: cardQuotationsTransposation,
                  initiallyExpanded: true,
                  // finalPadding: const EdgeInsets.only(bottom: 0.0),
                  title: Text("Quotation",
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Poppins',
                          fontSize: 16,
                          fontWeight: FontWeight.w500
                      )),
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(right: 10.0,left: 10.0, bottom: 8.0),
                      child: Column(
                        children: [
                          Divider(thickness: 1,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Quotation Charges"),
                              Text("₹ ${quotationChargesTotal}"),
                            ],
                          ),

                          SizedBox(height: 10,),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Professional Charges"),
                              Text("₹ ${quotationChargesList![0].commission}"),
                            ],
                          ),
                          SizedBox(height: 10,),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("GST "),
                              Text("₹ ${quotationChargesList![0].gst}"),
                            ],
                          ),
                          Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Amount",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'Poppins',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500
                                  )),
                              Text("₹ $grandTotal",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'Poppins',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500
                                  )),
                            ],
                          ),
                        ],
                      ),
                    )


                  ],
                ),

                ///Message from Client
                quotationMsgList!.length <= 0 ? Container():
                ExpansionTileCard(
                  key: cardMessage,
                  initiallyExpanded: true,
                  title:  Text("Message from Client",
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Poppins',
                          fontSize: 16,
                          fontWeight: FontWeight.w500
                      )),
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(right: 16.0,left: 16.0,bottom: 16.0),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(quotationMsgList![0].message.toString(),textAlign: TextAlign.start,)),
                    ),
                  ],
                ),

                ///Terms and Conditions
                ExpansionTileCard(
                  key: cardTermsConditions,
                  initiallyExpanded: true,
                  title:  Text("Terms and Conditions",
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Poppins',
                          fontSize: 16,
                          fontWeight: FontWeight.w500
                      )),
                  children: <Widget>[
                    Row(
                      children: [
                        Checkbox(
                          value: this.value,
                          activeColor: Colors.red,
                          onChanged: (value) {
                            setState(() {
                              this.value = value!;
                            });
                          },
                        ),
                        const Text("I agree to the terms and conditions.",
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Poppins',
                                fontSize: 14,
                                fontWeight: FontWeight.w400))
                      ],
                    )

                  ],
                ),
              ],
            ) : Center(child: CircularProgressIndicator(),),

            // Center(
            //   child: CircularProgressIndicator(),
            // )

          );
        })
        // ListView(
        //   children: [
        //     SizedBox(height: 7,),
        //     /// Vehicle Details
        //     ExpansionTileCard(
        //       key: cardVehicleDetailsTransposation,
        //       initiallyExpanded: true,
        //       title:  Text("Vehicle Details",
        //       style: TextStyle(
        //           color: Colors.black,
        //           fontFamily: 'Poppins',
        //           fontSize: 16,
        //           fontWeight: FontWeight.w500
        //       ),),
        //       children: <Widget>[
        //         Padding(
        //           padding: const EdgeInsets.only(left: 8.0,right: 8.0,bottom: 8.0),
        //           child: Column(
        //             children: [
        //               Container(
        //                 color: Color(0xffEBEBEB),
        //                 child: Padding(
        //                   padding: const EdgeInsets.all(8.0),
        //                   child: Row(
        //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                     children: [
        //                       Column(
        //                         crossAxisAlignment: CrossAxisAlignment.start,
        //                         children: [
        //                           Text("S no.",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
        //                         ],
        //                       ),
        //                       Column(
        //                         crossAxisAlignment: CrossAxisAlignment.start,
        //                         children: [
        //                           Text("Item Name",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
        //                         ],
        //                       ),
        //                     ],
        //                   ),
        //                 ),
        //               ),
        //               buildVehicleDetailsList(),
        //             ],
        //           ),
        //         ),
        //
        //       ],
        //     ),
        //     /// Quotation
        //     ExpansionTileCard(
        //       key: cardQuotationsTransposation,
        //       initiallyExpanded: true,
        //       title:  Text("Quotations",
        //         style: TextStyle(
        //             color: Colors.black,
        //             fontFamily: 'Poppins',
        //             fontSize: 16,
        //             fontWeight: FontWeight.w500
        //         ),),
        //       children: <Widget>[
        //         Padding(
        //           padding: const EdgeInsets.only(left: 8.0,right: 8.0,bottom: 8.0),
        //           child: Column(
        //             children: [
        //               Container(
        //                 color: Color(0xffEBEBEB),
        //                 child: Padding(
        //                   padding: const EdgeInsets.all(8.0),
        //                   child: Row(
        //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                     children: [
        //                       Column(
        //                         crossAxisAlignment: CrossAxisAlignment.start,
        //                         children: [
        //                           Text("S no.",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
        //                         ],
        //                       ),
        //                       Column(
        //                         crossAxisAlignment: CrossAxisAlignment.start,
        //                         children: [
        //                           Text("Service Name",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
        //                         ],
        //                       ),
        //                       Column(
        //                         crossAxisAlignment: CrossAxisAlignment.start,
        //                         children: [
        //                           Text("Amount",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
        //                         ],
        //                       ),
        //                     ],
        //                   ),
        //                 ),
        //               ),
        //               buildQuotationList(),
        //               Container(
        //                 color: Color(0xffF5F5F5),
        //                 child: Row(
        //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                   children: [
        //                     SizedBox(),
        //                     Padding(
        //                       padding: const EdgeInsets.only(top:8.0,right: 8.0,bottom: 8.0),
        //                       child: Row(
        //                         children: [
        //                           Text("Total",style: TextStyle(fontWeight: FontWeight.bold),),
        //                           SizedBox(width: 15,),
        //                           Text("₹ 1500",style: TextStyle(fontWeight: FontWeight.bold),)
        //                         ],
        //                       ),
        //                     ),
        //                   ],
        //                 ),
        //               ),
        //             ],
        //           ),
        //         ),
        //       ],
        //     ),
        //
        //     Divider(thickness: 2,),
        //     ///Amount
        //     Padding(
        //       padding: const EdgeInsets.only(right: 16.0,left: 16.0,bottom: 16.0,top: 16.0),
        //       child: Column(
        //         children: [
        //           Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //             children: [
        //               Text("Amount",
        //                   style: TextStyle(fontFamily: 'Poppins',
        //                       fontSize: 16,
        //                       fontWeight: FontWeight.w600)),
        //               Text("₹20000",
        //                   style: TextStyle(fontFamily: 'Poppins',
        //                       fontSize: 16,
        //                       fontWeight: FontWeight.w600)),
        //             ],
        //           ),
        //           SizedBox(height: 5,),
        //           Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //             children: [
        //               Text("Labour Charge",
        //                   style: TextStyle(fontFamily: 'Poppins',
        //                       fontSize: 15,
        //                       fontWeight: FontWeight.normal)),
        //               Text("₹ 1500",
        //                   style: TextStyle(fontFamily: 'Poppins',
        //                       fontSize: 15,
        //                       fontWeight: FontWeight.normal)),
        //             ],
        //           ),
        //           SizedBox(height: 5,),
        //
        //           Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //             children: [
        //               Text("Gst amount",
        //                   style: TextStyle(fontFamily: 'Poppins',
        //                       fontSize: 15,
        //                       fontWeight: FontWeight.normal)),
        //               Text("₹50.00",
        //                   style: TextStyle(fontFamily: 'Poppins',
        //                       fontSize: 15,
        //                       fontWeight: FontWeight.normal)),
        //             ],
        //           ),
        //           Divider(thickness: 1,),
        //           Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //             children: [
        //               Text("Total",
        //                   style: TextStyle(fontFamily: 'Poppins',
        //                       fontSize: 16,
        //                       fontWeight: FontWeight.w600)),
        //               Text("₹20050.00",
        //                   style: TextStyle(fontFamily: 'Poppins',
        //                       fontSize: 16,
        //                       fontWeight: FontWeight.w600)),
        //
        //             ],
        //           ),
        //           Row(
        //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //             children: [
        //           SizedBox(),
        //               Text("(Twenty thousand and Fifty Rupees)",style: TextStyle(fontWeight: FontWeight.normal),),
        //             ],
        //           ),
        //         ],
        //       ),
        //     ),
        //     Divider(thickness: 1,),
        //     ExpansionTileCard(
        //       key: cardMessage,
        //       initiallyExpanded: true,
        //       title:  Text("Message from Client",
        //         style: TextStyle(
        //             color: Colors.black,
        //             fontFamily: 'Poppins',
        //             fontSize: 16,
        //             fontWeight: FontWeight.w500
        //         ),),
        //       children: <Widget>[
        //         Padding(
        //           padding: const EdgeInsets.only(right: 16.0,left: 16.0,bottom: 16.0),
        //           child: Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry."
        //               " Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, "
        //               "when an unknown printer"),
        //         ),
        //       ],
        //     ),
        //   ],
        // ),
      ),
    );
  }

  DataRow _getVehicleDataRow(VehicleDetails? requiredItemData,index) {
    return DataRow(
      color: MaterialStateColor.resolveWith((states) {
        return Color(0xffFFE4E5); //make tha magic!
      }),
      cells: <DataCell>[
        DataCell(Text(index.toString())),
        DataCell(Text(requiredItemData!.vehicleName.toString())),
      ],
    );
  }

}
