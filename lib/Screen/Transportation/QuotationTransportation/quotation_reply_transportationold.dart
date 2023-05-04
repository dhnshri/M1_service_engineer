import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:service_engineer/Screen/MachineMaintenance/Quotations/quotations_reply_details.dart';
import 'package:service_engineer/Screen/Transportation/QuotationTransportation/quotation_details_transposition.dart';
import 'package:service_engineer/app.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

import '../../../Bloc/home/home_bloc.dart';
import '../../../Bloc/quotationReply/quotationReply_bloc.dart';
import '../../../Bloc/quotationReply/quotationReply_event.dart';
import '../../../Bloc/quotationReply/quotationReply_state.dart';
import '../../../Config/font.dart';
import '../../../Model/Transpotation/quotationReplyModel.dart';
import '../../../Utils/application.dart';
import '../../../Widget/app_button.dart';
import '../../../Widget/custom_snackbar.dart';
import '../../../Widget/function_button.dart';
import '../../bottom_navbar.dart';



class QuotationsReplyTransportationScreen extends StatefulWidget {
  const QuotationsReplyTransportationScreen({Key? key}) : super(key: key);

  @override
  _QuotationsReplyTransportationScreenState createState() => _QuotationsReplyTransportationScreenState();
}

class _QuotationsReplyTransportationScreenState extends State<QuotationsReplyTransportationScreen> {

  final _formKey = GlobalKey<FormState>();
  bool loading = true;
  QuotationReplyBloc? _quotationReplyBloc;
  List<QuotationReplyTransportModel> quotationReplyList=[];
  ScrollController _scrollController = ScrollController();
  int offset = 0;

  bool _isLoading = false;
  bool _loadData= false;
  double? _progressValue;

  @override
  void initState() {
    // TODO: implement initState
    //saveDeviceTokenAndId();
    super.initState();
   _quotationReplyBloc = BlocProvider.of<QuotationReplyBloc>(context);
    getApi();
   // _quotationReplyBloc!.add(OnQuotationReplyTranspotationList(service_user_id: Application.customerLogin!.id.toString(),offSet: '0'));

  }

  getApi(){
    _quotationReplyBloc!.add(OnQuotationReplyTranspotationList(service_user_id: '12',offSet: '0'));
    // _homeBloc!.add(OnMyTaskTranspotationList(userid: Application.customerLogin!.id.toString(), offset: offset.toString(),timeId: timeId.toString()));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // getroleofstudent();
  }

  Widget buildQuotationsaReplyList(List<QuotationReplyTransportModel> quotationReplyList ) {
    return ListView.builder(
      controller: _scrollController
        ..addListener(() {
          if (_scrollController.position.pixels  ==
              _scrollController.position.maxScrollExtent) {
            offset++;
            print("Offser : ${offset}");
            BlocProvider.of<HomeBloc>(context)
              ..isFetching = true
              ..add(getApi());
            // serviceList.addAll(serviceList);
          }
        }),
      shrinkWrap: true,
      physics: ScrollPhysics(),
      scrollDirection: Axis.vertical,
      padding: EdgeInsets.only(top: 10, bottom: 15),
      itemBuilder: (context, index) {
        //return  quotationsReplyCardNew(quotationReplyList[index]);
        return InkWell(
            onTap: (){
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => QuotationForTransportation(quotationReplyList: quotationReplyList[index],)));
            },
            child: quotationsReplyCardNew(quotationReplyList[index]));
      },
      itemCount: quotationReplyList.length,
    );
  }

  Widget quotationsReplyCardNew(QuotationReplyTransportModel quotationReplyData) {
    return Container(
      width: MediaQuery.of(context).size.width ,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0.0),
        ),
        // color: Colors.white70,
        elevation: 5,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: 4,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Enquiry ID:",
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 12,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        // SizedBox(
                        //   width: MediaQuery.of(context).size.width/9,
                        // ),
                        Container(
                          child: Text(
                            quotationReplyData.enquiryId.toString(),
                            style: TextStyle(
                              fontFamily: 'Poppins',
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
                          "Timings:",
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 12,
                              fontWeight: FontWeight.bold
                          ),
                          overflow: TextOverflow.ellipsis,

                        ),
                        // SizedBox(
                        //   width: MediaQuery.of(context).size.width/12.5,
                        // ),
                        Container(
                          child: Text(
                            DateFormat('MM-dd-yyyy h:mm a').format(DateTime.parse(quotationReplyData.dateAndTime.toString())).toString(),
                            style: TextStyle(
                              fontFamily: 'Poppins',
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

  Widget quotationsaReplyCard(QuotationReplyTransportModel quotationReplyData)
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
              Text("Title/Services Name or Any Other Name...",style: serviceRequestHeadingStyle,),
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
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: InkWell(
              onTap: (){
                Navigator.pop(context);
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => BottomNavigation (index:0,dropValue: "Transportation",)));
              },
              child: Icon(Icons.arrow_back_ios)),
          title: Text('Quotation Reply',),
        ),
         body:
         BlocBuilder<QuotationReplyBloc, QuotationReplyState>(builder: (context, state) {
            return BlocListener<QuotationReplyBloc, QuotationReplyState>(
                listener: (context, state) {
                  if(state is QuotationReplyTransportLoading){
                  //  _isLoading = state.isLoading;
                  }
                  if(state is QuotationReplyTransportSuccess){
                    quotationReplyList = state.quotationReplyTransportListData;
                    if(quotationReplyList!=null){
                      _loadData=true;
                    }
                  }
                  if(state is QuotationReplyTransportFail){
                    showCustomSnackBar(context,state.msg.toString());

                  }
                },
                child: _isLoading
                    ? quotationReplyList.length <= 0
                    ? Center(child: Text('No Data'),)
                    : Container(
             child: Padding(
               padding: const EdgeInsets.all(10.0),
               child: Column(
                 children: [
                   Expanded(child: buildQuotationsaReplyList(quotationReplyList)),
                 ],
               ),
             ),
           ) : ShimmerCard()

              // Center(
              //   child: CircularProgressIndicator(),
              // )

            );
          })
      ),
    );
  }
  Widget ShimmerCard(){
    return ListView.builder(
      scrollDirection: Axis.vertical,
      // padding: EdgeInsets.only(left: 5, right: 20, top: 10, bottom: 15),
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Theme.of(context).hoverColor,
          highlightColor: Theme.of(context).highlightColor,
          enabled: true,
          child: Container(
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
                        imageUrl: '',
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
                              '',
                              style: TextStyle(
                                  fontFamily: 'Poppins',
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
                                style: ExpanstionLeftDataStyle,
                              ),
                              // SizedBox(
                              //   // width: MediaQuery.of(context).size.width/,
                              // ),
                              Container(
                                // width: MediaQuery.of(context).size.width*0.2,
                                child: Text(
                                  '',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
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
                                "Working Timing:",
                                style: ExpanstionLeftDataStyle,
                              ),
                              // SizedBox(
                              //   width: MediaQuery.of(context).size.width/6.3,
                              // ),
                              Container(
                                // width: MediaQuery.of(context).size.width*0.2,
                                child: Text(
                                  "10 AM - 6 PM",
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
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
                                "Date & Time:",
                                style: ExpanstionLeftDataStyle,
                              ),
                              // SizedBox(
                              //   width: MediaQuery.of(context).size.width/6.3,
                              // ),
                              Container(
                                // width: MediaQuery.of(context).size.width*0.2,
                                child: Text(
                                  '',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
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
          ),
        );
      },
      itemCount: List.generate(8, (index) => index).length,
    );
  }
}