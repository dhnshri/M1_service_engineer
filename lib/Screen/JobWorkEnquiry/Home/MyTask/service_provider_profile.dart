import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:service_engineer/Bloc/profile/profile_bloc.dart';
import 'package:service_engineer/Bloc/profile/profile_event.dart';
import 'package:service_engineer/Bloc/profile/profile_state.dart';
import 'package:service_engineer/Config/image.dart';
import 'package:service_engineer/Constant/theme_colors.dart';
import 'package:service_engineer/Model/JobWorkEnquiry/my_task_model.dart';
import 'package:service_engineer/Model/JobWorkEnquiry/task_hand_over_jwe_model.dart';
import 'package:service_engineer/Model/machine_list_model.dart';
import 'package:service_engineer/Model/profile_repo.dart';
import 'package:service_engineer/Screen/JobWorkEnquiry/Home/MyTask/my_task_detail.dart';
import 'package:service_engineer/Screen/LoginRegistration/signUpAs.dart';
import 'package:service_engineer/Screen/bottom_navbar.dart';
import 'package:service_engineer/Utils/application.dart';
import 'package:service_engineer/Widget/custom_snackbar.dart';
import 'package:service_engineer/image_file.dart';
import 'package:flutter_custom_selector/flutter_custom_selector.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shimmer/shimmer.dart';


class JobWorkServiceProviderProfile extends StatefulWidget {
  JobWorkServiceProviderProfile({Key? key,required this.serviceList,required this.myTaskJobWorkEnquiryData}) : super(key: key);
  JobWorkEnquiryTaskHandOverModel? serviceList;
  JobWorkEnquiryMyTaskModel myTaskJobWorkEnquiryData;

  @override
  _JobWorkServiceProviderProfileState createState() => _JobWorkServiceProviderProfileState();
}

class _JobWorkServiceProviderProfileState extends State<JobWorkServiceProviderProfile> {
  bool loading = true;
  ImageFile? imageFile;
  File? _image;
  final picker = ImagePicker();
  File? _uploadCompanyProfileImage;
  UploadCompanyProfileFile? uploadCompanyProfileImageFile;
  File? _uploadUserProfileImage;
  UserProfileImageFile? uploadUserProfileImageFile;


  final _formKey = GlobalKey<FormState>();
  final _desKey = GlobalKey<FormState>();
  final _addressFormKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _iDController = TextEditingController();
  final _companyNameController = TextEditingController();
  final _coOrdinatorNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _gstController = TextEditingController();
  final _categoryController = TextEditingController();
  final _sub_CategoryController = TextEditingController();
  final _addressController = TextEditingController();
  final _pinCodeController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final _countryController = TextEditingController();
  final _machineNameController = TextEditingController();
  final _quantityController = TextEditingController();
  final _descriptionController = TextEditingController();

  List<MachineList> machineList = [];
  final List<String> quantity = [];
  bool _isLoading = false;
  ProfileBloc? _profileBloc;
  List<ServiceUserData>? serviceUserdataList;
  List<ProfileKYCDetails>? profileKycList;
  List<JobWorkMachineList>? profileMachineList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    uploadCompanyProfileImageFile = new UploadCompanyProfileFile();
    uploadUserProfileImageFile = new UserProfileImageFile();
    _profileBloc = BlocProvider.of<ProfileBloc>(this.context);
    _profileBloc!.add(GetJobWorkProfile(
        serviceUserId: widget.serviceList!.serviceUser.toString(),
        roleId: widget.serviceList!.role.toString()));
  }

  getData(){
    if(serviceUserdataList!.isNotEmpty || profileKycList!.isNotEmpty || profileMachineList!.isNotEmpty){
      _iDController.text = serviceUserdataList![0].email.toString();
      _companyNameController.text =serviceUserdataList![0].companyName.toString();
      _coOrdinatorNameController.text = serviceUserdataList![0].coordinateName.toString();
      _emailController.text = serviceUserdataList![0].email.toString();
      _phoneController.text = serviceUserdataList![0].mobile.toString();
      _gstController.text = serviceUserdataList![0].gstNo.toString();
      uploadCompanyProfileImageFile!.imagePath = serviceUserdataList![0].companyProfilePic!.split('/').last.toString();
      // _uploadCompanyProfileImage = File(widget.serviceUserdataList![0].companyProfilePic!.split('/').last.toString());
      uploadUserProfileImageFile!.imagePath = serviceUserdataList![0].userProfilePic.toString();
      _addressController.text = serviceUserdataList![0].currentAddress.toString();
      _pinCodeController.text = serviceUserdataList![0].pincode.toString();
      _cityController.text = serviceUserdataList![0].city.toString();
      _stateController.text = serviceUserdataList![0].state.toString();
      _countryController.text = serviceUserdataList![0].country.toString();
    }else{
      _iDController.text = "";
      _companyNameController.text = "";
      _coOrdinatorNameController.text = "";
      _emailController.text = "";
      _phoneController.text = "";
      _gstController.text = "";
      uploadCompanyProfileImageFile!.imagePath = "";
      uploadUserProfileImageFile!.imagePath = "";
      _addressController.text = "";
      _pinCodeController.text = "";
      _cityController.text = "";
      _stateController.text = "";
      _countryController.text = "";
      imageFile!.imagePath = "";
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _iDController.clear();
    _nameController.clear();
    _companyNameController.clear();
    _coOrdinatorNameController.clear();
    _emailController.clear();
    _phoneController.clear();
    _gstController.clear();
    _categoryController.clear();
    _sub_CategoryController.clear();
    _addressController.clear();
    _pinCodeController.clear();
    _cityController.clear();
    _stateController.clear();
    _countryController.clear();
    _descriptionController.clear();
  }


  void addToMachineList(){
    setState(() {
      int count = 0;
      // machineName.insert(0,_machineNameController.text);
      // quantity.insert(0, _quantityController.text);
      machineList.add(MachineList(id:count++,machineName: _machineNameController.text.toString(),quantity: _quantityController.text.toString()));
      print(machineList);
    });
  }

  List<String> dataString = [
    "Pakistan",
    "Saudi Arabia",
    "UAE",
    "USA",
    "Turkey",
    "Brazil",
    "Tunisia",
    'Canada'
  ];
  String? selectedString;
  List<String>? selectedDataString;

  void _onCountriesSelectionComplete(value) {
    selectedDataString?.addAll(value);
    setState(() {});
  }

  confirDailoge(){
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: new Text("Are you sure, you want to send this quotation?"),
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
                    _profileBloc!.add(JobWorkTaskHandover(
                        serviceUserId: widget.serviceList!.serviceUser.toString(),
                        jobWorkEnquiryId: widget.myTaskJobWorkEnquiryData.enquiryId.toString(),
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
            // leading: InkWell(
            //     onTap: (){
            //       Navigator.of(context).pop;
            //     },
            //     child: Icon(Icons.arrow_back_ios)),
            title: const Text("Profile",
              style: TextStyle(
                  fontFamily: 'Poppins-Medium'
              ),),
            backgroundColor: ThemeColors.backGroundColor,
          ),

          body: BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
            return BlocListener<ProfileBloc, ProfileState>(
              listener: (context, state) {
                if(state is GetJobWorkProfileLoading){
                  _isLoading = state.isLoading;
                }
                if(state is GetJobWorkProfileSuccess){
                  serviceUserdataList = state.serviceUserdataList;
                  profileKycList = state.profileKycList;
                  profileMachineList = state.profileMachineList;
                  getData();
                  for(int i=0; i < profileMachineList!.length;i++){
                    machineList.add(MachineList(id:i,machineName: profileMachineList![i].machineName.toString(),quantity: profileMachineList![i].quantity.toString()));
                    setState(() {});
                  }
                }
                if(state is GetJobWorkProfileFail){
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
              child: _isLoading ?
              SingleChildScrollView(
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
                                          child: SizedBox(
                                              width: 150.0,
                                              height: 150.0,
                                              child:
                                              (uploadUserProfileImageFile!.imagePath == null || uploadUserProfileImageFile!.imagePath == "")?
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Image.asset(
                                                  Images.profile_icon,
                                                  fit: BoxFit.fill,
                                                ),
                                              )
                                                  : Image.network(
                                                uploadUserProfileImageFile!.imagePath!,
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
                                      Text("Hello",
                                        style: TextStyle(fontFamily: 'Poppins-Regular',fontSize: 16),),
                                      Text(_companyNameController.text,
                                        style: TextStyle(fontFamily: 'Poppins-Medium', fontSize: 18,fontWeight: FontWeight.w500),
                                        textAlign: TextAlign.start, maxLines: 2, overflow: TextOverflow.ellipsis,
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),

                      ///Details
                      const Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Text("Details",
                          style: TextStyle(fontFamily: 'Poppins-Medium', fontSize: 18,fontWeight: FontWeight.w500),
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
                              child: Text("ID",
                                style: TextStyle(fontFamily: 'Poppins-Regular', fontSize: 14,fontWeight: FontWeight.w400,color: Colors.black.withOpacity(0.5)),
                                textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            ///ID
                            TextFormField(
                              enabled: false,
                              controller: _iDController,
                              textAlign: TextAlign.start,
                              keyboardType: TextInputType.emailAddress,
                              style: TextStyle(
                                fontSize: 18,
                                height: 1.5,
                              ),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: ThemeColors.textFieldBackgroundColor,
                                hintText: "9876543210@qwert",
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 15.0),
                                hintStyle: TextStyle(fontSize: 15),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(1.0)),
                                  borderSide: BorderSide(
                                      width: 0.8,
                                      color: ThemeColors.textFieldBackgroundColor
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(1.0)),
                                  borderSide: BorderSide(
                                      width: 0.8,
                                      color: ThemeColors.textFieldBackgroundColor),
                                ),
                                border: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(1.0)),
                                    borderSide: BorderSide(
                                        width: 0.8,
                                        color: ThemeColors.textFieldBackgroundColor)),
                              ),
                              validator: (value) {
                                // profile.name = value!.trim();
                                // Pattern pattern =
                                //     r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                // RegExp regex =
                                // new RegExp(pattern.toString());
                                if (value == null || value.isEmpty) {
                                  return 'Please enter ID';
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
                              child: Text("Company Name",
                                style: TextStyle(fontFamily: 'Poppins-Regular', fontSize: 14,fontWeight: FontWeight.w400,color: Colors.black.withOpacity(0.5)),
                                textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            ///Company Name
                            TextFormField(
                              enabled: false,
                              controller: _companyNameController,
                              textAlign: TextAlign.start,
                              keyboardType: TextInputType.text,
                              style: TextStyle(
                                fontSize: 18,
                                height: 1.5,
                              ),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: ThemeColors.textFieldBackgroundColor,
                                hintText: "Company Name",
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 15.0),
                                hintStyle: TextStyle(fontSize: 15),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(1.0)),
                                  borderSide: BorderSide(
                                      width: 0.8,
                                      color: ThemeColors.textFieldBackgroundColor
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(1.0)),
                                  borderSide: BorderSide(
                                      width: 0.8,
                                      color: ThemeColors.textFieldBackgroundColor),
                                ),
                                border: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(1.0)),
                                    borderSide: BorderSide(
                                        width: 0.8,
                                        color: ThemeColors.textFieldBackgroundColor)),
                              ),
                              validator: (value) {
                                // profile.name = value!.trim();
                                // Pattern pattern =
                                //     r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                // RegExp regex =
                                // new RegExp(pattern.toString());
                                if (value == null || value.isEmpty) {
                                  return 'Please enter company name';
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
                              child: Text("Co-Ordinator Name",
                                style: TextStyle(fontFamily: 'Poppins-Regular', fontSize: 14,fontWeight: FontWeight.w400,color: Colors.black.withOpacity(0.5)),
                                textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            ///CoOrdinator Name
                            TextFormField(
                              enabled: false,
                              controller: _coOrdinatorNameController,
                              textAlign: TextAlign.start,
                              keyboardType: TextInputType.text,
                              style: TextStyle(
                                fontSize: 18,
                                height: 1.5,
                              ),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: ThemeColors.textFieldBackgroundColor,
                                hintText: "Coordinator's Name",
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 15.0),
                                hintStyle: TextStyle(fontSize: 15),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(1.0)),
                                  borderSide: BorderSide(
                                      width: 0.8,
                                      color: ThemeColors.textFieldBackgroundColor
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(1.0)),
                                  borderSide: BorderSide(
                                      width: 0.8,
                                      color: ThemeColors.textFieldBackgroundColor),
                                ),
                                border: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(1.0)),
                                    borderSide: BorderSide(
                                        width: 0.8,
                                        color: ThemeColors.textFieldBackgroundColor)),
                              ),
                              validator: (value) {
                                // profile.name = value!.trim();
                                // Pattern pattern =
                                //     r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                // RegExp regex =
                                // new RegExp(pattern.toString());
                                if (value == null || value.isEmpty) {
                                  return 'Please enter coordinator name';
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
                              child: Text("Email",
                                style: TextStyle(fontFamily: 'Poppins-Regular', fontSize: 14,fontWeight: FontWeight.w400,color: Colors.black.withOpacity(0.5)),
                                textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            ///Email
                            TextFormField(
                              enabled: false,
                              controller: _emailController,
                              textAlign: TextAlign.start,
                              keyboardType: TextInputType.emailAddress,
                              style: TextStyle(
                                fontSize: 18,
                                height: 1.5,
                              ),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: ThemeColors.textFieldBackgroundColor,
                                hintText: "Email",
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 15.0),
                                hintStyle: TextStyle(fontSize: 15),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(1.0)),
                                  borderSide: BorderSide(
                                      width: 0.8,
                                      color: ThemeColors.textFieldBackgroundColor
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(1.0)),
                                  borderSide: BorderSide(
                                      width: 0.8,
                                      color: ThemeColors.textFieldBackgroundColor),
                                ),
                                border: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(1.0)),
                                    borderSide: BorderSide(
                                        width: 0.8,
                                        color: ThemeColors.textFieldBackgroundColor)),
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

                            Padding(
                              padding: const EdgeInsets.only(left: 0.0, bottom: 10),
                              child: Text("Phone Number",
                                style: TextStyle(fontFamily: 'Poppins-Regular', fontSize: 14,fontWeight: FontWeight.w400,color: Colors.black.withOpacity(0.5)),
                                textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            ///Phone Number
                            TextFormField(
                              enabled: false,
                              controller: _phoneController,
                              textAlign: TextAlign.start,
                              keyboardType: TextInputType.text,
                              style: TextStyle(
                                fontSize: 18,
                                height: 1.5,
                              ),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: ThemeColors.textFieldBackgroundColor,
                                hintText: "Phone Number",
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 15.0),
                                hintStyle: TextStyle(fontSize: 15),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(1.0)),
                                  borderSide: BorderSide(
                                      width: 0.8,
                                      color: ThemeColors.textFieldBackgroundColor
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(1.0)),
                                  borderSide: BorderSide(
                                      width: 0.8,
                                      color: ThemeColors.textFieldBackgroundColor),
                                ),
                                border: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(1.0)),
                                    borderSide: BorderSide(
                                        width: 0.8,
                                        color: ThemeColors.textFieldBackgroundColor)),
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
                              child: Text("GST Number",
                                style: TextStyle(fontFamily: 'Poppins-Regular', fontSize: 14,fontWeight: FontWeight.w400,color: Colors.black.withOpacity(0.5)),
                                textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            ///GST Number
                            TextFormField(
                              enabled: false,
                              controller: _gstController,
                              textAlign: TextAlign.start,
                              keyboardType: TextInputType.text,
                              style: TextStyle(
                                fontSize: 18,
                                height: 1.5,
                              ),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: ThemeColors.textFieldBackgroundColor,
                                hintText: "GST Number",
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 15.0),
                                hintStyle: TextStyle(fontSize: 15),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(1.0)),
                                  borderSide: BorderSide(
                                      width: 0.8,
                                      color: ThemeColors.textFieldBackgroundColor
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(1.0)),
                                  borderSide: BorderSide(
                                      width: 0.8,
                                      color: ThemeColors.textFieldBackgroundColor),
                                ),
                                border: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(1.0)),
                                    borderSide: BorderSide(
                                        width: 0.8,
                                        color: ThemeColors.textFieldBackgroundColor)),
                              ),
                              validator: (value) {
                                Pattern pattern = r'^([0][1-9]|[1-2][0-9]|[3][0-7])([a-zA-Z]{5}[0-9]{4}[a-zA-Z]{1}[1-9a-zA-Z]{1}[zZ]{1}[0-9a-zA-Z]{1})+$';
                                RegExp regex = new RegExp(pattern.toString());
                                if (value == null || value.isEmpty) {
                                  return 'Please Enter GST Number';
                                }else if(!regex.hasMatch(value)){
                                  return 'Please enter valid GST Number';
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
                              child: Text("Category",
                                style: TextStyle(fontFamily: 'Poppins-Regular', fontSize: 14,fontWeight: FontWeight.w400,color: Colors.black.withOpacity(0.5)),
                                textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            ///Category
                            SizedBox(
                              // height: deviceHeight,
                              // width: deviceWidth,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[

                                  CustomMultiSelectField<String>(
                                    decoration: InputDecoration(
                                        suffixIcon: Icon(Icons.arrow_drop_down),
                                        filled: true,
                                        fillColor: ThemeColors.textFieldBackgroundColor
                                    ),
                                    title: "Category",
                                    items: dataString,
                                    enableAllOptionSelect: true,
                                    onSelectionDone: _onCountriesSelectionComplete,
                                    itemAsString: (item) => item.toString(),
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(height: 15,),

                            Padding(
                              padding: const EdgeInsets.only(left: 0.0, bottom: 10),
                              child: Text("Company Profile",
                                style: TextStyle(fontFamily: 'Poppins-Regular', fontSize: 14,fontWeight: FontWeight.w400,color: Colors.black.withOpacity(0.5)),
                                textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            CachedNetworkImage(
                              filterQuality: FilterQuality.medium,
                              imageUrl: serviceUserdataList![0].companyProfilePic.toString(),
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

                      const SizedBox(height: 15,),

                      const Divider(
                        thickness: 5.0,
                      ),

                      ///Machine List
                      const Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Text("Machine List",
                          style: TextStyle(fontFamily: 'Poppins-Medium', fontSize: 18,fontWeight: FontWeight.w500),
                          textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis,
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(left: 40.0,right: 40.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 0.0, bottom: 5),
                              child: Text("Machine Name",
                                style: TextStyle(fontFamily: 'Poppins-Regular', fontSize: 14,fontWeight: FontWeight.w400,color: Colors.black.withOpacity(0.5)),
                                textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 0.0, bottom: 5),
                              child: Text("Quantity",
                                style: TextStyle(fontFamily: 'Poppins-Regular', fontSize: 14,fontWeight: FontWeight.w400,color: Colors.black.withOpacity(0.5)),
                                textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                      machineList.length>0?
                      SizedBox(
                        // height: MediaQuery.of(context).size.height/4,
                          child: ListView.builder(
                              padding: const EdgeInsets.all(8),
                              shrinkWrap: true,
                              itemCount: machineList.length,
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
                                          // color: msgCount[index]>=10? Colors.blue[400]:
                                          // msgCount[index]>3? Colors.blue[100]: Colors.grey,
                                          child:Container(
                                            height: 40,
                                            color: ThemeColors.greyBackgrounColor,
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.only(left: 8),
                                                    child: Container(
                                                      width: MediaQuery.of(context).size.width * 0.4,
                                                      child: Text('${machineList[index].machineName}',
                                                        style: TextStyle(fontFamily: 'Poppins-Medium',color: Colors.black),
                                                        textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis,
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.only(right: 10),
                                                    child: Text('${machineList[index].quantity}',
                                                      style: TextStyle(fontFamily: 'Poppins-Medium',color: Colors.black),
                                                      textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis,
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


                      SizedBox(height: 15,),

                      Divider(
                        // height: 2,
                        thickness: 5.0,
                      ),

                      ///Address
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text("Address",
                          style: TextStyle(fontFamily: 'Poppins-Medium', fontSize: 18,fontWeight: FontWeight.w500),
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

                              Padding(
                                padding: const EdgeInsets.only(left: 0.0, bottom: 10),
                                child: Text("Address",
                                  style: TextStyle(fontFamily: 'Poppins-Regular', fontSize: 14,fontWeight: FontWeight.w400,color: Colors.black.withOpacity(0.5)),
                                  textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              ///Address
                              TextFormField(
                                enabled: false,
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
                                  style: TextStyle(fontFamily: 'Poppins-Regular', fontSize: 14,fontWeight: FontWeight.w400,color: Colors.black.withOpacity(0.5)),
                                  textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              ///Pin Code
                              TextFormField(
                                enabled: false,
                                controller: _pinCodeController,
                                textAlign: TextAlign.start,
                                keyboardType: TextInputType.number,
                                style: TextStyle(
                                  fontSize: 18,
                                  height: 1.5,
                                ),
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: ThemeColors.textFieldBackgroundColor,
                                  hintText: "Pin Code",
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 15.0),
                                  hintStyle: TextStyle(fontSize: 15),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(1.0)),
                                    borderSide: BorderSide(
                                        width: 0.8,
                                        color: ThemeColors.textFieldBackgroundColor
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(1.0)),
                                    borderSide: BorderSide(
                                        width: 0.8,
                                        color: ThemeColors.textFieldBackgroundColor),
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(1.0)),
                                      borderSide: BorderSide(
                                          width: 0.8,
                                          color: ThemeColors.textFieldBackgroundColor)),
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
                                  style: TextStyle(fontFamily: 'Poppins-Regular', fontSize: 14,fontWeight: FontWeight.w400,color: Colors.black.withOpacity(0.5)),
                                  textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              ///City
                              TextFormField(
                                enabled: false,
                                controller: _cityController,
                                textAlign: TextAlign.start,
                                keyboardType: TextInputType.text,
                                style: TextStyle(
                                  fontSize: 18,
                                  height: 1.5,
                                ),
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: ThemeColors.textFieldBackgroundColor,
                                  hintText: "City",
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 15.0),
                                  hintStyle: TextStyle(fontSize: 15),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(1.0)),
                                    borderSide: BorderSide(
                                        width: 0.8,
                                        color: ThemeColors.textFieldBackgroundColor
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(1.0)),
                                    borderSide: BorderSide(
                                        width: 0.8,
                                        color: ThemeColors.textFieldBackgroundColor),
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(1.0)),
                                      borderSide: BorderSide(
                                          width: 0.8,
                                          color: ThemeColors.textFieldBackgroundColor)),
                                ),
                                validator: (value) {
                                  // profile.name = value!.trim();
                                  // Pattern pattern =
                                  //     r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                  // RegExp regex =
                                  // new RegExp(pattern.toString());
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter city';
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
                                child: Text("State",
                                  style: TextStyle(fontFamily: 'Poppins-Regular', fontSize: 14,fontWeight: FontWeight.w400,color: Colors.black.withOpacity(0.5)),
                                  textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              ///State
                              TextFormField(
                                enabled: false,
                                controller: _stateController,
                                textAlign: TextAlign.start,
                                keyboardType: TextInputType.text,
                                style: TextStyle(
                                  fontSize: 18,
                                  height: 1.5,
                                ),
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: ThemeColors.textFieldBackgroundColor,
                                  hintText: "State",
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 15.0),
                                  hintStyle: TextStyle(fontSize: 15),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(1.0)),
                                    borderSide: BorderSide(
                                        width: 0.8,
                                        color: ThemeColors.textFieldBackgroundColor
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(1.0)),
                                    borderSide: BorderSide(
                                        width: 0.8,
                                        color: ThemeColors.textFieldBackgroundColor),
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(1.0)),
                                      borderSide: BorderSide(
                                          width: 0.8,
                                          color: ThemeColors.textFieldBackgroundColor)),
                                ),
                                validator: (value) {
                                  // profile.name = value!.trim();
                                  // Pattern pattern =
                                  //     r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                  // RegExp regex =
                                  // new RegExp(pattern.toString());
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter state';
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
                                child: Text("Country",
                                  style: TextStyle(fontFamily: 'Poppins-Regular', fontSize: 14,fontWeight: FontWeight.w400,color: Colors.black.withOpacity(0.5)),
                                  textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              ///Country
                              TextFormField(
                                enabled: false,
                                controller: _countryController,
                                textAlign: TextAlign.start,
                                keyboardType: TextInputType.text,
                                style: TextStyle(
                                  fontSize: 18,
                                  height: 1.5,
                                ),
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: ThemeColors.textFieldBackgroundColor,
                                  hintText: "Country",
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 15.0),
                                  hintStyle: TextStyle(fontSize: 15),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(1.0)),
                                    borderSide: BorderSide(
                                        width: 0.8,
                                        color: ThemeColors.textFieldBackgroundColor
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(1.0)),
                                    borderSide: BorderSide(
                                        width: 0.8,
                                        color: ThemeColors.textFieldBackgroundColor),
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(1.0)),
                                      borderSide: BorderSide(
                                          width: 0.8,
                                          color: ThemeColors.textFieldBackgroundColor)),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter country';
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

                            ],
                          ),

                        ),
                      ),
                      SizedBox(height: 40,),

                      Center(
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
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  height: 1.5,
                                                ),
                                                decoration: InputDecoration(
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
                                child: Text(
                                  "Assign Task",
                                  style: Theme.of(context)
                                      .textTheme
                                      .button!
                                      .copyWith(color: Colors.white, fontWeight: FontWeight.w600),
                                ),

                              ),
                            )),
                      ),

                      SizedBox(height: 40,)

                    ],
                  ),
                ),
              ): Center(child: CircularProgressIndicator(),),

            );


          }),

      ),
    );
  }
}
