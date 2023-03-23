import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:service_engineer/Bloc/quotationReply/quotationReply_bloc.dart';
import 'package:service_engineer/Bloc/quotationReply/quotationReply_state.dart';
import 'package:service_engineer/Model/MachineMaintance/quotationReply.dart';
import 'package:service_engineer/Screen/MachineMaintenance/Quotations/ReviceQuotations/revice_quotations.dart';
import 'package:service_engineer/Screen/MachineMaintenance/Quotations/quotations_reply.dart';
import 'package:service_engineer/Utils/application.dart';
import 'package:service_engineer/Widget/custom_snackbar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

import '../../../Bloc/quotationReply/quotationReply_event.dart';
import '../../../Config/font.dart';
import '../../../Model/quotation_reply_detail_repo.dart';
import '../../../Widget/app_small_button.dart';
import '../../bottom_navbar.dart';
import '../MakeQuotations/make_quotatons.dart';


class QuotationsReplyDetailsScreen extends StatefulWidget {
  QuotationsReplyDetailsScreen({Key? key,required this.quotationReplyList}) : super(key: key);
  QuotationReplyModel quotationReplyList;
  @override
  _QuotationsReplyDetailsScreenState createState() => _QuotationsReplyDetailsScreenState();
}

class _QuotationsReplyDetailsScreenState extends State<QuotationsReplyDetailsScreen> {
  final TextEditingController _phoneNumberController = TextEditingController();
  bool loading = true;
  bool isLoading = false;
  bool isRejectLoading = true;
  bool isRevisedLoading = true;
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ExpansionTileCardState> cardItemRequired = new GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardOtherItemRequired = new GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardQuotations = new GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardTermsConditions = new GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardMessage = new GlobalKey();

  bool value = false;
  QuotationReplyBloc? _quotationReplyBloc;
  List<QuotationRequiredItems>? quotationRequiredItemList;
  List<QuotationRequiredItems>? quotationOtherItemList;
  List<QuotationCharges>? quotationChargesList;
  List<CustomerReplyMsg>? quotationMsgList;
  double itemRequiredTotal = 0.0;
  double itemOthersTotal = 0.0;
  double grandTotal = 0.0;



  @override
  void initState() {
    // TODO: implement initState
    //saveDeviceTokenAndId();
    super.initState();
    _phoneNumberController.clear();
    _quotationReplyBloc = BlocProvider.of<QuotationReplyBloc>(context);
    _quotationReplyBloc!.add(MachineQuotationReplyDetail(machineEnquiryId: widget.quotationReplyList.enquiryId.toString(),
        customerUserId: widget.quotationReplyList.userId.toString()));
    // _quotationReplyBloc!.add(MachineQuotationReplyDetail(machineEnquiryId: '44',
    //     customerUserId: '12'));

  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // getroleofstudent();
  }

  TotalAmount(){
    grandTotal = itemRequiredTotal + itemOthersTotal + double.parse(quotationChargesList![0].serviceCharge.toString()) +
        double.parse(quotationChargesList![0].transportCharge.toString()) + double.parse(quotationChargesList![0].commission.toString()) +
        double.parse(quotationChargesList![0].gst.toString());
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: InkWell(
            onTap: (){
              Navigator.of(context).pop();
            },
            child: Icon(Icons.arrow_back_ios)),
        title: Text(
            '#${widget.quotationReplyList.enquiryId.toString()}',style:appBarheadingStyle ,),
      ),
      bottomNavigationBar:Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppSmallButton(
              onPressed: () async {
                _quotationReplyBloc!.add(QuotationReject(machineEnquiryId: widget.quotationReplyList.enquiryId!.toInt(),
                    serviceUserId: Application.customerLogin!.id!.toInt(),status: 1,transportEnquiryId: 0,JobWorkEnquiryId: 0));
              },
              shape: const RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.all(Radius.circular(50))),
              text: 'Reject',
              loading: isRejectLoading,


            ),
            AppSmallButton(
              onPressed: () async {
                if(value==true) {
                  _quotationReplyBloc!.add(QuotationRevised(machineEnquiryId: widget.quotationReplyList.enquiryId!.toInt(),
                      serviceUserId: Application.customerLogin!.id!.toInt(),status: 0,transportEnquiryId: 0,JobWorkEnquiryId: 0));
                  }
                else{
                  showCustomSnackBar(context,'Please agree the terms and condition.');

                }
                },
              shape: const RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.all(Radius.circular(50))),
              text: 'Revise Quotation',
              loading: isRevisedLoading,


            ),
          ],
        ),
      ),
      body: BlocBuilder<QuotationReplyBloc, QuotationReplyState>(builder: (context, state) {
        return BlocListener<QuotationReplyBloc, QuotationReplyState>(
            listener: (context, state) {
              if(state is MachineQuotationReplyDetailLoading){
                isLoading = state.isLoading;
              }
              if(state is MachineQuotationReplyDetailSuccess){
                quotationRequiredItemList = state.quotationRequiredItemList;
                quotationOtherItemList = state.quotationOtherItemList;
                quotationChargesList = state.quotationChargesList;
                quotationMsgList = state.quotationMsgList;

              }
              if(state is MachineQuotationReplyDetailFail){
                showCustomSnackBar(context,state.msg.toString());

              }
              if(state is QuotationRejectLoading){
                isRejectLoading = state.isLoading;
              }
              if(state is QuotationRejectSuccess){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>QuotationsReplyScreen()));
                showCustomSnackBar(context,state.msg.toString(),isError: false);
              }
              if(state is QuotationRejectFail){
                showCustomSnackBar(context,state.msg.toString());
              }
              if(state is QuotationRevisedLoading){
                isRevisedLoading = state.isLoading;
              }
              if(state is QuotationRevisedSuccess){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MachineRevisedQuotationScreen(quotationRequiredItemList: quotationRequiredItemList,quotationOtherItemList: quotationOtherItemList,
                          quotationChargesList: quotationChargesList,quotationReplyList: widget.quotationReplyList,)));
              }
              if(state is QuotationRevisedFail){
                showCustomSnackBar(context,state.msg.toString());
              }
            },
            child: isLoading ? quotationRequiredItemList!.length <= 0 ? Center(child: CircularProgressIndicator(),):
            ListView(
              children: [
                SizedBox(height: 7,),
                // Item Required
                quotationRequiredItemList!.length <= 0 ? Container():
                ExpansionTileCard(
                  key: cardItemRequired,
                  initiallyExpanded: true,
                  title: Text("Item Required",
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Poppins-Medium',
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
                                label: Text('Item Name'),
                              ),
                              DataColumn(
                                label: Text('QTY'),
                              ),
                              DataColumn(
                                label: Text('Rate'),
                              ),
                              DataColumn(
                                label: Text('Amount'),
                              ),
                            ],
                            rows: List.generate(quotationRequiredItemList!.length, (index) {
                              int itemNo = index+1;
                              itemRequiredTotal = quotationRequiredItemList!
                                  .map((item) => double.parse(item.amount.toString()))
                                  .reduce((value, current) => value + current);
                              WidgetsBinding.instance.addPostFrameCallback((_){

                                TotalAmount();
                              });

                              return _getItemRequiredDataRow(quotationRequiredItemList![index],itemNo);
                            }),),
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
                                    "₹ $itemRequiredTotal",
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

                // Others Items
                quotationOtherItemList!.length <= 0 ? Container():
                ExpansionTileCard(
                  key: cardOtherItemRequired,
                  initiallyExpanded: true,
                  title: Text("Other Items( item not available on app)",
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Poppins-Medium',
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
                                label: Text('Item Name'),
                              ),
                              DataColumn(
                                label: Text('QTY'),
                              ),
                              DataColumn(
                                label: Text('Rate'),
                              ),
                              DataColumn(
                                label: Text('Amount'),
                              ),
                            ],
                            rows: List.generate(quotationOtherItemList!.length, (index) {
                              int itemNo = index+1;
                              itemOthersTotal = quotationOtherItemList!
                                  .map((item) => double.parse(item.amount.toString()))
                                  .reduce((value, current) => value + current);
                              return _getOtherItemRequiredDataRow(quotationOtherItemList![index],itemNo);
                            }),),
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
                                    "₹ $itemOthersTotal",
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

                // Date and Time
                Padding(
                  padding: const EdgeInsets.only(right: 16.0,left: 16.0,bottom: 8.0,top: 8.0),
                  child: Container(
                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Date & Time",
                              style: TextStyle(fontFamily: 'Poppins-Medium',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500)),
                          Container(
                            child: Text(DateFormat('MM-dd-yyyy h:mm a').format(DateTime.parse(quotationRequiredItemList![0].dateAndTime!.toString())).toString(),
                                style: TextStyle(fontFamily: 'Poppins-Medium',
                                    fontSize: 15,
                                    color: Colors.black.withOpacity(0.5)
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
                  key: cardQuotations,
                  initiallyExpanded: true,
                  // finalPadding: const EdgeInsets.only(bottom: 0.0),
                  title: Text("Quotation",
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Poppins-Medium',
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
                              Row(
                                children: [
                                  Text("Total Items charges"),
                                  SizedBox(width: 2,),
                                  Text("(Item + Other Items)",style: TextStyle(fontSize: 12),),

                                ],
                              ),
                              Text("₹ ${itemRequiredTotal + itemOthersTotal}"),
                            ],
                          ),
                          SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Service charge"),
                              Text("₹ ${quotationChargesList![0].serviceCharge}"),
                            ],
                          ),
                          SizedBox(height: 10,),


                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Transport charges"),
                              Text("₹ ${quotationChargesList![0].transportCharge}"),
                            ],
                          ),

                          SizedBox(height: 10,),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Handling charges"),
                              Text("₹ ${quotationChargesList![0].handlingCharge}"),
                            ],
                          ),

                          SizedBox(height: 10,),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("M1 Commission"),
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
                                      fontFamily: 'Poppins-Medium',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500
                                  )),
                              Text("₹ $grandTotal",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'Poppins-Medium',
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
                          fontFamily: 'Poppins-Medium',
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
                          fontFamily: 'Poppins-Medium',
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
                                fontFamily: 'Poppins-Medium',
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


    );
  }

  DataRow _getItemRequiredDataRow(QuotationRequiredItems? requiredItemData,index) {
    return DataRow(
      color: MaterialStateColor.resolveWith((states) {
        return Color(0xffFFE4E5); //make tha magic!
      }),
      cells: <DataCell>[
        DataCell(Text(index.toString())),
        DataCell(Text(requiredItemData!.itemName.toString())),
        DataCell(Text(requiredItemData.itemQty.toString())),
        DataCell(Text('₹${requiredItemData.rate.toString()}')),
        DataCell(Text('₹${requiredItemData.amount.toString()}')),
      ],
    );
  }

  DataRow _getOtherItemRequiredDataRow(QuotationRequiredItems? requiredOtherItemData,index) {
    return DataRow(
      color: MaterialStateColor.resolveWith((states) {
        return Color(0xffFFE4E5); //make tha magic!
      }),
      cells: <DataCell>[
        DataCell(Text(index.toString())),
        DataCell(Text(requiredOtherItemData!.itemName.toString())),
        DataCell(Text(requiredOtherItemData.itemQty.toString())),
        DataCell(Text('₹${requiredOtherItemData.rate.toString()}')),
        DataCell(Text('₹${requiredOtherItemData.amount.toString()}')),
      ],
    );
  }
}
