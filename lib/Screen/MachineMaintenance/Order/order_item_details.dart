import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:another_stepper/another_stepper.dart';
import '../../../Config/font.dart';
import '../../../Constant/theme_colors.dart';
import '../../../Widget/app_button.dart';

class OrderItemDetailsScreen extends StatefulWidget {
  const OrderItemDetailsScreen({Key? key}) : super(key: key);

  @override
  _OrderItemDetailsScreenState createState() => _OrderItemDetailsScreenState();
}

class _OrderItemDetailsScreenState extends State<OrderItemDetailsScreen> {
  final GlobalKey<ExpansionTileCardState> cardA = new GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardB = new GlobalKey();
  final GlobalKey<ExpansionTileCardState> invoice = new GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardQuotations = new GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardTermsConditions = new GlobalKey();




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


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: InkWell(
              onTap: () {
                Navigator.pop(context);
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => BottomNavigation (index:0)));
              },
              child: Icon(Icons.arrow_back_ios)),
          title: Text(
            'Order Details',
          ),
        ),
        bottomNavigationBar:Padding(
          padding: const EdgeInsets.all(10.0),
          child: AppButton(
            onPressed: () async {

            },
            shape: const RoundedRectangleBorder(
                borderRadius:
                BorderRadius.all(Radius.circular(50))),
            text: 'Cancel Order',
            loading: true,


          ),
        ),
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Column(
                children: [
                  ///Order Details
                  Row(
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
                            // imageUrl: Api.PHOTO_URL + widget.users.avatar,
                            // imageUrl: "https://picsum.photos/250?image=9",
                            imageUrl: "https://picsum.photos/250?image=9",
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
                                height: 120,
                                width: 100,
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
                                "Job Title/Services Name or Any Other Name",
                                style: TextStyle(
                                    fontFamily: 'Poppins-SemiBold',
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Price:",
                                  style: TextStyle(
                                    fontFamily: 'Poppins-Regular',
                                    fontSize: 12,
                                    // fontWeight: FontWeight.bold
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(width: 4,),
                                Text(
                                  "₹500",
                                  style: TextStyle(
                                    fontFamily: 'Poppins-Regular',
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                )
                              ],
                            ),
                            SizedBox(height: 5,),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Order Id:",
                                  style: TextStyle(
                                    fontFamily: 'Poppins-Regular',
                                    fontSize: 12,
                                    // fontWeight: FontWeight.bold
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(width: 4,),
                                Text(
                                  "1632456789",
                                  style: TextStyle(
                                    fontFamily: 'Poppins-Regular',
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                )
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width*0.6,
                              child: Text(
                                "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                                style: TextStyle(
                                  fontFamily: 'Poppins-Regular',
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold
                                ),
                                // overflow: TextOverflow.ellipsis,
                              ),
                            ),

                          ],
                        ),
                      ),
                    ],
                  ),

                  ///Track
                  ExpansionTileCard(
                    key: cardA,
                    initiallyExpanded: true,
                    title: Text("Track",
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Poppins-Medium',
                            fontSize: 16,
                            fontWeight: FontWeight.w500
                        )),
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: AnotherStepper(
                          stepperList: stepperData,
                          stepperDirection: Axis.vertical,
                          iconWidth: 25, // Height that will be applied to all the stepper icons
                          iconHeight: 25, // Width that will be applied to all the stepper icons
                          activeIndex: 1,
                          activeBarColor: Colors.red,
                        ),
                      )

                    ],
                  ),

                  ///Delivery Address
                  ExpansionTileCard(
                    key: cardB,
                    initiallyExpanded: true,
                    title: Text("Delivery Address",
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Poppins-Medium',
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
                              Text("Plot/Flat no, Area",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'Poppins-Medium',
                                      fontSize: 14,
                                      // fontWeight: FontWeight.w500
                                  )),
                              Text("Street, Road, City",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'Poppins-Medium',
                                      fontSize: 14,
                                      // fontWeight: FontWeight.w500
                                  )),
                              Text("State, PinCode",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'Poppins-Medium',
                                      fontSize: 14,
                                      // fontWeight: FontWeight.w500
                                  )),
                            ],
                          ),
                        ),
                      )

                    ],
                  ),

                  ///Invoice
                  ExpansionTileCard(
                    key: invoice,
                    initiallyExpanded: true,
                    title: Text("Invoice",
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Poppins-Medium',
                            fontSize: 16,
                            fontWeight: FontWeight.w500
                        )),
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0,right: 8.0,bottom: 8.0),
                        child: Column(
                          children: [
                            Container(
                              color: Color(0xffE47273),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("S no.",style: TextStyle(color: Colors.white),),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("Item Name",style: TextStyle(color: Colors.white),),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            SizedBox(width: 50,),
                                            Text("QTY",style: TextStyle(color: Colors.white),),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("Rate",style: TextStyle(color: Colors.white),),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("Amount",style: TextStyle(color: Colors.white),),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            buildOtherItemsList(),
                            Container(
                              color: Color(0xffFFE4E5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(),
                                  Padding(
                                    padding: const EdgeInsets.only(top:8.0,right: 8.0,bottom: 8.0),
                                    child: Row(
                                      children: [
                                        Text("Total",style: TextStyle(fontWeight: FontWeight.bold),),
                                        SizedBox(width: 15,),
                                        Text("₹ 1500",style: TextStyle(fontWeight: FontWeight.bold),)
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                    ],
                  ),

                  ///Quotations
                  ExpansionTileCard(
                    initiallyExpanded: true,
                    key: cardQuotations,
                    title: Text("Quotation",
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Poppins-Medium',
                            fontSize: 16,
                            fontWeight: FontWeight.w500
                        )),
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(right: 12.0,left: 12.0, bottom: 8.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Service Charge"),
                                Text("₹ 20"),
                              ],
                            ),
                            SizedBox(height: 5,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Total Items Charges"),
                                Text("₹ 15000"),
                              ],
                            ),
                            SizedBox(height: 5,),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Transport charges"),
                                Text("₹ 1500"),
                              ],
                            ),
                            SizedBox(height: 5,),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Other Charges"),
                                Text("₹ 550"),
                              ],
                            ),
                            SizedBox(height: 5,),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("M1 Commission"),
                                Text("₹ 28"),
                              ],
                            ),
                            SizedBox(height: 5,),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("GST %"),
                                Text("28%"),
                              ],
                            ),

                            Divider(
                              thickness: 1.5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Total",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'Poppins-Medium',
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500
                                    )),
                                Text("₹20000",
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

                  ///Terms And Conditions
                  ExpansionTileCard(
                    initiallyExpanded: true,
                    key: cardTermsConditions,
                    title: Text("Terms and Conditions",
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Poppins-Medium',
                            fontSize: 16,
                            fontWeight: FontWeight.w500
                        )),
                    children: <Widget>[

                    ],
                  ),



                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<StepperData> stepperData = [
    StepperData(
        title: StepperText(
          "Order Placed"),
        subtitle: StepperText("24, Nov 2023"),
        iconWidget: Container(
          padding: const EdgeInsets.all(0),
          decoration: const BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.all(Radius.circular(30))),
          child: const Icon(Icons.circle, color: Colors.red),
        )
        ),
    StepperData(
        title: StepperText("Order is ready for dispatch"),
        subtitle: StepperText("24, Nov 2023"),
        iconWidget: Container(
          padding: const EdgeInsets.all(0),
          decoration: const BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.all(Radius.circular(30))),
          child: const Icon(Icons.circle, color: Colors.red),
        )
        ),
    StepperData(
        title: StepperText("Order is reached your city"),
        subtitle: StepperText(
            "24, Nov 2023"),
        iconWidget: Container(
          padding: const EdgeInsets.all(0),
          decoration: const BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.all(Radius.circular(30))),
          child: const Icon(Icons.circle, color: Colors.red),
        )
        ),
    StepperData(
        title: StepperText("Order is reached your location\nplease verify and recive"),
        subtitle: StepperText(
            "24, Nov 2023"),
        iconWidget: Container(
          padding: const EdgeInsets.all(0),
          decoration: const BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.all(Radius.circular(30))),
          child: const Icon(Icons.circle, color: Colors.red),
        )
        ),
    StepperData(
      title: StepperText("Delivered",),
      subtitle: StepperText("24, Nov 2023"),
        iconWidget: Container(
          padding: const EdgeInsets.all(0),
          decoration: const BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.all(Radius.circular(30))),
          child: const Icon(Icons.circle, color: Colors.red),
        )
    ),
  ];


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
