import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:service_engineer/Screen/MachineMaintenance/Quotations/quotations_reply_details.dart';
import 'package:service_engineer/app.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

import '../../../Config/font.dart';
import '../../../Widget/app_button.dart';
import '../../../Widget/function_button.dart';
import '../../bottom_navbar.dart';



class QuotationsReplyScreen extends StatefulWidget {
  const QuotationsReplyScreen({Key? key}) : super(key: key);

  @override
  _QuotationsReplyScreenState createState() => _QuotationsReplyScreenState();
}

class _QuotationsReplyScreenState extends State<QuotationsReplyScreen> {

  final _formKey = GlobalKey<FormState>();
  bool loading = true;

  Widget buildQuotationsaReplyList() {
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
        return  quotationsaReplyCard();
      },
      itemCount: 20,
    );
  }

  Widget quotationsaReplyCard()
  {
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
              Text("Job Title/Services Name or Any Other Name...",style: serviceRequestHeadingStyle,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Enquiry ID:",style: serviceRequestSubHeadingStyle,),
                  Text("#102GRDSA36987",style: serviceRequestSubHeadingStyle.copyWith(fontWeight: FontWeight.normal),)
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Timings:",style: serviceRequestSubHeadingStyle,),
                  Text("10AM - 6PM",style: serviceRequestSubHeadingStyle.copyWith(fontWeight: FontWeight.normal),)
                ],
              ),
            ],
          ),

        ),
      ),
    );
  }


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
  }



  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: InkWell(
              onTap: (){
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => BottomNavigation (index:0,dropValue: "Machine Maintenance",)));
              },
              child: Icon(Icons.arrow_back_ios)),
          title: Text('Quotation Reply',style:appBarheadingStyle ,),
        ),

        body:Container(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListView(
              children: [
                InkWell(
                    onTap: (){
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => QuotationsReplyDetailsScreen()));
                    },
                    child: buildQuotationsaReplyList()),
              ],
            ),
          ),
        ),

      ),
    );
  }
}
