import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:service_engineer/Bloc/profile/profile_bloc.dart';
import 'package:service_engineer/Bloc/profile/profile_state.dart';
import 'package:service_engineer/Model/Transpotation/MyTaskTransportDetailModel.dart';
import 'package:service_engineer/Model/Transpotation/transport_task_hand_over_model.dart';
import 'package:service_engineer/Model/profile_repo.dart';
import 'package:service_engineer/Screen/bottom_navbar.dart';
import 'package:service_engineer/Utils/application.dart';
import 'package:service_engineer/Widget/custom_snackbar.dart';
import 'package:shimmer/shimmer.dart';
import '../../../Bloc/profile/profile_event.dart';
import '../../../Config/image.dart';
import '../../../Constant/theme_colors.dart';

import '../../../image_file.dart';


class TransportServiceProviderProfileScreen extends StatefulWidget {
  TransportServiceProviderProfileScreen({Key? key,required this.handOverListData,required this.myTaskData}) : super(key: key);
  TransportTaskHandOverModel handOverListData;
  TransportMyTaskDetailsModel? myTaskData;

  @override
  _TransportServiceProviderProfileScreenState createState() => _TransportServiceProviderProfileScreenState();
}

class _TransportServiceProviderProfileScreenState extends State<TransportServiceProviderProfileScreen> {
  bool loading = true;
  ImageFile? imageFile;
  File? _image;
  final picker = ImagePicker();
  DriverImage? driverImageFile;
  File? _driverImage;
  DrivingLiceseImage? drivingLicenseImageFile;
  File? _drivingLicenseImage;
  DriverIdProofImage? driverIdProofImageFile;
  File? _driverIdProofImage;
  CompanyCertificateImage? companyCertificateImageFile;
  File? _companyCertificateImage;
  File? _gstImage;
  GstImageFile? gstImageFile;
  File? _panImage;
  PanImageFile? panImageFile;
  File? _shopActImage;
  ShopActImageFile? shopActImageFile;
  File? _aadharImage;
  AddharImageFile? aadharImageFile;
  String? _currentAddress;
  Position? _currentPosition;

  final _formKey = GlobalKey<FormState>();
  final _addressFormKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _driverNameController = TextEditingController();
  final _iDController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _driverPhoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _pinCodeController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final _countryController = TextEditingController();
  final _driverLicenseValidityController = TextEditingController();
  final _driverLicenseNumberController = TextEditingController();
  final _vehicleNameController = TextEditingController();
  final _vehicleTypeController = TextEditingController();
  final _registrationUptoController = TextEditingController();
  final _vehicleNumberController = TextEditingController();
  final _yearsController = TextEditingController();
  final _descriptionController = TextEditingController();

  ProfileBloc? _profileBloc;
  bool _isLoading = false;
  List<ServiceUserData>? serviceUserdataList;
  List<ProfileKYCDetails>? profileKycList;
  List<DriverProfileDetails>? profileDriverDetailsList;
  List<ProfileVehicleInformation>? profileVehicleInfoList;
  final _desKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    //saveDeviceTokenAndId();
    super.initState();
    _profileBloc = BlocProvider.of<ProfileBloc>(this.context);
    imageFile = new ImageFile();
    _profileBloc!.add(GetTransportProfile(
        serviceUserId: widget.handOverListData.serviceUser.toString(),
        roleId: widget.handOverListData.role.toString()));
    // getData();
  }


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _descriptionController.clear();
    _yearsController.clear();
    _vehicleNameController.clear();
    _vehicleTypeController.clear();
    _vehicleNumberController.clear();
    _registrationUptoController.clear();
    _driverLicenseNumberController.clear();
    _driverLicenseValidityController.clear();
    _iDController.clear();
    _nameController.clear();
    _driverNameController.clear();
    _driverPhoneController.clear();
    _emailController.clear();
    _phoneController.clear();
    _addressController.clear();
    _pinCodeController.clear();
    _cityController.clear();
    _stateController.clear();
    _countryController.clear();
    _descriptionController.clear();
  }

  getData(){
    if(serviceUserdataList!=null){
      _iDController.text = serviceUserdataList![0].email.toString();
      _nameController.text = serviceUserdataList![0].name.toString();
      _emailController.text = serviceUserdataList![0].email.toString();
      _phoneController.text = serviceUserdataList![0].mobile.toString();
      _yearsController.text = widget.handOverListData.years.toString();
      imageFile!.imagePath  = serviceUserdataList![0].userProfilePic.toString();
      _addressController.text = serviceUserdataList![0].location.toString();
      _pinCodeController.text = serviceUserdataList![0].pincode.toString();
      _cityController.text = serviceUserdataList![0].city.toString();
      _stateController.text = serviceUserdataList![0].state.toString();
      _countryController.text = serviceUserdataList![0].country.toString();
      _driverNameController.text = profileDriverDetailsList![0].fullName.toString();
      _driverPhoneController.text = profileDriverDetailsList![0].mobile.toString();
      _driverLicenseValidityController.text = profileDriverDetailsList![0].drivingLicenceValidity.toString();
      _driverLicenseNumberController.text = profileDriverDetailsList![0].drivingLicenceNumber.toString();
    }else{
      _iDController.text = "";
      _nameController.text = "";
      _emailController.text = "";
      _phoneController.text = "";
      _yearsController.text = "";
      _addressController.text = "";
      _pinCodeController.text = "";
      _cityController.text = "";
      _stateController.text = "";
      _countryController.text = "";
      _driverNameController.text = "";
      _driverPhoneController.text = "";
      _driverLicenseValidityController.text = "";
      _driverLicenseNumberController.text = "";
    }
  }

  confirDailoge(){
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: new Text("Are you sure, you want to handover this Task?"),
          // content: new Text(""),
          actions: <Widget>[
            Row(
              mainAxisAlignment:
              MainAxisAlignment.center,
              children: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: TextButton.styleFrom(
                      fixedSize: const Size(120, 30),
                      shape:
                      const RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.all(
                              Radius.circular(
                                  25))),
                      side: const BorderSide(
                          color: ThemeColors
                              .defaultbuttonColor,
                          width: 1.5),
                    ),
                    child: const Text(
                      "No",
                      style: TextStyle(
                          color: Colors.black),
                    )),
                SizedBox(
                  width: 7,
                ),
                TextButton(
                  child: new Text(
                    "Yes",
                    style:
                    TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    _profileBloc!.add(TransportTaskHandover(
                      serviceUserId: widget.handOverListData.serviceUser.toString(),
                      transportEnquiryId: widget.myTaskData!.transportEnquiryId.toString(),
                      description: _descriptionController.text,
                    ));
                  },
                  style: TextButton.styleFrom(
                    fixedSize: const Size(120, 30),
                    backgroundColor: ThemeColors
                        .defaultbuttonColor,
                    shape:
                    const RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.all(
                            Radius.circular(
                                25))),),

                ),
              ],
            ),
          ],
        ));
  }



  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: const Text("Profile",
              style: TextStyle(
                  fontFamily: 'Poppins'
              ),),
            backgroundColor: ThemeColors.backGroundColor,
          ),

          body: BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
            return BlocListener<ProfileBloc, ProfileState>(
              listener: (context, state) {
                if(state is GetTransportProfileLoading){
                  _isLoading = state.isLoading;
                }
                if(state is GetTransportProfileSuccess){
                  serviceUserdataList = state.serviceUserdataList;
                  profileKycList = state.profileKycList;
                  profileDriverDetailsList = state.profileDriverDetailsList;
                  profileVehicleInfoList = state.profileVehicleInfoList;
                  getData();
                }
                if(state is GetTransportProfileFail){
                  showCustomSnackBar(context,state.msg.toString(),isError: true);
                }
                if(state is JobWorkTaskHandoverLoading){
                  _isLoading = state.isLoading;
                }
                if(state is JobWorkTaskHandoverSuccess){
                  showCustomSnackBar(context,state.msg.toString(),isError: false);
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>
                      BottomNavigation(index: 0, dropValue: Application.customerLogin!.role.toString(),)));
                }
                if(state is JobWorkTaskHandoverFail){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>
                      BottomNavigation(index: 0, dropValue: Application.customerLogin!.role.toString(),)));
                  showCustomSnackBar(context,state.msg.toString(),isError: true);
                }
              },
              child: _isLoading ? serviceUserdataList!.length <= 0 ? Center(child: CircularProgressIndicator(),): SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Material(
                          elevation: 5,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 25,top: 15,bottom: 15),
                                  child: Stack(
                                    children: [
                                      CircleAvatar(
                                        radius: 50,
                                        backgroundColor: ThemeColors.greyBackgrounColor,
                                        child: ClipOval(
                                          child: new SizedBox(
                                              width: 150.0,
                                              height: 150.0,
                                              child:
                                              (imageFile!.imagePath == null || imageFile!.imagePath == "")?
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Image.asset(
                                                  Images.profile_icon,
                                                  fit: BoxFit.fill,
                                                ),
                                              )
                                                  : Image.network(
                                                imageFile!.imagePath.toString(),
                                                fit: BoxFit.fill,
                                              )

                                          ),
                                        ),
                                      ),

                                    ],
                                  ),
                                ),
                                SizedBox(width: 20,),
                                Flexible(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                          child:Text(_nameController.text,
                                            style: TextStyle(fontFamily: 'Poppins', fontSize: 18,fontWeight: FontWeight.w500),
                                            textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis,
                                          )
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),

                      ///Owner Details
                      const Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text("Owner Details",
                          style: TextStyle(fontFamily: 'Poppins', fontSize: 18,fontWeight: FontWeight.w500),
                          textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis,
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.only(left: 30,right: 20),
                        child: Form(
                          // key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              ///Name
                              Padding(
                                padding: const EdgeInsets.only(left: 0.0, bottom: 10),
                                child: Text("Name",
                                  style: TextStyle(fontFamily: 'Poppins', fontSize: 14,fontWeight: FontWeight.w400,color: Colors.black.withOpacity(0.5)),
                                  textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis,
                                ),
                              ),

                              TextFormField(
                                readOnly: true,
                                controller: _nameController,
                                textAlign: TextAlign.start,
                                keyboardType: TextInputType.text,
                                style: TextStyle(
                                  fontSize: 18,
                                  height: 1.5,
                                ),
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: ThemeColors.whiteTextColor,
                                  hintText: "Full Name",
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 15.0),
                                  hintStyle: TextStyle(fontSize: 15),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(1.0)),
                                    borderSide: BorderSide(
                                        width: 0.8,
                                        color: ThemeColors.redTextColor
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(1.0)),
                                    borderSide: BorderSide(
                                        width: 0.8,
                                        color: ThemeColors.redTextColor),
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(1.0)),
                                      borderSide: BorderSide(
                                          width: 0.8,
                                          color: ThemeColors.redTextColor)),
                                ),
                                validator: (value) {

                                  if (value == null || value.isEmpty) {
                                    return 'Please enter name';
                                  }

                                  return null;
                                },
                                onChanged: (value) {
                                  // profile.name = value;
                                  setState(() {
                                    // _nameController.text = value;
                                    if (_formKey.currentState!.validate()) {}
                                  });
                                },
                              ),

                              SizedBox(height: 15,),

                              ///Email
                              Padding(
                                padding: const EdgeInsets.only(left: 0.0, bottom: 10),
                                child: Text("Email",
                                  style: TextStyle(fontFamily: 'Poppins', fontSize: 14,fontWeight: FontWeight.w400,color: Colors.black.withOpacity(0.5)),
                                  textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis,
                                ),
                              ),

                              TextFormField(
                                readOnly: true,
                                controller: _emailController,
                                textAlign: TextAlign.start,
                                keyboardType: TextInputType.emailAddress,
                                style: TextStyle(
                                  fontSize: 18,
                                  height: 1.5,
                                ),
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: ThemeColors.whiteTextColor,
                                  hintText: "Email",
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 15.0),
                                  hintStyle: TextStyle(fontSize: 15),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(1.0)),
                                    borderSide: BorderSide(
                                        width: 0.8,
                                        color: ThemeColors.redTextColor
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(1.0)),
                                    borderSide: BorderSide(
                                        width: 0.8,
                                        color: ThemeColors.redTextColor),
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(1.0)),
                                      borderSide: BorderSide(
                                          width: 0.8,
                                          color: ThemeColors.redTextColor)),
                                ),
                                validator: (value) {
                                  Pattern pattern =
                                      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                  RegExp regex =
                                  new RegExp(pattern.toString());

                                  if(value==null || value.isEmpty){
                                    return 'Please enter Email';
                                  }else if(!regex.hasMatch(value)){
                                    return 'Please enter valid Email';
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  // profile.name = value;
                                  setState(() {
                                    // _nameController.text = value;
                                    if (_formKey.currentState!.validate()) {}
                                  });
                                },
                              ),

                              SizedBox(height: 15,),

                              ///Phone Number
                              Padding(
                                padding: const EdgeInsets.only(left: 0.0, bottom: 10),
                                child: Text("Phone Number",
                                  style: TextStyle(fontFamily: 'Poppins', fontSize: 14,fontWeight: FontWeight.w400,color: Colors.black.withOpacity(0.5)),
                                  textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis,
                                ),
                              ),

                              TextFormField(
                                readOnly: true,
                                controller: _phoneController,
                                textAlign: TextAlign.start,
                                keyboardType: TextInputType.number,
                                style: TextStyle(
                                  fontSize: 18,
                                  height: 1.5,
                                ),
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: ThemeColors.whiteTextColor,
                                  hintText: "Phone Number",
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 15.0),
                                  hintStyle: TextStyle(fontSize: 15),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(1.0)),
                                    borderSide: BorderSide(
                                        width: 0.8,
                                        color: ThemeColors.redTextColor
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(1.0)),
                                    borderSide: BorderSide(
                                        width: 0.8,
                                        color: ThemeColors.redTextColor),
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(1.0)),
                                      borderSide: BorderSide(
                                          width: 0.8,
                                          color: ThemeColors.redTextColor)),
                                ),
                                validator: (value) {
                                  String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
                                  RegExp regExp = new RegExp(patttern);
                                  if (value?.length == 0) {
                                    return 'Please enter mobile number';
                                  }
                                  else if (!regExp.hasMatch(value!)) {
                                    return 'Please enter valid mobile number';
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  // profile.name = value;
                                  setState(() {
                                    // _nameController.text = value;
                                    if (_formKey.currentState!.validate()) {}
                                  });
                                },
                              ),

                              SizedBox(height: 15,),

                              ///Total Year Experience
                              Padding(
                                padding: const EdgeInsets.only(left: 0.0, bottom: 10),
                                child: Text("Total Year Experience",
                                  style: TextStyle(fontFamily: 'Poppins', fontSize: 14,fontWeight: FontWeight.w400,color: Colors.black.withOpacity(0.5)),
                                  textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis,
                                ),
                              ),

                              TextFormField(
                                readOnly: true,
                                controller: _yearsController,
                                textAlign: TextAlign.start,
                                keyboardType: TextInputType.text,
                                style: TextStyle(
                                  fontSize: 18,
                                  height: 1.5,
                                ),
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: ThemeColors.whiteTextColor,
                                  hintText: "Total Experience",
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 15.0),
                                  hintStyle: TextStyle(fontSize: 15),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(1.0)),
                                    borderSide: BorderSide(
                                        width: 0.8,
                                        color: ThemeColors.redTextColor
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(1.0)),
                                    borderSide: BorderSide(
                                        width: 0.8,
                                        color: ThemeColors.redTextColor),
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(1.0)),
                                      borderSide: BorderSide(
                                          width: 0.8,
                                          color: ThemeColors.redTextColor)),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please Enter Total Experience';
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  // profile.name = value;
                                  setState(() {
                                    // _nameController.text = value;
                                    if (_formKey.currentState!.validate()) {}
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(height: 10,),


                      const Divider(
                        // height: 2,
                        thickness: 2.0,
                      ),

                      const Divider(
                        // height: 2,
                        thickness: 2.0,
                      ),

                      ///Address
                      const Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Text("Address",
                          style: TextStyle(fontFamily: 'Poppins', fontSize: 18,fontWeight: FontWeight.w500),
                          textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis,
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.only(left: 30,right: 20),
                        child: Form(
                          key: _addressFormKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              SizedBox(height: 15,),

                              Padding(
                                padding: const EdgeInsets.only(left: 0.0, bottom: 10),
                                child: Text("Address",
                                  style: TextStyle(fontFamily: 'Poppins', fontSize: 14,fontWeight: FontWeight.w400,color: Colors.black.withOpacity(0.5)),
                                  textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              ///Address
                              TextFormField(
                                readOnly: true,
                                controller: _addressController,
                                obscureText: false,
                                textAlign: TextAlign.start,
                                keyboardType:
                                TextInputType.text,
                                maxLines: 4,
                                style: TextStyle(
                                  fontSize: 18,
                                  height: 1.5,
                                ),
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: ThemeColors.whiteTextColor,
                                  contentPadding:
                                  EdgeInsets.symmetric(
                                      vertical: 10.0,
                                      horizontal: 15.0),
                                  hintStyle:
                                  TextStyle(fontSize: 15),
                                  enabledBorder:
                                  OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.all(
                                        Radius.circular(
                                            10.0)),
                                    borderSide: BorderSide(
                                        width: 0.8,
                                        color: ThemeColors
                                            .redTextColor),
                                  ),
                                  focusedBorder:
                                  OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.all(
                                        Radius.circular(
                                            10.0)),
                                    borderSide: BorderSide(
                                        width: 0.8,
                                        color: ThemeColors
                                            .redTextColor),
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius:
                                      BorderRadius.all(
                                          Radius.circular(
                                              10.0)),
                                      borderSide: BorderSide(
                                          width: 0.8,
                                          color: ThemeColors
                                              .redTextColor)),
                                  hintText: "Enter your current address...",
                                ),
                                validator: (value) {
                                  if (value == null ||
                                      value.isEmpty) {
                                    return 'Please enter address';
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  setState(() {
                                    if (_formKey.currentState!
                                        .validate()) {}
                                  });
                                },
                              ),

                              SizedBox(height: 15,),
                              Padding(
                                padding: const EdgeInsets.only(left: 0.0, bottom: 10),
                                child: Text("Pin Code",
                                  style: TextStyle(fontFamily: 'Poppins', fontSize: 14,fontWeight: FontWeight.w400,color: Colors.black.withOpacity(0.5)),
                                  textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              ///Pin Code
                              TextFormField(
                                readOnly: true,
                                controller: _pinCodeController,
                                textAlign: TextAlign.start,
                                keyboardType: TextInputType.number,
                                style: TextStyle(
                                  fontSize: 18,
                                  height: 1.5,
                                ),
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: ThemeColors.whiteTextColor,
                                  hintText: "Pin Code",
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 15.0),
                                  hintStyle: TextStyle(fontSize: 15),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(1.0)),
                                    borderSide: BorderSide(
                                        width: 0.8,
                                        color: ThemeColors.redTextColor
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(1.0)),
                                    borderSide: BorderSide(
                                        width: 0.8,
                                        color: ThemeColors.redTextColor),
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(1.0)),
                                      borderSide: BorderSide(
                                          width: 0.8,
                                          color: ThemeColors.redTextColor)),
                                ),
                                validator: (value) {
                                  // profile.name = value!.trim();
                                  // Pattern pattern =
                                  //     r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                  // RegExp regex =
                                  // new RegExp(pattern.toString());
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter pin code';
                                  }
                                  // else if(!regex.hasMatch(value)){
                                  //   return 'Please enter valid name';
                                  // }
                                  return null;
                                },
                                onChanged: (value) {
                                  // profile.name = value;
                                  setState(() {
                                    // _nameController.text = value;
                                    if (_formKey.currentState!.validate()) {}
                                  });
                                },
                              ),

                              SizedBox(height: 15,),

                              Padding(
                                padding: const EdgeInsets.only(left: 0.0, bottom: 10),
                                child: Text("City",
                                  style: TextStyle(fontFamily: 'Poppins', fontSize: 14,fontWeight: FontWeight.w400,color: Colors.black.withOpacity(0.5)),
                                  textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              ///City
                              TextFormField(
                                readOnly: true,
                                controller: _cityController,
                                textAlign: TextAlign.start,
                                keyboardType: TextInputType.text,
                                style: TextStyle(
                                  fontSize: 18,
                                  height: 1.5,
                                ),
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: ThemeColors.whiteTextColor,
                                  hintText: "City",
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 15.0),
                                  hintStyle: TextStyle(fontSize: 15),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(1.0)),
                                    borderSide: BorderSide(
                                        width: 0.8,
                                        color: ThemeColors.redTextColor
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(1.0)),
                                    borderSide: BorderSide(
                                        width: 0.8,
                                        color: ThemeColors.redTextColor),
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(1.0)),
                                      borderSide: BorderSide(
                                          width: 0.8,
                                          color: ThemeColors.redTextColor)),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter city';
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  // profile.name = value;
                                  setState(() {
                                    // _nameController.text = value;
                                    if (_formKey.currentState!.validate()) {}
                                  });
                                },
                              ),

                              SizedBox(height: 15,),

                              Padding(
                                padding: const EdgeInsets.only(left: 0.0, bottom: 10),
                                child: Text("State",
                                  style: TextStyle(fontFamily: 'Poppins', fontSize: 14,fontWeight: FontWeight.w400,color: Colors.black.withOpacity(0.5)),
                                  textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              ///State
                              TextFormField(
                                readOnly: true,
                                controller: _stateController,
                                textAlign: TextAlign.start,
                                keyboardType: TextInputType.text,
                                style: TextStyle(
                                  fontSize: 18,
                                  height: 1.5,
                                ),
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: ThemeColors.whiteTextColor,
                                  hintText: "State",
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 15.0),
                                  hintStyle: TextStyle(fontSize: 15),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(1.0)),
                                    borderSide: BorderSide(
                                        width: 0.8,
                                        color: ThemeColors.redTextColor
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(1.0)),
                                    borderSide: BorderSide(
                                        width: 0.8,
                                        color: ThemeColors.redTextColor),
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(1.0)),
                                      borderSide: BorderSide(
                                          width: 0.8,
                                          color: ThemeColors.redTextColor)),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter state';
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  // profile.name = value;
                                  setState(() {
                                    // _nameController.text = value;
                                    if (_formKey.currentState!.validate()) {}
                                  });
                                },
                              ),

                              SizedBox(height: 15,),

                              Padding(
                                padding: const EdgeInsets.only(left: 0.0, bottom: 10),
                                child: Text("Country",
                                  style: TextStyle(fontFamily: 'Poppins', fontSize: 14,fontWeight: FontWeight.w400,color: Colors.black.withOpacity(0.5)),
                                  textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              ///Country
                              TextFormField(
                                readOnly: true,
                                controller: _countryController,
                                textAlign: TextAlign.start,
                                keyboardType: TextInputType.text,
                                style: TextStyle(
                                  fontSize: 18,
                                  height: 1.5,
                                ),
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: ThemeColors.whiteTextColor,
                                  hintText: "Country",
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 15.0),
                                  hintStyle: TextStyle(fontSize: 15),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(1.0)),
                                    borderSide: BorderSide(
                                        width: 0.8,
                                        color: ThemeColors.redTextColor
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(1.0)),
                                    borderSide: BorderSide(
                                        width: 0.8,
                                        color: ThemeColors.redTextColor),
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(1.0)),
                                      borderSide: BorderSide(
                                          width: 0.8,
                                          color: ThemeColors.redTextColor)),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter country';
                                  }

                                  return null;
                                },
                                onChanged: (value) {
                                  // profile.name = value;
                                  setState(() {
                                    // _nameController.text = value;
                                    if (_formKey.currentState!.validate()) {}
                                  });
                                },
                              ),

                            ],
                          ),

                        ),
                      ),

                      SizedBox(height: 10,),


                      const Divider(
                        // height: 2,
                        thickness: 2.0,
                      ),

                      const Divider(
                        // height: 2,
                        thickness: 2.0,
                      ),


                      ///Vehicle Information
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text("Vehicle Information",
                          style: TextStyle(fontFamily: 'Poppins', fontSize: 18,fontWeight: FontWeight.w500),
                          textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis,
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(left: 40.0,right: 40.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 0.0, bottom: 2),
                              child: Text("Vehicle Name",
                                style: TextStyle(fontFamily: 'Poppins', fontSize: 14,fontWeight: FontWeight.w400,color: Colors.black.withOpacity(0.5)),
                                textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 0.0, bottom: 2),
                              child: Text("Vehicle Type",
                                style: TextStyle(fontFamily: 'Poppins', fontSize: 14,fontWeight: FontWeight.w400,color: Colors.black.withOpacity(0.5)),
                                textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),

                      profileVehicleInfoList!.length>0?
                      SizedBox(
                        // height: MediaQuery.of(context).size.height/4,
                          child: ListView.builder(
                              padding: const EdgeInsets.all(8),
                              shrinkWrap: true,
                              itemCount: profileVehicleInfoList!.length,
                              itemBuilder: (BuildContext context,index) {
                                return Padding(
                                  padding: const EdgeInsets.only(left: 20.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                          height: 50,
                                          width: MediaQuery.of(context).size.width/1.2,
                                          margin: EdgeInsets.all(2),
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                color: Colors.red,
                                                width: 1,
                                              )),
                                          child:Container(
                                            height: 40,
                                            color: ThemeColors.whiteTextColor,
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.only(left: 8),
                                                    child: Container(
                                                      width: MediaQuery.of(context).size.width * 0.4,
                                                      child: Text('${index+1}. ${profileVehicleInfoList![index].vehicleName}',
                                                        style: TextStyle(fontFamily: 'Poppins',color: Colors.black),
                                                        textAlign: TextAlign.start, maxLines: 2, overflow: TextOverflow.ellipsis,
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.only(right: 10),
                                                    child: Text('${profileVehicleInfoList![index].vehicleType}',
                                                      style: TextStyle(fontFamily: 'Poppins',color: Colors.black),
                                                      textAlign: TextAlign.end, maxLines: 2, overflow: TextOverflow.ellipsis,
                                                    ),
                                                  ),

                                                ],
                                              ),
                                            ),
                                          )

                                      ),
                                    ],
                                  ),
                                );
                              }
                          )
                      ):SizedBox(),

                      const Divider(
                        // height: 2,
                        thickness: 2.0,
                      ),

                      const Divider(
                        // height: 2,
                        thickness: 2.0,
                      ),

                      ///Driver Details
                      const Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Text("Driver Details",
                          style: TextStyle(fontFamily: 'Poppins', fontSize: 18,fontWeight: FontWeight.w500),
                          textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis,
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.only(left: 30,right: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 0.0, bottom: 10),
                              child: Text("Driver Image",
                                style: TextStyle(fontFamily: 'Poppins', fontSize: 14,fontWeight: FontWeight.w400,color: Colors.black.withOpacity(0.5)),
                                textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            ///Owner Profile
                            CachedNetworkImage(
                              filterQuality: FilterQuality.medium,
                              imageUrl: profileDriverDetailsList![0].driverPic.toString(),
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
                                  height: 220,
                                  width: MediaQuery.of(context).size.width,
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


                            SizedBox(height: 15,),

                            Padding(
                              padding: const EdgeInsets.only(left: 0.0, bottom: 10),
                              child: Text("Name",
                                style: TextStyle(fontFamily: 'Poppins', fontSize: 14,fontWeight: FontWeight.w400,color: Colors.black.withOpacity(0.5)),
                                textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            ///Name
                            TextFormField(
                              readOnly: true,
                              controller: _driverNameController,
                              textAlign: TextAlign.start,
                              keyboardType: TextInputType.text,
                              style: TextStyle(
                                fontSize: 18,
                                height: 1.5,
                              ),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: ThemeColors.whiteTextColor,
                                hintText: "Full Name",
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 15.0),
                                hintStyle: TextStyle(fontSize: 15),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(1.0)),
                                  borderSide: BorderSide(
                                      width: 0.8,
                                      color: ThemeColors.redTextColor
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(1.0)),
                                  borderSide: BorderSide(
                                      width: 0.8,
                                      color: ThemeColors.redTextColor),
                                ),
                                border: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(1.0)),
                                    borderSide: BorderSide(
                                        width: 0.8,
                                        color: ThemeColors.redTextColor)),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter name';
                                }
                                return null;
                              },
                              onChanged: (value) {
                                // profile.name = value;
                                setState(() {
                                  // _nameController.text = value;
                                  if (_formKey.currentState!.validate()) {}
                                });
                              },
                            ),

                            SizedBox(height: 15,),

                            Padding(
                              padding: const EdgeInsets.only(left: 0.0, bottom: 10),
                              child: Text("Phone Number",
                                style: TextStyle(fontFamily: 'Poppins', fontSize: 14,fontWeight: FontWeight.w400,color: Colors.black.withOpacity(0.5)),
                                textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            ///Phone Number
                            TextFormField(
                              readOnly: true,
                              controller: _driverPhoneController,
                              textAlign: TextAlign.start,
                              keyboardType: TextInputType.number,
                              style: TextStyle(
                                fontSize: 18,
                                height: 1.5,
                              ),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: ThemeColors.whiteTextColor,
                                hintText: "Phone Number",
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 15.0),
                                hintStyle: TextStyle(fontSize: 15),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(1.0)),
                                  borderSide: BorderSide(
                                      width: 0.8,
                                      color: ThemeColors.redTextColor
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(1.0)),
                                  borderSide: BorderSide(
                                      width: 0.8,
                                      color: ThemeColors.redTextColor),
                                ),
                                border: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(1.0)),
                                    borderSide: BorderSide(
                                        width: 0.8,
                                        color: ThemeColors.redTextColor)),
                              ),
                              validator: (value) {
                                String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
                                RegExp regExp = new RegExp(patttern);
                                if (value?.length == 0) {
                                  return 'Please enter mobile number';
                                }
                                else if (!regExp.hasMatch(value!)) {
                                  return 'Please enter valid mobile number';
                                }
                                return null;
                              },
                              onChanged: (value) {
                                // profile.name = value;
                                setState(() {
                                  // _nameController.text = value;
                                  if (_formKey.currentState!.validate()) {}
                                });
                              },
                            ),

                            SizedBox(height: 15,),

                            Padding(
                              padding: const EdgeInsets.only(left: 0.0, bottom: 10),
                              child: Text("Driver License Validity",
                                style: TextStyle(fontFamily: 'Poppins', fontSize: 14,fontWeight: FontWeight.w400,color: Colors.black.withOpacity(0.5)),
                                textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            ///Driver License Validity
                            TextFormField(
                              readOnly: true,
                              controller: _driverLicenseValidityController,
                              textAlign: TextAlign.start,
                              keyboardType: TextInputType.text,
                              style: TextStyle(
                                fontSize: 18,
                                height: 1.5,
                              ),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: ThemeColors.whiteTextColor,
                                hintText: "Driver License Validity",
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 15.0),
                                hintStyle: TextStyle(fontSize: 15),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(1.0)),
                                  borderSide: BorderSide(
                                      width: 0.8,
                                      color: ThemeColors.redTextColor
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(1.0)),
                                  borderSide: BorderSide(
                                      width: 0.8,
                                      color: ThemeColors.redTextColor),
                                ),
                                border: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(1.0)),
                                    borderSide: BorderSide(
                                        width: 0.8,
                                        color: ThemeColors.redTextColor)),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please Enter Driver License Validity';
                                }
                                return null;
                              },
                              onChanged: (value) {
                                // profile.name = value;
                                setState(() {
                                  // _nameController.text = value;
                                  if (_formKey.currentState!.validate()) {}
                                });
                              },
                            ),

                            SizedBox(height: 15,),

                            Padding(
                              padding: const EdgeInsets.only(left: 0.0, bottom: 10),
                              child: Text("Driver License Number",
                                style: TextStyle(fontFamily: 'Poppins', fontSize: 14,fontWeight: FontWeight.w400,color: Colors.black.withOpacity(0.5)),
                                textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            ///Driver License Number
                            TextFormField(
                              readOnly: true,
                              controller: _driverLicenseNumberController,
                              textAlign: TextAlign.start,
                              keyboardType: TextInputType.text,
                              style: TextStyle(
                                fontSize: 18,
                                height: 1.5,
                              ),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: ThemeColors.whiteTextColor,
                                hintText: "Driver License Number",
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 15.0),
                                hintStyle: TextStyle(fontSize: 15),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(1.0)),
                                  borderSide: BorderSide(
                                      width: 0.8,
                                      color: ThemeColors.redTextColor
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(1.0)),
                                  borderSide: BorderSide(
                                      width: 0.8,
                                      color: ThemeColors.redTextColor),
                                ),
                                border: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(1.0)),
                                    borderSide: BorderSide(
                                        width: 0.8,
                                        color: ThemeColors.redTextColor)),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please Enter Driver License Number';
                                }
                                return null;
                              },
                              onChanged: (value) {
                                // profile.name = value;
                                setState(() {
                                  // _nameController.text = value;
                                  if (_formKey.currentState!.validate()) {}
                                });
                              },
                            ),

                            SizedBox(height: 15,),

                            Padding(
                              padding: const EdgeInsets.only(left: 0.0, bottom: 10),
                              child: Text("Driver License Image",
                                style: TextStyle(fontFamily: 'Poppins', fontSize: 14,fontWeight: FontWeight.w400,color: Colors.black.withOpacity(0.5)),
                                textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            ///Driving License Image
                            CachedNetworkImage(
                              filterQuality: FilterQuality.medium,
                              imageUrl: profileDriverDetailsList![0].drivingLicence.toString(),
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
                                  height: 220,
                                  width: MediaQuery.of(context).size.width,
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


                            SizedBox(height: 15,),

                            Padding(
                              padding: const EdgeInsets.only(left: 0.0, bottom: 10),
                              child: Text("Driver Id Proof",
                                style: TextStyle(fontFamily: 'Poppins', fontSize: 14,fontWeight: FontWeight.w400,color: Colors.black.withOpacity(0.5)),
                                textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            ///Driver Id Proof
                            CachedNetworkImage(
                              filterQuality: FilterQuality.medium,
                              imageUrl: profileDriverDetailsList![0].idProof.toString(),
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
                                  height: 220,
                                  width: MediaQuery.of(context).size.width,
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

                          ],
                        ),
                      ),






                      const SizedBox(height: 10,),


                      Center(
                          child: BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
                            return BlocListener<ProfileBloc, ProfileState>(
                              listener: (context, state) {
                                if(state is UpdateTransportProfileLoading){
                                  loading = state.isLoading;
                                }
                                if(state is UpdateTransportProfileSuccess){
                                  showCustomSnackBar(context,state.message,isError: false);
                                }
                                if(state is UpdateTransportProfileFail){
                                  showCustomSnackBar(context,state.msg.toString(),isError: true);
                                }
                              },
                              child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                              title: Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  new Text("Add Your Issue."),
                                                  SizedBox(height: 5,),
                                                  Form(
                                                    key: _desKey,
                                                    child: TextFormField(
                                                      controller: _descriptionController,
                                                      obscureText: false,
                                                      textAlign: TextAlign.start,
                                                      keyboardType:
                                                      TextInputType.text,
                                                      maxLines: 4,
                                                      style: const TextStyle(
                                                        fontSize: 18,
                                                        height: 1.5,
                                                      ),
                                                      decoration: const InputDecoration(
                                                        filled: true,
                                                        fillColor: ThemeColors.textFieldBackgroundColor,
                                                        contentPadding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 10.0,
                                                            horizontal: 15.0),
                                                        hintStyle:
                                                        TextStyle(fontSize: 15),
                                                        enabledBorder:
                                                        OutlineInputBorder(
                                                          borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  10.0)),
                                                          borderSide: BorderSide(
                                                              width: 0.8,
                                                              color: ThemeColors
                                                                  .textFieldBackgroundColor),
                                                        ),
                                                        focusedBorder:
                                                        OutlineInputBorder(
                                                          borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  10.0)),
                                                          borderSide: BorderSide(
                                                              width: 0.8,
                                                              color: ThemeColors
                                                                  .textFieldBackgroundColor),
                                                        ),
                                                        border: OutlineInputBorder(
                                                            borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    10.0)),
                                                            borderSide: BorderSide(
                                                                width: 0.8,
                                                                color: ThemeColors
                                                                    .textFieldBackgroundColor)),
                                                        hintText: "Add Description",
                                                      ),
                                                      validator: (value) {
                                                        if (value == null ||
                                                            value.isEmpty) {
                                                          return 'Please enter description';
                                                        }
                                                        return null;
                                                      },
                                                      onChanged: (value) {
                                                        setState(() {
                                                          if (_formKey.currentState!
                                                              .validate()) {}
                                                        });
                                                      },
                                                    ),
                                                  ),
                                                  SizedBox(height: 5,),
                                                ],
                                              ),

                                              // content: new Text(""),
                                              actions: <Widget>[
                                                Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                                  children: [
                                                    TextButton(
                                                        child: new Text(
                                                          "No",
                                                          style: TextStyle(
                                                              color: Colors.black),
                                                        ),
                                                        onPressed: () {
                                                          Navigator.of(context).pop();
                                                        },
                                                        style: TextButton.styleFrom(
                                                          fixedSize: const Size(120, 30),
                                                          shape:
                                                          const RoundedRectangleBorder(
                                                              borderRadius:
                                                              BorderRadius.all(
                                                                  Radius.circular(
                                                                      25))),
                                                          side: BorderSide(
                                                              color: ThemeColors
                                                                  .defaultbuttonColor,
                                                              width: 1.5),
                                                        )),
                                                    SizedBox(
                                                      width: 7,
                                                    ),
                                                    TextButton(
                                                      child: new Text(
                                                        "Yes",
                                                        style:
                                                        TextStyle(color: Colors.white),
                                                      ),
                                                      onPressed: () {
                                                        if(_desKey.currentState!.validate());
                                                        if(_descriptionController.text != ""){
                                                          confirDailoge();
                                                        }
                                                        else{
                                                          showCustomSnackBar(context,'Please Enter Description.');
                                                        }
                                                      },
                                                      style: TextButton.styleFrom(
                                                        fixedSize: const Size(120, 30),
                                                        backgroundColor: ThemeColors
                                                            .defaultbuttonColor,
                                                        shape:
                                                        const RoundedRectangleBorder(
                                                            borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    25))),),

                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ));
                                      },
                                      style: ElevatedButton.styleFrom(
                                        primary: ThemeColors.defaultbuttonColor,
                                        shape: StadiumBorder(),
                                      ),
                                      child: loading ? Text(
                                        "Assign Task",
                                        style: Theme.of(context)
                                            .textTheme
                                            .button!
                                            .copyWith(color: Colors.white, fontWeight: FontWeight.w600),
                                      ) : Center(child: SizedBox(width:25, height:25,child: CircularProgressIndicator()),),

                                    ),
                                  )),

                            );


                          })

                      )
                    ],
                  ),
                ),
              )
                  : Center(child: CircularProgressIndicator(),),

            );


          }),
      ),
    );
  }
}
