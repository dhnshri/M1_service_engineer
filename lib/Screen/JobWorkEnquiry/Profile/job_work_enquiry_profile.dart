import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:service_engineer/Model/profile_repo.dart';
import 'package:service_engineer/Utils/application.dart';
import 'package:service_engineer/Widget/custom_snackbar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../Utils/application.dart';
import 'package:flutter_custom_selector/flutter_custom_selector.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import '../../../Bloc/profile/profile_bloc.dart';
import '../../../Bloc/profile/profile_event.dart';
import '../../../Bloc/profile/profile_state.dart';
import '../../../Config/image.dart';
import '../../../Constant/theme_colors.dart';
import '../../../Model/JobWorkEnquiry/category_list_selected_model.dart';
import '../../../Model/machine_list_model.dart';
import '../../../NetworkFunction/fetchJobWorkEnquiryCategoryList.dart';
import '../../../image_file.dart';
import '../../LoginRegistration/signUpAs.dart';


class JobWorkProfileScreen extends StatefulWidget {
  JobWorkProfileScreen({Key? key,required this.serviceUserdataList,required this.profileKycList,required this.profileMachineList}) : super(key: key);
  List<ServiceUserData>? serviceUserdataList;
  List<ProfileKYCDetails>? profileKycList;
  List<JobWorkMachineList>? profileMachineList;
  @override
  _JobWorkProfileScreenState createState() => _JobWorkProfileScreenState();
}

class _JobWorkProfileScreenState extends State<JobWorkProfileScreen> {
  bool loading = true;
  ImageFile? imageFile;
  File? _image;
  final picker = ImagePicker();
  File? _gstImage;
  GstImageFile? gstImageFile;
  File? _panImage;
  PanImageFile? panImageFile;
  File? _shopActImage;
  ShopActImageFile? shopActImageFile;
  File? _aadharImage;
  AddharImageFile? aadharImageFile;
  File? _uploadCompanyProfileImage;
  UploadCompanyProfileFile? uploadCompanyProfileImageFile;
  File? _uploadUserProfileImage;
  UserProfileImageFile? uploadUserProfileImageFile;
  // JobWorkEnquiryCategoryListModel catrgoryTypeselected=JobWorkEnquiryCategoryListModel();
  JobWorkEnquiryCategoryListModel? catrgoryTypeselected;

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

  List<MachineList> machineList = [];
  final List<String> quantity = [];

  String? _currentAddress;
  Position? _currentPosition;

  ProfileBloc? _profileBloc;

  @override
  void initState() {
    // TODO: implement initState
    //saveDeviceTokenAndId();
    super.initState();
    imageFile = new ImageFile();
    gstImageFile = new GstImageFile();
    panImageFile = new PanImageFile();
    shopActImageFile = new ShopActImageFile();
    aadharImageFile = new AddharImageFile();
    uploadCompanyProfileImageFile = new UploadCompanyProfileFile();
    uploadUserProfileImageFile = new UserProfileImageFile();
    _profileBloc = BlocProvider.of<ProfileBloc>(this.context);
    getData();
  }

  getData(){
    if(widget.serviceUserdataList!.isNotEmpty || widget.profileKycList!.isNotEmpty || widget.profileMachineList!.isNotEmpty){

      // catrgoryTypeselected.id=widget.serviceUserdataList![0].jobCategoryId;
      // catrgoryTypeselected.enquiryDetailsCategory=widget.serviceUserdataList![0].jobCategoryName;
      _iDController.text = widget.serviceUserdataList![0].email.toString();
      _companyNameController.text = widget.serviceUserdataList![0].companyName.toString();
      _coOrdinatorNameController.text = widget.serviceUserdataList![0].coordinateName.toString();
      _emailController.text = widget.serviceUserdataList![0].email.toString();
      _phoneController.text = widget.serviceUserdataList![0].mobile.toString();
      _gstController.text = widget.serviceUserdataList![0].gstNo.toString();
      uploadCompanyProfileImageFile!.imagePath = widget.serviceUserdataList![0].companyProfilePic!.split('/').last.toString();
      // _uploadCompanyProfileImage = File(widget.serviceUserdataList![0].companyProfilePic!.split('/').last.toString());
      uploadUserProfileImageFile!.imagePath = widget.serviceUserdataList![0].userProfilePic.toString();
      _addressController.text = widget.serviceUserdataList![0].currentAddress.toString();
      _pinCodeController.text = widget.serviceUserdataList![0].pincode.toString();
      _cityController.text = widget.serviceUserdataList![0].city.toString();
      _stateController.text = widget.serviceUserdataList![0].state.toString();
      _countryController.text = widget.serviceUserdataList![0].country.toString();
      imageFile!.imagePath = widget.profileKycList![0].companyCertificate.toString();
      gstImageFile!.imagePath = widget.profileKycList![0].gstCertificate.toString();
      panImageFile!.imagePath = widget.profileKycList![0].panCard.toString();
      shopActImageFile!.imagePath = widget.profileKycList![0].shopActLicence.toString();
      aadharImageFile!.imagePath = widget.profileKycList![0].udhyogAdharLicence.toString();

      for(int i=0; i < widget.profileMachineList!.length;i++){

        machineList.add(MachineList(id:i,machineName: widget.profileMachineList![i].machineName.toString(),quantity: widget.profileMachineList![i].quantity.toString()));
      }
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
      gstImageFile!.imagePath = "";
      panImageFile!.imagePath = "";
      shopActImageFile!.imagePath = "";
      aadharImageFile!.imagePath = "";
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

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission(context);

    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() => _currentPosition = position);
      _getAddressFromLatLng(_currentPosition!);
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
        _currentPosition!.latitude, _currentPosition!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      setState(() {
        _currentAddress =
        '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';
        _addressController.text = _currentAddress.toString();
        _pinCodeController.text = place.postalCode.toString();
        _cityController.text = place.subAdministrativeArea.toString();
        _stateController.text = place.administrativeArea.toString();
        _countryController.text = place.country.toString();
      });
    }).catchError((e) {
      debugPrint(e);
    });
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
        _image = croppedFile;
        imageFile!.imagePath = _image!.path;
      });
      // Navigator.pop(context);
    }
  }

  _openUserProfileGallery(BuildContext context) async {
    final image =
    await picker.getImage(source: ImageSource.gallery, imageQuality: 25);
    uploadUserProfileImageFile = new UserProfileImageFile();
    if (image != null) {
      _userProfilecropImage(image);
    }
  }

  // For crop image

  Future<Null> _userProfilecropImage(PickedFile imageCropped) async {
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
        _uploadUserProfileImage = croppedFile;
        uploadUserProfileImageFile!.imagePath = _uploadUserProfileImage!.path;
      });
      // Navigator.pop(context);
    }
  }

  _gstCertificateOpenGallery(BuildContext context) async {
    final gstImage =
    await picker.getImage(source: ImageSource.gallery, imageQuality: 25);
    gstImageFile = new GstImageFile();
    if (gstImage != null) {
      _gstCertificateCropImage(gstImage);
    }
  }
  // For crop image
  Future<Null> _gstCertificateCropImage(PickedFile imageCropped) async {
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
        _gstImage = croppedFile;
        gstImageFile!.imagePath = _gstImage!.path;
      });
      // Navigator.pop(context);
    }
  }

  _panCertificateOpenGallery(BuildContext context) async {
    final panImage =
    await picker.getImage(source: ImageSource.gallery, imageQuality: 25);
    panImageFile = new PanImageFile();
    if (panImage != null) {
      _panCertificateCropImage(panImage);
    }
  }
  // For crop image
  Future<Null> _panCertificateCropImage(PickedFile imageCropped) async {
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
        _panImage = croppedFile;
        panImageFile!.imagePath = _panImage!.path;
      });
      // Navigator.pop(context);
    }
  }

  _shopActCertificateOpenGallery(BuildContext context) async {
    final shopActImage =
    await picker.getImage(source: ImageSource.gallery, imageQuality: 25);
    shopActImageFile = new ShopActImageFile();
    if (shopActImage != null) {
      _shopActCertificateCropImage(shopActImage);
    }
  }
  // For crop image
  Future<Null> _shopActCertificateCropImage(PickedFile imageCropped) async {
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
        _shopActImage = croppedFile;
        shopActImageFile!.imagePath = _shopActImage!.path;
      });
      // Navigator.pop(context);
    }
  }

  _aadharCertificateOpenGallery(BuildContext context) async {
    final aadharImage =
    await picker.getImage(source: ImageSource.gallery, imageQuality: 25);
    aadharImageFile = new AddharImageFile();
    if (aadharImage != null) {
      _aadharCertificateCropImage(aadharImage);
    }
  }
  // For crop image
  Future<Null> _aadharCertificateCropImage(PickedFile imageCropped) async {
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
        _aadharImage = croppedFile;
        aadharImageFile!.imagePath = _aadharImage!.path;
      });
      // Navigator.pop(context);
    }
  }


  _uploadCompanyProfileOpenGallery(BuildContext context) async {
    final uploadCompanyProfile =
    await picker.getImage(source: ImageSource.gallery, imageQuality: 25);
    uploadCompanyProfileImageFile = new UploadCompanyProfileFile();
    if (uploadCompanyProfile != null) {
      _companyProfileCropImage(uploadCompanyProfile);
    }
  }
  // For crop image
  Future<Null> _companyProfileCropImage(PickedFile imageCropped) async {
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
        _uploadCompanyProfileImage = croppedFile;
        uploadCompanyProfileImageFile!.imagePath = _uploadCompanyProfileImage!.path;
      });
      // Navigator.pop(context);
    }
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
                    Application.preferences!.remove('online');
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
                  fontFamily: 'Poppins'
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
                                            _openUserProfileGallery(context);
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
                                    style: TextStyle(fontFamily: 'Poppins',fontSize: 16),),
                                  Text(Application.customerLogin!.name == ""? "": Application.customerLogin!.name.toString(),
                                    style: TextStyle(fontFamily: 'Poppins', fontSize: 18,fontWeight: FontWeight.w500),
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
                          child: Text("ID",
                            style: TextStyle(fontFamily: 'Poppins', fontSize: 14,fontWeight: FontWeight.w400,color: Colors.black.withOpacity(0.5)),
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
                            style: TextStyle(fontFamily: 'Poppins', fontSize: 14,fontWeight: FontWeight.w400,color: Colors.black.withOpacity(0.5)),
                            textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis,
                          ),
                        ),
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

                        Padding(
                          padding: const EdgeInsets.only(left: 0.0, bottom: 10),
                          child: Text("Co-Ordinator Name",
                            style: TextStyle(fontFamily: 'Poppins', fontSize: 14,fontWeight: FontWeight.w400,color: Colors.black.withOpacity(0.5)),
                            textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis,
                          ),
                        ),
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

                        Padding(
                          padding: const EdgeInsets.only(left: 0.0, bottom: 10),
                          child: Text("Email",
                            style: TextStyle(fontFamily: 'Poppins', fontSize: 14,fontWeight: FontWeight.w400,color: Colors.black.withOpacity(0.5)),
                            textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis,
                          ),
                        ),
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

                        Padding(
                          padding: const EdgeInsets.only(left: 0.0, bottom: 10),
                          child: Text("Phone Number",
                            style: TextStyle(fontFamily: 'Poppins', fontSize: 14,fontWeight: FontWeight.w400,color: Colors.black.withOpacity(0.5)),
                            textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis,
                          ),
                        ),
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

                        Padding(
                          padding: const EdgeInsets.only(left: 0.0, bottom: 10),
                          child: Text("GST Number",
                            style: TextStyle(fontFamily: 'Poppins', fontSize: 14,fontWeight: FontWeight.w400,color: Colors.black.withOpacity(0.5)),
                            textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis,
                          ),
                        ),
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

                        Padding(
                          padding: const EdgeInsets.only(left: 0.0, bottom: 10),
                          child: Text("Category",
                            style: TextStyle(fontFamily: 'Poppins', fontSize: 14,fontWeight: FontWeight.w400,color: Colors.black.withOpacity(0.5)),
                            textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        ///Category
                        Padding(
                            padding: EdgeInsets.only(top: 8.0, bottom: 0.0),
                            //to hide underline
                            child: FutureBuilder<List<JobWorkEnquiryCategoryListModel>>(
                                future: fetchJWECategoryList(),
                                builder: (BuildContext context,
                                    AsyncSnapshot<List<JobWorkEnquiryCategoryListModel>> snapshot) {
                                  if (!snapshot.hasData) return Container();

                                  return DropdownButtonHideUnderline(
                                      child: Container(
                                        width: MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                          // color: Theme.of(context).dividerColor,
                                            color: ThemeColors.textFieldBackgroundColor,
                                            borderRadius: BorderRadius.circular(5.0),
                                            border: Border.all(
                                                color: ThemeColors.textFieldBgColor)),
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              left: 15.0, top: 0.0, right: 5.0, bottom: 0.0),
                                          child:
                                          //updated on 15/06/2021 to change background colour of dropdownbutton
                                          new Theme(
                                              data: Theme.of(context)
                                                  .copyWith(canvasColor: Colors.white),
                                              child: DropdownButton(
                                                  items: snapshot.data!
                                                      .map((categoryname) =>
                                                      DropdownMenuItem<JobWorkEnquiryCategoryListModel>(
                                                        value: categoryname,
                                                        child: Text(
                                                          categoryname.enquiryDetailsCategory.toString(),
                                                          style: TextStyle(
                                                              color: Colors.black),
                                                        ),
                                                      ))
                                                      .toList(),
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight: FontWeight.w600),
                                                  isExpanded: true,
                                                  hint: Text('Select  Category',
                                                      style: TextStyle(
                                                          color: Color(0xFF3F4141))),
                                                  value: catrgoryTypeselected == null
                                                      ? catrgoryTypeselected
                                                      : snapshot.data!
                                                      .where((i) =>
                                                  i.enquiryDetailsCategory ==
                                                      catrgoryTypeselected!
                                                          .enquiryDetailsCategory)
                                                      .first as JobWorkEnquiryCategoryListModel,
                                                  onChanged: (JobWorkEnquiryCategoryListModel? categoryname) {
                                                    setState(() {
                                                      catrgoryTypeselected = categoryname;
                                                      widget.serviceUserdataList![0].jobCategoryName = categoryname!.enquiryDetailsCategory;
                                                      widget.serviceUserdataList![0].jobCategoryId = categoryname.id;
                                                    });
                                                  })),
                                        ),
                                      ));
                                })),

                        widget.serviceUserdataList![0].jobCategoryName != "" ?
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0,top: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                  // height: 40,
                                  // width: MediaQuery.of(context).size.width/1.3,
                                  margin: EdgeInsets.all(2),
                                  child:Container(
                                    // height: 40,
                                    color: ThemeColors.greyBackgrounColor.withOpacity(0.5),
                                    child: Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(left: 3),
                                            child: Container(
                                              width: MediaQuery.of(context).size.width * 0.4,
                                              child: Text('${widget.serviceUserdataList![0].jobCategoryName}',
                                                style: TextStyle(fontFamily: 'Poppins',color: Colors.black),
                                                textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ),

                                        ],
                                      ),
                                    ),
                                  )

                              ),

                              // Padding(
                              //   padding: const EdgeInsets.only(right: 6.0),
                              //   child: InkWell(
                              //     onTap: (){
                              //       setState(() {
                              //         // int index1 = machineName
                              //         //     .indexWhere((element) => element.id! == machineName[index].id);
                              //
                              //         machineList.removeAt(index);
                              //       });
                              //
                              //     },
                              //     child: Icon(Icons.clear,color: ThemeColors.buttonColor,),
                              //   ),
                              // ),
                            ],
                          ),
                        ) : Container(),

                        SizedBox(height: 15,),

                        Padding(
                          padding: const EdgeInsets.only(left: 0.0, bottom: 10),
                          child: Text("Company Profile",
                            style: TextStyle(fontFamily: 'Poppins', fontSize: 14,fontWeight: FontWeight.w400,color: Colors.black.withOpacity(0.5)),
                            textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        ///Upload Company Profile
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
                                  child: Container(
                                    width: MediaQuery.of(context).size.width * 0.4,
                                    child: Text(uploadCompanyProfileImageFile!.imagePath == null ?"Upload Company Profile" : uploadCompanyProfileImageFile!.imagePath!.split('/').last.toString(),
                                      style: TextStyle(fontFamily: 'Poppins',color: Colors.black.withOpacity(0.5)),
                                      maxLines: 2, overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: (){
                                    _uploadCompanyProfileOpenGallery(context);
                                  },
                                  child: Container(
                                    height: 30,
                                    color: ThemeColors.textFieldHintColor.withOpacity(0.3),
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 4,right: 4),
                                      child: Center(child: Text("+Add Image",
                                        style: TextStyle(fontFamily: 'Poppins',color: Colors.black.withOpacity(0.5)),
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
                      style: TextStyle(fontFamily: 'Poppins', fontSize: 18,fontWeight: FontWeight.w500),
                      textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis,
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.only(left: 30,right: 0),
                    child: Form(
                      // key: _formKey,
                      child: Row(
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
                                _machineNameController.clear();
                                _quantityController.clear();
                              },
                              child: Icon(Icons.add,color: Colors.red,),
                            ),
                          ),


                        ],
                      ),

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
                                                  child: Text('${machineList[index].machineName}',
                                                    style: TextStyle(fontFamily: 'Poppins',color: Colors.black),
                                                    textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(right: 10),
                                                child: Text('${machineList[index].quantity}',
                                                  style: TextStyle(fontFamily: 'Poppins',color: Colors.black),
                                                  textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis,
                                                ),
                                              ),

                                            ],
                                          ),
                                        ),
                                      )

                                  ),

                                  // Padding(
                                  //   padding: const EdgeInsets.only(right: 6.0),
                                  //   child: InkWell(
                                  //     onTap: (){
                                  //       setState(() {
                                  //         // int index1 = machineName
                                  //         //     .indexWhere((element) => element.id! == machineName[index].id);
                                  //
                                  //         machineList.removeAt(index);
                                  //       });
                                  //
                                  //     },
                                  //     child: Icon(Icons.clear,color: ThemeColors.buttonColor,),
                                  //   ),
                                  // ),
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
                          /// GEt Current Location
                          InkWell(
                            onTap:(){
                              _getCurrentPosition();
                            },
                            child: Container(
                              height:50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                                border: Border.all(
                                  color: Colors.red,
                                  // style: BorderStyle.solid,
                                  width: 1.0,
                                ),

                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Location",
                                      style: TextStyle(fontFamily: 'Poppins', fontSize: 18,fontWeight: FontWeight.w500),
                                      textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis,
                                    ),
                                    Icon(Icons.my_location_rounded,color: Colors.red,)
                                  ],
                                ),
                              ),
                            ),
                          ),

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
                              style: TextStyle(fontFamily: 'Poppins', fontSize: 14,fontWeight: FontWeight.w400,color: Colors.black.withOpacity(0.5)),
                              textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis,
                            ),
                          ),
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

                          Padding(
                            padding: const EdgeInsets.only(left: 0.0, bottom: 10),
                            child: Text("City",
                              style: TextStyle(fontFamily: 'Poppins', fontSize: 14,fontWeight: FontWeight.w400,color: Colors.black.withOpacity(0.5)),
                              textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis,
                            ),
                          ),
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

                          Padding(
                            padding: const EdgeInsets.only(left: 0.0, bottom: 10),
                            child: Text("State",
                              style: TextStyle(fontFamily: 'Poppins', fontSize: 14,fontWeight: FontWeight.w400,color: Colors.black.withOpacity(0.5)),
                              textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis,
                            ),
                          ),
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

                          Padding(
                            padding: const EdgeInsets.only(left: 0.0, bottom: 10),
                            child: Text("Country",
                              style: TextStyle(fontFamily: 'Poppins', fontSize: 14,fontWeight: FontWeight.w400,color: Colors.black.withOpacity(0.5)),
                              textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis,
                            ),
                          ),
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
                          Padding(
                            padding: const EdgeInsets.only(left: 0.0, bottom: 10),
                            child: Text("Company Name",
                              style: TextStyle(fontFamily: 'Poppins', fontSize: 14,fontWeight: FontWeight.w400,color: Colors.black.withOpacity(0.5)),
                              textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis,
                            ),
                          ),
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

                          Padding(
                            padding: const EdgeInsets.only(left: 0.0, bottom: 10),
                            child: Text("Company Certificate",
                              style: TextStyle(fontFamily: 'Poppins', fontSize: 14,fontWeight: FontWeight.w400,color: Colors.black.withOpacity(0.5)),
                              textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis,
                            ),
                          ),
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
                                    child: Container(
                                      width: MediaQuery.of(context).size.width * 0.4,
                                      child: Text(imageFile!.imagePath == null ?"Company Certificate" : imageFile!.imagePath!.split('/').last.toString(),
                                        style: TextStyle(fontFamily: 'Poppins',color: Colors.black.withOpacity(0.5)),
                                        maxLines: 2, overflow: TextOverflow.ellipsis,
                                      ),
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
                                        child: Center(child: Text("+Add Image",
                                          style: TextStyle(fontFamily: 'Poppins',color: Colors.black.withOpacity(0.5)),
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

                          Padding(
                            padding: const EdgeInsets.only(left: 0.0, bottom: 10),
                            child: Text("GST Certificate",
                              style: TextStyle(fontFamily: 'Poppins', fontSize: 14,fontWeight: FontWeight.w400,color: Colors.black.withOpacity(0.5)),
                              textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis,
                            ),
                          ),
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
                                    child: Container(
                                      width: MediaQuery.of(context).size.width * 0.4,
                                      child: Text(gstImageFile!.imagePath==null?"GST Certificate":gstImageFile!.imagePath!.split('/').last.toString(),
                                        style: TextStyle(fontFamily: 'Poppins',color: Colors.black.withOpacity(0.5)),
                                        maxLines: 2, overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: (){
                                      _gstCertificateOpenGallery(context);
                                    },
                                    child: Container(
                                      height: 30,
                                      color: ThemeColors.textFieldHintColor.withOpacity(0.3),
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 4,right: 4),
                                        child: Center(child: Text("+Add Image",
                                          style: TextStyle(fontFamily: 'Poppins',color: Colors.black.withOpacity(0.5)),
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

                          Padding(
                            padding: const EdgeInsets.only(left: 0.0, bottom: 10),
                            child: Text("Pan Card",
                              style: TextStyle(fontFamily: 'Poppins', fontSize: 14,fontWeight: FontWeight.w400,color: Colors.black.withOpacity(0.5)),
                              textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis,
                            ),
                          ),
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
                                    child: Container(
                                      width: MediaQuery.of(context).size.width * 0.4,
                                      child: Text(panImageFile!.imagePath == null ?"Upload PAN Card" : panImageFile!.imagePath!.split('/').last.toString(),
                                        style: TextStyle(fontFamily: 'Poppins',color: Colors.black.withOpacity(0.5)),
                                        maxLines: 2, overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: (){
                                      _panCertificateOpenGallery(context);
                                    },
                                    child: Container(
                                      height: 30,
                                      color: ThemeColors.textFieldHintColor.withOpacity(0.3),
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 4,right: 4),
                                        child: Center(child: Text("+Add Image",
                                          style: TextStyle(fontFamily: 'Poppins',color: Colors.black.withOpacity(0.5)),
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

                          Padding(
                            padding: const EdgeInsets.only(left: 0.0, bottom: 10),
                            child: Text("SHOPACT License",
                              style: TextStyle(fontFamily: 'Poppins', fontSize: 14,fontWeight: FontWeight.w400,color: Colors.black.withOpacity(0.5)),
                              textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis,
                            ),
                          ),
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
                                    child: Container(
                                      width: MediaQuery.of(context).size.width * 0.4,
                                      child: Text(shopActImageFile!.imagePath == null ?"Shop Act License" : shopActImageFile!.imagePath!.split('/').last.toString(),
                                        style: TextStyle(fontFamily: 'Poppins',color: Colors.black.withOpacity(0.5)),
                                        maxLines: 2, overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: (){
                                      _shopActCertificateOpenGallery(context);
                                    },
                                    child: Container(
                                      height: 30,
                                      color: ThemeColors.textFieldHintColor.withOpacity(0.3),
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 4,right: 4),
                                        child: Center(child: Text("+Add Image",
                                          style: TextStyle(fontFamily: 'Poppins',color: Colors.black.withOpacity(0.5)),
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

                          Padding(
                            padding: const EdgeInsets.only(left: 0.0, bottom: 10),
                            child: Text("MSME/Udhyog Aadhar Card",
                              style: TextStyle(fontFamily: 'Poppins', fontSize: 14,fontWeight: FontWeight.w400,color: Colors.black.withOpacity(0.5)),
                              textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis,
                            ),
                          ),
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
                                      child: Container(
                                        width: MediaQuery.of(context).size.width * 0.4,
                                        child: Text(aadharImageFile!.imagePath == null ?"MSME/Udhyog AAdhar License" : aadharImageFile!.imagePath!.split('/').last.toString(),
                                          style: TextStyle(fontFamily: 'Poppins',color: Colors.black.withOpacity(0.5)),
                                          maxLines: 2, overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: (){
                                      _aadharCertificateOpenGallery(context);
                                    },
                                    child: Container(
                                      height: 30,
                                      color: ThemeColors.textFieldHintColor.withOpacity(0.3),
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 4,right: 4),
                                        child: Center(child: Text("+Add Image",
                                          style: TextStyle(fontFamily: 'Poppins',color: Colors.black.withOpacity(0.5)),
                                          textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis,
                                        )),
                                      ),
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
                    child: BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
                      return BlocListener<ProfileBloc, ProfileState>(
                        listener: (context, state) {
                          if(state is UpdateJobWorkProfileLoading){
                            loading = state.isLoading;
                          }
                          if(state is UpdateJobWorkProfileSuccess){
                            showCustomSnackBar(context,state.msg,isError: false);
                          }
                          if(state is UpdateJobWorkProfileFail){
                            showCustomSnackBar(context,state.msg.toString(),isError: true);
                          }
                        },
                        child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: ElevatedButton(
                                onPressed: () async {
                                  if(_formKey.currentState!.validate()) {
                                    _profileBloc!.add(UpdateJobWorkProfile(
                                      serviceUserId: Application
                                          .customerLogin!.id
                                          .toString(),
                                      companyName: _companyNameController.text,
                                      coOrdinateName:
                                          _coOrdinatorNameController.text,
                                      email: _emailController.text,
                                      mobile: _phoneController.text,
                                      gstNo: _gstController.text,
                                      catId: catrgoryTypeselected!.id!=null?catrgoryTypeselected!.id.toString():widget.serviceUserdataList![0].jobCategoryId.toString(),
                                      // widget.serviceUserdataList![0].jobCategoryName
                                      subCatId: '1',
                                      userProfilePic:
                                      uploadUserProfileImageFile!.imagePath
                                              .toString(),
                                      location: _addressController.text,
                                      currentAddress: _addressController.text,
                                      pincode: _pinCodeController.text,
                                      city: _cityController.text,
                                      state: _stateController.text,
                                      country: _countryController.text,
                                      // companyName: _companyNameController.text,
                                      machineList: machineList,
                                      companyProfilePic:
                                          uploadCompanyProfileImageFile!
                                              .imagePath.toString(),
                                      companyCertificateImg:
                                          imageFile!.imagePath.toString(),
                                      gstCertificateImg:
                                          gstImageFile!.imagePath.toString(),
                                      panCardImg:
                                          panImageFile!.imagePath.toString(),
                                      shopActLicenseImg: shopActImageFile!
                                          .imagePath
                                          .toString(),
                                      addharCardImg:
                                          aadharImageFile!.imagePath.toString(),
                                    ));
                                  }else{
                                    showCustomSnackBar(context,'Please fill all details.',isError: true);
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: ThemeColors.defaultbuttonColor,
                                  shape: StadiumBorder(),
                                ),
                                child: loading ? Text(
                                  "Update Changes",
                                  style: Theme.of(context)
                                      .textTheme
                                      .button!
                                      .copyWith(color: Colors.white, fontWeight: FontWeight.w600),
                                ) : Center(child: SizedBox(width:25, height:25,child: CircularProgressIndicator()),),

                              ),
                            )),

                      );


                    }),
                  )
                ],
              ),
            ),
          )
      ),
    );
  }
}
Future<bool> _handleLocationPermission(context) async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    showCustomSnackBar(context,'Location services are disabled. Please enable the services',isError: false);

    // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
    //     content: Text(
    //         'Location services are disabled. Please enable the services')));
    return false;
  }
  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      showCustomSnackBar(context,'Location permissions are denied',isError: true);

      // ScaffoldMessenger.of(context).showSnackBar(
      //     const SnackBar(content: Text('Location permissions are denied')));
      return false;
    }
  }
  if (permission == LocationPermission.deniedForever) {
    showCustomSnackBar(context,'Location permissions are permanently denied, we cannot request permissions.',isError: true);

    // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
    //     content: Text(
    //         'Location permissions are permanently denied, we cannot request permissions.')));
    return false;
  }
  return true;
}