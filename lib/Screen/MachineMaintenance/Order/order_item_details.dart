import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:service_engineer/Bloc/order/order_bloc.dart';
import 'package:service_engineer/Bloc/order/order_event.dart';
import 'package:service_engineer/Bloc/order/order_state.dart';
import 'package:service_engineer/Model/order_list_repo.dart';
import 'package:service_engineer/Model/order_repo.dart';
import 'package:service_engineer/Model/product_repo.dart';
import 'package:service_engineer/Model/quotation_reply_detail_repo.dart';
import 'package:service_engineer/Model/service_request_detail_repo.dart';
import 'package:service_engineer/Screen/bottom_navbar.dart';
import 'package:service_engineer/Utils/application.dart';
import 'package:service_engineer/Widget/custom_snackbar.dart';
import 'package:shimmer/shimmer.dart';
import 'package:another_stepper/another_stepper.dart';
import '../../../Constant/theme_colors.dart';
import '../../../Widget/app_button.dart';

class OrderItemDetailsScreen extends StatefulWidget {
  OrderItemDetailsScreen({Key? key,required this.orderList}) : super(key: key);
  OrderList orderList;
  @override
  _OrderItemDetailsScreenState createState() => _OrderItemDetailsScreenState();
}

class _OrderItemDetailsScreenState extends State<OrderItemDetailsScreen> {
  final GlobalKey<ExpansionTileCardState> cardA = new GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardB = new GlobalKey();
  final GlobalKey<ExpansionTileCardState> invoice = new GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardQuotations = new GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardTermsConditions = new GlobalKey();
  bool loading = true;
  bool isLoading = false;
  bool value = false;
  OrderBloc? _orderBloc;
  List<QuotationRequiredItems>? quotationRequiredItemList;
  List<QuotationRequiredItems>? quotationOtherItemList;
  List<QuotationCharges>? quotationChargesList;
  List<CustomerReplyMsg>? quotationMsgList;
  double itemRequiredTotal = 0.0;
  double itemOthersTotal = 0.0;
  double grandTotal = 0.0;
  List<OrderModel> orderDetail=[];
  List<ProductDetails>? productDetail = [];
  List<MachineServiceDetailsModel> serviceRequestData = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _orderBloc = BlocProvider.of<OrderBloc>(context);
    // _orderBloc!.add(MachineQuotationReplyDetail(machineEnquiryId: widget.quotationReplyList.enquiryId.toString(),
    //     customerUserId: widget.quotationReplyList.userId.toString()));
    _orderBloc!.add(GetOrderDetail(serviceUserId: widget.orderList.serviceUserId.toString(),machineEnquiryId: widget.orderList.machineEnquiryId.toString()));
    _orderBloc!.add(OnServiceRequestDetail(userID: widget.orderList.serviceUserId.toString(), machineEnquiryId: widget.orderList.machineEnquiryId.toString(),jobWorkEnquiryId: '0',transportEnquiryId: '0'));
  }

  TotalAmount(){
    grandTotal = itemRequiredTotal + itemOthersTotal + double.parse(orderDetail[0].serviceCharge.toString()) +
        double.parse(orderDetail[0].transportCharge.toString()) + double.parse(orderDetail[0].handlingCharge.toString())
        + double.parse(orderDetail[0].commission.toString()) +
        double.parse(orderDetail[0].gst.toString());
    setState(() {

    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // getroleofstudent();
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: InkWell(
              onTap: () {
              // Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => BottomNavigation (index:2,dropValue: '1',)));
              },
              child: Icon(Icons.arrow_back_ios)),
          title: Text(
            'Order Details',
          ),
        ),
        body: BlocBuilder<OrderBloc, OrderState>(builder: (context, state) {
          return BlocListener<OrderBloc, OrderState>(
            listener: (context, state) {

              if(state is OrderDetailLoading){
                isLoading = state.isLoading;
              }
              if(state is OrderDetailSuccess){
                orderDetail = state.orderDetailList;
              }
              if(state is OrderDetailFail){
                showCustomSnackBar(context,state.msg.toString());
              }
              if(state is ProductListLoading){
                // _isLoading = state.isLoading;
              }
              if(state is ProductListSuccess){
                productDetail = state.productList;
                // productDetail!.addAll(state.productList);
              }
              if(state is ProductListFail){
              }
              if(state is ServiceRequestDetailSuccess){
                serviceRequestData = state.machineServiceDetail;
              }
              if(state is ServiceRequestDetailFail){
                showCustomSnackBar(context,state.msg.toString());
              }
              if(state is CancelOrderLoading){
                isLoading = state.isLoading;
              }
              if(state is CancelOrderSuccess){
                showCustomSnackBar(context,state.msg.toString(),isError: false);
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>BottomNavigation(index: 2,dropValue: Application.customerLogin!.role.toString(),)));
              }
              if(state is CancelOrderFail){
                showCustomSnackBar(context,state.msg.toString());
              }
            },
            child: isLoading ? orderDetail.length <= 0 ? Center(child: CircularProgressIndicator(),):
            SingleChildScrollView(
              child: Stack(
                children: [
                  Column(
                    children: [
                      ///Order Details
                      orderDetail.length!=0?
                      ListView.builder(
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        padding: EdgeInsets.only(top: 10, bottom: 15),
                        itemCount: orderDetail.length,
                        itemBuilder: (context, index) {
                          // for(int i=0;i<orderDetail.length;i++){
                          //   _orderBloc!.add(ProductList(prodId: orderDetail[index].itemId.toString(),offSet: '0',brandId: '0',priceId: '0',catId: '0'));
                          // }
                          // String? descrip = productDetail![index].aboutProduct;

                          return  Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: ConstrainedBox(
                                  constraints: BoxConstraints(
                                    maxWidth: MediaQuery.of(context).size.width * 0.28,
                                    maxHeight: MediaQuery.of(context).size.width * 0.28,
                                  ),
                                  child: CachedNetworkImage(
                                    filterQuality: FilterQuality.medium,
                                    imageUrl: orderDetail[index].prodImage.toString(),
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
                                            borderRadius: BorderRadius.circular(0),
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
                                          borderRadius: BorderRadius.circular(0),
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
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  // mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      // width: MediaQuery.of(context).size.width / 1.8,
                                      width: MediaQuery.of(context).size.width / 1.9,
                                      child: Text(
                                        orderDetail[index].itemName.toString(),
                                        style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    // Row(
                                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    //   children: [
                                    //     Text(
                                    //       "Price:",
                                    //       style: TextStyle(
                                    //         fontFamily: 'Poppins',
                                    //         fontSize: 12,
                                    //         // fontWeight: FontWeight.bold
                                    //       ),
                                    //       overflow: TextOverflow.ellipsis,
                                    //     ),
                                    //     SizedBox(width: 4,),
                                    //     Text(
                                    //       "₹ ${orderDetail[index].rate.toString()}",
                                    //       style: TextStyle(
                                    //           fontFamily: 'Poppins',
                                    //           fontSize: 12,
                                    //           fontWeight: FontWeight.bold
                                    //       ),
                                    //       overflow: TextOverflow.ellipsis,
                                    //     )
                                    //   ],
                                    // ),
                                    // SizedBox(height: 5,),

                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Order Id:",
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 12,
                                            // fontWeight: FontWeight.bold
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        SizedBox(width: 4,),
                                        Text(
                                          orderDetail[index].machineEnquiryId.toString(),
                                          style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        )
                                      ],
                                    ),
                                    const Divider(thickness: 2,color: Colors.black),

                                    SizedBox(
                                      height: 5,
                                    ),
                                    // Container(
                                    //   width: MediaQuery.of(context).size.width*0.6,
                                    //   child: descrip != "" ?Text(descrip.toString(),
                                    //     style: TextStyle(
                                    //         fontFamily: 'Poppins',
                                    //         fontSize: 12,
                                    //         fontWeight: FontWeight.bold
                                    //     ),
                                    //     // overflow: TextOverflow.ellipsis,
                                    //   ): Text("",
                                    //     style: TextStyle(
                                    //         fontFamily: 'Poppins',
                                    //         fontSize: 12,
                                    //         fontWeight: FontWeight.bold
                                    //     ),
                                    //     // overflow: TextOverflow.ellipsis,
                                    //   ),
                                    // ),

                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                      ):Container(),


                      Divider(
                        thickness: 1,
                      ),
                      ///Track
                      ExpansionTileCard(
                        key: cardA,
                        initiallyExpanded: true,
                        title: Text("Track",
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Poppins',
                                fontSize: 16,
                                fontWeight: FontWeight.w500
                            )),
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: AnotherStepper(
                              // gap: 25,
                              stepperList: stepperData,
                              stepperDirection: Axis.vertical,
                              iconWidth: 20, // Height that will be applied to all the stepper icons
                              iconHeight: 20, // Width that will be applied to all the stepper icons
                              activeIndex: orderDetail[0].orderTrackingStatus!.toInt(),
                              activeBarColor: Colors.red,
                            ),
                          )

                        ],
                      ),

                      ///Delivery Address
                      serviceRequestData.length!=0?
                      ExpansionTileCard(
                        key: cardB,
                        initiallyExpanded: true,
                        title: Text("Delivery Address",
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Poppins',
                                fontSize: 16,
                                fontWeight: FontWeight.w500
                            )),
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left:20.0,bottom: 10),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(serviceRequestData[0].location.toString(),
                                  // Text("Plot 52B, Gandhi layout Jafar Nagar Nagpur 440013 Plot 52B, Gandhi layout Jafar Nagar Nagpur 440013",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'Poppins',
                                        fontSize: 14,
                                        // fontWeight: FontWeight.w500
                                      )),
                                ],
                              ),
                            ),
                          )

                        ],
                      ) :Container(),

                      // ///Invoice
                      // ExpansionTileCard(
                      //   key: invoice,
                      //   initiallyExpanded: true,
                      //   title: Text("Invoice",
                      //       style: TextStyle(
                      //           color: Colors.black,
                      //           fontFamily: 'Poppins',
                      //           fontSize: 16,
                      //           fontWeight: FontWeight.w500
                      //       )),
                      //   children: <Widget>[
                      //     Padding(
                      //       padding: const EdgeInsets.only(left: 10.0,right: 10.0),
                      //       child: Column(
                      //         crossAxisAlignment: CrossAxisAlignment.stretch,
                      //
                      //         children: [
                      //           DataTable(
                      //             headingRowHeight: 40,
                      //             headingRowColor: MaterialStateColor.resolveWith(
                      //                     (states) => Color(0xffE47273)),
                      //             columnSpacing: 15.0,
                      //             columns:const [
                      //               DataColumn(
                      //                 label: Expanded(child: Text('S no')),
                      //               ),
                      //               DataColumn(
                      //                 label: Text('Item Name'),
                      //               ),
                      //               DataColumn(
                      //                 label: Text('QTY'),
                      //               ),
                      //               DataColumn(
                      //                 label: Text('Rate'),
                      //               ),
                      //               DataColumn(
                      //                 label: Text('Amount'),
                      //               ),
                      //             ],
                      //             rows: List.generate(orderDetail.length, (index) {
                      //               int itemNo = index+1;
                      //               itemRequiredTotal = orderDetail
                      //                   .map((item) => double.parse(item.amount.toString()))
                      //                   .reduce((value, current) => value + current);
                      //               WidgetsBinding.instance.addPostFrameCallback((_){
                      //
                      //                 TotalAmount();
                      //               });
                      //
                      //               return _getItemRequiredDataRow(orderDetail[index],itemNo);
                      //             }),),
                      //         ],
                      //       ),
                      //
                      //     ),
                      //     Padding(
                      //       padding: const EdgeInsets.only(left: 10.0,right: 10.0,bottom: 10),
                      //       child: Container(
                      //         decoration: const BoxDecoration(
                      //           color: Color(0xffFFE4E5),
                      //           border: Border(
                      //             top: BorderSide(
                      //               color: Colors.black,
                      //               width: 1.0,
                      //             ),
                      //           ),
                      //         ),
                      //         child: Row(
                      //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //           children: [
                      //             SizedBox(),
                      //             Padding(
                      //               padding: const EdgeInsets.only(
                      //                   top: 8.0, right: 40.0, bottom: 8.0),
                      //               child: Row(
                      //                 children: [
                      //                   Text(
                      //                     "Total",
                      //                     style: TextStyle(fontWeight: FontWeight.bold),
                      //                   ),
                      //                   SizedBox(
                      //                     width: 15,
                      //                   ),
                      //                   Text(
                      //                     "₹ $itemRequiredTotal",
                      //                     style: TextStyle(fontWeight: FontWeight.bold),
                      //                   )
                      //                 ],
                      //               ),
                      //             ),
                      //           ],
                      //         ),
                      //       ),
                      //     ),
                      //
                      //   ],
                      // ),
                      //
                      // ///Quotation
                      // ExpansionTileCard(
                      //   key: cardQuotations,
                      //   initiallyExpanded: true,
                      //   // finalPadding: const EdgeInsets.only(bottom: 0.0),
                      //   title: Text("Quotation",
                      //       style: TextStyle(
                      //           color: Colors.black,
                      //           fontFamily: 'Poppins',
                      //           fontSize: 16,
                      //           fontWeight: FontWeight.w500
                      //       )),
                      //   children: <Widget>[
                      //     Padding(
                      //       padding: const EdgeInsets.only(right: 10.0,left: 10.0, bottom: 8.0),
                      //       child: Column(
                      //         children: [
                      //           Divider(thickness: 1,),
                      //           Row(
                      //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //             children: [
                      //               Text("Total Items charges"),
                      //               Text("₹ ${itemRequiredTotal + itemOthersTotal}"),
                      //             ],
                      //           ),
                      //           SizedBox(height: 10,),
                      //           Row(
                      //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //             children: [
                      //               Text("Service charge"),
                      //               Text("₹ ${orderDetail[0].serviceCharge}"),
                      //             ],
                      //           ),
                      //           SizedBox(height: 10,),
                      //
                      //
                      //           Row(
                      //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //             children: [
                      //               Text("Transport charges"),
                      //               Text("₹ ${orderDetail[0].transportCharge}"),
                      //             ],
                      //           ),
                      //
                      //           SizedBox(height: 10,),
                      //
                      //           Row(
                      //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //             children: [
                      //               Text("Handling charges"),
                      //               Text("₹ ${orderDetail[0].handlingCharge}"),
                      //             ],
                      //           ),
                      //
                      //           SizedBox(height: 10,),
                      //
                      //           Row(
                      //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //             children: [
                      //               Text("Professional Charges"),
                      //               Text("₹ ${orderDetail[0].commission}"),
                      //             ],
                      //           ),
                      //           SizedBox(height: 10,),
                      //
                      //           Row(
                      //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //             children: [
                      //               Text("GST "),
                      //               Text("₹ ${orderDetail[0].gst}"),
                      //             ],
                      //           ),
                      //           Divider(),
                      //           Row(
                      //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //             children: [
                      //               Text("Amount",
                      //                   style: TextStyle(
                      //                       color: Colors.black,
                      //                       fontFamily: 'Poppins',
                      //                       fontSize: 16,
                      //                       fontWeight: FontWeight.w500
                      //                   )),
                      //               Text("₹ $grandTotal",
                      //                   style: TextStyle(
                      //                       color: Colors.black,
                      //                       fontFamily: 'Poppins',
                      //                       fontSize: 16,
                      //                       fontWeight: FontWeight.w500
                      //                   )),
                      //             ],
                      //           ),
                      //         ],
                      //       ),
                      //     )
                      //
                      //
                      //   ],
                      // ),

                      ///Terms And Conditions
                      ExpansionTileCard(
                        initiallyExpanded: true,
                        key: cardTermsConditions,
                        title: Text("Terms and Conditions",
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

                      (widget.orderList.cancelOrder != 1 && widget.orderList.orderTrackingStatus != 5) ? Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: AppButton(
                          onPressed: () async {
                            if(value==true)
                            {
                              showDialog(
                                  context: context,
                                  builder: (context) =>  AlertDialog(
                                    title: new Text("Are you sure, you want to cancel this order?"),
                                    // content: new Text(""),
                                    actions: <Widget>[
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          TextButton(
                                              child: new Text("No",style: TextStyle(
                                                  color: Colors.black
                                              ),),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              }, style: TextButton.styleFrom(
                                              side: BorderSide(
                                                  color: ThemeColors.defaultbuttonColor,
                                                  width: 1.5)
                                          )
                                          ),
                                          SizedBox(width: 7,),
                                          TextButton(
                                            child: new Text("Yes",style: TextStyle(
                                                color: Colors.white
                                            ),),
                                            onPressed: () {
                                              _orderBloc!.add(CancelOrder(serviceUserId: widget.orderList.serviceUserId.toString(),
                                                  machineEnquiryId: widget.orderList.machineEnquiryId.toString()));
                                            },
                                            style: TextButton.styleFrom(
                                                backgroundColor: ThemeColors.defaultbuttonColor
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                              );
                            }
                            else{
                              showCustomSnackBar(context,"Please Agree Terms And Conditions.",isError: true);
                            }

                          },
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(50))),
                          text: 'Cancel Order',
                          loading: true,
                          color: ThemeColors.defaultbuttonColor,


                        ),
                      ):Container(),

                    ],
                  ),
                ],
              ),
            ) : Center(child: CircularProgressIndicator(),),

            // Center(
            //   child: CircularProgressIndicator(),
            // )

          );
        })
      ),
    );
  }
  DataRow _getItemRequiredDataRow(OrderModel orderDetail,index) {
    return DataRow(
      color: MaterialStateColor.resolveWith((states) {
        return Color(0xffFFE4E5); //make tha magic!
      }),
      cells: <DataCell>[
        DataCell(Text(index.toString())),
        DataCell(Text(orderDetail.itemName.toString())),
        DataCell(Text(orderDetail.itemQty.toString())),
        DataCell(Text('₹${orderDetail.rate.toString()}')),
        DataCell(Text('₹${orderDetail.amount.toString()}')),
      ],
    );
  }

  List<StepperData> stepperData = [
    StepperData(
        title: StepperText(
          "Order Placed",textStyle: TextStyle(
          fontSize: 13,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w500
        )),
        // subtitle: StepperText("24, Nov 2023"),
        iconWidget: Container(
          decoration: const BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.all(Radius.circular(30))),
          child: const Icon(Icons.circle, color: Colors.red,size: 10,),
        )
        ),
    StepperData(
        title: StepperText("Order is ready for dispatch",textStyle: TextStyle(
            fontSize: 13,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500
        )),
        // subtitle: StepperText("24, Nov 2023"),
        iconWidget: Container(
          decoration: const BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.all(Radius.circular(30))),
          child: const Icon(Icons.circle, color: Colors.red,size: 10,),
        )
        ),
    StepperData(
        title: StepperText("Order is reached your city",textStyle: TextStyle(
            fontSize: 13,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500
        )),
        // subtitle: StepperText("24, Nov 2023"),
        iconWidget: Container(
          decoration: const BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.all(Radius.circular(30))),
          child: const Icon(Icons.circle, color: Colors.red,size: 10,),
        )
        ),
    StepperData(
        title: StepperText("Order is reached your location\nplease verify and recive",textStyle: TextStyle(
            fontSize: 13,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500
        )),
        // subtitle: StepperText("24, Nov 2023"),
        iconWidget: Container(
          decoration: const BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.all(Radius.circular(30))),
          child: const Icon(Icons.circle, color: Colors.red,size: 10,),
        )
        ),
    StepperData(
      title: StepperText("Delivered",textStyle: TextStyle(
          fontSize: 13,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w500
      )),
      // subtitle: StepperText("24, Nov 2023"),
        iconWidget: Container(
          decoration: const BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.all(Radius.circular(30))),
          child: Icon(Icons.circle, color:Colors.red,size: 10,),
        )
    ),
  ];


  Widget buildOtherItemsList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      padding: EdgeInsets.only(top: 0, bottom: 1),
      itemBuilder: (context, index) {
        return  otherItemsCard();
      },
      itemCount: 3,
    );
  }

  Widget otherItemsCard()
  {
    return Padding(
        padding: const EdgeInsets.only(bottom:0.0),
        child: Container(
          // color: Color(0xffFFE4E5),
            decoration: BoxDecoration(
              color: Color(0xffFFE4E5),
            ),
            child:Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(

                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("1")
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Product Name or Any...")
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("5")
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("₹ 100")
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("₹ 500")
                    ],
                  ),
                ],
              ),
            )
        )
    );
  }
}
