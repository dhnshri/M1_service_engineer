import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:service_engineer/Model/cart_list_repo.dart';
import 'package:service_engineer/Model/item_not_available_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';


class RevisedQuotationPreviewScreen extends StatefulWidget {
  List<ItemNotAvailableModel>? cartList = [];
  List<ItemNotAvailableModel> itemNotAvailableList = [];
  TextEditingController workingTimeController = TextEditingController();
  TextEditingController dateofJoiningController = TextEditingController();
  TextEditingController serviceCallChargesController = TextEditingController();
  TextEditingController handlingChargesController = TextEditingController();
  TextEditingController otherChargesController = TextEditingController();
  TextEditingController transportChargesController = TextEditingController();
  RevisedQuotationPreviewScreen(
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
  _RevisedQuotationPreviewScreenState createState() => _RevisedQuotationPreviewScreenState();
}

class _RevisedQuotationPreviewScreenState extends State<RevisedQuotationPreviewScreen> {

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
  double? commission = 10;
  double? totalAmount= 0;

  @override
  void initState() {
    // TODO: implement initState
    //saveDeviceTokenAndId();
    super.initState();
    itemRequiredTotalAmount;
    // setState(() {
    //   totalAmount = int.parse(widget.serviceCallChargesController.text.toString()) + itemRequiredTotalAmount! + otherItemTotalAmount! +
    //       int.parse(widget.transportChargesController.text.toString()) +
    //        commission!;
    // });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // getroleofstudent();
  }


  DataRow _getItemRequiredDataRow(ItemNotAvailableModel? cartData,index) {
    return DataRow(
      color: MaterialStateColor.resolveWith((states) {
        return Color(0xffFFE4E5); //make tha magic!
      }),
      cells: <DataCell>[
        DataCell(Text(index.toString())),
        DataCell(Text(cartData!.itemName.toString())),
        DataCell(Text(cartData.quantity.toString())),
        DataCell(Text('₹${cartData.rate.toString()}')),
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

                    amount = int.parse(widget.cartList![index].rate
                        .toString()) * 100/100+int.parse(widget.cartList![index].gst.toString());
                    amountWithGST = amount! *
                        int.parse(widget.cartList![index].quantity.toString());
                    setState((){
                      itemRequiredTotalAmount = widget.cartList!
                          .map((item) =>
                          double.parse(amountWithGST.toString())
                      ).reduce((value, current) => value + current);
                    });
                    print(itemRequiredTotalAmount);
                    totalAmount = int.parse(widget.serviceCallChargesController.text.toString()) + itemRequiredTotalAmount! + otherItemTotalAmount! +
                          int.parse(widget.transportChargesController.text.toString()) +
                           commission! + int.parse(widget.handlingChargesController.text.toString()) + 18;
                    return _getItemRequiredDataRow(widget.cartList![index],index);
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
                    oterItemsAmount = double.parse(
                        widget.itemNotAvailableList[index].rate.toString()) *
                        100/100+int.parse(widget.itemNotAvailableList[index].gst.toString());

                    otherItemsAmountWithGST = oterItemsAmount! * int.parse(widget.itemNotAvailableList[index].quantity.toString());


                    otherItemTotalAmount = widget.itemNotAvailableList
                        .map((item) =>
                        double.parse(otherItemsAmountWithGST.toString()))
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
        // Padding(
        //   padding: const EdgeInsets.only(
        //       right: 16.0, left: 16.0, bottom: 8.0, top: 8.0),
        //   child: Container(
        //       child: Row(
        //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //         children: [
        //           Text("Date & Time"),
        //           Text("20 Nov, 2022 / 12PM - 4PM"),
        //         ],
        //       )),
        // ),

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
                      Text("Total Items charges"),
                      Text(
                          "₹ ${itemRequiredTotalAmount! + otherItemTotalAmount!}"),
                    ],
                  ),
                  SizedBox(height: 3,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Service charge"),
                      Text(widget.serviceCallChargesController.text == ''
                          ? "₹ 0"
                          : "₹ ${widget.serviceCallChargesController.text}"),
                    ],
                  ),
                  SizedBox(height: 3,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Transport charges"),
                      Text(widget.transportChargesController.text == ''
                          ? "₹ 0"
                          : "₹ ${widget.transportChargesController.text}"),
                    ],
                  ),
                  SizedBox(height: 3,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Handling charge"),
                      Text(widget.handlingChargesController.text == ''
                          ? "₹ 0"
                          : "₹ ${widget.handlingChargesController.text}"),
                    ],
                  ),
                  SizedBox(height: 3,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("M1 Commission"),
                      Text("₹ $commission"),
                    ],
                  ),
                  SizedBox(height: 3,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("GST "),
                      Text("18"),
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
