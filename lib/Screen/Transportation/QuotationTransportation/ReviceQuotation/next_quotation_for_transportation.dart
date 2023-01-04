import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../Config/font.dart';
import '../../../../Constant/theme_colors.dart';
import '../../../../Widget/common.dart';
import '../../../../Widget/function_button.dart';
import '../../../MachineMaintenance/MakeQuotations/item_required_filter.dart';
import '../../../bottom_navbar.dart';


class NextQuotationFor extends StatefulWidget {
  const NextQuotationFor({Key? key}) : super(key: key);

  @override
  State<NextQuotationFor> createState() => NextQuotationForState();
}

class NextQuotationForState extends State<NextQuotationFor> {
  final TextEditingController _itemNameController = TextEditingController();
  final TextEditingController _itemPriceController = TextEditingController();

  String dropdownValue = '+ 91';
  String? phoneNum;
  String? role;
  bool loading = true;
  bool isSwitched = false;

  var mainHeight, mainWidth;
  var quantity = 0;
  var totalValue = 0;
  int prodValue = 15000;

  final GlobalKey<ExpansionTileCardState> cardVehicleDetailsTransposation = new GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardOtherItemRequiredTransposation = new GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardQuotationsTransposation = new GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardQuotations = new GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardTermsConditionsTransposation = new GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardMessage = new GlobalKey();



  final _formKey = GlobalKey<FormState>();

  Widget buildVehicleDetailsList() {
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
        return  VehicleDetailsCard();
      },
      itemCount: 3,
    );
  }

  Widget VehicleDetailsCard()
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
                      Text("Vehicle Name")
                    ],
                  ),
                ],
              ),
            )
        )
    );
  }

  Widget buildQuotationList() {
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
        return  QuotationCard();
      },
      itemCount: 3,
    );
  }

  Widget QuotationCard()
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
                      Text("Service name")
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

  Widget Alertmessage() {
    return AlertDialog(
      title: new Text(""),
      content: new Text("Are you sure, you want to send this quotation ?"),
      actions: <Widget>[
        Row(
          children: [
            TextButton(
              child: new Text("No"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            SizedBox(width: 7,),
            TextButton(
              child: new Text("Yes"),
              onPressed: () {
                // AlertDialog(
                //   title: new Text(""),
                //   content: new Text("Quotation sent Successfully"),
                //   actions: <Widget>[
                //     Row(
                //       children: [
                //         TextButton(
                //           child: new Text("Done"),
                //           onPressed: () {
                //             Navigator.push(context,
                //                 MaterialPageRoute(builder: (context) => BottomNavigation(index: 0)));
                //           },
                //         ),
                //       ],
                //     ),
                //   ],
                // );
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) =>
                        BottomNavigation(
                          index: 0, dropValue: "Transportation",)));
              },
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: InkWell(
            onTap: (){
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => BottomNavigation (index:0,dropValue:"Transportation")));
            },
            child: Icon(Icons.arrow_back_ios)),
        title: Text('Quotation for #102GRDSA36987',style:appBarheadingStyle ,),
      ),
      bottomNavigationBar:Padding(
        padding: const EdgeInsets.all(10.0),
        child: FunctionButton(
          onPressed: () async {
            showDialog(
                context: context,
                builder: (context) =>  AlertDialog(
                  title: new Text("Are you sure, you want to send this quotation ?"),
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
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>
                                BottomNavigation(index: 0,dropValue: 'Transportation',)));
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
          },
          shape: const RoundedRectangleBorder(
              borderRadius:
              BorderRadius.all(Radius.circular(50))),
          text: 'Next',
          loading: loading,


        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            SizedBox(height: 7,),
            // Item Required
            ExpansionTileCard(
              key: cardVehicleDetailsTransposation,
              initiallyExpanded: true,
              leading: Text("Vehicle Details"),

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
                      ],
                    ),
                  ),
                ),
                buildVehicleDetailsList(),

              ],
            ),
            // Others Items
            ExpansionTileCard(
              key: cardQuotationsTransposation,
              initiallyExpanded: true,
              leading: Text("Quotations"),

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
                            Text("Service Name",style: TextStyle(color: Colors.white),),
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
                buildQuotationList(),
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
              padding: const EdgeInsets.only(right: 16.0,left: 16.0,bottom: 16.0,top: 16.0),
              child: Container(
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("GST Number",style: TextStyle(fontWeight: FontWeight.bold),),
                      Text("07AAGFF2194N1Z1",style: TextStyle(fontWeight: FontWeight.bold),),
                    ],
                  )
              ),
            ),
            ExpansionTileCard(
              key: cardQuotations,
              initiallyExpanded: true,
              leading: Text("Quotations"),

              title: SizedBox(),
              subtitle:SizedBox(),
              children: <Widget>[
               Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: Column(
                   children: [
                     Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         Text("Service charge",style: TextStyle(fontSize: 14),),
                         Text("₹ 20,000",style: TextStyle(fontSize: 14),)
                       ],
                     ),
                     Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         Text("Total Items charges",style: TextStyle(fontSize: 14),),
                         Text("₹ 1500",style: TextStyle(fontSize: 14),)
                       ],
                     ),
                     Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         Text("Transport charges",style: TextStyle(fontSize: 14),),
                         Text("₹ 1500",style: TextStyle(fontSize: 14),)
                       ],
                     ),
                     Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         Text("Other charge",style: TextStyle(fontSize: 14),),
                         Text("₹ 1500",style: TextStyle(fontSize: 14),)
                       ],
                     ),
                     Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         Text("M1 Commission",style: TextStyle(fontSize: 14),),
                         Text("₹ 550",style: TextStyle(fontSize: 14),)
                       ],
                     ),
                     Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         Text("GST %",style: TextStyle(fontSize: 14),),
                         Text("5 %",style: TextStyle(fontSize: 14),)
                       ],
                     ),
                     Divider(),
                     Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         Text("Amount",style: TextStyle(fontSize: 14),),
                         Text("₹20000",style: TextStyle(fontSize: 14),)
                       ],
                     ),
                   ],
                 ),
               )

              ],
            ),
            ExpansionTileCard(
              key: cardTermsConditionsTransposation,
              initiallyExpanded: true,
              leading: Text("Terms and Conditions"),
              title: SizedBox(),
              subtitle:SizedBox(),
              children: <Widget>[

              ],
            ),
            ExpansionTileCard(
              key: cardMessage,
              initiallyExpanded: true,
              leading: Text("Message from Client"),
              title: SizedBox(),
              subtitle:SizedBox(),
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 16.0,left: 16.0,bottom: 16.0),
                  child: Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry."
                      " Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, "
                      "when an unknown printer"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
