import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/foundation.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:service_engineer/Config/font.dart';
import 'package:service_engineer/Screen/JobWorkEnquiry/Home/ServiceRequest/enquiry_makeQuotation.dart';
import 'package:service_engineer/Widget/app_small_button.dart';
import 'package:service_engineer/Widget/pdf.dart';
import 'package:service_engineer/Widget/pdfViewer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../Bloc/home/home_bloc.dart';
import '../../../../Bloc/home/home_event.dart';
import '../../../../Bloc/home/home_state.dart';
import '../../../../Constant/theme_colors.dart';
import '../../../../Model/JobWorkEnquiry/service_request_detail_model.dart';
import '../../../../Model/JobWorkEnquiry/service_request_model.dart';
import '../../../../Model/service_request_repo.dart';




class EnquiryServiceRequestDetailsScreen extends StatefulWidget {
  JobWorkEnquiryServiceRequestModel serviceRequestData;
  EnquiryServiceRequestDetailsScreen({Key? key,required this.serviceRequestData}) : super(key: key);

  @override
  _EnquiryServiceRequestDetailsScreenState createState() => _EnquiryServiceRequestDetailsScreenState();
}

class _EnquiryServiceRequestDetailsScreenState extends State<EnquiryServiceRequestDetailsScreen> {
  final TextEditingController _phoneNumberController = TextEditingController();
  String dropdownValue = '+ 91';
  String? phoneNum;
  String? role;
  bool loading = true;
  bool _isLoading = false;

  HomeBloc? _homeBloc;
  List<JobWorkEnquiryDetailsModel>? serviceRequestDetailData = [];

  String? url =
      "http://www.africau.edu/images/default/sample.pdf";
  File? pdfUrl;

  // String? smsCode;
  // bool smsCodeSent = false;
  // String? verificationId;
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ExpansionTileCardState> cardA = new GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardB = new GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardC = new GlobalKey();

  // final pdf = pw.Document();
  //
  // Future<void> _convertImageToPDF(String _image) async {
  //
  //   //Create the PDF document
  //   PdfDocument document = PdfDocument();
  //
  //   //Add the page
  //   PdfPage page = document.pages.add();
  //
  //   //Load the image
  //   final PdfImage image =
  //   PdfBitmap(await _readImageData(_image));
  //
  //   //draw image to the first page
  //   page.graphics.drawImage(
  //       image, Rect.fromLTWH(0, 0, page.size.width, page.size.height));
  //
  //   //Save the document
  //   List<int> bytes = await document.save();
  //
  //   // Dispose the document
  //   document.dispose();
  //
  //   //Save the file and launch/download
  //   saveAndLaunchFile(bytes, 'output.pdf');
  // }
  //
  // Future<List<int>> _readImageData(String name) async {
  //   final ByteData data = await rootBundle.load('images/$name');
  //   return data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
  // }
  //
  // static Future<void> saveAndLaunchFile(
  //     List<int> bytes, String fileName) async {
  //   //Get external storage directory
  //   Directory directory = await getApplicationSupportDirectory();
  //   //Get directory path
  //   String path = directory.path;
  //   //Create an empty file to write PDF data
  //   File file = File('$path/$fileName');
  //   //Write PDF data
  //   await file.writeAsBytes(bytes, flush: true);
  //   //Open the PDF document in mobile
  //   OpenFile.open('$path/$fileName');
  // }
  //
  //
  // Future<File> loadPdfFromNetwork(String url) async {
  //   final response = await http.get(Uri.parse(url));
  //   final bytes = response.bodyBytes;
  //   return _storeFile(url, bytes);
  // }
  // Future<File> _storeFile(String url, List<int> bytes) async {
  //   final filename = basename(url);
  //   final dir = await getApplicationDocumentsDirectory();
  //   final file = File('${dir.path}/$filename');
  //   await file.writeAsBytes(bytes, flush: true);
  //   if (kDebugMode) {
  //     print('$file');
  //   }
  //   return file;
  // }

  Widget buildItemRequiredList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      padding: EdgeInsets.only(top: 10, bottom: 15),
      itemBuilder: (context, index) {
        return  ExpansionTileCard(
          initiallyExpanded: true,
          key: cardB,
          title: Text("Item Required",
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
                  Align(
                    alignment: Alignment.topLeft,
                      child: Text(index.toString())),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Item Name:",style: ExpanstionTileLeftDataStyle,),
                      Text(serviceRequestDetailData![0].itemName.toString(),style: ExpanstionTileRightDataStyle,),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Quantity Required:",style: ExpanstionTileLeftDataStyle,),
                      Text(serviceRequestDetailData![0].qty.toString(),style: ExpanstionTileRightDataStyle,),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Delivery Location:",style: ExpanstionTileLeftDataStyle,),
                      Text(serviceRequestDetailData![0].cityName.toString(),style: ExpanstionTileRightDataStyle,),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Align(
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
                    padding: const EdgeInsets.only(right:16.0,left: 16.0,bottom: 8.0),
                    child: Column(
                      children: [
                        SizedBox(height: 10,),

                        Container(
                          decoration: BoxDecoration(
                              color: ThemeColors.imageContainerBG
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(right:16.0,left: 16.0,bottom: 8.0,top: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Text('Image-abc',
                                      style: TextStyle(
                                          color: ThemeColors.buttonColor,
                                          fontFamily: 'Poppins-Regular',
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400
                                      )),
                                ),
                                InkWell(
                                  onTap: () async {
                                    final file = await PDF().loadPdfFromNetwork(url.toString());

                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            PDFScreen(file: file,url: url.toString(),),
                                      ),
                                    );
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
                        SizedBox(height: 10,),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black,width: 1),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(serviceRequestDetailData![0].about.toString(),
                              style:ExpanstionTileOtherInfoStyle ,),
                          ),
                        ),

                      ],
                    ),
                  ),
                ],
              ),
            ),

          ],
        );
      },
      itemCount:serviceRequestDetailData!.length,
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    //saveDeviceTokenAndId();
    super.initState();
    _homeBloc = BlocProvider.of<HomeBloc>(this.context);
    _homeBloc!.add(OnServiceRequestJobWorkEnquiryDetail(userID:'100', machineServiceId: '0',jobWorkServiceId: '13',transportServiceId: '0'));

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
        title: Text('${widget.serviceRequestData.enquiryId.toString()}'),
      ),
      bottomNavigationBar:Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppSmallButton(
              onPressed: () async {

              },
              shape: const RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.all(Radius.circular(50))),
              text: 'Ignore',
              loading: loading,


            ),
            // SizedBox(width:8),
            Flexible(
              child: AppSmallButton(
                onPressed: () async {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => EnquiryMakeQuotationScreen ()));
                },
                shape: const RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.all(Radius.circular(50))),
                text: 'Make Quotation',
                loading: loading,


              ),
            ),
          ],
        ),
      ),
        body: BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
          return BlocListener<HomeBloc, HomeState>(
              listener: (context, state) {
                if(state is ServiceRequestJobWorkEnquryDetailLoading){
                  _isLoading = state.isLoading;
                }
                if(state is ServiceRequestJobWorkEnquryDetailSuccess){
                  serviceRequestDetailData = state.jobWorkEnquryServiceDetail;
                }
                if(state is ServiceRequestJobWorkEnquryDetailFail){
                  // Fluttertoast.showToast(msg: state.msg.toString());
                }
              },
              child: _isLoading ? serviceRequestDetailData!.length <=0 ? Center(child: CircularProgressIndicator(),):
              ListView(
                children: [
                  SizedBox(height: 7,),
                  //Basic Info
                  ExpansionTileCard(
                    key: cardA,
                    initiallyExpanded: true,
                    title:  Text("Basic Info",
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
                                Text("Enquiry ID",style: ExpanstionTileLeftDataStyle,),
                                Text(serviceRequestDetailData![0].jobWorkEnquiryId.toString(),style: ExpanstionTileRightDataStyle,),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Enquiry Date:",style: ExpanstionTileLeftDataStyle,),
                                Text(serviceRequestDetailData![0].createdAt.toString(),style: ExpanstionTileRightDataStyle,),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Enquiry Last Date Closed:",style: ExpanstionTileLeftDataStyle,),
                                Text(serviceRequestDetailData![0].projectComplitionDate.toString(),style: ExpanstionTileRightDataStyle,),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Project Cost(Aprox):",style: ExpanstionTileLeftDataStyle,),
                                Text(serviceRequestDetailData![0].approximateCost.toString(),style: ExpanstionTileRightDataStyle,),
                              ],
                            ),

                          ],
                        ),
                      ),
                    ],
                  ),
                  ///Item Required
                  buildItemRequiredList(),
                  // Other Info
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
