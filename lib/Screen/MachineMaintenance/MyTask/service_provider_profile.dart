import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:service_engineer/Screen/MachineMaintenance/Profile/widget/expirence_company.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_custom_selector/flutter_custom_selector.dart';

import '../../../Config/image.dart';
import '../../../Constant/theme_colors.dart';
import '../../../Model/experience_company_model.dart';
import '../../../image_file.dart';
import '../../LoginRegistration/signUpAs.dart';


// import '../../Config/font.dart';
// import '../../Config/image.dart';
// import '../../Constant/theme_colors.dart';
// import '../../Widget/app_button.dart';
// import '../../image_file.dart';

class ServiceProviderProfileScreen extends StatefulWidget {
  const ServiceProviderProfileScreen({Key? key}) : super(key: key);

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
  final _ageController = TextEditingController();
  final _genderController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();


  List<ExpCompanyFormWidget> expCompanyForms = List.empty(growable: true);


  final List<String> machineName = [];
  final List<String> quantity = [];




  @override
  void initState() {
    // TODO: implement initState
    //saveDeviceTokenAndId();
    super.initState();
  }


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _ageController.clear();
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
    _genderController.clear();
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
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) =>
                    //             BottomNavigation(
                    //               index: 0,
                    //               dropValue:
                    //               'Job Work Enquiry',
                    //             )));
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
            // leading: Icon(Icons.arrow_back_ios),
            title: Text("Profile",
              style: TextStyle(
                  fontFamily: 'Poppins-Medium'
              ),),
            backgroundColor: ThemeColors.backGroundColor,
          ),
          body:SingleChildScrollView(
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
                                          // (profileData!.profile_img == null || profileData!.profile_img == "")?
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Image.asset(
                                              Images.profile_icon,
                                              fit: BoxFit.fill,
                                            ),
                                          )
                                        //     : Image.network(
                                        //   profileData!.profile_img.toString(),
                                        //   fit: BoxFit.fill,
                                        // )

                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    right: 0,
                                    child: CircleAvatar(
                                      radius: 18,
                                      backgroundColor: ThemeColors.blackColor,
                                      child: CircleAvatar(
                                        radius: 17,
                                        backgroundColor: ThemeColors.backGroundColor,
                                        child: IconButton(
                                          onPressed: () {
                                            //image picker
                                            // getImage();
                                            // _openGallery(context);
                                          },
                                          icon: Icon(
                                            Icons.edit,
                                            size: 20,
                                            color: ThemeColors.blackColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
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
                                      child:Text("Mcxeeco Sanasam",
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
                      children: [
                        ///ID
                        TextFormField(
                          // initialValue: Application.customerLogin!.name.toString(),
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

                        ///Name
                        TextFormField(
                          // initialValue: Application.customerLogin!.name.toString(),
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

                        ///Email
                        TextFormField(
                          // initialValue: Application.customerLogin!.name.toString(),
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

                        ///Phone Number
                        TextFormField(
                          // initialValue: Application.customerLogin!.name.toString(),
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

                        ///GST Number
                        TextFormField(
                          // initialValue: Application.customerLogin!.name.toString(),
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

                        ///AGE and GENDER
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ///Age
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.4,
                              child: TextFormField(
                                // initialValue: Application.customerLogin!.name.toString(),
                                controller: _ageController,
                                textAlign: TextAlign.start,
                                keyboardType: TextInputType.number,
                                style: TextStyle(
                                  fontSize: 18,
                                  height: 1.5,
                                ),
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: ThemeColors.textFieldBackgroundColor,
                                  hintText: "Age",
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

                            ///Gender
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.4,

                              child: TextFormField(
                                // initialValue: Application.customerLogin!.name.toString(),
                                controller: _genderController,
                                textAlign: TextAlign.start,
                                keyboardType: TextInputType.number,
                                style: TextStyle(
                                  fontSize: 18,
                                  height: 1.5,
                                ),
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: ThemeColors.textFieldBackgroundColor,
                                  hintText: "Gender",
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
                                        new Text("Add Price for Task."),
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
                                              confirDailoge();
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
          )
      ),
    );
  }
}
