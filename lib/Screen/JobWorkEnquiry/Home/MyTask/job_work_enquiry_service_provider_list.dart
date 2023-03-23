import 'dart:async';
import 'dart:math' as math;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart';
import 'package:service_engineer/Bloc/home/home_bloc.dart';
import 'package:service_engineer/Bloc/home/home_event.dart';
import 'package:service_engineer/Bloc/home/home_state.dart';
import 'package:service_engineer/Constant/theme_colors.dart';
import 'package:service_engineer/Model/MachineMaintance/myTaskModel.dart';
import 'package:service_engineer/Model/service_request_detail_repo.dart';
import 'package:service_engineer/Model/service_request_repo.dart';
import 'package:service_engineer/Model/track_process_repo.dart';
import 'package:service_engineer/Screen/MachineMaintenance/MyTask/process_detail.dart';
import 'package:service_engineer/Screen/MachineMaintenance/MyTask/service_provider_profile.dart';
import 'package:service_engineer/Utils/application.dart';
import 'package:service_engineer/Widget/image_view_screen.dart';
import 'package:service_engineer/Widget/pdfViewer.dart';
import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';
import 'package:flutter/foundation.dart';
import '../../../../Config/font.dart';
import '../../../../Model/JobWorkEnquiry/task_hand_over_jwe_model.dart';
import '../../../../Widget/custom_snackbar.dart';
import '../../../Chat/chat_listing.dart';
import 'add_task.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';



class JobWorkEnquiryServiceProviderListScreen extends StatefulWidget {

  JobWorkEnquiryServiceProviderListScreen({Key? key}) : super(key: key);

  @override
  _JobWorkEnquiryServiceProviderListScreenState createState() => _JobWorkEnquiryServiceProviderListScreenState();
}

class _JobWorkEnquiryServiceProviderListScreenState extends State<JobWorkEnquiryServiceProviderListScreen> {
  final TextEditingController _phoneNumberController = TextEditingController();
  String? role;
  bool loading = true;
  bool _isLoading = false;

  HomeBloc? _homeBloc;
  List<JobWorkEnquiryTaskHandOverModel>? serviceList = [];


  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ExpansionTileCardState> cardA = new GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardB = new GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardC = new GlobalKey();
  String? url =
      "http://www.africau.edu/images/default/sample.pdf";

  final Set<Marker> _markers = {};
  late LatLng _lastMapPosition;
  double? addressLat;
  double? addressLong;
  Completer<GoogleMapController> controller1 = Completer();

  List<TrackProcessModel>? trackProgressData = [];

  _onCameraMove(CameraPosition position) {
    _lastMapPosition = position.target;
  }

  _onMapCreated(GoogleMapController controller) {
    setState(() {
      controller1.complete(controller);
    });
  }

  MapType _currentMapType = MapType.normal;


  @override
  void initState() {
    // TODO: implement initState
    //saveDeviceTokenAndId();
    super.initState();
    _homeBloc = BlocProvider.of<HomeBloc>(this.context);
    // _homeBloc!.add(OnServiceRequestDetail(userID: Application.customerLogin!.id.toString(), machineServiceId: widget.myTaskData.enquiryId.toString(),jobWorkServiceId: '0',transportServiceId: '0'));
    // _homeBloc!.add(OnServiceRequestDetail(userID: '6', machineServiceId: widget.myTaskData.enquiryId.toString(),jobWorkServiceId: '0',transportServiceId: '0'));
    _homeBloc!.add(TrackProcessList(userId: '1',machineEnquiryId: '0',transportEnquiryId: '0',jobWorkEnquiryId: '1'));
    _homeBloc!.add(OnJobWorkEnquiryTaskHandOver(userID: '2', offSet: '0'));
    _phoneNumberController.clear();
    addressLat = double.parse(21.1458.toString());
    addressLong = double.parse(79.0882.toString());
    _lastMapPosition = LatLng(addressLat!, addressLong!);

    _markers.add(Marker(
        markerId: MarkerId(151.toString()),
        position: _lastMapPosition,
        infoWindow: InfoWindow(
            title: "You are here",
            snippet: "This is a current location snippet",
            onTap: () {}),
        onTap: () {},
        icon: BitmapDescriptor.defaultMarker));

  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // getroleofstudent();
  }

  Widget buildServiceProviderList(List<JobWorkEnquiryTaskHandOverModel> handOverList) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      padding: EdgeInsets.only(top: 10, bottom: 15),
      itemBuilder: (context, index) {
        return InkWell(
            onTap: (){
              // Navigator.push(context, MaterialPageRoute(
              //     builder: (context) => MyTaskDetailsScreen(myTaskData: myTaskList[index],)));
            },
            child: TaskHandOverCard(context,handOverList[index]));
      },
      itemCount: handOverList.length,
    );
  }

  Widget TaskHandOverCard(BuildContext context,JobWorkEnquiryTaskHandOverModel TaskData)
  {
    return
      Container(
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
                        // width: MediaQuery.of(context).size.width/1.8,
                        child: Text(
                          TaskData.serviceUser.toString(),
                          // "Job Title/Services Name or Any Other Name",
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
                            "Category Id:",
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
                            // width: MediaQuery.of(context).size.width*0.2,
                            child: Text(TaskData.enquiryCategoryId.toString(),
                              // "#102GRDSA36987",
                              style: TextStyle(
                                fontFamily: 'Poppins-Regular',
                                fontSize: 12,
                                // fontWeight: FontWeight.bold
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),

                        ],
                      ),
                      SizedBox(height: 3,),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Category Name:",
                            style: TextStyle(
                                fontFamily: 'Poppins-SemiBold',
                                fontSize: 12,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          // SizedBox(
                          //   width: MediaQuery.of(context).size.width/11,
                          // ),
                          Container(
                            // width: MediaQuery.of(context).size.width*0.2,
                            child: Text(
                              TaskData.enquiryDetailsCategory.toString(),
                              //"Step 1",
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
                      //       "Total Experience:",
                      //       style: TextStyle(
                      //           fontFamily: 'Poppins-SemiBold',
                      //           fontSize: 12,
                      //           fontWeight: FontWeight.bold
                      //       ),
                      //     ),
                      //     // SizedBox(
                      //     //   width: MediaQuery.of(context).size.width/8,
                      //     // ),
                      //     Container(
                      //       // width: MediaQuery.of(context).size.width*0.2,
                      //       child: Text(
                      //         TaskData.years.toString(),
                      //         //"Step 1",
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
                    ],
                  ),
                ),
              ),
            ],
          ),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: InkWell(
              onTap: (){
                Navigator.pop(context);
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => BottomNavigation (index:0)));
              },
              child: Icon(Icons.arrow_back_ios)),
          title: Text("",style:appBarheadingStyle ,),
        ),
        floatingActionButton:Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton(
                backgroundColor: ThemeColors.defaultbuttonColor,
                heroTag: "btn1",
                child: Icon(
                  Icons.messenger,color: ThemeColors.whiteTextColor,size: 30,
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>chatListing()));
                },
              ),
              SizedBox(width: 8,),
              FloatingActionButton(
                backgroundColor: ThemeColors.defaultbuttonColor,
                heroTag: "btn2",
                child: Icon(
                  Icons.call,color: ThemeColors.whiteTextColor,size: 30,
                ),
                onPressed: () {
                  //...
                },
              ),
            ],
          ),
        ),

        body:BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
          return BlocListener<HomeBloc, HomeState>(
              listener: (context, state) {
                if(state is JobWorkEnquiryTaskHandOverLoading){
                  _isLoading = state.isLoading;
                }
                if(state is JobWorkEnquiryTaskHandOverSuccess){
                  serviceList = state.serviceListJWEData;
                }
                if(state is JobWorkEnquiryTaskHandOverFail){
                  showCustomSnackBar(context,state.msg.toString());
                }
              },
              child: _isLoading ? serviceList!.length <= 0 ? Center(child: Text('No Data'),):
              Container(
                child: ListView(
                  children: [
                    SingleChildScrollView(child: Container(child:buildServiceProviderList(serviceList!))),
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

}