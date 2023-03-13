import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/foundation.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

import '../../../Bloc/home/home_bloc.dart';
import '../../../Bloc/home/home_event.dart';
import '../../../Bloc/home/home_state.dart';
import '../../../Config/font.dart';
import '../../../Model/Transpotation/serviceRequestDetailModel.dart';
import '../../../Model/Transpotation/serviceRequestListModel.dart';
import '../../../Utils/application.dart';
import '../../../Widget/app_small_button.dart';
import '../../bottom_navbar.dart';
import 'MakeQuotationTransportation/make_quotation_transposation.dart';
import 'dart:io';

import 'package:pdf/widgets.dart' as pw;





class TransportationServiceRequestDetailsScreen extends StatefulWidget {
  ServiceRequestTranspotationModel serviceRequestData;
  TransportationServiceRequestDetailsScreen({Key? key,required this.serviceRequestData}) : super(key: key);

  @override
  _TransportationServiceRequestDetailsScreenState createState() => _TransportationServiceRequestDetailsScreenState();
}

class _TransportationServiceRequestDetailsScreenState extends State<TransportationServiceRequestDetailsScreen> {
  final TextEditingController _phoneNumberController = TextEditingController();
  String dropdownValue = '+ 91';
  String? phoneNum;
  String? role;
  bool loading = true;

  bool _isLoading = false;

  HomeBloc? _homeBloc;
  List<TransportDetailsModel>? serviceRequestData = [];

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


  final pdf = pw.Document();

  Future<void> _convertImageToPDF(String _image) async {

    //Create the PDF document
    PdfDocument document = PdfDocument();

    //Add the page
    PdfPage page = document.pages.add();

    //Load the image
    final PdfImage image =
    PdfBitmap(await _readImageData(_image));

    //draw image to the first page
    page.graphics.drawImage(
        image, Rect.fromLTWH(0, 0, page.size.width, page.size.height));

    //Save the document
    List<int> bytes = await document.save();

    // Dispose the document
    document.dispose();

    //Save the file and launch/download
    saveAndLaunchFile(bytes, 'output.pdf');
  }

  Future<List<int>> _readImageData(String name) async {
    final ByteData data = await rootBundle.load('images/$name');
    return data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
  }

  static Future<void> saveAndLaunchFile(
      List<int> bytes, String fileName) async {
    //Get external storage directory
    Directory directory = await getApplicationSupportDirectory();
    //Get directory path
    String path = directory.path;
    //Create an empty file to write PDF data
    File file = File('$path/$fileName');
    //Write PDF data
    await file.writeAsBytes(bytes, flush: true);
    //Open the PDF document in mobile
    OpenFile.open('$path/$fileName');
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

  @override
  void initState() {
    // TODO: implement initState
    //saveDeviceTokenAndId();
    super.initState();
    _homeBloc = BlocProvider.of<HomeBloc>(this.context);
    _homeBloc!.add(OnServiceRequestTranspotationDetail(userID:widget.serviceRequestData.userId.toString(), machineServiceId:'0',jobWorkServiceId: '0',transportServiceId:widget.serviceRequestData.enquiryId.toString()));

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
              Navigator.of(context).pop();
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => BottomNavigation (index:0,dropValue:"Transportation")));
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
            AppSmallButton(
              onPressed: () async {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MakeQuotationTransposationScreen()));
              },
              shape: const RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.all(Radius.circular(50))),
              text: 'Make Quotation',
              loading: loading,


            ),
          ],
        ),
      ),
        body: BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
          return BlocListener<HomeBloc, HomeState>(
              listener: (context, state) {
                if(state is ServiceRequestTranspotationDetailLoading){
                  _isLoading = state.isLoading;
                }
                if(state is ServiceRequestTranspotationDetailSuccess){
                  serviceRequestData = state.transportServiceDetail;
                }
                if(state is ServiceRequestTranspotationDetailFail){
                  // Fluttertoast.showToast(msg: state.msg.toString());
                }
              },
              child: _isLoading ? serviceRequestData!.length <=0 ? Center(child: CircularProgressIndicator(),)
                  :ListView(
                  children: [
                    SizedBox(height: 7,),
                    //Basic Info
                    ExpansionTileCard(
                      key: cardA,
                      initiallyExpanded: true,
                      title: Text("Basic Info",style: TextStyle(
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
                                  Text("Enquiry ID:",style: ExpanstionTileLeftDataStyle,),
                                  Text(serviceRequestData![0].transportEnquiryId.toString(),style: ExpanstionTileRightDataStyle,),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Enquiry Date:",style: ExpanstionTileLeftDataStyle,),
                                  Text(DateFormat('MM-dd-yyyy').format(DateTime.parse(serviceRequestData![0].createdAt.toString())).toString(),style: ExpanstionTileRightDataStyle,),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Timing:",style: ExpanstionTileLeftDataStyle,),
                                  Text(DateFormat('MM-dd-yyyy h:mm a').format(DateTime.parse(serviceRequestData![0].createdAt.toString())).toString(),style: ExpanstionTileRightDataStyle,),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Approx Distance :",style: ExpanstionTileLeftDataStyle,),
                                  Text("10 KM",style: ExpanstionTileRightDataStyle,),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    //Load Detail
                    ExpansionTileCard(
                      key: cardB,
                      initiallyExpanded: true,
                      title: Text("Load Details",style: TextStyle(
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
                                  Text("Load Type",style: ExpanstionTileLeftDataStyle,),
                                  Text(serviceRequestData![0].loadType.toString(),style: ExpanstionTileRightDataStyle,),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Load Weight",style: ExpanstionTileLeftDataStyle,),
                                  Text(serviceRequestData![0].loadWeight.toString(),style: ExpanstionTileRightDataStyle,),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Load Size",style: ExpanstionTileLeftDataStyle,),
                                  Text(serviceRequestData![0].loadSize.toString(),style: ExpanstionTileRightDataStyle,),
                                ],
                              ),
                              SizedBox(height: 5,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Pickup Location",style: ExpanstionTileLeftDataStyle,),
                                  Text(serviceRequestData![0].pickupLocation.toString(),style: ExpanstionTileRightDataStyle,),
                                ],
                              ),
                              SizedBox(height: 5,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Drop Location",style: ExpanstionTileLeftDataStyle,),
                                  Text(serviceRequestData![0].dropLocation.toString(),style: ExpanstionTileRightDataStyle,),
                                ],
                              ),
                              SizedBox(height: 10,),
                              Text(serviceRequestData![0].about.toString(),
                                    style: ExpanstionTileLeftDataStyle,),
                            ],
                          ),
                        ),
                      ],
                    ),

                  ],
                ) : Center(
                child: CircularProgressIndicator(),
              )

          );


        })


    );
  }
}
