import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:service_engineer/Utils/application.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_custom_selector/flutter_custom_selector.dart';

import '../../../Config/image.dart';
import '../../../Constant/theme_colors.dart';
import '../../../image_file.dart';
import '../../LoginRegistration/signUpAs.dart';


class JobWorkProfileScreen extends StatefulWidget {
  const JobWorkProfileScreen({Key? key}) : super(key: key);

  @override
  _JobWorkProfileScreenState createState() => _JobWorkProfileScreenState();
}

class _JobWorkProfileScreenState extends State<JobWorkProfileScreen> {
  bool loading = true;
  ImageFile? imageFile;
  File? _image;
  final picker = ImagePicker();




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
  final _pinCodeController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final _countryController = TextEditingController();
  final _machineNameController = TextEditingController();
  final _quantityController = TextEditingController();

  final List<String> machineName = [];
  final List<String> quantity = [];




  @override
  void initState() {
    // TODO: implement initState
    //saveDeviceTokenAndId();
    super.initState();
    imageFile = new ImageFile();
    if(Application.customerLogin!.email!.isNotEmpty){
      _iDController.text = Application.customerLogin!.email.toString();
      _nameController.text = Application.customerLogin!.name.toString();
      _emailController.text = Application.customerLogin!.email.toString();
      _phoneController.text = Application.customerLogin!.mobile.toString();
    }
  }


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // getroleofstudent();

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
  }

  ///Method to open gallery
  _openGallery(BuildContext context) async {
    final image =
    await picker.getImage(source: ImageSource.gallery, imageQuality: 25);
    imageFile = new ImageFile();
    if (image != null) {
      _cropImage(image);
    }
  }

  // For crop image

  Future<Null> _cropImage(PickedFile imageCropped) async {
    File? croppedFile = await ImageCropper.cropImage(
        sourcePath: imageCropped.path,
        aspectRatioPresets: Platform.isAndroid
            ? [
          // CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio4x3,
        ]
            : [
          // CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio4x3,
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
        _image = croppedFile;
        imageFile!.imagePath = _image!.path;
      });
      // Navigator.pop(context);
    }
  }

  void addToMachineList(){
    setState(() {
      machineName.insert(0,_machineNameController.text);
      quantity.insert(0, _quantityController.text);
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            leading: Icon(Icons.arrow_back_ios),
            actions: [
              InkWell(
                  onTap: (){
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SignUpAsScreen()));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text("Logout"),
                        SizedBox(width: 5,),
                        Icon(Icons.logout,color: Colors.red,),
                      ],
                    ),
                  ))
            ],
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
                                  Text(Application.customerLogin!.name == ""? "": Application.customerLogin!.name.toString(),
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
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text("Details",
                      style: TextStyle(fontFamily: 'Poppins-Medium', fontSize: 18,fontWeight: FontWeight.w500),
                      textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis,
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
                            hintText: "Name",
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

                        ///Company Name
                        TextFormField(
                          // initialValue: Application.customerLogin!.name.toString(),
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

                        ///CoOrdinator Name
                        TextFormField(
                          // initialValue: Application.customerLogin!.name.toString(),
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
                                title: "Sub-Category",
                                items: dataString,
                                enableAllOptionSelect: true,
                                onSelectionDone: _onCountriesSelectionComplete,
                                itemAsString: (item) => item.toString(),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 15,),

                        ///Company Profile
                        Container(
                          height: 50,
                          color: ThemeColors.textFieldBackgroundColor,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 8),
                                  child: Text("Upload Company Profile",
                                    style: TextStyle(fontFamily: 'Poppins-Medium',color: Colors.black.withOpacity(0.5)),
                                    textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                InkWell(
                                  onTap: (){
                                    _openGallery(context);
                                  },
                                  child: Container(
                                    height: 30,
                                    color: ThemeColors.textFieldHintColor.withOpacity(0.3),
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 4,right: 4),
                                      child: Center(child: Text("+Add Document",
                                        style: TextStyle(fontFamily: 'Poppins-Regular',color: Colors.black.withOpacity(0.5)),
                                        textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis,
                                      )),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),

                        SizedBox(height: 15,),



                      ],
                    ),
                  ),

                  SizedBox(height: 15,),

                  Divider(
                    // height: 2,
                    thickness: 5.0,
                  ),

                  ///Machine List
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text("Machine List",
                      style: TextStyle(fontFamily: 'Poppins-Medium', fontSize: 18,fontWeight: FontWeight.w500),
                      textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis,
                    ),
                  ),

                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ///Machine Name
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.6,
                            child: TextFormField(
                              // initialValue: Application.customerLogin!.name.toString(),
                              controller: _machineNameController,
                              textAlign: TextAlign.start,
                              keyboardType: TextInputType.text,
                              style: TextStyle(
                                fontSize: 18,
                                height: 1.5,
                              ),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: ThemeColors.textFieldBackgroundColor,
                                hintText: "Machine Name",
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
                                  return 'Please enter machine name';
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

                          ///Quantity
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.22,

                            child: TextFormField(
                              // initialValue: Application.customerLogin!.name.toString(),
                              controller: _quantityController,
                              textAlign: TextAlign.start,
                              keyboardType: TextInputType.number,
                              style: TextStyle(
                                fontSize: 18,
                                height: 1.5,
                              ),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: ThemeColors.textFieldBackgroundColor,
                                hintText: "Quantity",
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
                                  return 'Please enter quantity';
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

                          Padding(
                            padding: const EdgeInsets.only(right: 6.0),
                            child: InkWell(
                              onTap: (){
                                addToMachineList();
                              },
                              child: Icon(Icons.add,color: Colors.red,),
                            ),
                          ),


                        ],
                      ),
                      machineName.length>0?
                      Padding(
                        padding: EdgeInsets.only(left: 30,right: 30),
                        child: SizedBox(
                            height: MediaQuery.of(context).size.height/4,
                            child: ListView.builder(
                                padding: const EdgeInsets.all(8),
                                itemCount: machineName.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(left: 20.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                            height: 50,
                                            width: MediaQuery.of(context).size.width/1.3,
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
                                                        child: Text('${machineName[index]}',
                                                          style: TextStyle(fontFamily: 'Poppins-Medium',color: Colors.black),
                                                          textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis,
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.only(right: 10),
                                                      child: Text('${quantity[index]}',
                                                        style: TextStyle(fontFamily: 'Poppins-Medium',color: Colors.black),
                                                        textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis,
                                                      ),
                                                    ),

                                                  ],
                                                ),
                                              ),
                                            )

                                        ),

                                        Padding(
                                          padding: const EdgeInsets.only(right: 6.0),
                                          child: InkWell(
                                            onTap: (){
                                              setState(() {
                                                machineName.removeAt(index);
                                                quantity.removeAt(index);
                                              });

                                            },
                                            child: Icon(Icons.clear,color: ThemeColors.buttonColor,),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }
                            )
                        ),
                      ):SizedBox(),
                    ],
                  ),




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
                        children: [
                          ///Address
                          TextFormField(
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

                          ///Pin Code
                          TextFormField(
                            // initialValue: Application.customerLogin!.name.toString(),
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

                          ///City
                          TextFormField(
                            // initialValue: Application.customerLogin!.name.toString(),
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

                          ///State
                          TextFormField(
                            // initialValue: Application.customerLogin!.name.toString(),
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

                          ///Country
                          TextFormField(
                            // initialValue: Application.customerLogin!.name.toString(),
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

                  SizedBox(height: 15,),

                  Divider(
                    // height: 2,
                    thickness: 5.0,
                  ),

                  ///KYC
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text("KYC",
                      style: TextStyle(fontFamily: 'Poppins-Medium', fontSize: 18,fontWeight: FontWeight.w500),
                      textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis,
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.only(left: 30,right: 20),
                    child: Form(
                      // key: _formKey,
                      child: Column(
                        children: [
                          ///Company Name
                          TextFormField(
                            // initialValue: Application.customerLogin!.name.toString(),
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

                          ///Company Certificate
                          Container(
                            height: 50,
                            color: ThemeColors.textFieldBackgroundColor,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8),
                                    child: Text("Company Certificate",
                                      style: TextStyle(fontFamily: 'Poppins-Medium',color: Colors.black.withOpacity(0.5)),
                                      textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Container(
                                    height: 30,
                                    color: ThemeColors.textFieldHintColor.withOpacity(0.3),
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 4,right: 4),
                                      child: Center(child: Text("+Add Image",
                                        style: TextStyle(fontFamily: 'Poppins-Regular',color: Colors.black.withOpacity(0.5)),
                                        textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis,
                                      )),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),

                          SizedBox(height: 15,),

                          ///GST Certificate
                          Container(
                            height: 50,
                            color: ThemeColors.textFieldBackgroundColor,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8),
                                    child: Text("GST Certificate",
                                      style: TextStyle(fontFamily: 'Poppins-Medium',color: Colors.black.withOpacity(0.5)),
                                      textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Container(
                                    height: 30,
                                    color: ThemeColors.textFieldHintColor.withOpacity(0.3),
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 4,right: 4),
                                      child: Center(child: Text("+Add Image",
                                        style: TextStyle(fontFamily: 'Poppins-Regular',color: Colors.black.withOpacity(0.5)),
                                        textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis,
                                      )),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),

                          SizedBox(height: 15,),

                          ///Upload Pan Card
                          Container(
                            height: 50,
                            color: ThemeColors.textFieldBackgroundColor,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8),
                                    child: Text("Upload Pan Card",
                                      style: TextStyle(fontFamily: 'Poppins-Medium',color: Colors.black.withOpacity(0.5)),
                                      textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Container(
                                    height: 30,
                                    color: ThemeColors.textFieldHintColor.withOpacity(0.3),
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 4,right: 4),
                                      child: Center(child: Text("+Add Image",
                                        style: TextStyle(fontFamily: 'Poppins-Regular',color: Colors.black.withOpacity(0.5)),
                                        textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis,
                                      )),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),

                          SizedBox(height: 15,),

                          ///SHOPACT License
                          Container(
                            height: 50,
                            color: ThemeColors.textFieldBackgroundColor,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8),
                                    child: Text("SHOPACT License",
                                      style: TextStyle(fontFamily: 'Poppins-Medium',color: Colors.black.withOpacity(0.5)),
                                      textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Container(
                                    height: 30,
                                    color: ThemeColors.textFieldHintColor.withOpacity(0.3),
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 4,right: 4),
                                      child: Center(child: Text("+Add Image",
                                        style: TextStyle(fontFamily: 'Poppins-Regular',color: Colors.black.withOpacity(0.5)),
                                        textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis,
                                      )),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),

                          SizedBox(height: 15,),

                          ///MSME/Udhyog Aadhar License
                          Container(
                            height: 50,
                            color: ThemeColors.textFieldBackgroundColor,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width*0.5,

                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 8),
                                      child: Text("MSME/Udhyog Aadhar License",
                                        style: TextStyle(fontFamily: 'Poppins-Medium',color: Colors.black.withOpacity(0.5)),
                                        textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 30,
                                    color: ThemeColors.textFieldHintColor.withOpacity(0.3),
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 4,right: 4),
                                      child: Center(child: Text("+Add Image",
                                        style: TextStyle(fontFamily: 'Poppins-Regular',color: Colors.black.withOpacity(0.5)),
                                        textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis,
                                      )),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )

                        ],
                      ),

                    ),
                  ),

                  SizedBox(height: 15,),

                  Divider(
                    // height: 2,
                    thickness: 3.0,
                  ),

                  Center(
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: ElevatedButton(
                            onPressed: () async { },
                            style: ElevatedButton.styleFrom(
                              primary: ThemeColors.defaultbuttonColor,
                              shape: StadiumBorder(),
                            ),
                            child: Text(
                              "Update Changes",
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
