import 'dart:math' as math;
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/foundation.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';

import 'package:service_engineer/Bloc/home/home_bloc.dart';
import 'package:service_engineer/Bloc/home/home_event.dart';
import 'package:service_engineer/Bloc/home/home_state.dart';
import 'package:service_engineer/Constant/theme_colors.dart';
import 'package:service_engineer/Model/JobWorkEnquiry/my_task_detail_model.dart';
import 'package:service_engineer/Model/JobWorkEnquiry/my_task_model.dart';
import 'package:service_engineer/Model/JobWorkEnquiry/service_request_model.dart';
import 'package:service_engineer/Model/JobWorkEnquiry/track_process_report_model.dart';
import 'package:service_engineer/Model/Transpotation/MyTaskTransportDetailModel.dart';
import 'package:service_engineer/Model/quotation_reply_detail_repo.dart';
import 'package:service_engineer/Screen/JobWorkEnquiry/HandOver%20Task%20List/handover_task_list.dart';
import 'package:service_engineer/Screen/JobWorkEnquiry/Home/MyTask/add_task.dart';
import 'package:service_engineer/Screen/JobWorkEnquiry/Home/MyTask/process_detail.dart';
import 'package:service_engineer/Screen/JobWorkEnquiry/Home/MyTask/show_google_map.dart';
import 'package:service_engineer/Screen/bottom_navbar.dart';
import 'package:service_engineer/Utils/application.dart';
import 'package:service_engineer/Widget/app_button.dart';
import 'package:service_engineer/Widget/custom_snackbar.dart';
import 'package:service_engineer/Widget/image_view_screen.dart';
import '../../../Config/font.dart';

class TransportHandOverTaskDetailScreen extends StatefulWidget {
  JobWorkEnquiryMyTaskModel handoverTaskData;
  TransportHandOverTaskDetailScreen({Key? key,required this.handoverTaskData}) : super(key: key);

  @override
  _TransportHandOverTaskDetailScreenState createState() => _TransportHandOverTaskDetailScreenState();
}

class _TransportHandOverTaskDetailScreenState extends State<TransportHandOverTaskDetailScreen> {
  String dropdownValue = '+ 91';
  String? phoneNum;
  String? role;
  bool loading = true;
  bool _isLoading = false;
  bool _acceptLoading = true;
  List<QuotationRequiredItems>? quotationRequiredItemList=[];
  List<QuotationCharges>? quotationChargesList=[];
  List<CustomerReplyMsg>? quotationMsgList=[];
  List<VehicleDetails>? vehicleList;
  List<QuotationCharges>? quotationDetailList=[];
  HomeBloc? _homeBloc;
  List<TransportMyTaskDetailsModel>? myTaskData = [];
  List<TrackProcessJobWorkEnquiryModel>? trackProgressData = [];
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ExpansionTileCardState> cardA = new GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardB = new GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardC = new GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardOtherItemRequiredTransposation = new GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardMessage = new GlobalKey();
  double itemRequiredTotal = 0.0;
  double grandTotal = 0.0;
  double quotationChargesTotal = 0.0;
  double itemOthersTotal = 0.0;
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    //saveDeviceTokenAndId();
    super.initState();
    _homeBloc = BlocProvider.of<HomeBloc>(this.context);
    _homeBloc!.add(OnMyTaskTranspotationDetail(userID:widget.handoverTaskData.userId.toString(), machineEnquiryId:'0',jobWorkEnquiryId: '0',transportEnquiryId:widget.handoverTaskData.enquiryId.toString()));
  // _homeBloc!.add(OnMyTaskTranspotationDetail(userID:'4', machineEnquiryId:'0',jobWorkEnquiryId: '0',transportEnquiryId:'31'));
  _homeBloc!.add(TransportQuotationReplyDetail(transportEnquiryId: widget.handoverTaskData.enquiryId.toString(), customerUserId: widget.handoverTaskData.userId.toString()));
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
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
          title: Text('${widget.handoverTaskData.enquiryId.toString()}'),
        ),
        bottomNavigationBar:
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: AppButton(
                  onPressed: () async {
                    _homeBloc!.add(TransportAcceptRejectHandOverTask(serviceUserId: widget.handoverTaskData.userId.toString(), transportEnquiryId: widget.handoverTaskData.enquiryId.toString(),
                      status: '2',));
                  },
                  shape: const RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.all(Radius.circular(50))),
                  text: 'Reject',
                  loading: loading,
                  color: ThemeColors.whiteTextColor,
                  borderColor: ThemeColors.defaultbuttonColor,textColor: ThemeColors.defaultbuttonColor,
                ),
              ),
              const SizedBox(width:10),
              Flexible(
                child: AppButton(
                  onPressed: () async {
                    _homeBloc!.add(TransportAcceptRejectHandOverTask(serviceUserId: widget.handoverTaskData.userId.toString(), transportEnquiryId: widget.handoverTaskData.enquiryId.toString(),
                      status: '1',));
                  },
                  shape: const RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.all(Radius.circular(50))),
                  text: 'Accept',
                  loading: _acceptLoading,
                  color: ThemeColors.defaultbuttonColor,
                ),
              ),
            ],
          ),
        ),
        body: BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
          return BlocListener<HomeBloc, HomeState>(
              listener: (context, state) {
                if(state is MyTaskTranspotationDetailLoading){
                  _isLoading = state.isLoading;
                }
                if(state is MyTaskTranspotationDetailSuccess){
                  myTaskData = state.transportMyTaskDetail;
                }
                if(state is MyTaskTranspotationDetailFail){
                  // Fluttertoast.showToast(msg: state.msg.toString());
                }
                if(state is TransportQuotationReplyDetailLoading){
                  isLoading = state.isLoading;
                }
                if(state is TransportQuotationReplyDetailSuccess){
                  vehicleList = state.vehicleDetailsList;
                  quotationDetailList = state.quotationDetailsList;
                  quotationChargesList = state.quotationChargesList;
                  quotationMsgList = state.quotationMsgList;
                  quotationChargesTotal = double.parse(quotationDetailList![0].handlingCharge.toString()) +
                      double.parse(quotationDetailList![0].serviceCharge.toString());
                  grandTotal = quotationChargesTotal + double.parse(quotationChargesList![0].commission.toString()) +
                      double.parse(quotationChargesList![0].gst.toString());
                }
                if(state is TransportQuotationReplyDetailFail){
                  showCustomSnackBar(context,state.msg.toString());
                }
                if(state is AcceptRejectHandoverLoading){
                  _acceptLoading = state.isLoading;
                }
                if(state is AcceptRejectHandoverSuccess){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>BottomNavigation(index: 0,dropValue: Application.customerLogin!.role.toString(),)));
                  showCustomSnackBar(context,state.message.toString(),isError: false);
                }
                if(state is AcceptRejectHandoverFail){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>BottomNavigation(index: 0,dropValue: Application.customerLogin!.role.toString(),)));
                  showCustomSnackBar(context,state.msg.toString(),isError: true);
                }
              },
              child: myTaskData!.isNotEmpty ? myTaskData!.length <=0 ? Center(child: CircularProgressIndicator(),):ListView(
                children: [
                  SizedBox(height: 7,),
                  //Basic Info
                  ExpansionTileCard(
                    initiallyExpanded: true,
                    key: cardA,
                    title:Text("Basic Info",
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
                                Text("Company Name:",style: ExpanstionTileLeftDataStyle,),
                                Text("",style: ExpanstionTileRightDataStyle,),
                              ],
                            ),
                            SizedBox(height: 5,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Email ID:",style: ExpanstionTileLeftDataStyle,),
                                Text(myTaskData![0].email.toString(),style: ExpanstionTileRightDataStyle,),
                              ],
                            ),
                            SizedBox(height: 5,),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Enquiry ID:",style: ExpanstionTileLeftDataStyle,),
                                Text(myTaskData![0].transportEnquiryId.toString(),style: ExpanstionTileRightDataStyle,),
                              ],
                            ),
                            SizedBox(height: 5,),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Enquiry Date:",style: ExpanstionTileLeftDataStyle,),
                                Text(myTaskData![0].createdAt.toString(),style: ExpanstionTileRightDataStyle,),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Divider(
                    thickness: 2.0,
                  ),
                  ///Load Details
                  ExpansionTileCard(
                    key: cardB,
                    initiallyExpanded: true,
                    title: const Text("Load Details",
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Load Type:",style: ExpanstionTileLeftDataStyle,),
                                Text(myTaskData![0].loadType.toString(),style: ExpanstionTileRightDataStyle,),
                              ],
                            ),
                            SizedBox(height: 5,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Load Weight:",style: ExpanstionTileLeftDataStyle,),
                                Text(myTaskData![0].loadWeight.toString(),style: ExpanstionTileRightDataStyle,),
                              ],
                            ),
                            SizedBox(height: 5,),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Load Size:",style: ExpanstionTileLeftDataStyle,),
                                Text(myTaskData![0].loadSize.toString(),style: ExpanstionTileRightDataStyle,),
                              ],
                            ),
                            SizedBox(height: 5,),

                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Pickup Location:",style: ExpanstionTileLeftDataStyle,),
                                Text(myTaskData![0].pickupLocation.toString(),style: ExpanstionTileRightDataStyle,),
                              ],
                            ),
                            SizedBox(height: 5,),

                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Drop Location:",style: ExpanstionTileLeftDataStyle,),
                                Text(myTaskData![0].dropLocation.toString(),style: ExpanstionTileRightDataStyle,),
                              ],
                            ),
                            SizedBox(height: 5,),

                            SizedBox(height: 5,),
                            InkWell(
                              onTap: ()async{
                                List<Location> locations = await locationFromAddress(myTaskData![0].dropLocation.toString());
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
                                      Text("Location",style: ExpanstionTileRightDataStyle.copyWith(color: Colors.red,fontWeight: FontWeight.normal),),
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
                          ],
                        ),
                      ),
                    ],
                  ),

                  const Divider(
                    thickness: 2.0,
                  ),

                  ///Quotation
                  quotationDetailList!.length <= 0 ? Container():
                  ExpansionTileCard(
                    key: cardOtherItemRequiredTransposation,
                    initiallyExpanded: true,
                    title: Text("Quotation",
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Poppins-Medium',
                            fontSize: 16,
                            fontWeight: FontWeight.w500
                        )),
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0,right: 10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,

                          children: [
                            DataTable(
                              headingRowHeight: 40,
                              headingRowColor: MaterialStateColor.resolveWith(
                                      (states) => Color(0xffE47273)),
                              columnSpacing: 15.0,
                              columns:const [
                                DataColumn(
                                  label: Expanded(child: Text('S no')),
                                ),
                                DataColumn(
                                  label: Text('Service Name'),
                                ),
                                DataColumn(
                                  label: Text('Amount'),
                                ),
                              ],
                              rows: [
                                DataRow(
                                  color: MaterialStateColor.resolveWith((states) {
                                    return Color(0xffFFE4E5); //make tha magic!
                                  }),cells: <DataCell>[
                                  DataCell(Text(1.toString())),
                                  DataCell(Text('Service/Call Charges')),
                                  DataCell(Text(quotationDetailList![0].serviceCharge.toString())),
                                ],),
                                DataRow(
                                  color: MaterialStateColor.resolveWith((states) {
                                    return Color(0xffFFE4E5); //make tha magic!
                                  }),cells: <DataCell>[
                                  DataCell(Text(2.toString())),
                                  DataCell(Text('Handling Charges')),
                                  DataCell(Text(quotationDetailList![0].handlingCharge.toString())),
                                ],)
                              ],),
                          ],
                        ),

                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0,right: 10.0,bottom: 10),
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Color(0xffFFE4E5),
                            border: Border(
                              top: BorderSide(
                                color: Colors.black,
                                width: 1.0,
                              ),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 8.0, right: 40.0, bottom: 8.0),
                                child: Row(
                                  children: [
                                    Text(
                                      "Total",
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Text(
                                      "₹ $quotationChargesTotal",
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10.0,left: 10.0, bottom: 8.0),
                        child: Column(
                          children: [
                            Divider(thickness: 1,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Quotation Charges"),
                                Text("₹ ${quotationChargesTotal}"),
                              ],
                            ),

                            SizedBox(height: 5,),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("M1 Commission"),
                                Text("₹ ${quotationChargesList![0].commission}"),
                              ],
                            ),
                            SizedBox(height: 5,),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("GST "),
                                Text("₹ ${quotationChargesList![0].gst}"),
                              ],
                            ),
                            Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Amount",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'Poppins-Medium',
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500
                                    )),
                                Text("₹ $grandTotal",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'Poppins-Medium',
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500
                                    )),
                              ],
                            ),
                          ],
                        ),
                      )

                    ],
                  ),

                  ///Message from Client
                  quotationMsgList!.length <= 0 ? Container():
                  ExpansionTileCard(
                    key: cardMessage,
                    initiallyExpanded: true,
                    title:  Text("Message from Client",
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Poppins-Medium',
                            fontSize: 16,
                            fontWeight: FontWeight.w500
                        )),
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(right: 16.0,left: 16.0,bottom: 16.0),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(quotationMsgList![0].message.toString(),textAlign: TextAlign.start,)),
                      ),
                    ],
                  ),

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
