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
  final TextEditingController _phoneNumberController = TextEditingController();
  String dropdownValue = '+ 91';
  String? phoneNum;
  String? role;
  bool loading = true;
  bool value = false;

  // String? smsCode;
  // bool smsCodeSent = false;
  // String? verificationId;
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ExpansionTileCardState> cardItemRequired = new GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardOtherItemRequired =
      new GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardQuotations = new GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardTermsConditions = new GlobalKey();

  int? amount = 0;
  int? itemRequiredTotalAmount = 0;
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
  Widget buildItemRequiredList() {
    // if (productList.length <= 0) {
    //   return ListView.builder(
    //     scrollDirection: Axis.vertical,
    //     // padding: EdgeInsets.only(left: 5, right: 20, top: 10, bottom: 15),
    //     itemBuilder: (context, index) {
    //       return Shimmer.fromColors(
    //         baseColor: Theme.of(context).hoverColor,
    //         highlightColor: Theme.of(context).highlightColor,
    //         enabled: true,
    //         child: Padding(
    //           padding: const EdgeInsets.all(8.0),
    //           child: Container(
    //             width: MediaQuery.of(context).size.width,
    //             child: ListTile(
    //               contentPadding: EdgeInsets.zero,
    //               //visualDensity: VisualDensity(horizontal: 0, vertical: -4),
    //               // leading: nameIcon(),
    //               leading: CachedNetworkImage(
    //                 filterQuality: FilterQuality.medium,
    //                 // imageUrl: Api.PHOTO_URL + widget.users.avatar,
    //                 imageUrl: "https://picsum.photos/250?image=9",
    //                 // imageUrl: model.cart[index].productImg == null
    //                 //     ? "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1050&q=80"
    //                 //     : model.cart[index].productImg,
    //                 placeholder: (context, url) {
    //                   return Shimmer.fromColors(
    //                     baseColor: Theme.of(context).hoverColor,
    //                     highlightColor: Theme.of(context).highlightColor,
    //                     enabled: true,
    //                     child: Container(
    //                       height: 80,
    //                       width: 80,
    //                       decoration: BoxDecoration(
    //                         color: Colors.white,
    //                         borderRadius: BorderRadius.circular(8),
    //                       ),
    //                     ),
    //                   );
    //                 },
    //                 imageBuilder: (context, imageProvider) {
    //                   return Container(
    //                     height: 80,
    //                     width: 80,
    //                     decoration: BoxDecoration(
    //                       image: DecorationImage(
    //                         image: imageProvider,
    //                         fit: BoxFit.cover,
    //                       ),
    //                       borderRadius: BorderRadius.circular(8),
    //                     ),
    //                   );
    //                 },
    //                 errorWidget: (context, url, error) {
    //                   return Shimmer.fromColors(
    //                     baseColor: Theme.of(context).hoverColor,
    //                     highlightColor: Theme.of(context).highlightColor,
    //                     enabled: true,
    //                     child: Container(
    //                       height: 80,
    //                       width: 80,
    //                       decoration: BoxDecoration(
    //                         color: Colors.white,
    //                         borderRadius: BorderRadius.circular(8),
    //                       ),
    //                       child: Icon(Icons.error),
    //                     ),
    //                   );
    //                 },
    //               ),
    //               title: Column(
    //                 children: [
    //                   Align(
    //                     alignment: Alignment.centerLeft,
    //                     child: Text(
    //                       "Loading...",
    //                       overflow: TextOverflow.clip,
    //                       style: TextStyle(
    //                         fontWeight: FontWeight.bold,
    //                         fontSize: 15.0,
    //                         //color: Theme.of(context).accentColor
    //                       ),
    //                     ),
    //                   ),
    //                   Column(
    //                     crossAxisAlignment: CrossAxisAlignment.start,
    //                     mainAxisAlignment: MainAxisAlignment.spaceAround,
    //                     children: [
    //                       Row(
    //                         children: [
    //                           Text(
    //                             ".......",
    //                             style: TextStyle(
    //                               fontWeight: FontWeight.normal,
    //                               color: Colors.black87,
    //                               fontSize: 14.0,
    //                             ),
    //                           ),
    //                           SizedBox(
    //                             width: 20,
    //                           )
    //                         ],
    //                       ),
    //                     ],
    //                   ),
    //                 ],
    //               ),
    //             ),
    //             decoration: BoxDecoration(
    //                 borderRadius: BorderRadius.all(Radius.circular(20)),
    //                 color: Colors.white),
    //           ),
    //         ),
    //       );
    //     },
    //     itemCount: List.generate(8, (index) => index).length,
    //   );
    // }

    // return ListView.builder(
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      padding: EdgeInsets.only(top: 0, bottom: 1),
      itemCount: widget.cartList!.length,
      itemBuilder: (context, index) {
        amount = int.parse(widget.cartList![index].discountPrice.toString()) *
            int.parse(widget.cartList![index].qty.toString());
        // onAdd();
        itemRequiredTotalAmount = widget.cartList!
            .map((item) =>
                int.parse(item.discountPrice.toString()) *
                int.parse(item.qty.toString()))
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
                        children: [Text(index.toString())],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(widget.cartList![index].productName.toString())
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(widget.cartList![index].qty.toString())
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              "₹ ${widget.cartList![index].discountPrice.toString()}")
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [Text(amount.toString())],
                      ),
                    ],
                  ),
                )));
      },
    );
  }

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
        DataCell(Text('₹${amount.toString()}')),
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
    // if (productList.length <= 0) {
    //   return ListView.builder(
    //     scrollDirection: Axis.vertical,
    //     // padding: EdgeInsets.only(left: 5, right: 20, top: 10, bottom: 15),
    //     itemBuilder: (context, index) {
    //       return Shimmer.fromColors(
    //         baseColor: Theme.of(context).hoverColor,
    //         highlightColor: Theme.of(context).highlightColor,
    //         enabled: true,
    //         child: Padding(
    //           padding: const EdgeInsets.all(8.0),
    //           child: Container(
    //             width: MediaQuery.of(context).size.width,
    //             child: ListTile(
    //               contentPadding: EdgeInsets.zero,
    //               //visualDensity: VisualDensity(horizontal: 0, vertical: -4),
    //               // leading: nameIcon(),
    //               leading: CachedNetworkImage(
    //                 filterQuality: FilterQuality.medium,
    //                 // imageUrl: Api.PHOTO_URL + widget.users.avatar,
    //                 imageUrl: "https://picsum.photos/250?image=9",
    //                 // imageUrl: model.cart[index].productImg == null
    //                 //     ? "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1050&q=80"
    //                 //     : model.cart[index].productImg,
    //                 placeholder: (context, url) {
    //                   return Shimmer.fromColors(
    //                     baseColor: Theme.of(context).hoverColor,
    //                     highlightColor: Theme.of(context).highlightColor,
    //                     enabled: true,
    //                     child: Container(
    //                       height: 80,
    //                       width: 80,
    //                       decoration: BoxDecoration(
    //                         color: Colors.white,
    //                         borderRadius: BorderRadius.circular(8),
    //                       ),
    //                     ),
    //                   );
    //                 },
    //                 imageBuilder: (context, imageProvider) {
    //                   return Container(
    //                     height: 80,
    //                     width: 80,
    //                     decoration: BoxDecoration(
    //                       image: DecorationImage(
    //                         image: imageProvider,
    //                         fit: BoxFit.cover,
    //                       ),
    //                       borderRadius: BorderRadius.circular(8),
    //                     ),
    //                   );
    //                 },
    //                 errorWidget: (context, url, error) {
    //                   return Shimmer.fromColors(
    //                     baseColor: Theme.of(context).hoverColor,
    //                     highlightColor: Theme.of(context).highlightColor,
    //                     enabled: true,
    //                     child: Container(
    //                       height: 80,
    //                       width: 80,
    //                       decoration: BoxDecoration(
    //                         color: Colors.white,
    //                         borderRadius: BorderRadius.circular(8),
    //                       ),
    //                       child: Icon(Icons.error),
    //                     ),
    //                   );
    //                 },
    //               ),
    //               title: Column(
    //                 children: [
    //                   Align(
    //                     alignment: Alignment.centerLeft,
    //                     child: Text(
    //                       "Loading...",
    //                       overflow: TextOverflow.clip,
    //                       style: TextStyle(
    //                         fontWeight: FontWeight.bold,
    //                         fontSize: 15.0,
    //                         //color: Theme.of(context).accentColor
    //                       ),
    //                     ),
    //                   ),
    //                   Column(
    //                     crossAxisAlignment: CrossAxisAlignment.start,
    //                     mainAxisAlignment: MainAxisAlignment.spaceAround,
    //                     children: [
    //                       Row(
    //                         children: [
    //                           Text(
    //                             ".......",
    //                             style: TextStyle(
    //                               fontWeight: FontWeight.normal,
    //                               color: Colors.black87,
    //                               fontSize: 14.0,
    //                             ),
    //                           ),
    //                           SizedBox(
    //                             width: 20,
    //                           )
    //                         ],
    //                       ),
    //                     ],
    //                   ),
    //                 ],
    //               ),
    //             ),
    //             decoration: BoxDecoration(
    //                 borderRadius: BorderRadius.all(Radius.circular(20)),
    //                 color: Colors.white),
    //           ),
    //         ),
    //       );
    //     },
    //     itemCount: List.generate(8, (index) => index).length,
    //   );
    // }

    // return ListView.builder(
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
                                  .toString()) *
                              int.parse(widget.cartList![index].qty.toString());
                          itemRequiredTotalAmount = widget.cartList!
                              .map((item) =>
                                  int.parse(item.discountPrice.toString()) *
                                  int.parse(item.qty.toString()))
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
                  // Container(
                  //   color: Color(0xffE47273),
                  //   child: Padding(
                  //     padding: const EdgeInsets.all(8.0),
                  //     child: Row(
                  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //       children: [
                  //         Column(
                  //           crossAxisAlignment: CrossAxisAlignment.start,
                  //           children: [
                  //             Text(
                  //               "S no.",
                  //               style: TextStyle(color: Colors.white),
                  //             ),
                  //           ],
                  //         ),
                  //         Column(
                  //           crossAxisAlignment: CrossAxisAlignment.start,
                  //           children: [
                  //             Text(
                  //               "Item Name",
                  //               style: TextStyle(color: Colors.white),
                  //             ),
                  //           ],
                  //         ),
                  //         Column(
                  //           crossAxisAlignment: CrossAxisAlignment.start,
                  //           children: [
                  //             Row(
                  //               children: [
                  //                 SizedBox(
                  //                   width: 50,
                  //                 ),
                  //                 Text(
                  //                   "QTY",
                  //                   style: TextStyle(color: Colors.white),
                  //                 ),
                  //               ],
                  //             ),
                  //           ],
                  //         ),
                  //         Column(
                  //           crossAxisAlignment: CrossAxisAlignment.start,
                  //           children: [
                  //             Text(
                  //               "Rate",
                  //               style: TextStyle(color: Colors.white),
                  //             ),
                  //           ],
                  //         ),
                  //         Column(
                  //           crossAxisAlignment: CrossAxisAlignment.start,
                  //           children: [
                  //             Text(
                  //               "Amount",
                  //               style: TextStyle(color: Colors.white),
                  //             ),
                  //           ],
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),

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
