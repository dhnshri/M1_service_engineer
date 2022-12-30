import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

import '../../Config/font.dart';
import '../../Widget/app_button.dart';

class PreviewScreen extends StatefulWidget {
  const PreviewScreen({Key? key}) : super(key: key);

  @override
  _PreviewScreenState createState() => _PreviewScreenState();
}

class _PreviewScreenState extends State<PreviewScreen> {
  final TextEditingController _phoneNumberController = TextEditingController();
  String dropdownValue = '+ 91';
  String? phoneNum;
  String? role;
  bool loading = true;

  // String? smsCode;
  // bool smsCodeSent = false;
  // String? verificationId;
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ExpansionTileCardState> cardItemRequired = new GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardOtherItemRequired = new GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardQuotations = new GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardTermsConditions = new GlobalKey();






  @override
  void initState() {
    // TODO: implement initState
    //saveDeviceTokenAndId();
    super.initState();
    _phoneNumberController.clear();

  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // getroleofstudent();
  }

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
      itemBuilder: (context, index) {
        return  ItemRequiredCard();
      },
      itemCount: 3,
    );
  }

  Widget ItemRequiredCard()
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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 7,),
        // Item Required
        ExpansionTileCard(
          key: cardItemRequired,
          leading: Text("Item Required"),

          title: SizedBox(),
          subtitle:SizedBox(),
          children: <Widget>[
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
            buildItemRequiredList(),
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
        // Others Items
        ExpansionTileCard(
          key: cardOtherItemRequired,
          leading: Text("Other Items( item not available on app)"),

          title: SizedBox(),
          subtitle:SizedBox(),
          children: <Widget>[
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
        // Date and Time
        Padding(
          padding: const EdgeInsets.only(right: 16.0,left: 16.0,bottom: 8.0,top: 8.0),
          child: Container(
           child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Date & Time"),
                Text("20 Nov, 2022 / 12PM - 4PM"),
              ],
            )
          ),
        ),
        ExpansionTileCard(
          key: cardQuotations,
          leading: Text("Quotation"),
          title: SizedBox(),
          subtitle:SizedBox(),
          children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 8.0,left: 8.0, bottom: 8.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Service charge"),
                    Text("₹ 20,000"),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Total Items charges"),
                    Text("₹ 1500"),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Transport charges"),
                    Text("₹ 1500"),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Other charge"),
                    Text("₹ 1500"),
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
        ExpansionTileCard(
          key: cardTermsConditions,
          leading: Text("Terms and Conditions"),
          title: SizedBox(),
          subtitle:SizedBox(),
          children: <Widget>[

          ],
        ),
      ],
    );
  }
}
