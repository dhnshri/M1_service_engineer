import 'dart:async';
import 'dart:math' as math;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:service_engineer/Config/font.dart';
import 'package:service_engineer/Constant/theme_colors.dart';
import 'package:service_engineer/Screen/Chat/chat_listing.dart';
import 'package:service_engineer/Screen/JobWorkEnquiry/Home/MyTask/job_work_enquiry_service_provider_list.dart';
import 'package:service_engineer/Screen/JobWorkEnquiry/Home/MyTask/process_detail.dart';
import 'package:service_engineer/Screen/JobWorkEnquiry/Home/MyTask/show_google_map.dart';
import 'package:service_engineer/Screen/bottom_navbar.dart';
import 'package:service_engineer/Widget/pdf.dart';
import 'package:service_engineer/Widget/pdfViewer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../Bloc/home/home_bloc.dart';
import '../../../../Bloc/home/home_event.dart';
import '../../../../Bloc/home/home_state.dart';
import '../../../../Model/JobWorkEnquiry/my_task_detail_model.dart';
import '../../../../Model/JobWorkEnquiry/my_task_model.dart';
import '../../../../Model/JobWorkEnquiry/service_request_model.dart';
import '../../../../Model/JobWorkEnquiry/track_process_report_model.dart';
import '../../../../Utils/application.dart';
import '../../../../Widget/image_view_screen.dart';
import 'add_task.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';



class EnquiryMyTaskDetailsScreen extends StatefulWidget {
  JobWorkEnquiryMyTaskModel myTaskJobWorkEnquiryData;
  EnquiryMyTaskDetailsScreen({Key? key,required this.myTaskJobWorkEnquiryData}) : super(key: key);

  @override
  _EnquiryMyTaskDetailsScreenState createState() => _EnquiryMyTaskDetailsScreenState();
}

class _EnquiryMyTaskDetailsScreenState extends State<EnquiryMyTaskDetailsScreen> {
  final TextEditingController _phoneNumberController = TextEditingController();
  String dropdownValue = '+ 91';
  String? phoneNum;
  String? role;
  bool loading = true;
  bool _isLoading = false;

  List<MyTaskEnquiryDetails>? myTaskData = [];
  List<TrackProcessJobWorkEnquiryModel>? trackProgressData = [];

  String? url =
      "http://www.africau.edu/images/default/sample.pdf";
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ExpansionTileCardState> cardA = new GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardB = new GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardC = new GlobalKey();
  final Set<Marker> _markers = {};
  late LatLng _lastMapPosition;
  double? addressLat;
  double? addressLong;
  Completer<GoogleMapController> controller1 = Completer();


  _onCameraMove(CameraPosition position) {
    _lastMapPosition = position.target;
  }

  _onMapCreated(GoogleMapController controller) {
    setState(() {
      controller1.complete(controller);
    });
  }

  MapType _currentMapType = MapType.normal;
  HomeBloc? _homeBloc;

  @override
  void initState() {
    // TODO: implement initState
    //saveDeviceTokenAndId();
    super.initState();
    _homeBloc = BlocProvider.of<HomeBloc>(context);
    _homeBloc!.add(OnMyTaskJobWorkEnquiryDetail(userID:widget.myTaskJobWorkEnquiryData.userId.toString(), machineEnquiryId: '0',jobWorkEnquiryId: widget.myTaskJobWorkEnquiryData.enquiryId.toString(),transportEnquiryId: '0'));
    // _homeBloc!.add(OnMyTaskJobWorkEnquiryDetail(userID:'100', machineEnquiryId: '0',jobWorkEnquiryId: '13',transportEnquiryId: '0'));
    _homeBloc!.add(OnTrackProcessList(userId: Application.customerLogin!.id.toString(),machineEnquiryId:'0',transportEnquiryId: '0',jobWorkEnquiryId:widget.myTaskJobWorkEnquiryData.enquiryId.toString()));
    // _homeBloc!.add(OnTrackProcessList(userId:'1',machineEnquiryId:'0',transportEnquiryId: '0',jobWorkEnquiryId:'1'));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _phoneNumberController.clear();
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
        title: Text(widget.myTaskJobWorkEnquiryData.enquiryId.toString(),),
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

        body: BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
          return BlocListener<HomeBloc, HomeState>(
              listener: (context, state) {
                if(state is MyTaskJobWorkEnquiryDetailLoading){
                  _isLoading = state.isLoading;
                }
                if(state is MyTaskJobWorkEnquiryDetailSuccess){
                  myTaskData = state.MyTaskDetail;
                }
                if(state is MyTaskJobWorkEnquiryDetailFail){
                  // Fluttertoast.showToast(msg: state.msg.toString());
                }
                if(state is TrackProcssJWEListLoading){
                  // _isLoading = state.isLoading;
                }
                if(state is TrackProcssJWEListSuccess){
                  trackProgressData = state.trackProgressList;
                }
                if(state is TrackProcssJWEListFail){
                  // Fluttertoast.showToast(msg: state.msg.toString());
                }
              },
              child: _isLoading ?myTaskData!.length <=0 ? Center(child: CircularProgressIndicator(),):
              ListView(
                children: [
                  SizedBox(height: 7,),
                  //Basic Info
                  ExpansionTileCard(
                    initiallyExpanded: true,
                    key: cardA,
                    title: const Text("Basic Info",
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Poppins',
                          fontSize: 16,
                          fontWeight: FontWeight.w500
                      ),),
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(right:16.0,left: 16.0,bottom: 8.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Company ID",style: ExpanstionTileLeftDataStyle,),
                                Text(myTaskData![0].id.toString(),style: ExpanstionTileRightDataStyle,),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Enquiry ID:",style: ExpanstionTileLeftDataStyle,),
                                Text(myTaskData![0].jobWorkEnquiryId.toString(),style: ExpanstionTileRightDataStyle,),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Date & Timing :",style: ExpanstionTileLeftDataStyle,),
                                Text(myTaskData![0].createdAt.toString(),style: ExpanstionTileRightDataStyle,),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    // height: 2,
                    thickness: 2.0,
                  ),
                  ///Item Required
                  ExpansionTileCard(
                    initiallyExpanded: true,
                    key: cardB,
                    title: const Text("Item Required",
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Poppins',
                            fontSize: 16,
                            fontWeight: FontWeight.w500
                        )),
                    children: <Widget>[
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemCount: myTaskData!.length,
                        // padding: EdgeInsets.only(top: 10, bottom: 15),
                        itemBuilder: (context, index) {
                          int itemIndex = index +1;
                          return Padding(
                            padding: const EdgeInsets.only(right:16.0,left: 16.0,bottom: 8.0),
                            child: Column(
                              children: [
                                Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(itemIndex.toString())),
                                SizedBox(height: 10,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Item Name:",style: ExpanstionTileLeftDataStyle,),
                                    Text(myTaskData![index].itemName.toString(),style: ExpanstionTileRightDataStyle,),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Quantity Required:",style: ExpanstionTileLeftDataStyle,),
                                    Text(myTaskData![index].qty.toString(),style: ExpanstionTileRightDataStyle,),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Delivery Location:",style: ExpanstionTileLeftDataStyle,),
                                    Text(myTaskData![index].cityName.toString(),style: ExpanstionTileRightDataStyle,),
                                  ],
                                ),
                                SizedBox(height: 5,),
                                InkWell(
                                  onTap: ()async{
                                    List<Location> locations = await locationFromAddress(myTaskData![index].cityName.toString());
                                    print(locations);
                                    if(locations!=null) {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  MapSample(addressLat: locations[0].latitude,addressLong: locations[0].longitude,)));
                                    }
                                  },
                                  child: Container(
                                    color:Color(0xFFFFE0E1),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Transform.rotate (
                                              angle: 180 * math.pi / 100,
                                              child: Icon(Icons.send,color: Colors.red, size: 11,)),
                                          SizedBox(width: 10,),
                                          Text("location",style: ExpanstionTileRightDataStyle.copyWith(color: Colors.red,fontWeight: FontWeight.normal),),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 5,),
                                const Align(
                                  alignment: Alignment.topLeft,
                                  child: Text("Drawing Attachment:",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: 'Poppins',
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500
                                      )),
                                ),
                                SizedBox(height: 5,),
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Container(
                                    decoration: const BoxDecoration(
                                        color: ThemeColors.imageContainerBG
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(right:16.0,left: 16.0,bottom: 8.0,top: 8.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width:200,
                                            child: Text(myTaskData![index].drawingAttachment.toString(),
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                    color: ThemeColors.buttonColor,
                                                    fontFamily: 'Poppins',
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w400
                                                )),
                                          ),
                                          InkWell(
                                            onTap: () async {
                                              Navigator.push(context, MaterialPageRoute(builder: (context)=>
                                                  ImageViewerScreen(url: myTaskData![index].drawingAttachment.toString())));
                                            },
                                            child: Container(
                                              child: const Text('View',
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
                                ),
                                SizedBox(height: 10,),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black,width: 1),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(myTaskData![0].about.toString(),
                                      style:ExpanstionTileOtherInfoStyle ,),
                                  ),
                                ),
                                SizedBox(height: 10,),
                                Divider(color: Colors.black45),
                              ],
                            ),
                          );
                        },
                      ),

                    ],
                  ),

                  const Divider(
                    thickness: 2.0,
                  ),

                  ///Track PRocess
                  trackProgressData!.length <= 0 ? Container():
                  const Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Text("Track Process",
                        style: TextStyle(fontFamily: 'Poppins',
                            fontSize: 16,
                            fontWeight: FontWeight.w500)
                    ),
                  ),

                  ///Track Process List
                  trackProgressData!.length <= 0 ? Container():
                  Column(
                    // height: MediaQuery.of(context).size.height,
                    children: [
                      ListView.builder(
                          itemCount: trackProgressData!.length,
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (_, index) {
                            return Padding(
                              padding: const EdgeInsets.only(left: 10.0,bottom: 10,right: 10),
                              child: Material(
                                elevation: 5,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context)=> ProcessDetailScreen(trackProgressData: trackProgressData![index],
                                          myTaskJobWorkEnquiryData: widget.myTaskJobWorkEnquiryData,fromHandOver: true,)));
                                  },
                                  child: Container(
                                    // height: 60,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: ListTile(
                                      title: Padding(
                                        padding: const EdgeInsets.only(bottom: 8,top: 5),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(trackProgressData![index].heading.toString(),
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w400)),
                                            Text(trackProgressData![index].status == 0 ? "Process" : "Completed",
                                              style: TextStyle(color: trackProgressData![index].status == 0 ? Colors.red: Colors.green),)
                                          ],
                                        ),
                                      ),
                                      subtitle: Padding(
                                        padding: const EdgeInsets.only(bottom: 8.0),
                                        child: Text(trackProgressData![index].description.toString(),
                                            maxLines: 2, overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontFamily: 'Poppins',fontSize: 12,color: Colors.black
                                            )),
                                      ),
                                      trailing: Padding(
                                        padding: const EdgeInsets.only(top: 8.0),
                                        child: Icon(
                                          Icons.arrow_forward_ios,),
                                      ),
                                    ),
                                  ),

                                ),
                              ),
                            );
                          })
                    ],
                  ) ,



                  ///Add task Button
                  Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Material(
                      elevation: 5,
                      child: Container(
                        height: 60,
                        child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(ThemeColors.textFieldBackgroundColor),

                            ),
                            onPressed: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>AddTaskScreen()));
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.add, color: Colors.black.withOpacity(0.55)),
                                Text("Create Task",
                                  style: TextStyle(fontFamily: 'Poppins',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black.withOpacity(0.55)
                                  ),)
                              ],
                            )),
                      ),
                    ),),

                  ///Assign to Other Button
                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>JobWorkEnquiryServiceProviderListScreen(
                        myTaskJobWorkEnquiryData: widget.myTaskJobWorkEnquiryData,)));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: ThemeColors.defaultbuttonColor,
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(
                              color: ThemeColors.defaultbuttonColor,
                              width: 1,
                            )),
                        child: const Center(child: Text("Assign Task to Other",
                            style: TextStyle(fontFamily: 'Poppins',
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: ThemeColors.whiteTextColor,
                            ))),
                      ),
                    ),
                  ),


                  // ///Mark as Completed Button
                  // InkWell(
                  //   onTap: (){
                  //     // Navigator.of(context).pop();
                  //     AlertDialog(
                  //       title: new Text(""),
                  //       content: new Text("Are you sure, you want to mark service as completed?"),
                  //       actions: <Widget>[
                  //         Row(
                  //           children: [
                  //             TextButton(
                  //               child: new Text("No"),
                  //               onPressed: () {
                  //                 Navigator.of(context).pop();
                  //               },
                  //             ),
                  //             SizedBox(width: 7,),
                  //             TextButton(
                  //               child: new Text("Yes"),
                  //               onPressed: () {
                  //                 Navigator.of(context).pop();
                  //               },
                  //             ),
                  //           ],
                  //         ),
                  //       ],
                  //     );
                  //   },
                  //   child: Padding(
                  //     padding: const EdgeInsets.all(10.0),
                  //     child: Container(
                  //       height: 50,
                  //       width: MediaQuery.of(context).size.width,
                  //       decoration: BoxDecoration(
                  //           color: ThemeColors.defaultbuttonColor,
                  //           borderRadius: BorderRadius.circular(30)),
                  //       child: Center(child: Text("Mark As Completed",
                  //           style: TextStyle(fontFamily: 'Poppins',
                  //             fontSize: 16,
                  //             fontWeight: FontWeight.w500,
                  //             color: Colors.white,
                  //           ))),
                  //     ),
                  //   ),
                  // ),


                  SizedBox(
                    height: 80,
                  )


                ],
              )
                  : Center(
                child: CircularProgressIndicator(),
              )

          );


        })
    );
  }
}
