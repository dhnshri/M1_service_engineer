import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:service_engineer/Constant/theme_colors.dart';
import 'package:service_engineer/Model/JobWorkEnquiry/my_task_model.dart';
import 'package:service_engineer/Screen/JobWorkEnquiry/HandOver%20Task%20List/handover_task_list.dart';
import 'package:service_engineer/Screen/JobWorkEnquiry/Home/ServiceRequest/enquiry_serviceRequestDetails.dart';
import 'package:service_engineer/Screen/JobWorkEnquiry/Home/ServiceRequest/enquiry_serviceRequestFilter.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../Bloc/home/home_bloc.dart';
import '../../../../Bloc/home/home_event.dart';
import '../../../../Bloc/home/home_state.dart';
import '../../../../Model/JobWorkEnquiry/service_request_model.dart';
import '../../../../Utils/application.dart';
import '../../../../Widget/custom_snackbar.dart';

class EnquiryServiceRequestScreen extends StatefulWidget {
  EnquiryServiceRequestScreen({Key? key,required this.isSwitched}) : super(key: key);
  bool isSwitched;

  @override
  _EnquiryServiceRequestScreenState createState() =>
      _EnquiryServiceRequestScreenState();
}

class _EnquiryServiceRequestScreenState
    extends State<EnquiryServiceRequestScreen> {
  final _formKey = GlobalKey<FormState>();
  final _searchController = TextEditingController();
  bool _isLoading = false;
  HomeBloc? _homeBloc;
  List<JobWorkEnquiryServiceRequestModel> serviceJobWorkEnquiryList = [];
  bool flagSearchResult=false;
  bool _isSearching=false;
  List<JobWorkEnquiryServiceRequestModel> searchResult=[];
  List<JobWorkEnquiryMyTaskModel>? handOverServiceList = [];
  ScrollController _scrollController = ScrollController();
  int offset = 0;
  int handoverOffset = 0;
  int? timeId=0;
  bool _loadData=false;

  @override
  void initState() {
    // TODO: implement initState
    //saveDeviceTokenAndId();
    super.initState();
    _homeBloc = BlocProvider.of<HomeBloc>(context);
    getApi();
    _homeBloc!.add(JobWorkHandOverServiceRequestList(timeId: '0',offSet: '0',serviceUserId: Application.customerLogin!.id.toString()));
  }

  getApi(){
    _homeBloc!.add(OnServiceRequestJWEList(offSet:'$offset',timePeriod: '$timeId'));
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
      for (int i = 0; i < serviceJobWorkEnquiryList.length; i++) {
        JobWorkEnquiryServiceRequestModel serviceListData = new JobWorkEnquiryServiceRequestModel();
        serviceListData.itemName = serviceJobWorkEnquiryList[i].itemName.toString();
        serviceListData.enquiryId = serviceJobWorkEnquiryList[i].enquiryId;
        serviceListData.dateAndTime = serviceJobWorkEnquiryList[i].dateAndTime;

        if (serviceListData.itemName.toString().toLowerCase().contains(searchText.toLowerCase()) ||
            serviceListData.enquiryId.toString().toLowerCase().contains(searchText.toLowerCase()) ||
            serviceListData.dateAndTime.toString().toLowerCase().contains(searchText.toLowerCase()) ) {
          flagSearchResult=false;
          searchResult.add(serviceListData);
        }
      }
      setState(() {
        if(searchResult.length==0){
          flagSearchResult=true;
        }
      });
    }
  }

  Widget buildJobWorkEnquiriesList(List<JobWorkEnquiryServiceRequestModel> jobWorkEnquiryList) {
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
      physics: NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      padding: EdgeInsets.only(top: 10, bottom: 15),
      itemBuilder: (context, index) {
        return InkWell(
            onTap: (){
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => EnquiryServiceRequestDetailsScreen(serviceRequestData:jobWorkEnquiryList[index],)));
            },
            child: serviceRequestCard(context, jobWorkEnquiryList[index]));
      },
      itemCount: jobWorkEnquiryList.length,
    );
  }

  Widget serviceRequestCard(BuildContext context,JobWorkEnquiryServiceRequestModel serviceRequestData) {
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
                    // Container(
                    //   width: MediaQuery.of(context).size.width/1.8,
                    //   child: Text(
                    //     serviceRequestData.itemName.toString(),
                    //     style: TextStyle(
                    //       fontFamily: 'Poppins',
                    //       fontSize: 16,
                    //       fontWeight: FontWeight.bold
                    //     ),
                    //     overflow: TextOverflow.ellipsis,
                    //     maxLines: 2,
                    //   ),
                    // ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Item name:",
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
                            serviceRequestData.itemName.toString(),
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
                            serviceRequestData.enquiryId.toString(),
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
                            DateFormat('MM-dd-yyyy h:mm a').format(DateTime.parse(serviceRequestData.dateAndTime.toString())).toString(),
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
    return Scaffold(
        body:BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
          return BlocListener<HomeBloc, HomeState>(
              listener: (context, state) {
                if(state is ServiceRequestJWELoading){
                  _isLoading = state.isLoading;
                }
                if(state is ServiceRequestJWESuccess){
                  // serviceJobWorkEnquiryList  = state.serviceListData;
                  serviceJobWorkEnquiryList.addAll(state.serviceListData);
                  if(serviceJobWorkEnquiryList!=null){
                    _loadData=true;
                  }
                }
                if(state is ServiceRequestJWEFail){
                  showCustomSnackBar(context,state.msg.toString());
                }
                if(state is JobWorkHandOverServiceRequestListLoading){
                  _isLoading = state.isLoading;
                }
                if(state is JobWorkHandOverServiceRequestListSuccess){
                  handOverServiceList = state.serviceListData;
                }
                if(state is JobWorkHandOverServiceRequestListFail){
                  showCustomSnackBar(context,state.msg.toString());
                }
              },
              child: widget.isSwitched
                  ?  _loadData ? serviceJobWorkEnquiryList.length <= 0 ? Center(child: Text('No Data'),):
              Column(
                  children: [
                    const SizedBox(height: 5,),
                    handOverServiceList!.length > 0 ?
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: ThemeColors.imageContainerBG
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(right:16.0,left: 16.0,bottom: 8.0,top: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                // width:200,
                                child: const Text("Task Assigned By Other Service Providers",
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    style: TextStyle(
                                      // color: ThemeColors.buttonColor,
                                        fontFamily: 'Poppins',
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600
                                    )),
                              ),
                              InkWell(
                                onTap: () async {
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>
                                      JobWorkHandOverTaskList()));
                                },
                                child: Container(
                                  child: Text('View',
                                      style: TextStyle(
                                          color: ThemeColors.buttonColor,
                                          fontFamily: 'Poppins',
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500
                                      )),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ): Container(),
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
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 15.0),
                                  hintStyle: TextStyle(fontSize: 15),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(1.0)),
                                    borderSide: BorderSide(
                                        width: 0.8, color: ThemeColors.bottomNavColor),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(1.0)),
                                    borderSide: BorderSide(
                                        width: 0.8, color: ThemeColors.bottomNavColor),
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(1.0)),
                                      borderSide: BorderSide(
                                          width: 0.8,
                                          color: ThemeColors.bottomNavColor)),
                                ),
                                validator: (value) {
                                  return null;
                                },
                                onChanged: (value) {
                                  searchOperation(value);
                                },
                              ),
                            ),
                            InkWell(
                              onTap: () async {
                                var searchResult = await Navigator.push(context,
                                    MaterialPageRoute(builder: (context) =>
                                        EnquiryServiceRequestFilterScreen()));

                                if(searchResult != null){
                                  serviceJobWorkEnquiryList = searchResult['serviceList'];
                                  timeId = searchResult['time_period'];
                                }
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
                    SingleChildScrollView(child:
                      Container(child:
                      flagSearchResult == false? (searchResult.length != 0 || _searchController.text.isNotEmpty) ?
                      Expanded(child:buildJobWorkEnquiriesList(searchResult)) :
                      Expanded(child:buildJobWorkEnquiriesList(serviceJobWorkEnquiryList)): Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: const Center(child: Text("No Data"),),
                      ))),
                  ],
                )
              : ShimmerCard(): Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Nothing to show",
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                    SizedBox(
                      height: 5,
                    ),
                    Text("You are currently",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 16,
                        )),
                    SizedBox(
                      height: 5,
                    ),
                    Text("offline",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 16,
                        )),
                  ],
                ),
              ),
          );
        })
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
              child:Row(
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
                            width: MediaQuery.of(context).size.width/1.8,
                            child: Text(
                              "Item Name",
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
                                  "Enquiry Id",
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
                                "Item:",
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              // SizedBox(
                              //   width: MediaQuery.of(context).size.width/5.3,
                              // ),
                              Container(
                                child: Text(
                                  "Steal Plates",
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
                                  "dateAndTime",
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
