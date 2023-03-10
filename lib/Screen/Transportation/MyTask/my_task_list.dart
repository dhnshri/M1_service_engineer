import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:service_engineer/Constant/theme_colors.dart';
import 'package:service_engineer/Screen/MachineMaintenance/ServiceRequest/serviceRequestDetails.dart';
import 'package:service_engineer/Screen/MachineMaintenance/ServiceRequest/serviceRequestFilter.dart';
import 'package:service_engineer/Screen/Transportation/MyTask/transportation_filter_my_task.dart';
import 'package:service_engineer/Screen/Transportation/ServiceRequest/transportation_service_request_details.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

import '../../../Bloc/home/home_bloc.dart';
import '../../../Bloc/home/home_event.dart';
import '../../../Bloc/home/home_state.dart';
import '../../../Config/font.dart';
import '../../../Model/Transpotation/myTaskListModel.dart';
import '../../../Utils/application.dart';
import '../../../Widget/custom_snackbar.dart';
import '../../JobWorkEnquiry/Home/ServiceRequest/enquiry_serviceRequestDetails.dart';
import '../../JobWorkEnquiry/Home/ServiceRequest/enquiry_serviceRequestFilter.dart';
import 'my_task_details.dart';



class TransportationMyTaskScreen extends StatefulWidget {
  const TransportationMyTaskScreen({Key? key}) : super(key: key);

  @override
  _TransportationMyTaskScreenState createState() => _TransportationMyTaskScreenState();
}

class _TransportationMyTaskScreenState extends State<TransportationMyTaskScreen> {

  final _formKey = GlobalKey<FormState>();
  final _searchController = TextEditingController();
  HomeBloc? _homeBloc;
  List<MyTaskTransportationModel> myTaskList=[];

  bool _isLoading = false;
  double? _progressValue;



  @override
  void initState() {
    // TODO: implement initState
    //saveDeviceTokenAndId();
    super.initState();
    _progressValue = 0.5;
    _homeBloc = BlocProvider.of<HomeBloc>(context);
    _homeBloc!.add(OnMyTaskTranspotationList(userid: Application.customerLogin!.id.toString(), offset: '0'));

  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // getroleofstudent();
  }

  Widget buildTransportationMyTaskList(List<MyTaskTransportationModel> myTaskList) {

    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      padding: EdgeInsets.only(top: 10, bottom: 15),
      itemBuilder: (context, index) {
        return  myTaskCardNew(context,myTaskList[index]);
      },
      itemCount: myTaskList.length,
    );
  }

  Widget myTaskCard(BuildContext context,MyTaskTransportationModel myTaskData)
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
                  Text(myTaskData.enquiryId.toString(),style: serviceRequestSubHeadingStyle.copyWith(fontWeight: FontWeight.normal),)
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Date & Time:",style: serviceRequestSubHeadingStyle,),
                  Text(myTaskData.dateAndTime.toString(),style: serviceRequestSubHeadingStyle.copyWith(fontWeight: FontWeight.normal),)
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Applicants:",style: serviceRequestSubHeadingStyle,),
                  Text("2",style: serviceRequestSubHeadingStyle.copyWith(fontWeight: FontWeight.normal),)
                ],
              ),
            ],
          ),

        ),
      ),
    );
  }

  Widget myTaskCardNew(BuildContext context,MyTaskTransportationModel myTaskData) {
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
                        "Job Title/Services Name or Any Other Name...",
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
                        //   width: MediaQuery.of(context).size.width/9,
                        // ),
                        Container(
                          child: Text(
                            myTaskData.enquiryId.toString(),
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
                          "Task Status:",
                          style: TextStyle(
                              fontFamily: 'Poppins-SemiBold',
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
                            "Step 1 ( Lorem Ipsum)",
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
      // body:Container(
      //   child: ListView(
      //     children: [
      //       Container(
      //         decoration: BoxDecoration(
      //             border: Border(
      //               bottom: BorderSide(width: 0.2,),
      //             )
      //         ),
      //         child: Padding(
      //           padding: const EdgeInsets.only(
      //               top: 15.0, left: 10, right: 10, bottom: 5),
      //           child: Row(
      //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //             children: [
      //
      //               Expanded(
      //                 child: TextFormField(
      //                   // initialValue: Application.customerLogin!.name.toString(),
      //                   controller: _searchController,
      //                   textAlign: TextAlign.start,
      //                   keyboardType: TextInputType.text,
      //                   style: TextStyle(
      //                     fontSize: 18,
      //                     height: 1.5,
      //                   ),
      //                   decoration: InputDecoration(
      //                     filled: true,
      //                     fillColor: ThemeColors.bottomNavColor,
      //                     prefixIcon: Icon(Icons.search,color: ThemeColors.textFieldHintColor,),
      //                     hintText: "Search all Orders",
      //                     contentPadding: EdgeInsets.symmetric(
      //                         vertical: 10.0, horizontal: 15.0),
      //                     hintStyle: TextStyle(fontSize: 15),
      //                     enabledBorder: OutlineInputBorder(
      //                       borderRadius:
      //                       BorderRadius.all(Radius.circular(1.0)),
      //                       borderSide: BorderSide(
      //                           width: 0.8,
      //                           color: ThemeColors.bottomNavColor
      //                       ),
      //                     ),
      //                     focusedBorder: OutlineInputBorder(
      //                       borderRadius:
      //                       BorderRadius.all(Radius.circular(1.0)),
      //                       borderSide: BorderSide(
      //                           width: 0.8,
      //                           color: ThemeColors.bottomNavColor),
      //                     ),
      //                     border: OutlineInputBorder(
      //                         borderRadius:
      //                         BorderRadius.all(Radius.circular(1.0)),
      //                         borderSide: BorderSide(
      //                             width: 0.8,
      //                             color: ThemeColors.bottomNavColor)),
      //                   ),
      //                   validator: (value) {
      //                     Pattern pattern = r'^([0][1-9]|[1-2][0-9]|[3][0-7])([a-zA-Z]{5}[0-9]{4}[a-zA-Z]{1}[1-9a-zA-Z]{1}[zZ]{1}[0-9a-zA-Z]{1})+$';
      //                     RegExp regex = new RegExp(pattern.toString());
      //                     if (value == null || value.isEmpty) {
      //                       return 'Please Enter GST Number';
      //                     }else if(!regex.hasMatch(value)){
      //                       return 'Please enter valid GST Number';
      //                     }
      //                     return null;
      //                   },
      //                   onChanged: (value) {
      //                     // profile.name = value;
      //                     setState(() {
      //                       // _nameController.text = value;
      //                       if (_formKey.currentState!.validate()) {}
      //                     });
      //                   },
      //                 ),
      //               ),
      //               InkWell(
      //                 onTap: () {
      //                   Navigator.push(
      //                       context,
      //                       MaterialPageRoute(
      //                           builder: (context) =>
      //                               MyTaskTransportationFilterScreen()));
      //                 },
      //                 child: Row(
      //                   children: [
      //                     Icon(Icons.filter_list),
      //                     SizedBox(
      //                       width: 5,
      //                     ),
      //                     Text("Filter")
      //                   ],
      //                 ),
      //               )
      //             ],
      //           ),
      //         ),
      //       ),
      //
      //       InkWell(
      //           onTap: (){
      //             Navigator.push(context,
      //                 MaterialPageRoute(builder: (context) => TransportationMyTaskDetailsScreen()));
      //           },
      //           child: buildTransportationMyTaskList()),
      //     ],
      //   ),
      // ),
        body:BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
          return BlocListener<HomeBloc, HomeState>(
              listener: (context, state) {
                if(state is MyTaskTranspotationLoading){
                  _isLoading = state.isLoading;
                }
                if(state is MyTaskTranspotationListSuccess){
                  myTaskList = state.MyTaskList;
                }
                if(state is MyTaskTranspotationListLoadFail){
                  showCustomSnackBar(context,state.msg.toString());
                }
              },
              child: _isLoading ? myTaskList.length <= 0 ? Center(child: Text('No Data'),):
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
                                    MaterialPageRoute(builder: (context) =>
                                        MyTaskTransportationFilterScreen()));

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
                    SingleChildScrollView(child: Container(child: buildTransportationMyTaskList(myTaskList))),
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
