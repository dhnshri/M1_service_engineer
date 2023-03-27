import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:service_engineer/Bloc/profile/profile_bloc.dart';
import 'package:service_engineer/Bloc/profile/profile_event.dart';
import 'package:service_engineer/Bloc/profile/profile_state.dart';
import 'package:service_engineer/Model/MachineMaintance/myTaskModel.dart';
import 'package:service_engineer/Model/MachineMaintance/task_hand_over_model.dart';
import 'package:service_engineer/Model/profile_repo.dart';
import 'package:service_engineer/Model/track_process_repo.dart';
import 'package:service_engineer/Screen/MachineMaintenance/MyTask/my_task_detail.dart';
import 'package:service_engineer/Screen/MachineMaintenance/Profile/widget/expirence_company.dart';
import 'package:flutter_custom_selector/flutter_custom_selector.dart';
import 'package:service_engineer/Widget/custom_snackbar.dart';
import 'package:service_engineer/image_file.dart';
import '../../../Config/image.dart';
import '../../../Constant/theme_colors.dart';


class ServiceProviderProfileScreen extends StatefulWidget {
  ServiceProviderProfileScreen({Key? key,required this.handoverServiceListData,required this.trackProgressData,required this.myTaskData}) : super(key: key);
  MachineMaintanceTaskHandOverModel? handoverServiceListData;
  TrackProcessModel trackProgressData;
  MyTaskModel myTaskData;

  @override
  _ServiceProviderProfileScreenState createState() => _ServiceProviderProfileScreenState();
}

class _ServiceProviderProfileScreenState extends State<ServiceProviderProfileScreen> {
  bool loading = true;
  final _formKey = GlobalKey<FormState>();
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
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();


  List<ExpCompanyFormWidget> expCompanyForms = List.empty(growable: true);


  final List<String> machineName = [];
  final List<String> quantity = [];
  ProfileBloc? _profileBloc;
  bool _isLoading = false;
  List<ServiceUserData>? serviceUserdataList;
  List<ProfileKYCDetails>? profileKycList;
  List<JobWorkMachineList>? profileMachineList;
  List<MachineMaintenanceExperiences>? profileMachineExperienceList;
  List<MachineMaintenanceEducations>? profileMachineEducationList;
  final _yearsController = TextEditingController();
  final _monthsController = TextEditingController();
  File? _userProfileImage;
  UserProfileImageFile? userProfileImageFile;

  @override
  void initState() {
    // TODO: implement initState
    userProfileImageFile = new UserProfileImageFile();
    super.initState();
    _profileBloc = BlocProvider.of<ProfileBloc>(this.context);
    _profileBloc!.add(GetMachineProfile(
        serviceUserId: widget.handoverServiceListData!.serviceUser.toString(),
        roleId: widget.handoverServiceListData!.role.toString()));
  }


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _descriptionController.clear();
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
    _yearsController.clear();
    _monthsController.clear();
    _priceController.clear();
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
  String dropdownvalue = 'INR';

  // List of items in our dropdown menu
  var items = [
    'INR'
  ];

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
                    if(_priceController.text == ""){
                      _priceController.text = "0";
                    }
                    _profileBloc!.add(MachineTaskHandover(
                        serviceUserId: widget.handoverServiceListData!.serviceUser.toString(),
                        machineEnquiryId: widget.myTaskData.enquiryId.toString(),
                        dailyTaskId: widget.trackProgressData.id.toString(),
                        description: _descriptionController.text,
                        price: _priceController.text));
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

  GetData(){
    if(serviceUserdataList!=null){
      _iDController.text = serviceUserdataList![0].email.toString();
      _nameController.text = serviceUserdataList![0].name.toString();
      _emailController.text = serviceUserdataList![0].email.toString();
      _phoneController.text = serviceUserdataList![0].mobile.toString();
      _gstController.text = serviceUserdataList![0].gstNo.toString();
      _yearsController.text = profileMachineExperienceList![0].yearOfExperience.toString();
      _monthsController.text = profileMachineExperienceList![0].monthOfExperience.toString();
      userProfileImageFile!.imagePath = serviceUserdataList![0].userProfilePic.toString();
      // selectedDataString?.addAll(serviceUserdataList![0].workCatgory);
    }else{
      _iDController.text = "";
      _nameController.text = "";
      _emailController.text = "";
      _phoneController.text = "";
      _gstController.text = "";
      _yearsController.text = "";
      _monthsController.text = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            // leading: Icon(Icons.arrow_back_ios),
            title: Text("Profile",
              style: TextStyle(
                  fontFamily: 'Poppins-Medium'
              ),),
            backgroundColor: ThemeColors.backGroundColor,
          ),
          body: BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
            return BlocListener<ProfileBloc, ProfileState>(
              listener: (context, state) {
                if(state is GetMachineProfileLoading){
                  _isLoading = state.isLoading;
                }
                if(state is GetMachineProfileSuccess){
                  serviceUserdataList = state.serviceUserdataList;
                  profileKycList = state.profileKycList;
                  profileMachineExperienceList = state.profileMachineExperienceList;
                  profileMachineEducationList = state.profileMachineEducationList;
                  GetData();
                }
                if(state is GetMachineProfileFail){
                  showCustomSnackBar(context,state.msg.toString(),isError: true);
                }
                if(state is MachineTaskHandoverLoading){
                  _isLoading = state.isLoading;
                }
                if(state is MachineTaskHandoverSuccess){
                  showCustomSnackBar(context,state.msg.toString(),isError: false);
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>
                      MyTaskDetailsScreen(myTaskData: widget.myTaskData,)));
                }
                if(state is MachineTaskHandoverFail){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>
                      MyTaskDetailsScreen(myTaskData: widget.myTaskData,)));
                  showCustomSnackBar(context,state.msg.toString(),isError: true);
                }
              },
              child: _isLoading ?SingleChildScrollView(
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
                                              (userProfileImageFile!.imagePath == null || userProfileImageFile!.imagePath == "")?
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Image.asset(
                                                  Images.profile_icon,
                                                  fit: BoxFit.fill,
                                                ),
                                              )
                                                : Image.network(
                                                userProfileImageFile!.imagePath.toString(),
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
                                      Container(
                                          child:Text(_nameController.text,
                                            style: TextStyle(fontFamily: 'Poppins-Medium', fontSize: 18,fontWeight: FontWeight.w500),
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
                              child: Text("Name",
                                style: TextStyle(fontFamily: 'Poppins-Regular', fontSize: 14,fontWeight: FontWeight.w400,color: Colors.black.withOpacity(0.5)),
                                textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            ///Name
                            TextFormField(
                              enabled: false,
                              controller: _nameController,
                              textAlign: TextAlign.start,
                              keyboardType: TextInputType.text,
                              style: TextStyle(
                                fontSize: 18,
                                height: 1.5,
                              ),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: ThemeColors.textFieldBackgroundColor,
                                hintText: "Full Name",
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
                                  return 'Please enter name';
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
                                    title: "Work Category",
                                    items: dataString,
                                    enableAllOptionSelect: true,
                                    onSelectionDone: _onCountriesSelectionComplete,
                                    itemAsString: (item) => item.toString(),
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(height: 15,),

                            ///Sub-Category
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
                                    title: "Work Sub-Category",
                                    items: dataString,
                                    enableAllOptionSelect: true,
                                    onSelectionDone: _onCountriesSelectionComplete,
                                    itemAsString: (item) => item.toString(),
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(height: 15,),

                            ///Total Experience
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ///Years
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 0.0, bottom: 10),
                                      child: Text("Year",
                                        style: TextStyle(fontFamily: 'Poppins-Regular', fontSize: 14,fontWeight: FontWeight.w400,color: Colors.black.withOpacity(0.5)),
                                        textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width * 0.4,
                                      child: TextFormField(
                                        enabled: false,
                                        controller: _yearsController,
                                        textAlign: TextAlign.start,
                                        keyboardType: TextInputType.number,
                                        style: TextStyle(
                                          fontSize: 18,
                                          height: 1.5,
                                        ),
                                        decoration: InputDecoration(
                                          filled: true,
                                          fillColor: ThemeColors.textFieldBackgroundColor,
                                          hintText: "Years",
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
                                            return 'Please enter Years';
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
                                    ),
                                  ],
                                ),

                                ///Months
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 0.0, bottom: 10),
                                      child: Text("Months",
                                        style: TextStyle(fontFamily: 'Poppins-Regular', fontSize: 14,fontWeight: FontWeight.w400,color: Colors.black.withOpacity(0.5)),
                                        textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width * 0.4,

                                      child: TextFormField(
                                        enabled: false,
                                        controller: _monthsController,
                                        textAlign: TextAlign.start,
                                        keyboardType: TextInputType.number,
                                        style: TextStyle(
                                          fontSize: 18,
                                          height: 1.5,
                                        ),
                                        decoration: InputDecoration(
                                          filled: true,
                                          fillColor: ThemeColors.textFieldBackgroundColor,
                                          hintText: "Months",
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
                                            return 'Please enter months';
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
                                    ),
                                  ],
                                ),


                              ],
                            ),
                          ],
                        ),
                      ),

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
                                            TextFormField(
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
                                              // onSaved: (value) => widget.expCompanyModel!.desciption = value!,

                                              onChanged: (value) {
                                                setState(() {
                                                  if (_formKey.currentState!
                                                      .validate()) {}
                                                });
                                              },
                                            ),
                                            SizedBox(height: 5,),
                                            Row(
                                              children: const [
                                                 Text("Add Price for Task."),
                                                  Text("(optional)", style: TextStyle(
                                                      fontFamily: 'Poppins-SemiBold',
                                                      fontSize: 10,
                                                  ),)
                                              ],
                                            ),
                                            SizedBox(height: 5,),

                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  width: MediaQuery.of(context).size.width * 0.13,
                                                  child: DropdownButton(

                                                    // Initial Value
                                                    value: dropdownvalue,

                                                    // Down Arrow Icon
                                                    icon: const Icon(Icons.keyboard_arrow_down),

                                                    // Array list of items
                                                    items: items.map((String items) {
                                                      return DropdownMenuItem(
                                                        value: items,
                                                        child: Text(items),
                                                      );
                                                    }).toList(),
                                                    // After selecting the desired option,it will
                                                    // change button value to selected value
                                                    onChanged: (String? newValue) {
                                                      setState(() {
                                                        dropdownvalue = newValue!;
                                                      });
                                                    },
                                                  ),
                                                ),
                                                Expanded(
                                                  child: SizedBox(
                                                    width: MediaQuery.of(context).size.width * 0.9,
                                                    child: TextFormField(
                                                      // initialValue: Application.customerLogin!.name.toString(),
                                                      controller: _priceController,
                                                      textAlign: TextAlign.start,
                                                      keyboardType: TextInputType.number,
                                                      style: TextStyle(
                                                        fontSize: 18,
                                                        height: 1.5,
                                                      ),
                                                      decoration: InputDecoration(
                                                        filled: true,
                                                        fillColor: ThemeColors.textFieldBackgroundColor,
                                                        hintText: "Amount",
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
                                                        // String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
                                                        // RegExp regExp = new RegExp(patttern);
                                                        if (value?.length == 0) {
                                                          return 'Please enter amount';
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
                                                  ),
                                                ),
                                              ],
                                            )
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
                      )


                    ],
                  ),
                ),
              ) : Center(child: CircularProgressIndicator(),)

            );
          }),
      ),
    );
  }
}
