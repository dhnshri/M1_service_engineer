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

class JobWorkHandOverTaskDetailScreen extends StatefulWidget {
  JobWorkEnquiryMyTaskModel handoverTaskData;
  JobWorkHandOverTaskDetailScreen({Key? key,required this.handoverTaskData}) : super(key: key);

  @override
  _JobWorkHandOverTaskDetailScreenState createState() => _JobWorkHandOverTaskDetailScreenState();
}

class _JobWorkHandOverTaskDetailScreenState extends State<JobWorkHandOverTaskDetailScreen> {
  String dropdownValue = '+ 91';
  String? phoneNum;
  String? role;
  bool loading = true;
  bool _isLoading = false;
  bool _acceptLoading = true;
  List<QuotationRequiredItems>? quotationRequiredItemList=[];
  List<QuotationCharges>? quotationChargesList=[];
  List<CustomerReplyMsg>? quotationMsgList=[];
  HomeBloc? _homeBloc;
  List<MyTaskEnquiryDetails>? myTaskData = [];
  List<TrackProcessJobWorkEnquiryModel>? trackProgressData = [];
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ExpansionTileCardState> cardA = new GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardB = new GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardC = new GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardItemRequired = new GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardMessage = new GlobalKey();
  double itemRequiredTotal = 0.0;
  double grandTotal = 0.0;

  @override
  void initState() {
    // TODO: implement initState
    //saveDeviceTokenAndId();
    super.initState();
    _homeBloc = BlocProvider.of<HomeBloc>(this.context);
    _homeBloc!.add(OnMyTaskJobWorkEnquiryDetail(userID:widget.handoverTaskData.userId.toString(), machineEnquiryId: '0',jobWorkEnquiryId: widget.handoverTaskData.enquiryId.toString(),transportEnquiryId: '0'));
    // _homeBloc!.add(OnMyTaskJobWorkEnquiryDetail(userID:'100', machineEnquiryId: '0',jobWorkEnquiryId: '13',transportEnquiryId: '0'));
    // _homeBloc!.add(OnTrackProcessList(userId:'1',machineEnquiryId:'0',transportEnquiryId: '0',jobWorkEnquiryId:'1'));
    _homeBloc!.add(OnTrackProcessList(userId:widget.handoverTaskData.userId.toString(),machineEnquiryId:'0',transportEnquiryId: '0',jobWorkEnquiryId: widget.handoverTaskData.enquiryId.toString()));
    // _homeBloc!.add(JobWorkQuotationReplyDetail(jobWorkEnquiryId: '13', customerUserId: '100'));
    _homeBloc!.add(JobWorkQuotationReplyDetail(jobWorkEnquiryId: widget.handoverTaskData.enquiryId.toString(), customerUserId: widget.handoverTaskData.userId.toString()));
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
          title: Text('${widget.handoverTaskData.itemName.toString()}'),
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
                    _homeBloc!.add(JobWorkAcceptRejectHandOverTask(serviceUserId: widget.handoverTaskData.userId.toString(), jobWorkEnquiryId: widget.handoverTaskData.enquiryId.toString(),
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
                    _homeBloc!.add(JobWorkAcceptRejectHandOverTask(serviceUserId: widget.handoverTaskData.userId.toString(), jobWorkEnquiryId: widget.handoverTaskData.enquiryId.toString(),
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
                if(state is MyTaskJobWorkEnquiryDetailLoading){
                  _isLoading = state.isLoading;
                }
                if(state is MyTaskJobWorkEnquiryDetailSuccess){
                  myTaskData = state.MyTaskDetail;
                }
                if(state is MyTaskJobWorkEnquiryDetailFail){
                  showCustomSnackBar(context,state.msg.toString());
                }
                if(state is TrackProcssJWEListLoading){
                  // _isLoading = state.isLoading;
                }
                if(state is TrackProcssJWEListSuccess){
                  trackProgressData = state.trackProgressList;
                }
                if(state is TrackProcssJWEListFail){
                  showCustomSnackBar(context,state.msg.toString());
                }
                if(state is JobWorkQuotationReplyDetailLoading){
                  _isLoading = state.isLoading;
                }
                if(state is JobWorkQuotationReplyDetailSuccess){
                  quotationRequiredItemList = state.quotationRequiredItemList;
                  quotationChargesList = state.quotationChargesList;
                  quotationMsgList = state.quotationMsgList;

                }
                if(state is JobWorkQuotationReplyDetailFail){
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
              child: _isLoading ? myTaskData!.length <=0 ? Center(child: CircularProgressIndicator(),):ListView(
                children: [
                  SizedBox(height: 7,),
                  //Basic Info
                  ExpansionTileCard(
                    initiallyExpanded: true,
                    key: cardA,
                    title: const Text("Basic Info",
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
                                Text("Company ID",style: ExpanstionTileLeftDataStyle,),
                                Text(myTaskData![0].id.toString(),style: ExpanstionTileRightDataStyle,),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Company Name:",style: ExpanstionTileLeftDataStyle,),
                                // Text(myTaskData![0]..toString(),style: ExpanstionTileRightDataStyle,),
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
                            fontFamily: 'Poppins-Medium',
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
                                          fontFamily: 'Poppins-Medium',
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
                                                    fontFamily: 'Poppins-Regular',
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
                                        MaterialPageRoute(builder: (context)=> ProcessDetailScreen(trackProgressData: trackProgressData![index],
                                          myTaskJobWorkEnquiryData: widget.handoverTaskData,fromHandOver: false,)));
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
                  // Padding(
                  //   padding: EdgeInsets.all(15.0),
                  //   child: Material(
                  //     elevation: 5,
                  //     child: Container(
                  //       height: 60,
                  //       child: ElevatedButton(
                  //           style: ButtonStyle(
                  //             backgroundColor: MaterialStateProperty.all(ThemeColors.textFieldBackgroundColor),
                  //
                  //           ),
                  //           onPressed: (){
                  //             Navigator.push(context, MaterialPageRoute(builder: (context)=>AddTaskScreen()));
                  //           },
                  //           child: Row(
                  //             mainAxisAlignment: MainAxisAlignment.center,
                  //             children: [
                  //               Icon(Icons.add, color: Colors.black.withOpacity(0.55)),
                  //               Text("Create Task",
                  //                 style: TextStyle(fontFamily: 'Poppins-Medium',
                  //                     fontSize: 16,
                  //                     fontWeight: FontWeight.w500,
                  //                     color: Colors.black.withOpacity(0.55)
                  //                 ),)
                  //             ],
                  //           )),
                  //     ),
                  //   ),),

                  quotationRequiredItemList!.isEmpty ? Container():
                  ExpansionTileCard(
                    key: cardItemRequired,
                    initiallyExpanded: true,
                    title: Text("Item Required",
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
                                  label: Text('Item Name'),
                                ),
                                DataColumn(
                                  label: Text('QTY'),
                                ),
                                DataColumn(
                                  label: Text('Rate'),
                                ),
                                DataColumn(
                                  label: Text('Amount'),
                                ),
                              ],
                              rows: List.generate(quotationRequiredItemList!.length, (index) {
                                int itemNo = index+1;
                                itemRequiredTotal = quotationRequiredItemList!
                                    .map((item) => double.parse(item.amount.toString()))
                                    .reduce((value, current) => value + current);

                                grandTotal = itemRequiredTotal + double.parse(quotationRequiredItemList![0].packingCharge.toString()) +
                                    double.parse(quotationRequiredItemList![0].testingCharge.toString()) + double.parse(quotationRequiredItemList![0].transportCharge.toString()) +
                                    double.parse(quotationChargesList![0].commission.toString()) + double.parse(quotationChargesList![0].sgst.toString()) +
                                    double.parse(quotationChargesList![0].igst.toString()) + double.parse(quotationChargesList![0].cgst.toString());

                                return _getItemRequiredDataRow(quotationRequiredItemList![index],itemNo);
                              }),),
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
                                      "₹ $itemRequiredTotal",
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      quotationChargesList!.length <=0 ? Container():
                      Padding(
                        padding: const EdgeInsets.only(right: 10.0,left: 10.0, bottom: 8.0),
                        child: Column(
                          children: [
                            Divider(thickness: 1,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Total Items charges"),
                                Text("₹ ${itemRequiredTotal}"),
                              ],
                            ),
                            SizedBox(height: 5,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Packing charge"),
                                Text("₹ ${quotationRequiredItemList![0].packingCharge.toString()}"),
                              ],
                            ),
                            SizedBox(height: 5,),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Testing charge"),
                                Text("₹ ${quotationRequiredItemList![0].testingCharge.toString()}"),
                              ],
                            ),
                            SizedBox(height: 5,),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Transport charges"),
                                Text("₹ ${quotationRequiredItemList![0].transportCharge.toString()}"),
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
                                Text("CGST"),
                                Text("${quotationChargesList![0].cgst}"),
                              ],
                            ),
                            SizedBox(height: 5,),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("SGST"),
                                Text("${quotationChargesList![0].sgst}"),
                              ],
                            ),
                            SizedBox(height: 5,),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("IGST"),
                                Text("${quotationChargesList![0].igst}"),
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
  DataRow _getItemRequiredDataRow(QuotationRequiredItems? requiredItemData,index) {
    return DataRow(
      color: MaterialStateColor.resolveWith((states) {
        return Color(0xffFFE4E5); //make tha magic!
      }),
      cells: <DataCell>[
        DataCell(Text(index.toString())),
        DataCell(Text(requiredItemData!.itemName.toString())),
        DataCell(Text(requiredItemData.itemQty.toString())),
        DataCell(Text('₹${requiredItemData.rate.toString()}')),
        DataCell(Text('₹${requiredItemData.amount.toString()}')),
      ],
    );
  }

}
