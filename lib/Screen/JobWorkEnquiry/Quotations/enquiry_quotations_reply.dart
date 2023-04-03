import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:service_engineer/Screen/JobWorkEnquiry/Quotations/enquiry_quotations_reply_details.dart';
import 'package:service_engineer/Screen/MachineMaintenance/Quotations/quotations_reply_details.dart';
import 'package:service_engineer/app.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

import '../../../Bloc/quotationReply/quotationReply_bloc.dart';
import '../../../Bloc/quotationReply/quotationReply_event.dart';
import '../../../Bloc/quotationReply/quotationReply_state.dart';
import '../../../Config/font.dart';
import '../../../Constant/theme_colors.dart';
import '../../../Model/JobWorkEnquiry/quotation_reply.dart';
import '../../../Utils/application.dart';
import '../../../Widget/app_button.dart';
import '../../../Widget/custom_snackbar.dart';
import '../../../Widget/function_button.dart';

class EnquiryQuotationsReplyScreen extends StatefulWidget {
  const EnquiryQuotationsReplyScreen({Key? key}) : super(key: key);

  @override
  _EnquiryQuotationsReplyScreenState createState() =>
      _EnquiryQuotationsReplyScreenState();
}

class _EnquiryQuotationsReplyScreenState
    extends State<EnquiryQuotationsReplyScreen> {
  final _formKey = GlobalKey<FormState>();
  bool loading = true;
  QuotationReplyBloc? _quotationReplyBloc;
  List<QuotationReplyJobWorkEnquiryModel> quotationReplyJobWorkEnquiryList = [];
  final _searchController = TextEditingController();
  double? _progressValue;
  bool _isLoading = false;
  bool flagSearchResult = false;
  bool _isSearching = false;
  List<QuotationReplyJobWorkEnquiryModel> searchResult = [];
  int offset = 0;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    //saveDeviceTokenAndId();
    super.initState();
    _progressValue = 0.5;
    _quotationReplyBloc = BlocProvider.of<QuotationReplyBloc>(context);
    getApi();
  }

  getApi() {
    _quotationReplyBloc!.add(OnQuotationReplyJWEList(
        offSet: offset.toString(),
        userId: Application.customerLogin!.id.toString(),
        timeId: '0'));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // getroleofstudent();
  }

  void _handleSearchStart() {
    setState(() {
      _isSearching = true;
    });
  }

  void searchOperation(String searchText) {
    searchResult.clear();
    if (_isSearching != null) {
      for (int i = 0; i < quotationReplyJobWorkEnquiryList.length; i++) {
        QuotationReplyJobWorkEnquiryModel quotationListData =
            new QuotationReplyJobWorkEnquiryModel();
        quotationListData.id = quotationReplyJobWorkEnquiryList[i].id;
        quotationListData.dateAndTime =
            quotationReplyJobWorkEnquiryList[i].dateAndTime.toString();
        quotationListData.enquiryId =
            quotationReplyJobWorkEnquiryList[i].enquiryId;
        quotationListData.userId = quotationReplyJobWorkEnquiryList[i].userId;

        if (quotationListData.id
                .toString()
                .toLowerCase()
                .contains(searchText.toLowerCase()) ||
            quotationListData.dateAndTime
                .toString()
                .toLowerCase()
                .contains(searchText.toLowerCase()) ||
            quotationListData.enquiryId
                .toString()
                .toLowerCase()
                .contains(searchText.toLowerCase()) ||
            quotationListData.userId
                .toString()
                .toLowerCase()
                .contains(searchText.toLowerCase())) {
          flagSearchResult = false;
          searchResult.add(quotationListData);
        }
      }
      setState(() {
        if (searchResult.length == 0) {
          flagSearchResult = true;
        }
      });
    }
  }

  Widget buildQuotationsaReplyList(
      List<QuotationReplyJobWorkEnquiryModel>
          quotationReplyJobWorkEnquiryList) {
    return ListView.builder(
      controller: _scrollController
        ..addListener(() {
          if (_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent) {
            offset++;
            print("Offser : ${offset}");
            BlocProvider.of<QuotationReplyBloc>(context).add(getApi());
            // serviceList.addAll(serviceList);
          }
        }),
      shrinkWrap: true,
      physics: ScrollPhysics(),
      scrollDirection: Axis.vertical,
      padding: EdgeInsets.only(top: 10, bottom: 15),
      itemBuilder: (context, index) {
        return InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => EnquiryQuotationsReplyDetailsScreen(
                            quotationReplyJobWorkEnquiryList:
                                quotationReplyJobWorkEnquiryList[index],
                          )));
            },
            child: quotationsaReplyCard(
                context, quotationReplyJobWorkEnquiryList[index]));
      },
      itemCount: quotationReplyJobWorkEnquiryList.length,
    );
  }

  Widget quotationsaReplyCard(BuildContext context,
      QuotationReplyJobWorkEnquiryModel quotationReplyJobWorkEnquiryData) {
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
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Enquiry ID:",
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 12,
                              fontWeight: FontWeight.bold),
                        ),
                        // SizedBox(
                        //   width: MediaQuery.of(context).size.width/9,
                        // ),
                        Container(
                          child: Text(
                            quotationReplyJobWorkEnquiryData.enquiryId
                                .toString(),
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
                    SizedBox(
                      height: 3,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Date and Time:",
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 12,
                              fontWeight: FontWeight.bold),
                        ),
                        // SizedBox(
                        //   width: MediaQuery.of(context).size.width/5.3,
                        // ),
                        Container(
                          child: Text(
                            DateFormat('MM-dd-yyyy h:mm a')
                                .format(DateTime.parse(
                                    quotationReplyJobWorkEnquiryData.dateAndTime
                                        .toString()))
                                .toString(),
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            leading: InkWell(
                onTap: () {
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (context) => BottomNavigation (index:0,dropValue: "Machine Maintenance",)));
                },
                child: Icon(Icons.arrow_back_ios)),
            title: Text(
              'Quotation Reply',
            ),
          ),
          body: BlocBuilder<QuotationReplyBloc, QuotationReplyState>(
              builder: (context, state) {
            return BlocListener<QuotationReplyBloc, QuotationReplyState>(
                listener: (context, state) {
                  if (state is QuotationReplyJWELoading) {
                    _isLoading = state.isLoading;
                  }
                  if (state is QuotationReplyJWESuccess) {
                    quotationReplyJobWorkEnquiryList =
                        state.quotationReplyJWEListData;
                  }
                  if (state is QuotationReplyJWEFail) {
                    showCustomSnackBar(context, state.msg.toString());
                  }
                },
                child: _isLoading
                    ? quotationReplyJobWorkEnquiryList.length <= 0
                        ? Center(
                            child: Text('No Data'),
                          )
                        : Container(
                            child: Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      border: Border(
                                    bottom: BorderSide(
                                      width: 0.2,
                                    ),
                                  )),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10.0,
                                        left: 10,
                                        right: 10,
                                        bottom: 5),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
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
                                              fillColor:
                                                  ThemeColors.bottomNavColor,
                                              prefixIcon: IconButton(
                                                icon: Icon(
                                                  Icons.search,
                                                  size: 25.0,
                                                  color: ThemeColors.blackColor,
                                                ),
                                                onPressed: () {
                                                  _handleSearchStart();
                                                },
                                              ),
                                              hintText: "Search all Orders",
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      vertical: 10.0,
                                                      horizontal: 15.0),
                                              hintStyle:
                                                  TextStyle(fontSize: 15),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(1.0)),
                                                borderSide: BorderSide(
                                                    width: 0.8,
                                                    color: ThemeColors
                                                        .bottomNavColor),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(1.0)),
                                                borderSide: BorderSide(
                                                    width: 0.8,
                                                    color: ThemeColors
                                                        .bottomNavColor),
                                              ),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(1.0)),
                                                  borderSide: BorderSide(
                                                      width: 0.8,
                                                      color: ThemeColors
                                                          .bottomNavColor)),
                                            ),
                                            validator: (value) {},
                                            onChanged: (value) {
                                              searchOperation(value);
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                flagSearchResult == false
                                    ? (searchResult.length != 0 ||
                                            _searchController.text.isNotEmpty)
                                        ? Expanded(
                                            child: buildQuotationsaReplyList(
                                                searchResult),
                                          )
                                        : Expanded(
                                            child: buildQuotationsaReplyList(
                                                quotationReplyJobWorkEnquiryList),
                                          )
                                    : Padding(
                                        padding:
                                            const EdgeInsets.only(top: 20.0),
                                        child: const Center(
                                          child: Text("No Data"),
                                        ),
                                      ),
                              ],
                            ),
                          )
                    : ShimmerCard()

                // Center(
                //   child: CircularProgressIndicator(),
                // )

                );
          })),
    );
  }

  Widget ShimmerCard() {
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
                                  fontWeight: FontWeight.bold),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Enquiry ID:",
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold),
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
                          SizedBox(
                            height: 3,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Working Timing:",
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold),
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
                          SizedBox(
                            height: 3,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Date & Time:",
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold),
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
