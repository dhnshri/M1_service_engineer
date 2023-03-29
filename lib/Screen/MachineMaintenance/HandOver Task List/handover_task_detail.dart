import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/foundation.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:service_engineer/Bloc/home/home_bloc.dart';
import 'package:service_engineer/Bloc/home/home_event.dart';
import 'package:service_engineer/Bloc/home/home_state.dart';
import 'package:service_engineer/Constant/theme_colors.dart';
import 'package:service_engineer/Model/service_request_detail_repo.dart';
import 'package:service_engineer/Model/service_request_repo.dart';
import 'package:service_engineer/Screen/MachineMaintenance/HandOver%20Task%20List/handover_task_list.dart';
import 'package:service_engineer/Screen/bottom_navbar.dart';
import 'package:service_engineer/Utils/application.dart';
import 'package:service_engineer/Widget/app_button.dart';
import 'package:service_engineer/Widget/custom_snackbar.dart';
import 'package:service_engineer/Widget/image_view_screen.dart';
import 'package:shimmer/shimmer.dart';
import 'package:path_provider/path_provider.dart';
import '../../../Config/font.dart';
import '../../../Widget/app_small_button.dart';
import '../MakeQuotations/make_quotatons.dart';
// import 'package:pdf/pdf.dart';

class HandOverTaskDetailScreen extends StatefulWidget {
  ServiceRequestModel handoverTaskData;
  HandOverTaskDetailScreen({Key? key,required this.handoverTaskData}) : super(key: key);

  @override
  _HandOverTaskDetailScreenState createState() => _HandOverTaskDetailScreenState();
}

class _HandOverTaskDetailScreenState extends State<HandOverTaskDetailScreen> {
  String dropdownValue = '+ 91';
  String? phoneNum;
  String? role;
  bool loading = true;
  bool _isLoading = false;
  bool _acceptLoading = true;

  HomeBloc? _homeBloc;
  List<MachineServiceDetailsModel>? serviceRequestData = [];
  List<HandOverTaskDetailModel>? handoverTaskData = [];
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ExpansionTileCardState> cardA = new GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardB = new GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardC = new GlobalKey();


  @override
  void initState() {
    // TODO: implement initState
    //saveDeviceTokenAndId();
    super.initState();
    _homeBloc = BlocProvider.of<HomeBloc>(this.context);
    _homeBloc!.add(OnServiceRequestDetail(userID: widget.handoverTaskData.serviceUserId.toString(), machineEnquiryId: widget.handoverTaskData.enquiryId.toString(),jobWorkEnquiryId: '0',transportEnquiryId: '0'));
    _homeBloc!.add(MachineHandOverTaskDetail(serviceUserID: widget.handoverTaskData.serviceUserId.toString(), dailyTaskId: widget.handoverTaskData.dailyTaskId.toString(),));
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
          title: Text('${widget.handoverTaskData.machineName.toString()}'),
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
                    _homeBloc!.add(MachineAcceptRejectHandOverTask(serviceUserId: widget.handoverTaskData.serviceUserId.toString(), machineEnquiryId: widget.handoverTaskData.enquiryId.toString(),
                        status: '2', dailyTaskId: widget.handoverTaskData.dailyTaskId.toString()));
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
                    _homeBloc!.add(MachineAcceptRejectHandOverTask(serviceUserId: widget.handoverTaskData.serviceUserId.toString(), machineEnquiryId: widget.handoverTaskData.enquiryId.toString(),
                        status: '1', dailyTaskId: widget.handoverTaskData.dailyTaskId.toString()));
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
                if(state is ServiceRequestLoading){
                  _isLoading = state.isLoading;
                }
                if(state is ServiceRequestDetailSuccess){
                  serviceRequestData = state.machineServiceDetail;
                }
                if(state is ServiceRequestFail){
                  showCustomSnackBar(context,state.msg.toString(),isError: true);
                }
                if(state is MachineHandOverTaskDetailLoading){
                  _isLoading = state.isLoading;
                }
                if(state is MachineHandOverTaskDetailSuccess){
                  handoverTaskData = state.serviceListData;
                }
                if(state is MachineHandOverTaskDetailFail){
                  showCustomSnackBar(context,state.msg.toString(),isError: true);
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
              child: _isLoading ? serviceRequestData!.length <=0 ? Center(child: CircularProgressIndicator(),):ListView(
                children: [
                  SizedBox(height: 7,),

                  // Machin Info
                  ExpansionTileCard(
                    initiallyExpanded: true,
                    key: cardB,
                    title: const Text("Machine Information",
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Poppins',
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
                              // width: 340,
                              width: MediaQuery.of(context).size.width,
                              child: CachedNetworkImage(
                                filterQuality: FilterQuality.medium,
                                // imageUrl: Api.PHOTO_URL + widget.users.avatar,
                                // imageUrl: "https://picsum.photos/250?image=9",
                                imageUrl: serviceRequestData![0].machineImg.toString(),
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
                                    height: 80,
                                    width: 80,
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
                                        borderRadius: BorderRadius.circular(0),
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
                                        Text(serviceRequestData![0].serviceCategoryName.toString(),style: ExpanstionTileRightDataStyle,),
                                      ],
                                    ),
                                    SizedBox(height: 7,),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("Machine Name",style: ExpanstionTileLeftDataStyle,),
                                        Text(serviceRequestData![0].machineName.toString(),style: ExpanstionTileRightDataStyle,),
                                      ],
                                    ),
                                    SizedBox(height: 7,),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("Manufacturer (Brand)",style: ExpanstionTileLeftDataStyle,),
                                        Text(serviceRequestData![0].brand.toString(),style: ExpanstionTileRightDataStyle,),
                                      ],
                                    ),
                                    SizedBox(height: 7,),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("Make",style: ExpanstionTileLeftDataStyle,),
                                        Text(serviceRequestData![0].make.toString(),style: ExpanstionTileRightDataStyle,),
                                      ],
                                    ),
                                    SizedBox(height: 7,),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("Machine No.",style: ExpanstionTileLeftDataStyle,),
                                        Text(serviceRequestData![0].machineNumber.toString(),style: ExpanstionTileRightDataStyle,),
                                      ],
                                    ),
                                    SizedBox(height: 7,),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("Controler",style: ExpanstionTileLeftDataStyle,),
                                        Text(serviceRequestData![0].companyName.toString(),style: ExpanstionTileRightDataStyle,),
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
                                        Text(serviceRequestData![0].serviceSubCategoryName.toString(),style: ExpanstionTileRightDataStyle,),
                                      ],
                                    ),
                                    SizedBox(height: 7,),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("Machine Type",style: ExpanstionTileLeftDataStyle,),
                                        Text(serviceRequestData![0].machineType.toString(),style: ExpanstionTileRightDataStyle,),
                                      ],
                                    ),
                                    SizedBox(height: 7,),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("System name",style: ExpanstionTileLeftDataStyle,),
                                        Text(serviceRequestData![0].systemName.toString(),style: ExpanstionTileRightDataStyle,),
                                      ],
                                    ),
                                    SizedBox(height: 7,),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("Model no.",style: ExpanstionTileLeftDataStyle,),
                                        Text(serviceRequestData![0].modelNumber.toString(),style: ExpanstionTileRightDataStyle,),
                                      ],
                                    ),
                                    SizedBox(height: 7,),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("Machine Size",style: ExpanstionTileLeftDataStyle,),
                                        Text(serviceRequestData![0].machineSize.toString(),style: ExpanstionTileRightDataStyle,),
                                      ],
                                    ),
                                    SizedBox(height: 7,),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("Manufacture Date",style: ExpanstionTileLeftDataStyle,),
                                        Text(serviceRequestData![0].manufacturingDate.toString(),style: ExpanstionTileRightDataStyle,),
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
                  /// TrackProcess Details
                  ExpansionTileCard(
                    initiallyExpanded: true,
                    key: cardC,
                    title: const Text("Task Detail",
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Poppins',
                            fontSize: 16,
                            fontWeight: FontWeight.w500
                        )),
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0,bottom: 10),
                        child: Column(
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Column(
                                children: [
                                  Text(handoverTaskData![0].heading.toString(),
                                      style: TextStyle(fontFamily: 'Poppins',
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500)),
                                ],
                              ),
                            ),

                            SizedBox(height: 8,),
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Text(handoverTaskData![0].description.toString())),
                          ],
                        ),
                      ),
                    ],
                  ),

                  /// Task Amount and Description
                  ExpansionTileCard(
                    initiallyExpanded: true,
                    key: cardA,
                    title: const Text("Task Amount and Description",
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Poppins',
                            fontSize: 16,
                            fontWeight: FontWeight.w500
                        )),
                    children: <Widget>[
                      handoverTaskData![0].price != 0?
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
                                Container(
                                  // width:200,
                                  child: const Text("Task Amount:",
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        // color: ThemeColors.buttonColor,
                                          fontFamily: 'Poppins',
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500
                                      )),
                                ),
                                Container(
                                  child: Text("₹ ${handoverTaskData![0].price.toString()}",
                                      style: TextStyle(
                                          // color: ThemeColors.buttonColor,
                                          fontFamily: 'Poppins',
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500
                                      )),
                                )
                              ],
                            ),
                          ),
                        ),
                      ):Container(),

                      Padding(
                        padding: const EdgeInsets.only(left: 20.0,top: 20,bottom: 10),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text("Other Information",
                              style: TextStyle(
                                // color: ThemeColors.buttonColor,
                                  fontFamily: 'Poppins',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600
                              )),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(left: 20.0,bottom: 10),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(handoverTaskData![0].description.toString(),
                              style: TextStyle(
                                // color: ThemeColors.buttonColor,
                                  fontFamily: 'Poppins',
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500
                              )),
                        ),
                      )
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
