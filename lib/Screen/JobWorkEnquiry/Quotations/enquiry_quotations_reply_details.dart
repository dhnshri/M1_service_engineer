import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:service_engineer/Model/quotation_reply_detail_repo.dart';
import 'package:service_engineer/Screen/JobWorkEnquiry/Quotations/ReviceQuotations/enquiry_revice_quotations.dart';
import 'package:service_engineer/Widget/custom_snackbar.dart';
import '../../../Bloc/quotationReply/quotationReply_bloc.dart';
import '../../../Bloc/quotationReply/quotationReply_event.dart';
import '../../../Bloc/quotationReply/quotationReply_state.dart';
import '../../../Config/font.dart';
import '../../../Model/JobWorkEnquiry/quotation_reply.dart';
import '../../../Widget/app_small_button.dart';


class EnquiryQuotationsReplyDetailsScreen extends StatefulWidget {
  EnquiryQuotationsReplyDetailsScreen({Key? key,required this.quotationReplyJobWorkEnquiryList}) : super(key: key);
  QuotationReplyJobWorkEnquiryModel quotationReplyJobWorkEnquiryList;

  @override
  _EnquiryQuotationsReplyDetailsScreenState createState() => _EnquiryQuotationsReplyDetailsScreenState();
}

class _EnquiryQuotationsReplyDetailsScreenState extends State<EnquiryQuotationsReplyDetailsScreen> {
  final TextEditingController _phoneNumberController = TextEditingController();
  bool loading = true;

  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ExpansionTileCardState> cardItemRequired = new GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardOtherItemRequired = new GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardQuotations = new GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardTermsConditions = new GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardMessage = new GlobalKey();

  QuotationReplyBloc? _jobworkQuotationBloc;
  List<QuotationRequiredItems>? quotationRequiredItemList;
  List<QuotationCharges>? quotationChargesList;
  List<CustomerReplyMsg>? quotationMsgList;
  bool isLoading = false;
  bool value = false;
  double itemRequiredTotal = 0.0;
  double grandTotal = 0.0;


  @override
  void initState() {
    // TODO: implement initState
    //saveDeviceTokenAndId();
    super.initState();
    _phoneNumberController.clear();
    _jobworkQuotationBloc = BlocProvider.of<QuotationReplyBloc>(context);
    _jobworkQuotationBloc!.add(JobWorkQuotationReplyDetail(jobWorkEnquiryId: widget.quotationReplyJobWorkEnquiryList.enquiryId.toString(),
        customerUserId: widget.quotationReplyJobWorkEnquiryList.userId.toString()));
    // _jobworkQuotationBloc!.add(JobWorkQuotationReplyDetail(jobWorkEnquiryId: '13',
    //     customerUserId: '100'));
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
              Navigator.of(context).pop();
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => BottomNavigation (index:0,dropValue:"Machine Maintenance")));
            },
            child: Icon(Icons.arrow_back_ios)),
        title: Text('#${widget.quotationReplyJobWorkEnquiryList.enquiryId}',style:appBarheadingStyle ,),
      ),
      bottomNavigationBar:Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppSmallButton(
              onPressed: () async {
              },
              shape: const RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.all(Radius.circular(50))),
              text: 'Reject',
              loading: loading,


            ),
            Flexible(
              child: AppSmallButton(
                onPressed: () async {
                  if(value == true) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  EnquiryReviseQuotationScreen(
                                    quotationRequiredItemList:
                                        quotationRequiredItemList,
                                    quotationChargesList: quotationChargesList,
                                    quotationReplyJobWorkEnquiryList: widget.quotationReplyJobWorkEnquiryList,
                                  )));
                    }else{
                    showCustomSnackBar(context,'Please Agree the terms and conditions.'.toString());
                  }
                  },
                shape: const RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.all(Radius.circular(50))),
                text: 'Revise Quotation',
                loading: loading,


              ),
            ),
          ],
        ),
      ),
      body: BlocBuilder<QuotationReplyBloc, QuotationReplyState>(builder: (context, state) {
        return BlocListener<QuotationReplyBloc, QuotationReplyState>(
          listener: (context, state) {
            if(state is JobWorkQuotationReplyDetailLoading){
              isLoading = state.isLoading;
            }
            if(state is JobWorkQuotationReplyDetailSuccess){
              quotationRequiredItemList = state.quotationRequiredItemList;
              quotationChargesList = state.quotationChargesList;
              quotationMsgList = state.quotationMsgList;

            }
            if(state is JobWorkQuotationReplyDetailFail){
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

                            grandTotal = itemRequiredTotal + double.parse(quotationRequiredItemList![0].packingCharge.toString()) +
                                double.parse(quotationRequiredItemList![0].testingCharge.toString()) + double.parse(quotationRequiredItemList![0].transportCharge.toString()) +
                                double.parse(quotationChargesList![0].commission.toString()) + double.parse(quotationChargesList![0].sgst.toString()) +
                                double.parse(quotationChargesList![0].igst.toString()) + double.parse(quotationChargesList![0].cgst.toString());

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
                            Text("Total Items charges"),
                            Text("₹ ${itemRequiredTotal}"),
                          ],
                        ),
                        SizedBox(height: 5,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Packing charge"),
                            Text("₹ ${quotationRequiredItemList![0].packingCharge.toString()}"),
                          ],
                        ),
                        SizedBox(height: 5,),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Testing charge"),
                            Text("₹ ${quotationRequiredItemList![0].testingCharge.toString()}"),
                          ],
                        ),
                        SizedBox(height: 5,),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Transport charges"),
                            Text("₹ ${quotationRequiredItemList![0].transportCharge.toString()}"),
                          ],
                        ),

                        SizedBox(height: 5,),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("M1 Commission"),
                            Text("₹ ${quotationChargesList![0].commission}"),
                          ],
                        ),
                        SizedBox(height: 5,),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("CGST"),
                            Text("${quotationChargesList![0].cgst}"),
                          ],
                        ),
                        SizedBox(height: 5,),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("SGST"),
                            Text("${quotationChargesList![0].sgst}"),
                          ],
                        ),
                        SizedBox(height: 5,),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("IGST"),
                            Text("${quotationChargesList![0].igst}"),
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
      // Column(
      //   children: [
      //     SizedBox(height: 7,),
      //
      //     ///Quotation
      //     ExpansionTileCard(
      //       initiallyExpanded: true,
      //       key: cardQuotations,
      //       leading: Text("Quotation",
      //           style: TextStyle(
      //               color: Colors.black,
      //               fontFamily: 'Poppins-Medium',
      //               fontSize: 16,
      //               fontWeight: FontWeight.w500
      //           )),
      //       title: SizedBox(),
      //       subtitle:SizedBox(),
      //       children: <Widget>[
      //         Padding(
      //           padding: const EdgeInsets.only(right: 8.0,left: 8.0, bottom: 8.0),
      //           child: Column(
      //             children: [
      //               Row(
      //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                 children: [
      //                   Text("Item Rate/Piece"),
      //                   Text("₹ 20"),
      //                 ],
      //               ),
      //               SizedBox(height: 5,),
      //               Row(
      //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                 children: [
      //                   Text("Required Quantity"),
      //                   Text("₹ 15000 pieces"),
      //                 ],
      //               ),
      //               SizedBox(height: 5,),
      //
      //               Row(
      //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                 children: [
      //                   Text("Transport charges"),
      //                   Text("₹ 1500"),
      //                 ],
      //               ),
      //               SizedBox(height: 5,),
      //
      //               Row(
      //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                 children: [
      //                   Text("M1 Commission"),
      //                   Text("₹ 550"),
      //                 ],
      //               ),
      //               SizedBox(height: 5,),
      //
      //               Row(
      //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                 children: [
      //                   Text("CGST %"),
      //                   Text("9%"),
      //                 ],
      //               ),
      //               SizedBox(height: 5,),
      //
      //               Row(
      //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                 children: [
      //                   Text("SGST %"),
      //                   Text("5%"),
      //                 ],
      //               ),
      //               SizedBox(height: 5,),
      //
      //               Row(
      //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                 children: [
      //                   Text("IGST %"),
      //                   Text("28%"),
      //                 ],
      //               ),
      //               Divider(
      //                 thickness: 1.5,
      //               ),
      //               Row(
      //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                 children: [
      //                   Text("Total",
      //                       style: TextStyle(
      //                           color: Colors.black,
      //                           fontFamily: 'Poppins-Medium',
      //                           fontSize: 16,
      //                           fontWeight: FontWeight.w500
      //                       )),
      //                   Text("₹20000",
      //                       style: TextStyle(
      //                           color: Colors.black,
      //                           fontFamily: 'Poppins-Medium',
      //                           fontSize: 16,
      //                           fontWeight: FontWeight.w500
      //                       )),
      //                 ],
      //               ),
      //             ],
      //           ),
      //         )
      //
      //
      //       ],
      //     ),
      //     ExpansionTileCard(
      //       initiallyExpanded: true,
      //       key: cardTermsConditions,
      //       leading: Text("Terms and Conditions",
      //           style: TextStyle(
      //               color: Colors.black,
      //               fontFamily: 'Poppins-Medium',
      //               fontSize: 16,
      //               fontWeight: FontWeight.w500
      //           )),
      //       title: SizedBox(),
      //       subtitle:SizedBox(),
      //       children: <Widget>[
      //
      //       ],
      //     ),
      //     ExpansionTileCard(
      //       initiallyExpanded: true,
      //       key: cardMessage,
      //       leading: Text("Message from Client",
      //           style: TextStyle(
      //               color: Colors.black,
      //               fontFamily: 'Poppins-Medium',
      //               fontSize: 16,
      //               fontWeight: FontWeight.w500
      //           )),
      //       title: SizedBox(),
      //       subtitle:SizedBox(),
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

}
