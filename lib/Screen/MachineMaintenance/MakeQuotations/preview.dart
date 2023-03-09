import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:service_engineer/Model/cart_list_repo.dart';
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
  PreviewScreen(
      {Key? key,
      required this.cartList,
      required this.itemNotAvailableList,
      required this.workingTimeController,
      required this.dateofJoiningController,
      required this.serviceCallChargesController,
      required this.handlingChargesController,
      required this.transportChargesController,
      required this.otherChargesController})
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
  int? oterItemsAmount = 0;
  int? otherItemTotalAmount = 0;

  @override
  void initState() {
    // TODO: implement initState
    //saveDeviceTokenAndId();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // getroleofstudent();
  }

  //Item Added To Cart List
  // Widget buildItemRequiredList() {
  //
  //   return ListView.builder(
  //     shrinkWrap: true,
  //     physics: NeverScrollableScrollPhysics(),
  //     scrollDirection: Axis.vertical,
  //     padding: EdgeInsets.only(top: 0, bottom: 1),
  //     itemCount: widget.cartList!.length,
  //     itemBuilder: (context, index) {
  //       amount = double.parse(widget.cartList![index].discountPrice.toString()) *
  //           int.parse(widget.cartList![index].qty.toString());
  //       // onAdd();
  //       itemRequiredTotalAmount = widget.cartList!
  //           .map((item) =>
  //               int.parse(item.discountPrice.toString()) *
  //               int.parse(item.qty.toString()))
  //           .reduce((value, current) => value + current);
  //
  //       return Padding(
  //           padding: const EdgeInsets.only(bottom: 0.0),
  //           child: Container(
  //               // color: Color(0xffFFE4E5),
  //               decoration: BoxDecoration(
  //                 color: Color(0xffFFE4E5),
  //               ),
  //               child: Padding(
  //                 padding: const EdgeInsets.all(8.0),
  //                 child: Row(
  //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                   children: [
  //                     Column(
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       children: [Text(index.toString())],
  //                     ),
  //                     Column(
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       children: [
  //                         Text(widget.cartList![index].productName.toString())
  //                       ],
  //                     ),
  //                     Column(
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       children: [
  //                         Text(widget.cartList![index].qty.toString())
  //                       ],
  //                     ),
  //                     Column(
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       children: [
  //                         Text(
  //                             "₹ ${widget.cartList![index].discountPrice.toString()}")
  //                       ],
  //                     ),
  //                     Column(
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       children: [Text(amount.toString())],
  //                     ),
  //                   ],
  //                 ),
  //               )));
  //     },
  //   );
  // }

  DataRow _getItemRequiredDataRow(CartListModel? cartData,index) {
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

  DataRow _getOtherItemRequiredDataRow(ItemNotAvailableModel? itemNotAvailableData) {
    return DataRow(
      color: MaterialStateColor.resolveWith((states) {
        return Color(0xffFFE4E5); //make tha magic!
      }),
      cells: <DataCell>[
        DataCell(Text(itemNotAvailableData!.id.toString())),
        DataCell(Text(itemNotAvailableData.itemName.toString())),
        DataCell(Text(itemNotAvailableData.quantity.toString())),
        DataCell(Text('₹${itemNotAvailableData.rate.toString()}')),
        DataCell(Text('₹${oterItemsAmount.toString()}')),
      ],
    );
  }

  Widget buildOtherItemsList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      padding: EdgeInsets.only(top: 0, bottom: 1),
      itemCount: widget.itemNotAvailableList.length,
      itemBuilder: (context, index) {
        oterItemsAmount = int.parse(
                widget.itemNotAvailableList[index].rate.toString()) *
            int.parse(widget.itemNotAvailableList[index].quantity.toString());
        otherItemTotalAmount = widget.itemNotAvailableList
            .map((item) =>
                int.parse(item.rate.toString()) *
                int.parse(item.quantity.toString()))
            .reduce((value, current) => value + current);
        return Padding(
            padding: const EdgeInsets.only(bottom: 0.0),
            child: Container(
                // color: Color(0xffFFE4E5),
                decoration: BoxDecoration(
                  color: Color(0xffFFE4E5),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              widget.itemNotAvailableList[index].id.toString()),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(widget.itemNotAvailableList[index].itemName
                              .toString())
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(widget.itemNotAvailableList[index].quantity
                              .toString())
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              "₹ ${widget.itemNotAvailableList[index].rate.toString()}")
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [Text("₹ $oterItemsAmount")],
                      ),
                    ],
                  ),
                )));
      },
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
                        fontFamily: 'Poppins-Medium',
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
                          amount = int.parse(widget.cartList![index].discountPrice
                                  .toString()) * 100/100+int.parse(widget.cartList![index].gst.toString());
                          amountWithGST = amount! *
                              int.parse(widget.cartList![index].qty.toString());
                          // itemRequiredTotalAmount = widget.cartList!
                          //     .map((item) =>
                          //         // int.parse(item.discountPrice.toString()) *
                          //         // int.parse(item.qty.toString())
                          //             int.parse(amountWithGST.toString())
                          // )
                          //     .reduce((value, current) => value + current);
                          itemRequiredTotalAmount = widget.cartList!
                              .map((item) =>
                          // int.parse(item.discountPrice.toString()) *
                          // int.parse(item.qty.toString())
                          double.parse(amountWithGST.toString())
                          )
                              .reduce((value, current) => value + current);
                          return _getItemRequiredDataRow(widget.cartList![index],index);
                        }),
                      ),
                    ],
                  ),
                  // buildItemRequiredList(),
                  // Divider(thickness: 1,color: Colors.grey,),
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
                ],
              ),
        SizedBox(height: 5,),
        // Others Items
        widget.itemNotAvailableList.isEmpty
            ? Container()
            : ExpansionTileCard(
                key: cardOtherItemRequired,
                initiallyExpanded: true,
                title: Text("Other Items( item not available on app)",
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Poppins-Medium',
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
                          rows: List.generate(widget.itemNotAvailableList.length, (index) {
                            oterItemsAmount = int.parse(
                                widget.itemNotAvailableList[index].rate.toString()) *
                                int.parse(widget.itemNotAvailableList[index].quantity.toString());
                            otherItemTotalAmount = widget.itemNotAvailableList
                                .map((item) =>
                            int.parse(item.rate.toString()) *
                                int.parse(item.quantity.toString()))
                                .reduce((value, current) => value + current);
                            return _getOtherItemRequiredDataRow(widget.itemNotAvailableList[index]);
                          }),),
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
        // Date and Time
        Padding(
          padding: const EdgeInsets.only(
              right: 16.0, left: 16.0, bottom: 8.0, top: 8.0),
          child: Container(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Date & Time"),
              Text("20 Nov, 2022 / 12PM - 4PM"),
            ],
          )),
        ),

        //Quotation Charges
        ExpansionTileCard(
          key: cardQuotations,
          initiallyExpanded: true,
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
                      Text("Service charge"),
                      Text(widget.serviceCallChargesController.text == ''
                          ? "₹ 0"
                          : "₹ ${widget.serviceCallChargesController.text}"),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Total Items charges"),
                      Text(
                          "₹ ${itemRequiredTotalAmount! + otherItemTotalAmount!}"),
                    ],
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Other charge"),
                      Text(widget.otherChargesController.text == ''
                          ? "₹ 0"
                          : "₹ ${widget.otherChargesController.text}"),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("M1 Commission"),
                      Text("₹ 550"),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("GST %"),
                      Text("5%"),
                    ],
                  ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Amount"),
                      Text("₹20000"),
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
                  fontFamily: 'Poppins-Medium',
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
                        fontFamily: 'Poppins-Medium',
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
