import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

import '../../../Config/font.dart';
import '../../../Constant/theme_colors.dart';
import '../../../Widget/common.dart';
import 'item_required_filter.dart';
import '../../../Widget/stepper_button.dart';
import 'make_quotatons.dart';


class ItemRequired extends StatefulWidget {
  const ItemRequired({Key? key}) : super(key: key);

  @override
  State<ItemRequired> createState() => ItemRequiredState();
}

class ItemRequiredState extends State<ItemRequired> {


  final TextEditingController _srNumberController = TextEditingController();
  final TextEditingController _itemNameController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _rateController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();


  String dropdownValue = '+ 91';
  String? phoneNum;
  String? role;
  bool loading = true;
  bool isSwitched = false;

  var mainHeight, mainWidth;
  var quantity = 0;
  var totalValue = 0;
  int prodValue = 15000;



  final _formKey = GlobalKey<FormState>();

  Widget builditemRequredCardList() {
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
      padding: EdgeInsets.only(top: 10, bottom: 15),
      itemBuilder: (context, index) {
        return  itemRequredCard();
      },
      itemCount: 3,
    );
  }

  Widget itemRequredCard()
  {
    mainHeight = MediaQuery.of(context).size.height;
    mainWidth = MediaQuery.of(context).size.width;
    return Padding(
        padding: const EdgeInsets.only(bottom:8.0),
        child: Card(
            elevation: 1,
            child: ListTile(
              leading: CachedNetworkImage(
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
                        borderRadius: BorderRadius.circular(8),
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
                      borderRadius: BorderRadius.circular(8),
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
              title: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Item Name",style:itemRequiredCardHeading,),
                            Text("ID: 123456",style: itemRequiredCardSubtitle),
                            Text("₹2000",style:itemRequiredCardSubtitle),
                          ],

                        ),

                        Expanded(
                          child: Container(
                            width: mainWidth / 3,
                            //width: 80,
                            child: Row(
                              children: [
                                IconButton(
                                  icon: Icon(
                                    Icons.remove_circle,
                                    color: Colors.grey,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      if (quantity > 1) {
                                        quantity--;
                                        totalValue = prodValue * quantity;
                                      }
                                    });
                                  },
                                ),
                                Text(
                                  quantity.toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 18),
                                ),
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      if (quantity < 10) {
                                        quantity++;
                                        totalValue = prodValue * quantity;
                                      }
                                      // var qty = cert.cart[index].qty! + 1;
                                      // cert.updateProduct(
                                      //     cert.cart[index].id,
                                      //     cert.cart[index].price.toString(),
                                      //     qty);
                                    });
                                  },
                                  icon: Icon(
                                    Icons.add_circle,
                                    color: ThemeColors.baseThemeColor,
                                  ),
                                ),
                              ],
                            ),

                          ),
                        )
                      ],
                    ),
                    Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. "
                        "when an unknown printer...Read More.",style: itemRequiredCardSubtitle),
                  ]
              ),
            )));
  }

  Widget buildItemRequiredList() {
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
                      Text("Item Name...")
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("00")
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("₹ 0")
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("₹ 0")
                    ],
                  ),
                ],
              ),
            )
        )
    );
  }

  Future AddItemNotAvailable() {
    return showModalBottomSheet(
        isScrollControlled: true,

        // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(35.0),
                topRight: Radius.circular(35.0))),
        context: context,
        builder: (BuildContext context) {
          return NotAvailableItemCard();

        });
  }

  Widget NotAvailableItemCard()
  {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 1,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    SizedBox(
                      width:
                      MediaQuery.of(context).size.width * 0.8,
                      height: 60,
                      child: TextFormField(
                        controller: _srNumberController,
                        keyboardType: TextInputType.text,
                        maxLength: 10,
                        cursorColor: primaryAppColor,
                        decoration: InputDecoration(
                          disabledBorder: OutlineInputBorder(
                            borderRadius:
                            BorderRadius.circular(8.0),
                            borderSide: const BorderSide(
                              color: Colors.white,
                              width: 1.0,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius:
                            BorderRadius.circular(8.0),
                            borderSide: const BorderSide(
                              color: Colors.red,
                              width: 1.0,
                            ),
                          ),
                          fillColor: Colors.white,
                          filled: true,
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                            BorderRadius.circular(10.0),
                            borderSide: const BorderSide(
                                color: Colors.white, width: 1.0),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.circular(8.0),
                              borderSide: const BorderSide(
                                color: Colors.white,
                                width: 1.0,
                              )),
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                            BorderRadius.circular(8.0),
                            borderSide: const BorderSide(
                              color: Colors.white,
                              width: 1.0,
                            ),
                          ),
                          hintText: 'Number',
                          contentPadding: const EdgeInsets.fromLTRB(
                              20.0, 20.0, 0.0, 0.0),
                          hintStyle: GoogleFonts.poppins(
                              color: Colors.grey,
                              fontSize: 12.0,
                              fontWeight: FontWeight.w500),
                        ),
                        onChanged: (val) {
                          setState(() {
                            if ( _formKey.currentState!.validate()) {}
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      width:
                      MediaQuery.of(context).size.width * 0.8,
                      height: 60,
                      child: TextFormField(
                        controller: _itemNameController,
                        keyboardType: TextInputType.text,
                        maxLength: 10,
                        cursorColor: primaryAppColor,
                        decoration: InputDecoration(
                          disabledBorder: OutlineInputBorder(
                            borderRadius:
                            BorderRadius.circular(8.0),
                            borderSide: const BorderSide(
                              color: Colors.white,
                              width: 1.0,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius:
                            BorderRadius.circular(8.0),
                            borderSide: const BorderSide(
                              color: Colors.red,
                              width: 1.0,
                            ),
                          ),
                          fillColor: Colors.white,
                          filled: true,
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                            BorderRadius.circular(10.0),
                            borderSide: const BorderSide(
                                color: Colors.white, width: 1.0),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.circular(8.0),
                              borderSide: const BorderSide(
                                color: Colors.white,
                                width: 1.0,
                              )),
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                            BorderRadius.circular(8.0),
                            borderSide: const BorderSide(
                              color: Colors.white,
                              width: 1.0,
                            ),
                          ),
                          hintText: 'Item Name',
                          contentPadding: const EdgeInsets.fromLTRB(
                              20.0, 20.0, 0.0, 0.0),
                          hintStyle: GoogleFonts.poppins(
                              color: Colors.grey,
                              fontSize: 12.0,
                              fontWeight: FontWeight.w500),
                        ),
                        onChanged: (val) {
                          setState(() {
                            if ( _formKey.currentState!.validate()) {}
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      width:
                      MediaQuery.of(context).size.width * 0.8,
                      height: 60,
                      child: TextFormField(
                        controller: _quantityController,
                        keyboardType: TextInputType.text,
                        maxLength: 10,
                        cursorColor: primaryAppColor,
                        decoration: InputDecoration(
                          disabledBorder: OutlineInputBorder(
                            borderRadius:
                            BorderRadius.circular(8.0),
                            borderSide: const BorderSide(
                              color: Colors.white,
                              width: 1.0,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius:
                            BorderRadius.circular(8.0),
                            borderSide: const BorderSide(
                              color: Colors.red,
                              width: 1.0,
                            ),
                          ),
                          fillColor: Colors.white,
                          filled: true,
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                            BorderRadius.circular(10.0),
                            borderSide: const BorderSide(
                                color: Colors.white, width: 1.0),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.circular(8.0),
                              borderSide: const BorderSide(
                                color: Colors.white,
                                width: 1.0,
                              )),
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                            BorderRadius.circular(8.0),
                            borderSide: const BorderSide(
                              color: Colors.white,
                              width: 1.0,
                            ),
                          ),
                          hintText: 'Quantity',
                          contentPadding: const EdgeInsets.fromLTRB(
                              20.0, 20.0, 0.0, 0.0),
                          hintStyle: GoogleFonts.poppins(
                              color: Colors.grey,
                              fontSize: 12.0,
                              fontWeight: FontWeight.w500),
                        ),
                        onChanged: (val) {
                          setState(() {
                            if ( _formKey.currentState!.validate()) {}
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      width:
                      MediaQuery.of(context).size.width * 0.8,
                      height: 60,
                      child: TextFormField(
                        controller: _rateController,
                        keyboardType: TextInputType.number,
                        maxLength: 10,
                        cursorColor: primaryAppColor,
                        decoration: InputDecoration(
                          disabledBorder: OutlineInputBorder(
                            borderRadius:
                            BorderRadius.circular(8.0),
                            borderSide: const BorderSide(
                              color: Colors.white,
                              width: 1.0,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius:
                            BorderRadius.circular(8.0),
                            borderSide: const BorderSide(
                              color: Colors.red,
                              width: 1.0,
                            ),
                          ),
                          fillColor: Colors.white,
                          filled: true,
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                            BorderRadius.circular(10.0),
                            borderSide: const BorderSide(
                                color: Colors.white, width: 1.0),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.circular(8.0),
                              borderSide: const BorderSide(
                                color: Colors.white,
                                width: 1.0,
                              )),
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                            BorderRadius.circular(8.0),
                            borderSide: const BorderSide(
                              color: Colors.white,
                              width: 1.0,
                            ),
                          ),
                          hintText: 'Rate',
                          contentPadding: const EdgeInsets.fromLTRB(
                              20.0, 20.0, 0.0, 0.0),
                          hintStyle: GoogleFonts.poppins(
                              color: Colors.grey,
                              fontSize: 12.0,
                              fontWeight: FontWeight.w500),
                        ),
                        onChanged: (val) {
                          setState(() {
                            if ( _formKey.currentState!.validate()) {}
                          });
                        },
                      ),
                    ),

                    SizedBox(
                      width:
                      MediaQuery.of(context).size.width * 0.8,
                      height: 60,
                      child: TextFormField(
                        controller: _amountController,
                        keyboardType: TextInputType.text,
                        // maxLength: 10,
                        cursorColor: primaryAppColor,
                        decoration: InputDecoration(
                          disabledBorder: OutlineInputBorder(
                            borderRadius:
                            BorderRadius.circular(8.0),
                            borderSide: const BorderSide(
                              color: Colors.white,
                              width: 1.0,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius:
                            BorderRadius.circular(8.0),
                            borderSide: const BorderSide(
                              color: Colors.red,
                              width: 1.0,
                            ),
                          ),
                          fillColor: Colors.white,
                          filled: true,
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                            BorderRadius.circular(10.0),
                            borderSide: const BorderSide(
                                color: Colors.white, width: 1.0),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.circular(8.0),
                              borderSide: const BorderSide(
                                color: Colors.white,
                                width: 1.0,
                              )),
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                            BorderRadius.circular(8.0),
                            borderSide: const BorderSide(
                              color: Colors.white,
                              width: 1.0,
                            ),
                          ),
                          hintText: 'Amount',
                          contentPadding: const EdgeInsets.fromLTRB(
                              20.0, 20.0, 0.0, 0.0),
                          hintStyle: GoogleFonts.poppins(
                              color: Colors.grey,
                              fontSize: 12.0,
                              fontWeight: FontWeight.w500),
                        ),
                        onChanged: (val) {
                          setState(() {
                            if ( _formKey.currentState!.validate()) {}
                          });
                        },
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        StepperButton(
                          onPressed: () async {
                            // Navigator.of(context).push(
                            //     MaterialPageRoute(builder: (context) => MakeQuotationScreen()));
                          },
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(50))),
                          text: 'Cancel',
                          loading: loading,
                        ),
                        SizedBox(width: 15,),
                        StepperButton(
                          onPressed: () async {
                            // Navigator.of(context).push(
                            //     MaterialPageRoute(builder: (context) => MakeQuotationScreen()));
                          },
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(50))),
                          text: 'Done',
                          loading: loading,
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }



  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(Icons.search),
                SizedBox(width: 5,),
                Text("Search all Orders")
              ],
            ),

            InkWell(
              onTap: ()
              {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ItemRequiredFilterScreen()));
              },
              child: Row(
                children: [
                  Icon(Icons.filter_list),
                  SizedBox(width: 5,),
                  Text("Filter")
                ],
              ),
            )

          ],
        ),
        Container(
          height: 275,
          child:SingleChildScrollView(
            child: InkWell(
                onTap: (){
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (context) => ServiceRequestDetailsScreen()));
                },
                child:  builditemRequredCardList()),
          ),
        ),
        SizedBox(height: 15,),
        Align(
            alignment: Alignment.topLeft,
            child: Text("Items not available on app",style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins'
            ),)),
        SizedBox(height: 5,),
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
        SizedBox(height: 7,),
        SizedBox(width: 5,),
        InkWell(
          onTap: (){
            AddItemNotAvailable();
          },
          child:  Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(),
              ///Add More
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text("Add More",
                    style: TextStyle(fontFamily: 'Poppins', fontSize: 14,fontWeight: FontWeight.w600,color: Colors.black),
                    textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(width: 5,),
                  InkWell(
                    onTap: (){
                      AddItemNotAvailable();
                    },
                    child: CircleAvatar(
                      backgroundColor: ThemeColors.redTextColor,
                      child: Icon(Icons.add,color: Colors.white,),
                    ),
                  )
                ],
              ),

            ],
          ),

        )
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: [
        //     SizedBox(),
        //     InkWell(
        //       onTap: (){
        //
        //       },
        //       child: Row(
        //         children: [
        //           Text("Add More"),
        //           SizedBox(width: 5,),
        //           addIcon(),
        //         ],
        //       ),
        //     )
        //   ],
        // ),
      ],
    );
  }
}
