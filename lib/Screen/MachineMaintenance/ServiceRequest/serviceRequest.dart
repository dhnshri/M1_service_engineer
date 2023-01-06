import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:service_engineer/Constant/theme_colors.dart';
import 'package:service_engineer/Screen/MachineMaintenance/ServiceRequest/serviceRequestDetails.dart';
import 'package:service_engineer/Screen/MachineMaintenance/ServiceRequest/serviceRequestFilter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

import '../../../Config/font.dart';
import '../../JobWorkEnquiry/Home/ServiceRequest/enquiry_serviceRequestDetails.dart';
import '../../JobWorkEnquiry/Home/ServiceRequest/enquiry_serviceRequestFilter.dart';



class ServiceRequestScreen extends StatefulWidget {
  bool isSwitched;
  ServiceRequestScreen({Key? key,required this.isSwitched}) : super(key: key);

  @override
  _ServiceRequestScreenState createState() => _ServiceRequestScreenState();
}

class _ServiceRequestScreenState extends State<ServiceRequestScreen> {

  final _formKey = GlobalKey<FormState>();
  final _searchController = TextEditingController();



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

  Widget buildCustomerEnquiriesList() {
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
        return  serviceRequestCard();
      },
      itemCount: 20,
    );
  }

  Widget serviceRequestCard()
  {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0.0),
        ),
        // color: Colors.white70,
        elevation: 5,
        child: Row(
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
                      height: 100,
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
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      // width: MediaQuery.of(context).size.width/2.5,
                      child: Text(
                        "Job Title/Services Name or Any Other Name",
                        style: TextStyle(
                            fontFamily: 'Poppins-SemiBold',
                            fontSize: 16,
                            fontWeight: FontWeight.bold
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                    SizedBox(height: 4,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Enquiry ID:",
                          style: TextStyle(
                              fontFamily: 'Poppins-SemiBold',
                              fontSize: 12,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        // SizedBox(
                        //   // width: MediaQuery.of(context).size.width/,
                        // ),
                        Container(
                          // width: MediaQuery.of(context).size.width*0.2,
                          child: Text(
                            "#102GRDSA36987",
                            style: TextStyle(
                              fontFamily: 'Poppins-Regular',
                              fontSize: 12,
                              // fontWeight: FontWeight.bold
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 3,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Timing:",
                          style: TextStyle(
                              fontFamily: 'Poppins-SemiBold',
                              fontSize: 12,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        // SizedBox(
                        //   width: MediaQuery.of(context).size.width/6.3,
                        // ),
                        Container(
                          // width: MediaQuery.of(context).size.width*0.2,
                          child: Text(
                            "10 AM - 6 PM",
                            style: TextStyle(
                              fontFamily: 'Poppins-Regular',
                              fontSize: 12,
                              // fontWeight: FontWeight.bold
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        )
                      ],
                    ),

                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.isSwitched?
      Container(
          child: ListView(
            children: [
              Container(
                decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(width: 0.2,),
                    )
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 10.0, left: 10, right: 10, bottom: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: TextFormField(
                          // initialValue: Application.customerLogin!.name.toString(),
                          controller: _searchController,
                          textAlign: TextAlign.start,
                          keyboardType: TextInputType.text,
                          style: TextStyle(
                            fontSize: 18,
                            height: 1.5,
                          ),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: ThemeColors.bottomNavColor,
                            prefixIcon: Icon(
                              Icons.search,
                              color: ThemeColors.textFieldHintColor,
                            ),
                            hintText: "Search all Orders",
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 15.0),
                            hintStyle: TextStyle(fontSize: 15),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(1.0)),
                              borderSide: BorderSide(
                                  width: 0.8, color: ThemeColors.bottomNavColor),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(1.0)),
                              borderSide: BorderSide(
                                  width: 0.8, color: ThemeColors.bottomNavColor),
                            ),
                            border: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(1.0)),
                                borderSide: BorderSide(
                                    width: 0.8, color: ThemeColors.bottomNavColor)),
                          ),
                          validator: (value) {
                            Pattern pattern =
                                r'^([0][1-9]|[1-2][0-9]|[3][0-7])([a-zA-Z]{5}[0-9]{4}[a-zA-Z]{1}[1-9a-zA-Z]{1}[zZ]{1}[0-9a-zA-Z]{1})+$';
                            RegExp regex = new RegExp(pattern.toString());
                            if (value == null || value.isEmpty) {
                              return 'Please Enter GST Number';
                            } else if (!regex.hasMatch(value)) {
                              return 'Please enter valid GST Number';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            // profile.name = value;
                            setState(() {
                              // _nameController.text = value;
                              if (_formKey.currentState!.validate()) {}
                            });
                          },
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => ServiceRequestFilterScreen()));
                        },
                        child: Row(
                          children: [
                            Icon(Icons.filter_list),
                            SizedBox(
                              width: 5,
                            ),
                            Text("Filter")
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            InkWell(
              onTap: (){
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ServiceRequestDetailsScreen()));
              },
                child: buildCustomerEnquiriesList())
            ],
          ),
        ):Center(
        child: Column(
          mainAxisAlignment:MainAxisAlignment.center,
          children: [
            Text("Nothing to show",
                style: TextStyle(
                    fontFamily: 'Poppins-SemiBold',
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                )),
            SizedBox(height: 5,),
            Text("You are currently",
                style: TextStyle(
                  fontFamily: 'Poppins-SemiBold',
                  fontSize: 16,
                )),
            SizedBox(height: 5,),

            Text("offline",
                style: TextStyle(
                  fontFamily: 'Poppins-SemiBold',
                  fontSize: 16,
                )),
          ],
        ),
      ),

    );
  }
}
