import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:service_engineer/Screen/MachineMaintenance/Profile/widget/education_form.dart';
import 'package:service_engineer/Screen/MachineMaintenance/Profile/widget/expirence_company.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_custom_selector/flutter_custom_selector.dart';
import '../../../../Utils/application.dart';

import '../../../Config/image.dart';
import '../../../Constant/theme_colors.dart';
import '../../../Model/education_model.dart';
import '../../../Model/experience_company_model.dart';
import '../../../Utils/application.dart';
import '../../../image_file.dart';
import '../../LoginRegistration/signUpAs.dart';


// import '../../Config/font.dart';
// import '../../Config/image.dart';
// import '../../Constant/theme_colors.dart';
// import '../../Widget/app_button.dart';
// import '../../image_file.dart';

class MachineProfileScreen extends StatefulWidget {
  const MachineProfileScreen({Key? key}) : super(key: key);

  @override
  _MachineProfileScreenState createState() => _MachineProfileScreenState();
}

class _MachineProfileScreenState extends State<MachineProfileScreen> {
  bool loading = true;
  ImageFile? imageFile;
  File? _image;
  final picker = ImagePicker();




  final _formKey = GlobalKey<FormState>();
  final _addressFormKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _driverNameController = TextEditingController();
  final _iDController = TextEditingController();
  final _companyNameController = TextEditingController();
  final _coOrdinatorNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _driverPhoneController = TextEditingController();
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
  final _driverLicenseValidityController = TextEditingController();
  final _driverLicenseNumberController = TextEditingController();
  final _vehicleNameController = TextEditingController();
  final _vehicleTypeController = TextEditingController();
  final _chassisNumberController = TextEditingController();
  final _registrationUptoController = TextEditingController();
  final _vehicleNumberController = TextEditingController();
  final _yearsController = TextEditingController();
  final _monthsController = TextEditingController();
  final _workFromYearsController = TextEditingController();
  final _workTillYearsController = TextEditingController();
  final _workFromMonthsController = TextEditingController();
  final _workTillMonthsController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _bankNameController = TextEditingController();
  final _accountNumberController = TextEditingController();
  final _iFSCCodeController = TextEditingController();
  final _branchNameController = TextEditingController();
  final _upiIdController = TextEditingController();
  final _ageController = TextEditingController();
  final _genderController = TextEditingController();
  final _jobPostController = TextEditingController();
  final _schoolNameController = TextEditingController();
  final _courseNameController = TextEditingController();
  final _passingYearController = TextEditingController();

  List<ExpCompanyFormWidget> expCompanyForms = List.empty(growable: true);


  final List<String> machineName = [];
  final List<String> quantity = [];




  @override
  void initState() {
    // TODO: implement initState
    //saveDeviceTokenAndId();
    super.initState();
    imageFile = new ImageFile();
    _iDController.text = Application.customerLogin!.email.toString();
    _nameController.text = Application.customerLogin!.name.toString();
    _emailController.text = Application.customerLogin!.email.toString();
    _phoneController.text = Application.customerLogin!.mobile.toString();
  }


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // getroleofstudent();

    _schoolNameController.clear();
    _courseNameController.clear();
    _passingYearController.clear();
    _jobPostController.clear();
    _ageController.clear();
    _genderController.clear();
    _bankNameController.clear();
    _accountNumberController.clear();
    _iFSCCodeController.clear();
    _branchNameController.clear();
    _upiIdController.clear();
    _descriptionController.clear();
    _workFromMonthsController.clear();
    _workTillMonthsController.clear();
    _workFromYearsController.clear();
    _workTillYearsController.clear();
    _yearsController.clear();
    _monthsController.clear();
    _vehicleNameController.clear();
    _vehicleTypeController.clear();
    _vehicleNumberController.clear();
    _chassisNumberController.clear();
    _registrationUptoController.clear();
    _driverLicenseNumberController.clear();
    _driverLicenseValidityController.clear();
    _iDController.clear();
    _nameController.clear();
    _driverNameController.clear();
    _driverPhoneController.clear();
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

  onAdd() {
    setState(() {
      ExpCompanyModel _contactModel = ExpCompanyModel(id: expCompanyForms.length);
      expCompanyForms.add(ExpCompanyFormWidget(
        index: expCompanyForms.length,
        expCompanyModel: _contactModel,
        onRemove: () => onRemove(_contactModel),
      ));
    });
  }

  //Delete specific form
  onRemove(ExpCompanyModel expCompanyModel) {
    setState(() {
      int index = expCompanyForms
          .indexWhere((element) => element.expCompanyModel!.id == expCompanyModel.id);

      if (expCompanyForms != null) expCompanyForms.removeAt(index);
    });
  }

  List<EducationFormWidget> educationForms = List.empty(growable: true);

  educationOnAdd() {
    setState(() {
      EducationModel _educationModel = EducationModel();
      educationForms.add(EducationFormWidget(
        index: educationForms.length,
        educationModel: _educationModel,
        onRemove: () => educationOnRemove(_educationModel),
      ));
    });
  }

  educationOnRemove(EducationModel educationModel) {
    setState(() {
      int index = educationForms
          .indexWhere((element) => element.educationModel!.id == educationModel.id);

      if (educationForms != null) educationForms.removeAt(index);
    });
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
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (context) => SignUpAsScreen()));
                  Application.preferences!.remove('user');
                  // _RemoverUser();
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => SignUpAsScreen()),
                        (Route<dynamic> route) => false,
                  );
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
                                  Container(
                                      child:Text(Application.customerLogin!.name == ""? "": Application.customerLogin!.name.toString(),
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

                  ///User Data
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
                                keyboardType: TextInputType.text,
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
                  SizedBox(height: 10,),


                  Divider(
                    // height: 2,
                    thickness: 2.0,
                  ),

                  Divider(
                    // height: 2,
                    thickness: 2.0,
                  ),


                  ///Total Expirence
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text("Total Experince",
                      style: TextStyle(fontFamily: 'Poppins-Medium', fontSize: 18,fontWeight: FontWeight.w500),
                      textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis,
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.only(left: 30,right: 10),
                    child: Form(
                      // key: _formKey,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ///Years
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.4,
                            child: TextFormField(
                              // initialValue: Application.customerLogin!.name.toString(),
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

                          ///Months
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.4,

                            child: TextFormField(
                              // initialValue: Application.customerLogin!.name.toString(),
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

                    ),
                  ),

                  SizedBox(height: 10,),


                  Divider(
                    // height: 2,
                    thickness: 2.0,
                  ),

                  Divider(
                    // height: 2,
                    thickness: 2.0,
                  ),


                  ///Expirence in companies
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text("Experience in Companies",
                      style: TextStyle(fontFamily: 'Poppins-Medium', fontSize: 18,fontWeight: FontWeight.w500),
                      textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis,
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.only(left: 30,right: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        expCompanyForms.isNotEmpty
                        ? Column(
                          children: [
                            ListView.builder(
                                itemCount: expCompanyForms.length,
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (_, index) {
                                  return expCompanyForms[index];
                                }),
                          ],
                        )
                            : SizedBox(),

                        ///Add More
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(expCompanyForms.isNotEmpty?"Add More":"Add",
                              style: TextStyle(fontFamily: 'Poppins-SemiBold', fontSize: 14,fontWeight: FontWeight.w600,color: Colors.black),
                              textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(width: 5,),
                            InkWell(
                              onTap: (){
                                onAdd();
                              },
                              child: CircleAvatar(
                                backgroundColor: ThemeColors.redTextColor,
                                child: Icon(Icons.add,color: Colors.white,),
                              )
                            )
                          ],
                        )



                      ],
                    ),
                  ),

                  Divider(
                    // height: 2,
                    thickness: 2.0,
                  ),

                  Divider(
                    // height: 2,
                    thickness: 2.0,
                  ),

                  SizedBox(height: 10),

                  ///Education
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text("Education",
                      style: TextStyle(fontFamily: 'Poppins-Medium', fontSize: 18,fontWeight: FontWeight.w500),
                      textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis,
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.only(left: 30,right: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        educationForms.isNotEmpty
                            ? Column(
                          children: [
                            ListView.builder(
                                itemCount: educationForms.length,
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (_, index) {
                                  return educationForms[index];
                                }),
                          ],
                        )
                            : SizedBox(),

                        ///Add More
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(educationForms.isNotEmpty?"Add More":"Add",
                              style: TextStyle(fontFamily: 'Poppins-SemiBold', fontSize: 14,fontWeight: FontWeight.w600,color: Colors.black),
                              textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(width: 5,),
                            InkWell(
                                onTap: (){
                                  educationOnAdd();
                                },
                                child: CircleAvatar(
                                  backgroundColor: ThemeColors.redTextColor,
                                  child: Icon(Icons.add,color: Colors.white,),
                                )
                            )
                          ],
                        )



                      ],
                    ),
                  ),

                  // Padding(
                  //   padding: EdgeInsets.only(left: 30,right: 20),
                  //   child: Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       ///School/College Name
                  //       TextFormField(
                  //         // initialValue: Application.customerLogin!.name.toString(),
                  //         controller: _schoolNameController,
                  //         textAlign: TextAlign.start,
                  //         keyboardType: TextInputType.text,
                  //         style: TextStyle(
                  //           fontSize: 18,
                  //           height: 1.5,
                  //         ),
                  //         decoration: InputDecoration(
                  //           filled: true,
                  //           fillColor: ThemeColors.textFieldBackgroundColor,
                  //           hintText: "School/College Name",
                  //           contentPadding: EdgeInsets.symmetric(
                  //               vertical: 10.0, horizontal: 15.0),
                  //           hintStyle: TextStyle(fontSize: 15),
                  //           enabledBorder: OutlineInputBorder(
                  //             borderRadius:
                  //             BorderRadius.all(Radius.circular(1.0)),
                  //             borderSide: BorderSide(
                  //                 width: 0.8,
                  //                 color: ThemeColors.textFieldBackgroundColor
                  //             ),
                  //           ),
                  //           focusedBorder: OutlineInputBorder(
                  //             borderRadius:
                  //             BorderRadius.all(Radius.circular(1.0)),
                  //             borderSide: BorderSide(
                  //                 width: 0.8,
                  //                 color: ThemeColors.textFieldBackgroundColor),
                  //           ),
                  //           border: OutlineInputBorder(
                  //               borderRadius:
                  //               BorderRadius.all(Radius.circular(1.0)),
                  //               borderSide: BorderSide(
                  //                   width: 0.8,
                  //                   color: ThemeColors.textFieldBackgroundColor)),
                  //         ),
                  //         validator: (value) {
                  //           // profile.name = value!.trim();
                  //           // Pattern pattern =
                  //           //     r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                  //           // RegExp regex =
                  //           // new RegExp(pattern.toString());
                  //           if (value == null || value.isEmpty) {
                  //             return 'Please enter School/College Name';
                  //           }
                  //           // else if(!regex.hasMatch(value)){
                  //           //   return 'Please enter valid name';
                  //           // }
                  //           return null;
                  //         },
                  //         onChanged: (value) {
                  //           // profile.name = value;
                  //           setState(() {
                  //             // _nameController.text = value;
                  //             if (_formKey.currentState!.validate()) {}
                  //           });
                  //         },
                  //       ),
                  //
                  //       SizedBox(height: 15,),
                  //
                  //       ///Class/Course Name
                  //       TextFormField(
                  //         // initialValue: Application.customerLogin!.name.toString(),
                  //         controller: _courseNameController,
                  //         textAlign: TextAlign.start,
                  //         keyboardType: TextInputType.text,
                  //         style: TextStyle(
                  //           fontSize: 18,
                  //           height: 1.5,
                  //         ),
                  //         decoration: InputDecoration(
                  //           filled: true,
                  //           fillColor: ThemeColors.textFieldBackgroundColor,
                  //           hintText: "Class/Course Name",
                  //           contentPadding: EdgeInsets.symmetric(
                  //               vertical: 10.0, horizontal: 15.0),
                  //           hintStyle: TextStyle(fontSize: 15),
                  //           enabledBorder: OutlineInputBorder(
                  //             borderRadius:
                  //             BorderRadius.all(Radius.circular(1.0)),
                  //             borderSide: BorderSide(
                  //                 width: 0.8,
                  //                 color: ThemeColors.textFieldBackgroundColor
                  //             ),
                  //           ),
                  //           focusedBorder: OutlineInputBorder(
                  //             borderRadius:
                  //             BorderRadius.all(Radius.circular(1.0)),
                  //             borderSide: BorderSide(
                  //                 width: 0.8,
                  //                 color: ThemeColors.textFieldBackgroundColor),
                  //           ),
                  //           border: OutlineInputBorder(
                  //               borderRadius:
                  //               BorderRadius.all(Radius.circular(1.0)),
                  //               borderSide: BorderSide(
                  //                   width: 0.8,
                  //                   color: ThemeColors.textFieldBackgroundColor)),
                  //         ),
                  //         validator: (value) {
                  //           // profile.name = value!.trim();
                  //           // Pattern pattern =
                  //           //     r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                  //           // RegExp regex =
                  //           // new RegExp(pattern.toString());
                  //           if (value == null || value.isEmpty) {
                  //             return 'Please enter Class/Course Name';
                  //           }
                  //           // else if(!regex.hasMatch(value)){
                  //           //   return 'Please enter valid name';
                  //           // }
                  //           return null;
                  //         },
                  //         onChanged: (value) {
                  //           // profile.name = value;
                  //           setState(() {
                  //             // _nameController.text = value;
                  //             if (_formKey.currentState!.validate()) {}
                  //           });
                  //         },
                  //       ),
                  //
                  //       SizedBox(height: 15,),
                  //
                  //       ///Passing Year
                  //       TextFormField(
                  //         // initialValue: Application.customerLogin!.name.toString(),
                  //         controller: _passingYearController,
                  //         textAlign: TextAlign.start,
                  //         keyboardType: TextInputType.text,
                  //         style: TextStyle(
                  //           fontSize: 18,
                  //           height: 1.5,
                  //         ),
                  //         decoration: InputDecoration(
                  //           filled: true,
                  //           fillColor: ThemeColors.textFieldBackgroundColor,
                  //           hintText: "Passing Year",
                  //           contentPadding: EdgeInsets.symmetric(
                  //               vertical: 10.0, horizontal: 15.0),
                  //           hintStyle: TextStyle(fontSize: 15),
                  //           enabledBorder: OutlineInputBorder(
                  //             borderRadius:
                  //             BorderRadius.all(Radius.circular(1.0)),
                  //             borderSide: BorderSide(
                  //                 width: 0.8,
                  //                 color: ThemeColors.textFieldBackgroundColor
                  //             ),
                  //           ),
                  //           focusedBorder: OutlineInputBorder(
                  //             borderRadius:
                  //             BorderRadius.all(Radius.circular(1.0)),
                  //             borderSide: BorderSide(
                  //                 width: 0.8,
                  //                 color: ThemeColors.textFieldBackgroundColor),
                  //           ),
                  //           border: OutlineInputBorder(
                  //               borderRadius:
                  //               BorderRadius.all(Radius.circular(1.0)),
                  //               borderSide: BorderSide(
                  //                   width: 0.8,
                  //                   color: ThemeColors.textFieldBackgroundColor)),
                  //         ),
                  //         validator: (value) {
                  //           // profile.name = value!.trim();
                  //           // Pattern pattern =
                  //           //     r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                  //           // RegExp regex =
                  //           // new RegExp(pattern.toString());
                  //           if (value == null || value.isEmpty) {
                  //             return 'Please enter Passing Year';
                  //           }
                  //           // else if(!regex.hasMatch(value)){
                  //           //   return 'Please enter valid name';
                  //           // }
                  //           return null;
                  //         },
                  //         onChanged: (value) {
                  //           // profile.name = value;
                  //           setState(() {
                  //             // _nameController.text = value;
                  //             if (_formKey.currentState!.validate()) {}
                  //           });
                  //         },
                  //       ),
                  //
                  //       SizedBox(height: 15,),
                  //
                  //       SizedBox(height: 15,),
                  //
                  //       ///Certificate
                  //       Container(
                  //         height: 50,
                  //         color: ThemeColors.textFieldBackgroundColor,
                  //         child: Padding(
                  //           padding: const EdgeInsets.all(8.0),
                  //           child: Row(
                  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //             children: [
                  //               Padding(
                  //                 padding: const EdgeInsets.only(left: 8),
                  //                 child: Text("Certificate",
                  //                   style: TextStyle(fontFamily: 'Poppins-Medium',color: Colors.black.withOpacity(0.5)),
                  //                   textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis,
                  //                 ),
                  //               ),
                  //               Container(
                  //                 height: 30,
                  //                 color: ThemeColors.textFieldHintColor.withOpacity(0.3),
                  //                 child: Padding(
                  //                   padding: const EdgeInsets.only(left: 4,right: 4),
                  //                   child: Center(child: Text("+Add Image",
                  //                     style: TextStyle(fontFamily: 'Poppins-Regular',color: Colors.black.withOpacity(0.5)),
                  //                     textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis,
                  //                   )),
                  //                 ),
                  //               )
                  //             ],
                  //           ),
                  //         ),
                  //       ),
                  //
                  //       SizedBox(height: 15,),
                  //
                  //
                  //       ///Add More
                  //       Row(
                  //         mainAxisAlignment: MainAxisAlignment.end,
                  //         children: [
                  //           Text("Add More",
                  //             style: TextStyle(fontFamily: 'Poppins-SemiBold', fontSize: 14,fontWeight: FontWeight.w600,color: Colors.black),
                  //             textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis,
                  //           ),
                  //           SizedBox(width: 5,),
                  //           CircleAvatar(
                  //             backgroundColor: ThemeColors.redTextColor,
                  //             child: Icon(Icons.add,color: Colors.white,),
                  //           )
                  //         ],
                  //       )
                  //
                  //
                  //
                  //     ],
                  //   ),
                  // ),

                  Divider(
                    // height: 2,
                    thickness: 2.0,
                  ),

                  Divider(
                    // height: 2,
                    thickness: 2.0,
                  ),

                  SizedBox(height: 10),

                  ///Bank Details
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text("Bank Details",
                      style: TextStyle(fontFamily: 'Poppins-Medium', fontSize: 18,fontWeight: FontWeight.w500),
                      textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis,
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.only(left: 30,right: 20),
                    child: Column(
                      children: [
                        ///Bank NAme
                        TextFormField(
                          // initialValue: Application.customerLogin!.name.toString(),
                          controller: _bankNameController,
                          textAlign: TextAlign.start,
                          keyboardType: TextInputType.text,
                          style: TextStyle(
                            fontSize: 18,
                            height: 1.5,
                          ),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: ThemeColors.textFieldBackgroundColor,
                            hintText: "Bank Name",
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
                              return 'Please enter bank name';
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

                        ///Account Number
                        TextFormField(
                          // initialValue: Application.customerLogin!.name.toString(),
                          controller: _accountNumberController,
                          textAlign: TextAlign.start,
                          keyboardType: TextInputType.text,
                          style: TextStyle(
                            fontSize: 18,
                            height: 1.5,
                          ),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: ThemeColors.textFieldBackgroundColor,
                            hintText: "Account Number",
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
                              return 'Please enter account number';
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

                        ///IFSC Code
                        TextFormField(
                          // initialValue: Application.customerLogin!.name.toString(),
                          controller: _iFSCCodeController,
                          textAlign: TextAlign.start,
                          keyboardType: TextInputType.text,
                          style: TextStyle(
                            fontSize: 18,
                            height: 1.5,
                          ),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: ThemeColors.textFieldBackgroundColor,
                            hintText: "IFSC Code",
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
                              return 'Please enter IFSC code';
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

                        ///Branch Name
                        TextFormField(
                          // initialValue: Application.customerLogin!.name.toString(),
                          controller: _branchNameController,
                          textAlign: TextAlign.start,
                          keyboardType: TextInputType.text,
                          style: TextStyle(
                            fontSize: 18,
                            height: 1.5,
                          ),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: ThemeColors.textFieldBackgroundColor,
                            hintText: "Branch Name",
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
                              return 'Please enter branch name';
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

                        ///UPI ID
                        TextFormField(
                          // initialValue: Application.customerLogin!.name.toString(),
                          controller: _upiIdController,
                          textAlign: TextAlign.start,
                          keyboardType: TextInputType.text,
                          style: TextStyle(
                            fontSize: 18,
                            height: 1.5,
                          ),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: ThemeColors.textFieldBackgroundColor,
                            hintText: "UPI ID",
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
                              return 'Please enter UPI id';
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

                  SizedBox(height: 10,),


                  Divider(
                    // height: 2,
                    thickness: 2.0,
                  ),

                  Divider(
                    // height: 2,
                    thickness: 2.0,
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
