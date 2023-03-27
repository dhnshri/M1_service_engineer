import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:service_engineer/Bloc/home/home_bloc.dart';
import 'package:service_engineer/Bloc/home/home_event.dart';
import 'package:service_engineer/Constant/theme_colors.dart';
import 'package:service_engineer/Model/service_request_repo.dart';
import 'package:service_engineer/Screen/MachineMaintenance/HandOver%20Task%20List/handover_task_detail.dart';
import 'package:service_engineer/Screen/MachineMaintenance/ServiceRequest/serviceRequestDetails.dart';
import 'package:service_engineer/Screen/MachineMaintenance/ServiceRequest/serviceRequestFilter.dart';
import 'package:service_engineer/Utils/application.dart';
import 'package:service_engineer/Widget/custom_snackbar.dart';
import 'package:shimmer/shimmer.dart';
import '../../../Bloc/home/home_state.dart';


class HandOverTaskList extends StatefulWidget {
  HandOverTaskList({Key? key,}) : super(key: key);

  @override
  _HandOverTaskListState createState() => _HandOverTaskListState();
}

class _HandOverTaskListState extends State<HandOverTaskList> {

  final _formKey = GlobalKey<FormState>();
  final _searchController = TextEditingController();
  bool _isLoading = false;
  bool flagSearchResult=false;
  bool _isSearching=false;
  HomeBloc? _homeBloc;
  List<ServiceRequestModel>? handOverServiceList = [];
  ScrollController _scrollController = ScrollController();
  List<ServiceRequestModel> searchResult=[];
  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  int offset = 0;
  int? timeId=0;
  int? offSet = 0;

  @override
  void initState() {
    // TODO: implement initState
    //saveDeviceTokenAndId();
    super.initState();
    _homeBloc = BlocProvider.of<HomeBloc>(context);
    // _homeBloc!.add(OnServiceRequest(timeId: timeId.toString(),offSet: offSet.toString()));
    _homeBloc!.add(HandOverServiceRequest(timeId: timeId.toString(),offSet: offSet.toString(),serviceUserId: Application.customerLogin!.id.toString()));
    // print("SERVICE USER ID: ${Application.customerLogin!.id.toString()}");
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
      for (int i = 0; i < handOverServiceList!.length; i++) {
        ServiceRequestModel serviceListData = new ServiceRequestModel();
        serviceListData.machineImg = handOverServiceList![i].machineProblemImg.toString();
        serviceListData.machineName = handOverServiceList![i].machineName.toString();
        serviceListData.enquiryId = handOverServiceList![i].enquiryId;
        serviceListData.dateAndTime = handOverServiceList![i].dateAndTime.toString();

        if (serviceListData.machineImg.toString().toLowerCase().contains(searchText.toLowerCase()) ||
            serviceListData.machineName.toString().toLowerCase().contains(searchText.toLowerCase()) ||
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


  Widget buildCustomerEnquiriesList(BuildContext context, List<ServiceRequestModel> serviceList) {
    return ListView.builder(
      controller: _scrollController
        ..addListener(() {
          if (_scrollController.position.pixels  ==
              _scrollController.position.maxScrollExtent) {
            offset++;
            print("Offser : ${offset}");
            BlocProvider.of<HomeBloc>(context)
              ..isFetching = true
              ..add(OnServiceRequest(timeId: timeId.toString(),offSet: offSet.toString()));
            serviceList.addAll(serviceList);

          }
        }),
      shrinkWrap: true,
      physics: ScrollPhysics(),
      scrollDirection: Axis.vertical,
      padding: EdgeInsets.only(top: 10, bottom: 15),
      itemBuilder: (context, index) {
        return  InkWell(
            onTap: (){
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => HandOverTaskDetailScreen(handoverTaskData: serviceList[index],)));
            },
            child: serviceRequestCard(context, serviceList[index]));
      },
      itemCount: serviceList.length,
    );
  }

  Widget serviceRequestCard(BuildContext context, ServiceRequestModel serviceListData)
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
                  imageUrl: serviceListData.machineImg!,
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
                        serviceListData.machineName!,
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
                            serviceListData.enquiryId.toString(),
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

                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     Text(
                    //       "Working Timing:",
                    //       style: TextStyle(
                    //           fontFamily: 'Poppins-SemiBold',
                    //           fontSize: 12,
                    //           fontWeight: FontWeight.bold
                    //       ),
                    //     ),
                    //     // SizedBox(
                    //     //   width: MediaQuery.of(context).size.width/6.3,
                    //     // ),
                    //     Container(
                    //       // width: MediaQuery.of(context).size.width*0.2,
                    //       child: Text(
                    //         "10 AM - 6 PM",
                    //         style: TextStyle(
                    //           fontFamily: 'Poppins-Regular',
                    //           fontSize: 12,
                    //           // fontWeight: FontWeight.bold
                    //         ),
                    //         overflow: TextOverflow.ellipsis,
                    //       ),
                    //     )
                    //   ],
                    // ),
                    SizedBox(height: 3,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Date & Time:",
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
                            // serviceListData.dateAndTime!,
                            DateFormat('MM-dd-yyyy h:mm a').format(DateTime.parse(serviceListData.dateAndTime!.toString())).toString(),
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
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_ios)),
        title: Text(
          'Assign Task List',
        ),
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            return BlocListener<HomeBloc, HomeState>(
                listener: (context, state) {
                  if(state is HandOverServiceRequestLoading){
                    _isLoading = state.isLoading;
                  }
                  if(state is HandOverServiceRequestSuccess){
                    // serviceList = state.serviceListData;
                    // if(serviceList!=null) {
                    handOverServiceList!.addAll(state.serviceListData);
                    // }
                  }
                  if(state is HandOverServiceRequestFail){
                    showCustomSnackBar(context,state.msg.toString());
                  }
                },
                child: _isLoading ? handOverServiceList!.length <= 0 ? Center(child: Text('No Data'),):
                Container(
                  child: Column(
                    children:<Widget> [
                      Container(
                        decoration: const BoxDecoration(
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
                                  style: const TextStyle(
                                    fontSize: 18,
                                    height: 1.5,
                                  ),
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: ThemeColors.bottomNavColor,
                                    prefixIcon: IconButton(
                                      icon: const Icon(
                                        Icons.search,
                                        size: 25.0,
                                        color: ThemeColors.blackColor,
                                      ),
                                      onPressed: () {
                                        _handleSearchStart();
                                      },
                                    ),
                                    hintText: "Search all Orders",
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 10.0, horizontal: 15.0),
                                    hintStyle: const TextStyle(fontSize: 15),
                                    enabledBorder: const OutlineInputBorder(
                                      borderRadius:BorderRadius.all(Radius.circular(1.0)),
                                      borderSide: BorderSide(
                                          width: 0.8, color: ThemeColors.bottomNavColor),
                                    ),
                                    focusedBorder:const OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(1.0)),
                                      borderSide: BorderSide(
                                          width: 0.8, color: ThemeColors.bottomNavColor),
                                    ),
                                    border:const OutlineInputBorder(
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(1.0)),
                                        borderSide: BorderSide(
                                            width: 0.8, color: ThemeColors.bottomNavColor)),
                                  ),
                                  validator: (value) {

                                  },
                                  onChanged: (value) {
                                    // profile.name = value;
                                    searchOperation(value);
                                  },
                                ),
                              ),
                              InkWell(
                                onTap: () async {
                                  var filterResult = await Navigator.push(context,
                                      MaterialPageRoute(builder: (context) => ServiceRequestFilterScreen()));

                                  if(filterResult != null){
                                    print(filterResult);
                                    handOverServiceList = filterResult['serviceList'];
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
                      // _isLoading ?
                      flagSearchResult == false? (searchResult.length != 0 || _searchController.text.isNotEmpty) ?
                      buildCustomerEnquiriesList(context, searchResult)
                          :
                      Expanded(child: buildCustomerEnquiriesList(context, handOverServiceList!))
                          : Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: const Center(child: Text("No Data"),),
                      )
                      // : ShimmerCard()
                      // : CircularProgressIndicator()
                    ],
                  ),
                ) : ShimmerCard()

              // Center(
              //   child: CircularProgressIndicator(),
              // )

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
                                  '',
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
                                "Working Timing:",
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
                          SizedBox(height: 3,),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Date & Time:",
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
                                  '',
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
          ),
        );
      },
      itemCount: List.generate(8, (index) => index).length,
    );
  }

}
