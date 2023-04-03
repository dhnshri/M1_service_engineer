import 'dart:async';
import 'dart:math' as math;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:service_engineer/Config/font.dart';
import 'package:service_engineer/Constant/theme_colors.dart';
import 'package:service_engineer/Model/Transpotation/myTaskListModel.dart';
import 'package:service_engineer/Model/track_model.dart';
import 'package:service_engineer/Screen/JobWorkEnquiry/Home/MyTask/process_detail.dart';
import 'package:service_engineer/Screen/Transportation/MyTask/process_detail_transport_screen.dart';
import 'package:service_engineer/Screen/Transportation/MyTask/transpotation_service_provider_list.dart';
import 'package:service_engineer/Screen/bottom_navbar.dart';
import 'package:service_engineer/Widget/custom_snackbar.dart';
import 'package:service_engineer/image_file.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../Bloc/home/home_bloc.dart';
import '../../../Bloc/home/home_event.dart';
import '../../../Bloc/home/home_state.dart';
import '../../../Model/Transpotation/MyTaskTransportDetailModel.dart';
import '../../../Model/service_request_detail_repo.dart';
import '../../../Model/track_process_repo.dart';
import '../../../Utils/application.dart';
import '../../JobWorkEnquiry/Home/MyTask/show_google_map.dart';
import 'add_task.dart';

class TransportationMyTaskDetailsScreen extends StatefulWidget {
  MyTaskTransportationModel myTaskData;
  TransportationMyTaskDetailsScreen({Key? key, required this.myTaskData})
      : super(key: key);

  @override
  _TransportationMyTaskDetailsScreenState createState() =>
      _TransportationMyTaskDetailsScreenState();
}

class _TransportationMyTaskDetailsScreenState
    extends State<TransportationMyTaskDetailsScreen> {
  final TextEditingController _phoneNumberController = TextEditingController();
  String dropdownValue = '+ 91';
  String? phoneNum;
  String? role;
  bool loading = true;
  bool _isLoading = false;

  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ExpansionTileCardState> cardA = new GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardB = new GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardC = new GlobalKey();
  final Set<Marker> _markers = {};
  late LatLng _lastMapPosition;
  double? addressLat;
  double? addressLong;
  Completer<GoogleMapController> controller1 = Completer();
  HomeBloc? _homeBloc;
  List<TransportMyTaskDetailsModel>? myTaskData = [];
  List<TrackProcessModel>? trackProgressData = [];

  int _currentStep = 0;
  StepperType stepperType = StepperType.vertical;

  int reachAtPick = 0;
  int loadComplete = 0;
  int onTheWay = 0;
  int reachOnDrop = 0;
  List<TrackDataModel> trackData = [];
  TrackDataModel? getTransportTrackData;
  final picker = ImagePicker();
  File? _invoiceImage;
  GstImageFile? invoiceImageFile;

  tapped(int step) {
    setState(() => _currentStep = step);
  }

  List<Step> getSteps() {
    return <Step>[
      Step(
        title: new Text('Reached at pickup location',
            style: TextStyle(
                fontSize: 15,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500)),
        content: SizedBox(),
        isActive: _currentStep >= 0,
        state: _currentStep >= 0 ? StepState.complete : StepState.disabled,
      ),
      Step(
        title: new Text('Loading completed',
            style: TextStyle(
                fontSize: 15,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500)),
        content: SizedBox(),
        isActive: _currentStep >= 0,
        state: _currentStep >= 1 ? StepState.complete : StepState.disabled,
      ),
      Step(
        title: new Text('On the way to drop location',
            style: TextStyle(
                fontSize: 15,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500)),
        content: SizedBox(),
        isActive: _currentStep >= 0,
        state: _currentStep >= 2 ? StepState.complete : StepState.disabled,
      ),
      Step(
        title: new Text('Reached on drop location',
            style: TextStyle(
                fontSize: 15,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500)),
        content: SizedBox(),
        isActive: _currentStep >= 0,
        state: _currentStep >= 3 ? StepState.complete : StepState.disabled,
      )
    ];
  }

  @override
  void initState() {
    // TODO: implement initState
    //saveDeviceTokenAndId();
    super.initState();
    invoiceImageFile = new GstImageFile();
    _homeBloc = BlocProvider.of<HomeBloc>(this.context);
    _homeBloc!.add(OnMyTaskTranspotationDetail(
        userID: widget.myTaskData.userId.toString(),
        machineEnquiryId: '0',
        jobWorkEnquiryId: '0',
        transportEnquiryId: widget.myTaskData.enquiryId.toString()));
    // _homeBloc!.add(OnMyTaskTranspotationDetail(userID:'4', machineEnquiryId:'0',jobWorkEnquiryId: '0',transportEnquiryId:'31'));
    getTrackApi();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  _invoiceOpenGallery(BuildContext context) async {
    final invoiceImage =
        await picker.getImage(source: ImageSource.camera, imageQuality: 25);
    invoiceImageFile = new GstImageFile();
    if (invoiceImage != null) {
      _invoiceCropImage(invoiceImage);
    }
  }

  // For crop image
  Future<Null> _invoiceCropImage(PickedFile imageCropped) async {
    File? croppedFile = await ImageCropper.cropImage(
        sourcePath: imageCropped.path,
        aspectRatioPresets: Platform.isAndroid
            ? [
                // CropAspectRatioPreset.square,
                CropAspectRatioPreset.original,
              ]
            : [
                // CropAspectRatioPreset.square,
                CropAspectRatioPreset.original,
              ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Theme.of(context).primaryColor,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.square,
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(
          title: 'Cropper',
        )) as File?;
    if (croppedFile != null) {
      setState(() {
        // mImageFile.image = croppedFile;
        // print(mImageFile.image.path);
        // state = AppState.cropped;
        _invoiceImage = croppedFile;
        invoiceImageFile!.imagePath = _invoiceImage!.path;
      });
      // Navigator.pop(context);
    }
  }

  getTrackApi() {
    _homeBloc!.add(TransporGetTrackProcess(
        transportEnquiryId: widget.myTaskData.enquiryId.toString(),
        serviceUserID: widget.myTaskData.userId.toString()));
    // _homeBloc!.add(TransporGetTrackProcess(transportEnquiryId:'1', serviceUserID: '1'));
  }

  trackApi() {
    _homeBloc!.add(TransportUpdateTrackProcess(
        serviceUserID: widget.myTaskData.userId.toString(),
        transportEnquiryId: widget.myTaskData.enquiryId.toString(),
        reachAtPick: reachAtPick.toString(),
        loadComplete: loadComplete.toString(),
        onWayToDrop: onTheWay.toString(),
        reachOnDrop: reachOnDrop.toString(),
        invoiceImage: invoiceImageFile!.imagePath.toString()));
    // _homeBloc!.add(TransportUpdateTrackProcess(serviceUserID:'1',
    //     transportEnquiryId:'1',reachAtPick: reachAtPick.toString(),
    //     loadComplete: loadComplete.toString(),onWayToDrop: onTheWay.toString(),reachOnDrop: reachOnDrop.toString(),invoiceImage: invoiceImageFile!.imagePath.toString()));
  }

  getTrackData() {
    if (getTransportTrackData!.reachedAtPickupLocation == 1 &&
        getTransportTrackData!.loadingCompleted == 0 &&
        getTransportTrackData!.onTheWayToDropLocation == 0 &&
        getTransportTrackData!.reachesOnDropLocation == 0) {
      _currentStep = 0;
      reachAtPick = 1;
      loadComplete = 0;
      onTheWay = 0;
      reachOnDrop = 0;
    } else if (getTransportTrackData!.reachedAtPickupLocation == 1 &&
        getTransportTrackData!.loadingCompleted == 1 &&
        getTransportTrackData!.onTheWayToDropLocation == 0 &&
        getTransportTrackData!.reachesOnDropLocation == 0) {
      _currentStep = 1;
      reachAtPick = 1;
      loadComplete = 1;
      onTheWay = 0;
      reachOnDrop = 0;
    } else if (getTransportTrackData!.reachedAtPickupLocation == 1 &&
        getTransportTrackData!.loadingCompleted == 1 &&
        getTransportTrackData!.onTheWayToDropLocation == 1 &&
        getTransportTrackData!.reachesOnDropLocation == 0) {
      _currentStep = 2;
      reachAtPick = 1;
      loadComplete = 1;
      onTheWay = 1;
      reachOnDrop = 0;
    } else if (getTransportTrackData!.reachedAtPickupLocation == 1 &&
        getTransportTrackData!.loadingCompleted == 1 &&
        getTransportTrackData!.onTheWayToDropLocation == 1 &&
        getTransportTrackData!.reachesOnDropLocation == 1) {
      _currentStep = 3;
      reachAtPick = 1;
      loadComplete = 1;
      onTheWay = 1;
      reachOnDrop = 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back_ios)),
          title: Text(
            widget.myTaskData.enquiryId.toString(),
          ),
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton(
                backgroundColor: ThemeColors.defaultbuttonColor,
                heroTag: "btn1",
                child: Icon(
                  Icons.messenger,
                  color: ThemeColors.whiteTextColor,
                  size: 30,
                ),
                onPressed: () {
                  //...
                },
              ),
              SizedBox(
                width: 8,
              ),
              FloatingActionButton(
                backgroundColor: ThemeColors.defaultbuttonColor,
                heroTag: "btn2",
                child: Icon(
                  Icons.call,
                  color: ThemeColors.whiteTextColor,
                  size: 30,
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
                if (state is MyTaskTranspotationDetailLoading) {
                  _isLoading = state.isLoading;
                }
                if (state is MyTaskTranspotationDetailSuccess) {
                  myTaskData = state.transportMyTaskDetail;
                }
                if (state is MyTaskTranspotationDetailFail) {
                  // Fluttertoast.showToast(msg: state.msg.toString());
                }
                if (state is TrackProcssListTransportLoading) {
                  // _isLoading = state.isLoading;
                }
                if (state is TrackProcssListTransportSuccess) {
                  trackProgressData = state.trackProgressList;
                }
                if (state is TrackProcssListTransportFail) {
                  // Fluttertoast.showToast(msg: state.msg.toString());
                }
                if (state is TransportUpdateProcessLoading) {
                  // _isLoading = state.isLoading;
                }
                if (state is TransportUpdateProcessSuccess) {
                  showCustomSnackBar(context, state.message.toString(),
                      isError: false);
                }
                if (state is TransportUpdateProcessFail) {
                  showCustomSnackBar(context, state.msg.toString(),
                      isError: true);
                }
                if (state is TransportGetProcessLoading) {
                  // _isLoading = state.isLoading;
                }
                if (state is TransportGetProcessSuccess) {
                  trackData = state.trackData;
                  getTransportTrackData = trackData.last;
                  getTrackData();
                  setState(() {});
                }
                if (state is TransportGetProcessFail) {
                  showCustomSnackBar(context, state.msg.toString(),
                      isError: true);
                }
              },
              child: _isLoading
                  ? myTaskData!.length <= 0
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : ListView(
                          children: [
                            SizedBox(
                              height: 7,
                            ),
                            //Basic Info
                            ExpansionTileCard(
                              initiallyExpanded: true,
                              key: cardA,
                              title: Text(
                                "Basic Info",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Poppins',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              ),
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(
                                      right: 16.0, left: 16.0, bottom: 8.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Company Name:",
                                            style: ExpanstionTileLeftDataStyle,
                                          ),
                                          Text(
                                            "",
                                            style: ExpanstionTileRightDataStyle,
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Email ID:",
                                            style: ExpanstionTileLeftDataStyle,
                                          ),
                                          Text(
                                            myTaskData![0].email.toString(),
                                            style: ExpanstionTileRightDataStyle,
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Enquiry ID:",
                                            style: ExpanstionTileLeftDataStyle,
                                          ),
                                          Text(
                                            myTaskData![0]
                                                .transportEnquiryId
                                                .toString(),
                                            style: ExpanstionTileRightDataStyle,
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Enquiry Date:",
                                            style: ExpanstionTileLeftDataStyle,
                                          ),
                                          Text(
                                            myTaskData![0].createdAt.toString(),
                                            style: ExpanstionTileRightDataStyle,
                                          ),
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
                                      fontFamily: 'Poppins',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500)),
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(
                                      right: 16.0, left: 16.0, bottom: 8.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Load Type:",
                                            style: ExpanstionTileLeftDataStyle,
                                          ),
                                          Text(
                                            myTaskData![0].loadType.toString(),
                                            style: ExpanstionTileRightDataStyle,
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Load Weight:",
                                            style: ExpanstionTileLeftDataStyle,
                                          ),
                                          Text(
                                            myTaskData![0]
                                                .loadWeight
                                                .toString(),
                                            style: ExpanstionTileRightDataStyle,
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Load Size:",
                                            style: ExpanstionTileLeftDataStyle,
                                          ),
                                          Text(
                                            myTaskData![0].loadSize.toString(),
                                            style: ExpanstionTileRightDataStyle,
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Pickup Location:",
                                            style: ExpanstionTileLeftDataStyle,
                                          ),
                                          Text(
                                            myTaskData![0]
                                                .pickupLocation
                                                .toString(),
                                            style: ExpanstionTileRightDataStyle,
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Drop Location:",
                                            style: ExpanstionTileLeftDataStyle,
                                          ),
                                          Text(
                                            myTaskData![0]
                                                .dropLocation
                                                .toString(),
                                            style: ExpanstionTileRightDataStyle,
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      InkWell(
                                        onTap: () async {
                                          List<Location> locations =
                                              await locationFromAddress(
                                                  myTaskData![0]
                                                      .dropLocation
                                                      .toString());
                                          print(locations);
                                          if (locations != null) {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        MapSample(
                                                          addressLat:
                                                              locations[0]
                                                                  .latitude,
                                                          addressLong:
                                                              locations[0]
                                                                  .longitude,
                                                        )));
                                          }
                                        },
                                        child: Container(
                                          color: Color(0xFFFFE0E1),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Transform.rotate(
                                                    angle: 180 * math.pi / 100,
                                                    child: Icon(
                                                      Icons.send,
                                                      color: Colors.red,
                                                      size: 11,
                                                    )),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  "Location",
                                                  style:
                                                      ExpanstionTileRightDataStyle
                                                          .copyWith(
                                                              color: Colors.red,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.black, width: 1),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            myTaskData![0].about.toString(),
                                            style: ExpanstionTileOtherInfoStyle,
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

                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Text("Track Process",
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500)),
                            ),

                            ///Track Process List
                            Column(
                              children: [
                                Theme(
                                  data: ThemeData(
                                    colorScheme:
                                        Theme.of(context).colorScheme.copyWith(
                                              primary: Colors.red,
                                            ),
                                  ),
                                  child: Stepper(
                                    type: stepperType,
                                    physics: ScrollPhysics(),
                                    currentStep: _currentStep,
                                    // onStepTapped: (step) => tapped(step),
                                    // onStepContinue:  continued,
                                    // onStepCancel: cancel,
                                    steps: getSteps(),
                                    controlsBuilder: (context, _) {
                                      return Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          _currentStep == 3
                                              ? SizedBox()
                                              : TextButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      if (_currentStep < 3) {
                                                        _currentStep++;
                                                        print(_currentStep);
                                                        if (_currentStep == 1) {
                                                          reachAtPick = 1;
                                                          loadComplete = 0;
                                                          onTheWay = 0;
                                                          reachOnDrop = 0;
                                                          trackApi();
                                                        } else if (_currentStep ==
                                                            2) {
                                                          reachAtPick = 1;
                                                          loadComplete = 1;
                                                          onTheWay = 0;
                                                          reachOnDrop = 0;
                                                          trackApi();
                                                        } else if (_currentStep ==
                                                            3) {
                                                          reachAtPick = 1;
                                                          loadComplete = 1;
                                                          onTheWay = 1;
                                                          reachOnDrop = 0;
                                                          trackApi();
                                                        }
                                                      }
                                                    });
                                                  },
                                                  child: const Text('Update',
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          fontFamily: 'Poppins',
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                ),
                                        ],
                                      );
                                    },
                                  ),
                                )
                              ],
                            ),

                            SizedBox(
                              height: 20,
                            ),

                            ///Upload Receipt Copy
                            getTransportTrackData != null
                                ? (getTransportTrackData!
                                                .reachedAtPickupLocation ==
                                            1 &&
                                        getTransportTrackData!
                                                .loadingCompleted ==
                                            1 &&
                                        getTransportTrackData!
                                                .onTheWayToDropLocation ==
                                            1 &&
                                        getTransportTrackData!
                                                .reachesOnDropLocation ==
                                            1)
                                    ? Container()
                                    : Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          height: 50,
                                          color: ThemeColors
                                              .textFieldBackgroundColor,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8),
                                                  child: Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.4,
                                                    child: Text(
                                                      invoiceImageFile!
                                                                  .imagePath ==
                                                              null
                                                          ? "Upload Receipt Copy"
                                                          : invoiceImageFile!
                                                              .imagePath!
                                                              .split('/')
                                                              .last
                                                              .toString(),
                                                      style: TextStyle(
                                                          fontFamily: 'Poppins',
                                                          color: Colors.black
                                                              .withOpacity(
                                                                  0.5)),
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    _invoiceOpenGallery(
                                                        context);
                                                  },
                                                  child: Container(
                                                    height: 30,
                                                    color: ThemeColors
                                                        .textFieldHintColor
                                                        .withOpacity(0.3),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 4,
                                                              right: 4),
                                                      child: Center(
                                                          child: Text(
                                                        "+Add Image",
                                                        style: TextStyle(
                                                            fontFamily:
                                                                'Poppins',
                                                            color: Colors.black
                                                                .withOpacity(
                                                                    0.5)),
                                                        textAlign:
                                                            TextAlign.center,
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      )),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                : Container(),

                            ///Complete Task\
                            getTransportTrackData != null
                                ? (getTransportTrackData!
                                                .reachedAtPickupLocation ==
                                            1 &&
                                        getTransportTrackData!
                                                .loadingCompleted ==
                                            1 &&
                                        getTransportTrackData!
                                                .onTheWayToDropLocation ==
                                            1 &&
                                        getTransportTrackData!
                                                .reachesOnDropLocation ==
                                            1)
                                    ? Container()
                                    : InkWell(
                                        onTap: () {
                                          if (invoiceImageFile!.imagePath ==
                                              null) {
                                            showCustomSnackBar(
                                                context, "Upload Invoice",
                                                isError: true);
                                          } else {
                                            reachAtPick = 1;
                                            loadComplete = 1;
                                            onTheWay = 1;
                                            reachOnDrop = 1;
                                            trackApi();
                                            getTrackApi();
                                            setState(() {
                                              getTransportTrackData;
                                            });
                                          }
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Container(
                                            height: 50,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            decoration: BoxDecoration(
                                                color:
                                                    ThemeColors.whiteTextColor,
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                border: Border.all(
                                                  color: ThemeColors
                                                      .defaultbuttonColor,
                                                  width: 1,
                                                )),
                                            child: const Center(
                                                child: Text("Complete Task",
                                                    style: TextStyle(
                                                      fontFamily: 'Poppins',
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: ThemeColors
                                                          .defaultbuttonColor,
                                                    ))),
                                          ),
                                        ),
                                      )
                                : Container(),

                            ///Assign to Other Button
                            getTransportTrackData != null
                                ? (getTransportTrackData!
                                                .reachedAtPickupLocation ==
                                            1 &&
                                        getTransportTrackData!
                                                .loadingCompleted ==
                                            1 &&
                                        getTransportTrackData!
                                                .onTheWayToDropLocation ==
                                            1 &&
                                        getTransportTrackData!
                                                .reachesOnDropLocation ==
                                            1)
                                    ? Container()
                                    : InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      TransportServiceProviderListScreen(
                                                        myTaskData:
                                                            myTaskData![0],
                                                      )));
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Container(
                                            height: 50,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            decoration: BoxDecoration(
                                                color: ThemeColors
                                                    .defaultbuttonColor,
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                border: Border.all(
                                                  color: ThemeColors
                                                      .defaultbuttonColor,
                                                  width: 1,
                                                )),
                                            child: const Center(
                                                child:
                                                    Text("Assign Task to Other",
                                                        style: TextStyle(
                                                          fontFamily: 'Poppins',
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: ThemeColors
                                                              .whiteTextColor,
                                                        ))),
                                          ),
                                        ),
                                      )
                                : Container(),

                            SizedBox(
                              height: 80,
                            )
                          ],
                        )
                  : Center(
                      child: CircularProgressIndicator(),
                    ));
        }));
  }
}
