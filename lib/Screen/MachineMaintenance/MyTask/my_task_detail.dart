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
import 'package:service_engineer/Utils/application.dart';
import 'package:service_engineer/Widget/image_view_screen.dart';
import 'package:service_engineer/Widget/pdfViewer.dart';
import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';
import 'package:flutter/foundation.dart';
import '../../../Config/font.dart';
import 'package:path_provider/path_provider.dart';
import '../../Chat/chat_listing.dart';
import '../../JobWorkEnquiry/Home/MyTask/show_google_map.dart';
import '../../bottom_navbar.dart';
import 'add_task.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';



class MyTaskDetailsScreen extends StatefulWidget {
  MyTaskModel myTaskData;

  MyTaskDetailsScreen({Key? key,required this.myTaskData}) : super(key: key);

  @override
  _MyTaskDetailsScreenState createState() => _MyTaskDetailsScreenState();
}

class _MyTaskDetailsScreenState extends State<MyTaskDetailsScreen> {
  final TextEditingController _phoneNumberController = TextEditingController();
  String? role;
  bool loading = true;
  bool _isLoading = false;

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
  HomeBloc? _homeBloc;
  List<MachineServiceDetailsModel>? myTaskData = [];
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
    _homeBloc!.add(OnServiceRequestDetail(userID: Application.customerLogin!.id.toString(), machineServiceId: widget.myTaskData.enquiryId.toString(),jobWorkServiceId: '0',transportServiceId: '0'));
    // _homeBloc!.add(OnServiceRequestDetail(userID: '6', machineServiceId: widget.myTaskData.enquiryId.toString(),jobWorkServiceId: '0',transportServiceId: '0'));
    _homeBloc!.add(TrackProcessList(userId: Application.customerLogin!.id.toString(),machineEnquiryId: widget.myTaskData.enquiryId.toString(),transportEnquiryId: '0',jobWorkEnquiryId: '0'));

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
        title: Text(widget.myTaskData.machineName.toString(),style:appBarheadingStyle ,),
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
              if(state is ServiceRequestLoading){
                _isLoading = state.isLoading;
              }
              if(state is ServiceRequestDetailSuccess){
                myTaskData = state.machineServiceDetail;
              }
              if(state is ServiceRequestFail){
                // Fluttertoast.showToast(msg: state.msg.toString());
              }
              if(state is TrackProcssListLoading){
                // _isLoading = state.isLoading;
              }
              if(state is TrackProcssListSuccess){
                trackProgressData = state.trackProgressList;
              }
              if(state is TrackProcssListFail){
                // Fluttertoast.showToast(msg: state.msg.toString());
              }
            },
            child: _isLoading ?myTaskData!.length <=0 ? Center(child: CircularProgressIndicator(),): ListView(
              children: [
                SizedBox(height: 7,),
                //Basic Info
                ExpansionTileCard(
                  initiallyExpanded: true,
                  key: cardA,
                  title: Text("Basic Info",
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Poppins-Medium',
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
                              Text("Company Name",style: ExpanstionTileLeftDataStyle,),
                              Text(myTaskData![0].companyName.toString(),style: ExpanstionTileRightDataStyle,),
                            ],
                          ),
                          SizedBox(height: 5,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Enquiry ID:",style: ExpanstionTileLeftDataStyle,),
                              Text(myTaskData![0].machineEnquiryId.toString(),style: ExpanstionTileRightDataStyle,),
                            ],
                          ),
                          SizedBox(height: 5,),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Enquiry Date:",style: ExpanstionTileLeftDataStyle,),
                              Text(DateFormat('MM-dd-yyyy').format(DateTime.parse(myTaskData![0].createdAt.toString())).toString(),style: ExpanstionTileRightDataStyle,),
                            ],
                          ),
                          SizedBox(height: 5,),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Date & Timing :",style: ExpanstionTileLeftDataStyle,),
                              Text(DateFormat('MM-dd-yyyy h:mm a').format(DateTime.parse(myTaskData![0].createdAt.toString())).toString(),style: ExpanstionTileRightDataStyle,),

                            ],
                          ),
                          SizedBox(height: 5,),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Location :",style: ExpanstionTileLeftDataStyle,),
                              InkWell(
                                  onTap: (){
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) => MapSample()));
                                  },
                                  child: Container(
                                    width: 140,
                                    child: Text(myTaskData![0].location.toString(),
                                      maxLines: 5,
                                      overflow: TextOverflow.ellipsis,style:TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                        fontFamily: 'Poppins-Bold',
                                        fontWeight: FontWeight.bold,
                                      ),),
                                  ),
                              ),
                            ],
                          ),
                          SizedBox(height: 5,),
                          InkWell(
                            onTap: (){
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) => MapSample()));
                            },
                            child: Container(
                              color:Color(0xFFFFE0E1),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Transform.rotate (
                                        angle: 180 * math.pi / 100,
                                        child: Icon(Icons.send,color: Colors.red, size: 11,)),
                                    SizedBox(width: 10,),
                                    Text("Google location Link | Google location Link ….",style: ExpanstionTileRightDataStyle.copyWith(color: Colors.red,fontWeight: FontWeight.normal),),
                                  ],
                                ),
                              ),
                            ),
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
                /// Machin Info
                ExpansionTileCard(
                  key: cardB,
                  initiallyExpanded: true,
                  title: Text("Machine Information",
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Poppins-Medium',
                          fontSize: 16,
                          fontWeight: FontWeight.w500
                      )),
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(right:16.0,left: 16.0,bottom: 8.0),
                      child: Column(
                        children: [
                          Container(
                            height:200,
                            width: MediaQuery.of(context).size.width,
                            child: CachedNetworkImage(
                              filterQuality: FilterQuality.medium,
                              imageUrl: myTaskData![0].machineImg.toString(),
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
                                      fit: BoxFit.fill,
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
                          ),
                          SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Category",style: ExpanstionTileLeftDataStyle,),
                                      Container(
                                        width: 150,
                                        child: Text(myTaskData![0].serviceCategoryName.toString(),
                                          maxLines: 5,
                                          overflow: TextOverflow.ellipsis,style:TextStyle(
                                            color: Colors.black,
                                            fontSize: 12,
                                            fontFamily: 'Poppins-Bold',
                                            fontWeight: FontWeight.bold,
                                          ),),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 7,),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Machine Name",style: ExpanstionTileLeftDataStyle,),
                                      Text(myTaskData![0].machineName.toString(),style: ExpanstionTileRightDataStyle,),
                                    ],
                                  ),
                                  SizedBox(height: 7,),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Manufacturer (Brand)",style: ExpanstionTileLeftDataStyle,),
                                      Text(myTaskData![0].brand.toString(),style: ExpanstionTileRightDataStyle,),
                                    ],
                                  ),
                                  SizedBox(height: 7,),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Make",style: ExpanstionTileLeftDataStyle,),
                                      Text(myTaskData![0].make.toString(),style: ExpanstionTileRightDataStyle,),
                                    ],
                                  ),
                                  SizedBox(height: 7,),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Machine No.",style: ExpanstionTileLeftDataStyle,),
                                      Text(myTaskData![0].machineNumber.toString(),style: ExpanstionTileRightDataStyle,),
                                    ],
                                  ),
                                  SizedBox(height: 7,),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Controler",style: ExpanstionTileLeftDataStyle,),
                                      Text(myTaskData![0].companyName.toString(),style: ExpanstionTileRightDataStyle,),
                                    ],
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Sub-Category",style: ExpanstionTileLeftDataStyle,),
                                      Container(
                                        width: 150,
                                        child: Text(myTaskData![0].serviceSubCategoryName.toString(),
                                          maxLines: 5,
                                          overflow: TextOverflow.ellipsis,style:TextStyle(
                                            color: Colors.black,
                                            fontSize: 12,
                                            fontFamily: 'Poppins-Bold',
                                            fontWeight: FontWeight.bold,
                                          ),),
                                      ),                                    ],
                                  ),
                                  SizedBox(height: 7,),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Machine Type",style: ExpanstionTileLeftDataStyle,),
                                      Text(myTaskData![0].machineType.toString(),style: ExpanstionTileRightDataStyle,),
                                    ],
                                  ),
                                  SizedBox(height: 7,),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("System name",style: ExpanstionTileLeftDataStyle,),
                                      Text(myTaskData![0].systemName.toString(),style: ExpanstionTileRightDataStyle,),
                                    ],
                                  ),
                                  SizedBox(height: 7,),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Model no.",style: ExpanstionTileLeftDataStyle,),
                                      Text(myTaskData![0].modelNumber.toString(),style: ExpanstionTileRightDataStyle,),
                                    ],
                                  ),
                                  SizedBox(height: 7,),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Machine Size",style: ExpanstionTileLeftDataStyle,),
                                      Text(myTaskData![0].machineSize.toString(),style: ExpanstionTileRightDataStyle,),
                                    ],
                                  ),
                                  SizedBox(height: 7,),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Manufacture Date",style: ExpanstionTileLeftDataStyle,),
                                      Text(myTaskData![0].manufacturingDate.toString(),style: ExpanstionTileRightDataStyle,),
                                    ],
                                  ),
                                ],
                              )
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
                /// Other Info
                ExpansionTileCard(
                  key: cardC,
                  initiallyExpanded: true,
                  leading: Text("Other Info",
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Poppins-Medium',
                          fontSize: 16,
                          fontWeight: FontWeight.w500
                      )),
                  title: SizedBox(),
                  subtitle:SizedBox(),
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(right:16.0,left: 16.0,bottom: 8.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Priority",style: TextStyle(fontFamily: 'Poppins-Medium',
                                fontSize: 16,
                              )),
                              Text(myTaskData![0].otherInfoName.toString(),style: TextStyle(fontFamily: 'Poppins-Medium',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500)),
                            ],
                          ),
                          SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Maintenance Type",style: TextStyle(fontFamily: 'Poppins-Medium',
                                fontSize: 16,
                              )),
                              Text(myTaskData![0].serviceCategoryName.toString(),style: TextStyle(fontFamily: 'Poppins-Medium',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500)),
                            ],
                          ),
                          SizedBox(height: 10,),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black,width: 1),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(myTaskData![0].machineProblem.toString(),
                                style:ExpanstionTileOtherInfoStyle ,),
                            ),
                          ),
                          SizedBox(height: 10,),

                          ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            itemCount: myTaskData![0].machineProblemImg!.length,
                            padding: EdgeInsets.only(top: 10, bottom: 15),
                            itemBuilder: (context, index) {

                              return  Padding(
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
                                        Container(
                                          width:200,
                                          child: Text(myTaskData![0].machineProblemImg![index].split('/').last.toString(),
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  color: ThemeColors.buttonColor,
                                                  fontFamily: 'Poppins-Regular',
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400
                                              )),
                                        ),
                                        InkWell(
                                          onTap: () async {
                                            Navigator.push(context, MaterialPageRoute(builder: (context)=>
                                                ImageViewerScreen(url: myTaskData![0].machineProblemImg![index])));
                                          },
                                          child: Container(
                                            child: Text('View',
                                                style: TextStyle(
                                                    color: ThemeColors.buttonColor,
                                                    fontFamily: 'Poppins-Regular',
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500
                                                )),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
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

                ///Working Days
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Working Days :",
                          style: TextStyle(fontFamily: 'Poppins-Medium',
                              fontSize: 16,
                              fontWeight: FontWeight.w500)),
                      Text("4 Days",
                          style: TextStyle(fontFamily: 'Poppins-Medium',
                              fontSize: 16,
                              fontWeight: FontWeight.w500))
                    ],
                  ),
                ),

                SizedBox(height: 5,),


                Divider(
                  // height: 2,
                  thickness: 2.0,
                ),

                Divider(
                  // height: 2,
                  thickness: 2.0,
                ),

                ///Track PRocess
                trackProgressData!.length <= 0 ? Container():
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text("Track Process",
                      style: TextStyle(fontFamily: 'Poppins-Medium',
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
                                      MaterialPageRoute(builder: (context)=> ProcessDetailScreen(trackProgressData: trackProgressData![index],)));
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
                                            style: TextStyle(color: Colors.red),)
                                        ],
                                      ),
                                    ),
                                    subtitle: Padding(
                                      padding: const EdgeInsets.only(bottom: 8.0),
                                      child: Text(trackProgressData![index].description.toString(),
                                          maxLines: 2, overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontFamily: 'Poppins-Regular',fontSize: 12,color: Colors.black
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
                                style: TextStyle(fontFamily: 'Poppins-Medium',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black.withOpacity(0.55)
                                ),)
                            ],
                          )),
                    ),
                  ),),

                ///Mark as Completed Button
                InkWell(
                  onTap: (){
                    // Navigator.of(context).pop();
                    AlertDialog(
                      title: new Text(""),
                      content: new Text("Are you sure, you want to mark service as completed?"),
                      actions: <Widget>[
                        Row(
                          children: [
                            TextButton(
                              child: new Text("No"),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            SizedBox(width: 7,),
                            TextButton(
                              child: new Text("Yes"),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: ThemeColors.defaultbuttonColor,
                          borderRadius: BorderRadius.circular(30)),
                      child: Center(child: Text("Mark As Completed",
                          style: TextStyle(fontFamily: 'Poppins-Medium',
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ))),
                    ),
                  ),
                ),


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

  Future<File> loadPdfFromNetwork(String url) async {
    final response = await http.get(Uri.parse(url));
    final bytes = response.bodyBytes;
    return _storeFile(url, bytes);
  }
  Future<File> _storeFile(String url, List<int> bytes) async {
    final filename = basename(url);
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$filename');
    await file.writeAsBytes(bytes, flush: true);
    if (kDebugMode) {
      print('$file');
    }
    return file;
  }
}
