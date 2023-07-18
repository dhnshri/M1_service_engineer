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
import 'package:service_engineer/Utils/application.dart';
import 'package:service_engineer/Widget/app_button.dart';
import 'package:service_engineer/Widget/image_view_screen.dart';
import 'package:shimmer/shimmer.dart';
import 'package:path_provider/path_provider.dart';
import '../../../Config/font.dart';
import '../../../Widget/app_small_button.dart';
import '../../../Widget/pdfViewer.dart';
import '../../bottom_navbar.dart';
import '../MakeQuotations/make_quotatons.dart';
// import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

import '../home.dart';

class ServiceRequestDetailsScreen extends StatefulWidget {
  ServiceRequestModel serviceRequestData;
  ServiceRequestDetailsScreen({Key? key,required this.serviceRequestData}) : super(key: key);

  @override
  _ServiceRequestDetailsScreenState createState() => _ServiceRequestDetailsScreenState();
}

class _ServiceRequestDetailsScreenState extends State<ServiceRequestDetailsScreen> {
  final TextEditingController _phoneNumberController = TextEditingController();
  String dropdownValue = '+ 91';
  String? phoneNum;
  String? role;
  bool loading = true;
  bool _isLoading = false;

  HomeBloc? _homeBloc;
  List<MachineServiceDetailsModel>? serviceRequestData = [];


  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ExpansionTileCardState> cardA = new GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardB = new GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardC = new GlobalKey();

  final pdf = pw.Document();


  @override
  void initState() {
    // TODO: implement initState
    //saveDeviceTokenAndId();
    super.initState();
    _homeBloc = BlocProvider.of<HomeBloc>(this.context);
    _homeBloc!.add(OnServiceRequestDetail(userID: widget.serviceRequestData.userId.toString(), machineEnquiryId: widget.serviceRequestData.enquiryId.toString(),jobWorkEnquiryId: '0',transportEnquiryId: '0'));

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
             // Navigator.pop(context);
             //  Navigator.push(context,
             //      MaterialPageRoute(builder: (context) => MachineMaintenanceHomeScreen()));
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => BottomNavigation (index:0,dropValue: '1',)));
            },
            child: Icon(Icons.arrow_back_ios)),
        title: Text('${widget.serviceRequestData.machineName.toString()}'),
      ),
      bottomNavigationBar:
      // serviceRequestData!.isEmpty ? Container():
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: AppButton(
                onPressed: () async {
                 // Navigator.of(context).pop();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => BottomNavigation (index:0,dropValue: '1',)));
                },
                shape: const RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.all(Radius.circular(50))),
                text: 'Ignore',
                loading: loading,
                color: ThemeColors.whiteTextColor,
                borderColor: ThemeColors.defaultbuttonColor,textColor: ThemeColors.defaultbuttonColor,
              ),
            ),
            const SizedBox(width:10),
            Flexible(
              child: AppButton(
                onPressed: () async {
                  serviceRequestData!.isEmpty ? null:
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => MakeQuotationScreen (serviceRequestData: serviceRequestData![0],)));
                  },
                shape: const RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.all(Radius.circular(50))),
                text: 'Make Quotation',
                loading: loading,
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
                // Fluttertoast.showToast(msg: state.msg.toString());
              }
            },
            child: _isLoading ? serviceRequestData!.length <=0 ? Center(child: CircularProgressIndicator(),):ListView(
              children: [
                SizedBox(height: 7,),
                //Basic Info
                ExpansionTileCard(
                  initiallyExpanded: true,
                  key: cardA,
                  title: Text("Basic Info",
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Company Name",style: ExpanstionTileLeftDataStyle,),
                              Text(serviceRequestData![0].companyName.toString(),style: ExpanstionTileRightDataStyle,),
                            ],
                          ),
                          SizedBox(height: 5,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Enquiry ID:",style: ExpanstionTileLeftDataStyle,),
                              Text(serviceRequestData![0].machineEnquiryId.toString(),style: ExpanstionTileRightDataStyle,),
                            ],
                          ),
                          SizedBox(height: 5,),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Enquiry Date:",style: ExpanstionTileLeftDataStyle,),
                              // Text(serviceRequestData![0].createdAt.toString(),style: ExpanstionTileRightDataStyle,),
                              Text(DateFormat('MM-dd-yyyy').format(DateTime.parse(serviceRequestData![0].createdAt.toString())).toString(),style: ExpanstionTileRightDataStyle,),
                            ],
                          ),
                          SizedBox(height: 5,),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Date & Timing :",style: ExpanstionTileLeftDataStyle,),
                              Text(DateFormat('MM-dd-yyyy h:mm a').format(DateTime.parse(serviceRequestData![0].createdAt.toString())).toString(),style: ExpanstionTileRightDataStyle,),
                            ],
                          ),
                          SizedBox(height: 5,),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Location :",style: ExpanstionTileLeftDataStyle),
                              Container(
                                width: 140,
                                child: Text(serviceRequestData![0].location.toString(),
                                  maxLines: 5,
                                  textAlign: TextAlign.end,
                                  overflow: TextOverflow.ellipsis,style:TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.bold,
                                ),),
                              ),
                            ],
                          ),

                        ],
                      ),
                    ),
                  ],
                ),
                // Machin Info
                ExpansionTileCard(
                  initiallyExpanded: true,
                  key: cardB,
                  title: Text("Machine Information",
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
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("Category",style: ExpanstionTileLeftDataStyle,),
                                        Container(
                                          width: 200,
                                          child: Text(serviceRequestData![0].serviceCategoryName.toString(),style: ExpanstionTileRightDataStyle,
                                          maxLines: 2,overflow: TextOverflow.ellipsis,),),

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
                              ),
                              Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("Sub-Category",style: ExpanstionTileLeftDataStyle,),
                                          Container(
                                            width: 200,
                                            child: Text(serviceRequestData![0].serviceSubCategoryName.toString(),style: ExpanstionTileRightDataStyle,
                                              maxLines: 2,overflow: TextOverflow.ellipsis,),
                                          ),
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
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                // Other Info
                ExpansionTileCard(
                  initiallyExpanded: true,
                  key: cardC,
                  title: Text("Other Info",
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Priority",style: ExpanstionTileLeftDataStyle,),
                              Text(serviceRequestData![0].otherInfoName.toString(),style: ExpanstionTileRightDataStyle,),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Maintenance Type",style: ExpanstionTileLeftDataStyle,),
                              Text(serviceRequestData![0].serviceCategoryName.toString(),style: ExpanstionTileRightDataStyle,),
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
                              child: Text(serviceRequestData![0].machineProblem.toString(),
                                style:ExpanstionTileOtherInfoStyle ,),
                            ),
                          ),

                          SizedBox(height: 10,),

            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemCount: serviceRequestData![0].machineProblemImg!.length,
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
                            child: Text(serviceRequestData![0].machineProblemImg![index].split('/').last.toString(),
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: ThemeColors.buttonColor,
                                    fontFamily: 'Poppins',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400
                                )),
                          ),
                          InkWell(
                            onTap: () async {
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>
                                  ImageViewerScreen(url: serviceRequestData![0].machineProblemImg![index])));
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
                );
              },
            ),






                        ],
                      ),
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
