import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:service_engineer/Bloc/authentication/authentication_event.dart';
import 'package:service_engineer/Model/cart_list_repo.dart';
import 'package:service_engineer/app_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

import '../../../Model/item_not_available_model.dart';

class PreviewScreen extends StatefulWidget {
  List<CartListModel>? cartList = [];
  List<ItemNotAvailableModel> itemNotAvailableList = [];
  TextEditingController workingTimeController = TextEditingController();
  TextEditingController dateofJoiningController = TextEditingController();
  TextEditingController serviceCallChargesController = TextEditingController();
  TextEditingController handlingChargesController = TextEditingController();
  TextEditingController otherChargesController = TextEditingController();
  TextEditingController transportChargesController = TextEditingController();
  TextEditingController gstChargesController = TextEditingController();
  int commission;
  PreviewScreen(
      {Key? key,
      required this.cartList,
      required this.itemNotAvailableList,
      required this.workingTimeController,
      required this.dateofJoiningController,
      required this.serviceCallChargesController,
      required this.handlingChargesController,
      required this.transportChargesController,
      required this.otherChargesController,
      required this.gstChargesController,
      required this.commission})
      : super(key: key);

  @override
  _PreviewScreenState createState() => _PreviewScreenState();
}

class _PreviewScreenState extends State<PreviewScreen> {
  bool loading = true;
  bool value = false;

  final GlobalKey<ExpansionTileCardState> cardItemRequired = new GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardOtherItemRequired =
      new GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardQuotations = new GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardTermsConditions = new GlobalKey();

  double? amount = 0;
  double? amountWithGST = 0;
  double? itemRequiredTotalAmount = 0;
  double? oterItemsAmount = 0;
  double? otherItemsAmountWithGST = 0;
  double? otherItemTotalAmount = 0;
  double? commission = 0;
  double? totalAmount = 0;

  @override
  void initState() {
    // TODO: implement initState
    //saveDeviceTokenAndId();
    super.initState();
    // commission = widget.commission.toDouble();
  }

  TotalAmount() {
    if (widget.serviceCallChargesController.text == "") {
      widget.serviceCallChargesController.text = "0";
    }
    if (widget.transportChargesController.text == "") {
      widget.transportChargesController.text = "0";
    }
    if (widget.handlingChargesController.text == "") {
      widget.handlingChargesController.text = "0";
    }

    totalAmount = itemRequiredTotalAmount! +
        otherItemTotalAmount! +
        double.parse(widget.serviceCallChargesController.text) +
        double.parse(widget.transportChargesController.text) +
        double.parse(widget.handlingChargesController.text) +
        double.parse(widget.gstChargesController.text) +
        widget.commission;
    AppBloc.authBloc.add(OnSaveMaintainenceTotalAmount(totalAmount));
    setState(() {});
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // getroleofstudent();
  }

  DataRow _getItemRequiredDataRow(CartListModel? cartData, index) {
    return DataRow(
      color: MaterialStateColor.resolveWith((states) {
        return Color(0xffFFE4E5); //make tha magic!
      }),
      cells: <DataCell>[
        DataCell(Text(index.toString())),
        DataCell(Text(cartData!.productName.toString())),
        DataCell(Text(cartData.qty.toString())),
        DataCell(Text('₹${cartData.discountPrice.toString()}')),
        DataCell(Text('₹${amountWithGST.toString()}')),
      ],
    );
  }

  DataRow _getOtherItemRequiredDataRow(
      ItemNotAvailableModel? itemNotAvailableData, index) {
    return DataRow(
      color: MaterialStateColor.resolveWith((states) {
        return Color(0xffFFE4E5); //make tha magic!
      }),
      cells: <DataCell>[
        DataCell(Text(index.toString())),
        DataCell(Text(itemNotAvailableData!.itemName.toString())),
        DataCell(Text(itemNotAvailableData.quantity.toString())),
        DataCell(Text('₹${itemNotAvailableData.rate.toString()}')),
        DataCell(Text('₹${otherItemsAmountWithGST.toString()}')),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 7,
        ),
        // Item Required
        widget.cartList!.isEmpty
            ? Container()
            : ExpansionTileCard(
                key: cardItemRequired,
                initiallyExpanded: true,
                title: Text("Item Required",
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
                        rows: List.generate(widget.cartList!.length, (index) {
                          int itemIndex = index + 1;
                          amount = int.parse(widget
                                      .cartList![index].discountPrice
                                      .toString()) *
                                  100 /
                                  100 +
                              int.parse(widget.cartList![index].gst.toString());
                          amountWithGST = amount! *
                              int.parse(widget.cartList![index].qty.toString());
                          itemRequiredTotalAmount = widget.cartList!
                              .map((item) =>
                                  double.parse(amountWithGST.toString()))
                              .reduce((value, current) => value + current);
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            if (widget.gstChargesController.text != "") {
                              TotalAmount();
                            }
                          });

                          return _getItemRequiredDataRow(
                              widget.cartList![index], itemIndex);
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
                                width: 5,
                              ),
                              Text(
                                "(+gst)",
                                style: TextStyle(fontWeight: FontWeight.normal),
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
                ],
              ),
        SizedBox(
          height: 5,
        ),
        // Others Items
        widget.itemNotAvailableList.isEmpty
            ? Container()
            : ExpansionTileCard(
                key: cardOtherItemRequired,
                initiallyExpanded: true,
                title: Text("Other Items( item not available on app)",
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
                        rows: List.generate(widget.itemNotAvailableList.length,
                            (index) {
                          int itemIndex = index + 1;
                          oterItemsAmount = double.parse(widget
                                      .itemNotAvailableList[index].rate
                                      .toString()) *
                                  100 /
                                  100 +
                              int.parse(widget.itemNotAvailableList[index].gst
                                  .toString());

                          otherItemsAmountWithGST = oterItemsAmount! *
                              int.parse(widget
                                  .itemNotAvailableList[index].quantity
                                  .toString());

                          otherItemTotalAmount = widget.itemNotAvailableList
                              .map((item) => double.parse(
                                  otherItemsAmountWithGST.toString()))
                              .reduce((value, current) => value + current);
                          if (widget.gstChargesController.text != "") {
                            TotalAmount();
                          }
                          return _getOtherItemRequiredDataRow(
                              widget.itemNotAvailableList[index], itemIndex);
                        }),
                      ),
                    ],
                  ),
                  // buildOtherItemsList(),
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
                              top: 8.0, right: 40.0, bottom: 8.0),
                          child: Row(
                            children: [
                              Text(
                                "Total",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "(+gst)",
                                style: TextStyle(fontWeight: FontWeight.normal),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Text(
                                "₹ $otherItemTotalAmount",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
        // // Date and Time
        // Padding(
        //   padding: const EdgeInsets.only(
        //       right: 16.0, left: 16.0, bottom: 8.0, top: 8.0),
        //   child: Container(
        //       child: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     children: [
        //       Text("Date & Time"),
        //       Text("20 Nov, 2022 / 12PM - 4PM"),
        //     ],
        //   )),
        // ),

        //Quotation Charges
        ExpansionTileCard(
          key: cardQuotations,
          initiallyExpanded: true,
          title: Text("Quotation",
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Poppins',
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
                      Row(
                        children: [
                          Text("Total Items charges"),
                          SizedBox(
                            width: 2,
                          ),
                          Text(
                            "(Item + Other Items)",
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                      Text(
                          "₹ ${itemRequiredTotalAmount! + otherItemTotalAmount!}"),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Service charge"),
                      Text(widget.serviceCallChargesController.text == ''
                          ? "₹ 0"
                          : "₹ ${widget.serviceCallChargesController.text}"),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Transport charges"),
                      Text(widget.transportChargesController.text == ''
                          ? "₹ 0"
                          : "₹ ${widget.transportChargesController.text}"),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Handling charge"),
                      Text(widget.handlingChargesController.text == ''
                          ? "₹ 0"
                          : "₹ ${widget.handlingChargesController.text}"),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Professional Charges"),
                      Text("₹ ${widget.commission}"),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("GST "),
                      Text(widget.gstChargesController.text == ''
                          ? "₹ 0"
                          : "₹ ${widget.gstChargesController.text}"),
                    ],
                  ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Amount"),
                      Text("₹$totalAmount"),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),

        //Terms And Condition
        ExpansionTileCard(
          key: cardTermsConditions,
          initiallyExpanded: true,
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
      ],
    );
  }
}
