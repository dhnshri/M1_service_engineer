import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:service_engineer/Api/commission_api.dart';
import 'package:service_engineer/Bloc/home/home_bloc.dart';
import 'package:service_engineer/Bloc/home/home_event.dart';
import 'package:service_engineer/Bloc/home/home_state.dart';
import 'package:service_engineer/Bloc/quotationReply/quotationReply_bloc.dart';
import 'package:service_engineer/Config/font.dart';
import 'package:service_engineer/Constant/theme_colors.dart';
import 'package:service_engineer/Model/JobWorkEnquiry/quotation_reply.dart';
import 'package:service_engineer/Model/JobWorkEnquiry/service_request_detail_model.dart';
import 'package:service_engineer/Model/quotation_reply_detail_repo.dart';
import 'package:service_engineer/Screen/bottom_navbar.dart';

import '../../../../Bloc/quotationReply/quotationReply_event.dart';
import '../../../../Bloc/quotationReply/quotationReply_state.dart';
import '../../../../Utils/application.dart';
import '../../../../Widget/custom_snackbar.dart';

class EnquiryReviseQuotationPreviewScreen extends StatefulWidget {
  EnquiryReviseQuotationPreviewScreen({Key? key, required this.requestDetailList,required this.itemRateController,
    required this.cgstController, required this.testingChargesController,required this.packingController,
    required this.transportController,required this.igstController, required this.sgstController,
    required this.volumeController,required this.quotationReplyJobWorkEnquiryData}) : super(key: key);
  List<QuotationRequiredItems>? requestDetailList = [];
  List<TextEditingController> itemRateController = [];
  List<TextEditingController> volumeController = [];
  TextEditingController transportController = TextEditingController();
  TextEditingController packingController = TextEditingController();
  TextEditingController testingChargesController = TextEditingController();
  TextEditingController cgstController = TextEditingController();
  TextEditingController sgstController = TextEditingController();
  TextEditingController igstController = TextEditingController();
  QuotationReplyJobWorkEnquiryModel quotationReplyJobWorkEnquiryData;


  @override
  _EnquiryReviseQuotationPreviewScreenState createState() =>
      _EnquiryReviseQuotationPreviewScreenState();
}

class _EnquiryReviseQuotationPreviewScreenState
    extends State<EnquiryReviseQuotationPreviewScreen> {
  final TextEditingController _phoneNumberController = TextEditingController();
  String dropdownValue = '+ 91';
  String? phoneNum;
  String? role;
  bool loading = true;
  bool value = false;
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ExpansionTileCardState> cardItemRequired = new GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardOtherItemRequired =
  new GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardQuotations = new GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardTermsConditions = new GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardMessage = new GlobalKey();
  double? amount = 0;
  double? amountWithGST = 0;
  double? itemRequiredTotalAmount = 0;
  int? commission = 0;
  double? grandTotal = 0.0;
  QuotationReplyBloc? _quotationBloc;


  @override
  void initState() {
    // TODO: implement initState
    //saveDeviceTokenAndId();
    super.initState();
    _phoneNumberController.clear();
    _quotationBloc = BlocProvider.of<QuotationReplyBloc>(this.context);
    getCommissionApi();
  }

  getCommissionApi()async{
    var com = await fetchCommision(Application.customerLogin!.id.toString(),Application.customerLogin!.role.toString()).
    then((value) => value);
    print(com);
    print(com['data']);
    commission = com['data'];
    setState(() {
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // getroleofstudent();
  }

  DataRow _getItemRequiredDataRow(QuotationRequiredItems? cartData,index) {
    return DataRow(
      color: MaterialStateColor.resolveWith((states) {
        return Color(0xffFFE4E5); //make tha magic!
      }),
      cells: <DataCell>[
        DataCell(Text(index.toString())),
        DataCell(Text(cartData!.itemName.toString())),
        DataCell(Text(cartData.itemQty.toString())),
        DataCell(Text('₹${widget.itemRateController[index].text}')),
        DataCell(Text('₹${amount.toString()}')),
      ],
    );
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
          '#${widget.quotationReplyJobWorkEnquiryData.enquiryId}',
          style: appBarheadingStyle,
        ),
      ),
      body: ListView(
        // mainAxisSize: MainAxisSize.min,
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
                    fontFamily: 'Poppins',
                    fontSize: 16,
                    fontWeight: FontWeight.w500)),
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  DataTable(
                    headingRowHeight: 40,
                    headingRowColor: MaterialStateColor.resolveWith(
                            (states) => Color(0xffE47273)),
                    columnSpacing: 15.0,
                    columns: const [
                      DataColumn(
                        label: Text('S no'),
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
                    rows: List.generate(widget.requestDetailList!.length, (index) {
                      String rate = widget.itemRateController[index].text.toString();
                      amount = double.parse(widget.requestDetailList![index].itemQty
                          .toString()) * int.parse(rate);
                      amountWithGST = amount! ;
                      print(amount);

                      itemRequiredTotalAmount = widget.requestDetailList!
                          .map((item) => double.parse(widget.itemRateController[index].text.toString()) * double.parse(item.itemQty.toString()))
                          .reduce((value, current) => value + current);

                      grandTotal = itemRequiredTotalAmount! + double.parse(widget.transportController.text) + double.parse(widget.packingController.text) +
                          double.parse(widget.testingChargesController.text) + double.parse(widget.cgstController.text) + double.parse(widget.sgstController.text) +
                          double.parse(widget.igstController.text) + commission!;
                      return _getItemRequiredDataRow(widget.requestDetailList![index],index);
                    }),
                  ),
                ],
              ),

              Container(
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
                          top: 8.0, right: 30.0, bottom: 8.0),
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
                            "₹ ${itemRequiredTotalAmount}",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                const EdgeInsets.only(right: 8.0, left: 8.0, bottom: 8.0,top: 15),
                child: Column(
                  children: [
                    ///Transport Charges
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Transport Charges"),
                        Text("₹${widget.transportController.text}"),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ///Packing Charges
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Packing Charges"),
                        Text("₹${widget.packingController.text}"),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ///Testing Charges
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Testing charges"),
                        Text("₹${widget.testingChargesController.text}"),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Professional Charges"),
                        Text("₹$commission"),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("CGST "),
                        Text("${widget.cgstController.text}"),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("SGST "),
                        Text("${widget.sgstController.text}"),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("IGST "),
                        Text("${widget.igstController.text}"),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Divider(
                      thickness: 1.5,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ///Total Amount
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Total",
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Poppins',
                                fontSize: 16,
                                fontWeight: FontWeight.w500)),
                        Text("₹ $grandTotal",
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Poppins',
                                fontSize: 16,
                                fontWeight: FontWeight.w500)),
                      ],
                    ),
                    SizedBox(
                      height: 10,
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
                    fontFamily: 'Poppins',
                    fontSize: 16,
                    fontWeight: FontWeight.w500)),
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

          ///Message from client
          // ExpansionTileCard(
          //   initiallyExpanded: true,
          //   key: cardMessage,
          //   title: Text("Message from Client",
          //       style: TextStyle(
          //           color: Colors.black,
          //           fontFamily: 'Poppins',
          //           fontSize: 16,
          //           fontWeight: FontWeight.w500)),
          //   children: <Widget>[
          //     Padding(
          //       padding: const EdgeInsets.only(
          //           right: 16.0, left: 16.0, bottom: 16.0),
          //       child: Text(
          //           "Lorem Ipsum is simply dummy text of the printing and typesetting industry."
          //           " Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, "
          //           "when an unknown printer"),
          //     ),
          //   ],
          // ),

          SizedBox(
            height: 40,
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    onPressed: () async {
                      if(value==true) {
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  title: new Text(
                                      "Are you sure, you want to send this quotation?"),

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
                                        BlocBuilder<QuotationReplyBloc, QuotationReplyState>(
                                            builder: (context, state) {
                                          return BlocListener<QuotationReplyBloc,
                                              QuotationReplyState>(
                                            listener: (context, state) {
                                              if (state
                                                  is JobWorkSendRevisedQuotationSuccess) {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            BottomNavigation(
                                                              index: 0,
                                                              dropValue: Application
                                                                  .customerLogin!
                                                                  .role
                                                                  .toString(),
                                                            )));
                                                showCustomSnackBar(
                                                    context, state.message,
                                                    isError: false);
                                              }
                                            },
                                            child: TextButton(
                                              child: new Text(
                                                "Yes",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              onPressed: () {
                                                _quotationBloc!.add(JobWorkSendRevisedQuotation(
                                                  serviceUserId: Application.customerLogin!.id.toString(),
                                                  jobWorkEnquirydate: widget.quotationReplyJobWorkEnquiryData.dateAndTime.toString(),
                                                  jobWorkEnquiryId: widget.quotationReplyJobWorkEnquiryData.enquiryId.toString(),
                                                  transportCharge: widget.transportController.text == "" ? '0': widget.transportController.text,
                                                  packingCharge: widget.packingController.text == "" ? '0':widget.packingController.text,
                                                  testingCharge: widget.testingChargesController.text == "" ? '0':widget.testingChargesController.text,
                                                  cgst: widget.cgstController.text == "" ? '0':widget.cgstController.text,
                                                  sgst: widget.sgstController.text == "" ? '0':widget.sgstController.text,
                                                  igst: widget.igstController.text == "" ? '0':widget.igstController.text,
                                                  commission: commission.toString(),
                                                  itemList: widget.requestDetailList!,
                                                  itemRateController: widget.itemRateController,
                                                  volumeController: widget.volumeController,
                                                    totalAmount:grandTotal.toString()
                                                ));
                                              },
                                              style: TextButton.styleFrom(
                                                fixedSize:
                                                    const Size(120, 30),
                                                backgroundColor: ThemeColors
                                                    .defaultbuttonColor,
                                                shape:
                                                    const RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius
                                                                    .circular(
                                                                        25))),
                                              ),
                                            ),
                                          );
                                        })
                                      ],
                                    ),
                                  ],
                                ));
                      }else{
                        showCustomSnackBar(context,'Please agree the terms and condition.',isError: true);

                      }
                      // Navigator.push(context, MaterialPageRoute(builder: (contex)=>EnquiryReviseQuotationPreviewScreen()));
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
          )
        ],
      ),
    );
  }
}
