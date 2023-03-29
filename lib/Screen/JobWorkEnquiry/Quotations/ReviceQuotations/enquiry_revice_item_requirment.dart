import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../Config/font.dart';
import '../../../../Constant/theme_colors.dart';
import '../../../../Widget/common.dart';




class ReviceItemRequired extends StatefulWidget {
  const ReviceItemRequired({Key? key}) : super(key: key);

  @override
  State<ReviceItemRequired> createState() => ReviceItemRequiredState();
}

class ReviceItemRequiredState extends State<ReviceItemRequired> {
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



  final _formKey = GlobalKey<FormState>();

  Widget builditemRequredCardList() {

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
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => ItemRequiredFilterScreen()));
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
        SizedBox(height: 10,),
        Align(
            alignment: Alignment.topLeft,
            child: Text("Items not available on app",style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins'
            ),)),
        SizedBox(height: 5,),
        Card(
          elevation: 1,
          child: Padding(
            padding: const EdgeInsets.only(right: 8.0,left: 8.0,top: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("01:"),
                SizedBox(height: 5,),
                SizedBox(
                  width:
                  MediaQuery.of(context).size.width * 0.8,
                  height: 40,
                  child: TextFormField(
                    controller: _itemNameController,
                    keyboardType: TextInputType.number,
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
                      fillColor: Color(0xffF5F5F5),
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
                      hintText: 'Item name',
                      contentPadding: const EdgeInsets.fromLTRB(
                          20.0, 20.0, 0.0, 0.0),
                      hintStyle: GoogleFonts.poppins(
                          color: Colors.grey,
                          fontSize: 12.0,
                          fontWeight: FontWeight.w500),
                    ),
                    onChanged: (val) {
                      setState(() {
                        phoneNum = val;
                        // _phoneNumberController.text = val;
                      });
                    },
                  ),
                ),
                SizedBox(height: 5,),
                SizedBox(
                  width:
                  MediaQuery.of(context).size.width * 0.8,
                  height: 40,
                  child: TextFormField(
                    controller: _itemPriceController,
                    keyboardType: TextInputType.number,
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
                      fillColor: Color(0xffF5F5F5),
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
                      hintText: '₹2,000',
                      contentPadding: const EdgeInsets.fromLTRB(
                          20.0, 20.0, 0.0, 0.0),
                      hintStyle: GoogleFonts.poppins(
                          color: Colors.grey,
                          fontSize: 12.0,
                          fontWeight: FontWeight.w500),
                    ),
                    onChanged: (val) {
                      setState(() {
                        phoneNum = val;
                        // _phoneNumberController.text = val;
                      });
                    },
                  ),
                ),
                SizedBox(height: 5,),
              ],
            ),
          ),
        ),
        SizedBox(height: 7,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(),
            InkWell(
              onTap: (){

              },
              child: Row(
                children: [
                  Text("Add More"),
                  SizedBox(width: 5,),
                  addIcon(),
                ],
              ),
            )
          ],
        ),
      ],
    );
  }
}
