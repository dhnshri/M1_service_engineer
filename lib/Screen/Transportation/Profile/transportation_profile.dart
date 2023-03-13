import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:service_engineer/Bloc/profile/profile_bloc.dart';
import 'package:service_engineer/Bloc/profile/profile_state.dart';
import 'package:service_engineer/Model/vehicle_info_model.dart';
import 'package:service_engineer/Screen/MachineMaintenance/Profile/widget/education_form.dart';
import 'package:service_engineer/Screen/MachineMaintenance/Profile/widget/expirence_company.dart';
import 'package:service_engineer/Screen/Transportation/Profile/widget/vehicle_info_widget.dart';
import 'package:service_engineer/Widget/custom_snackbar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_custom_selector/flutter_custom_selector.dart';
import '../../../../Utils/application.dart';

import '../../../Bloc/profile/profile_event.dart';
import '../../../Config/image.dart';
import '../../../Constant/theme_colors.dart';
import '../../../Model/education_model.dart';
import '../../../Model/experience_company_model.dart';
import '../../../image_file.dart';
import '../../LoginRegistration/signUpAs.dart';

// import '../../Config/font.dart';
// import '../../Config/image.dart';
// import '../../Constant/theme_colors.dart';
// import '../../Widget/app_button.dart';
// import '../../image_file.dart';

class TransportationProfileScreen extends StatefulWidget {
  const TransportationProfileScreen({Key? key}) : super(key: key);

  @override
  _TransportationProfileScreenState createState() => _TransportationProfileScreenState();
}

class _TransportationProfileScreenState extends State<TransportationProfileScreen> {
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
  ProfileBloc? _profileBloc;


  @override
  void initState() {
    // TODO: implement initState
    //saveDeviceTokenAndId();
    super.initState();
    _profileBloc = BlocProvider.of<ProfileBloc>(this.context);
    imageFile = new ImageFile();
    driverImageFile= new DriverImage();
    drivingLicenseImageFile= new DrivingLiceseImage();
    driverIdProofImageFile= new DriverIdProofImage();
    companyCertificateImageFile = CompanyCertificateImage();
    gstImageFile = new GstImageFile();
    panImageFile = new PanImageFile();
    shopActImageFile = new ShopActImageFile();
    aadharImageFile = new AddharImageFile();
    _nameController.text = Application.customerLogin!.name.toString();
    _emailController.text = Application.customerLogin!.email.toString();
    _phoneController.text = Application.customerLogin!.mobile.toString();
  }


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // getroleofstudent();

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

  ///User Profile
  _userProfileOpenGallery(BuildContext context) async {
    final image =
    await picker.getImage(source: ImageSource.gallery, imageQuality: 25);
    imageFile = new ImageFile();
    if (image != null) {
      _userProfileCropImage(image);
    }
  }
  // For crop image
  Future<Null> _userProfileCropImage(PickedFile imageCropped) async {
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


  ///Driver Profile
  _driverProfileOpenGallery(BuildContext context) async {
    final driverProfileImage =
    await picker.getImage(source: ImageSource.gallery, imageQuality: 25);
    driverImageFile = new DriverImage();
    if (driverProfileImage != null) {
      _driverProfileCropImage(driverProfileImage);
    }
  }
  // For crop image
  Future<Null> _driverProfileCropImage(PickedFile imageCropped) async {
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
        _driverImage = croppedFile;
        driverImageFile!.imagePath = _driverImage!.path;
      });
      // Navigator.pop(context);
    }
  }

  ///Driving License
  _drivingLicenseOpenGallery(BuildContext context) async {
    final drivingLicenseImage =
    await picker.getImage(source: ImageSource.gallery, imageQuality: 25);
    drivingLicenseImageFile = new DrivingLiceseImage();
    if (drivingLicenseImage != null) {
      _drivingLicenseCropImage(drivingLicenseImage);
    }
  }
  // For crop image
  Future<Null> _drivingLicenseCropImage(PickedFile imageCropped) async {
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
        _drivingLicenseImage = croppedFile;
        drivingLicenseImageFile!.imagePath = _drivingLicenseImage!.path;
      });
      // Navigator.pop(context);
    }
  }

  ///Driver Id Prooof
  _drivingIdProofOpenGallery(BuildContext context) async {
    final driverIdProofImage =
    await picker.getImage(source: ImageSource.gallery, imageQuality: 25);
    driverIdProofImageFile = new DriverIdProofImage();
    if (driverIdProofImage != null) {
      _driverIdProofCropImage(driverIdProofImage);
    }
  }
  // For crop image
  Future<Null> _driverIdProofCropImage(PickedFile imageCropped) async {
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
        _driverIdProofImage = croppedFile;
        driverIdProofImageFile!.imagePath = _driverIdProofImage!.path;
      });
      // Navigator.pop(context);
    }
  }


  _companyCertificateopenGallery(BuildContext context) async {
    final companyCertificateImage =
    await picker.getImage(source: ImageSource.gallery, imageQuality: 25);
    companyCertificateImageFile = new CompanyCertificateImage();
    if (companyCertificateImage != null) {
      _companyCertificatecropImage(companyCertificateImage);
    }
  }

  // For crop image

  Future<Null> _companyCertificatecropImage(PickedFile imageCropped) async {
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
        _companyCertificateImage = croppedFile;
        companyCertificateImageFile!.imagePath = _companyCertificateImage!.path;
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
        _aadharImage = croppedFile;
        aadharImageFile!.imagePath = _aadharImage!.path;
      });
      // Navigator.pop(context);
    }
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

  List<ExpCompanyFormWidget> expCompanyForms = List.empty(growable: true);

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

  List<VehicleInfFormWidget> vehicleInfoForms = List.empty(growable: true);

  VehicleImageModel _vehicleImageModel = VehicleImageModel();
  VehicleRCImageModel _vehicleRCImageModel = VehicleRCImageModel();
  VehiclePUCImageModel _vehiclePUCImageModel = VehiclePUCImageModel();

  vehicleInfoOnAdd() {
    setState(() {
      VehicleInfoModel _vehicleInfoModel = VehicleInfoModel(id: vehicleInfoForms.length);
      // EducationCertificateModel _educationCertificateModel = EducationCertificateModel(id: vehicleInfoForms.length);
      vehicleInfoForms.add(VehicleInfFormWidget(
        index: vehicleInfoForms.length,
        vehicleInfoModel: _vehicleInfoModel,
        vehicleImageModel: _vehicleImageModel,
        vehicleRCImageModel: _vehicleRCImageModel,
        vehiclePUCImageModel: _vehiclePUCImageModel,
        onRemove: () => vehicleInfoOnRemove(_vehicleInfoModel,_vehicleImageModel,_vehicleRCImageModel,_vehiclePUCImageModel),
      ));
      // _educationModel.add();
    });
  }

  vehicleInfoOnRemove(VehicleInfoModel vehicleModel,VehicleImageModel vehicleImageModel,VehicleRCImageModel vehicleRCImageModel,VehiclePUCImageModel vehiclePUCImageModel) {
    setState(() {
      int index = vehicleInfoForms
          .indexWhere((element) => element.vehicleInfoModel!.id == vehicleModel.id);

      int vehivleImageIndex = vehicleInfoForms
          .indexWhere((element) => element.vehicleImageModel!.id == vehicleImageModel.id);

      int vehicleRCImageIndex = vehicleInfoForms
          .indexWhere((element) => element.vehicleRCImageModel!.id == vehicleRCImageModel.id);

      int vehiclePUCImageIndex = vehicleInfoForms
          .indexWhere((element) => element.vehiclePUCImageModel!.id == vehiclePUCImageModel.id);

      if (vehicleInfoForms != null) vehicleInfoForms.removeAt(index);
      if (vehicleImageModel.id != null) vehicleInfoForms.removeAt(vehivleImageIndex);
      if (vehicleRCImageModel.id != null) vehicleInfoForms.removeAt(vehicleRCImageIndex);
      if (vehiclePUCImageModel.id != null) vehicleInfoForms.removeAt(vehiclePUCImageIndex);
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
                                          (imageFile!.imagePath == null || imageFile!.imagePath == "")?
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Image.asset(
                                              Images.profile_icon,
                                              fit: BoxFit.fill,
                                            ),
                                          )
                                            : Image.file(
                                            _image!,
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
                                      child:Text(Application.customerLogin!.name == "" ? "" : Application.customerLogin!.name.toString(),
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

                  ///Owner Details
                  const Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text("Owner Details",
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
                          ///Owner Profile
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
                                      child: Text(imageFile!.imagePath == null ?"Upload Profile" : imageFile!.imagePath!.split('/').last.toString(),
                                        style: TextStyle(fontFamily: 'Poppins-Medium',color: Colors.black.withOpacity(0.5)),
                                        maxLines: 2, overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: (){
                                      _userProfileOpenGallery(context);
                                    },
                                    child: Container(
                                      height: 30,
                                      color: ThemeColors.textFieldHintColor.withOpacity(0.3),
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 4,right: 4),
                                        child: Center(child: Text("+Add Image",
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
                            keyboardType: TextInputType.number,
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
                        ],
                      ),
                    ),
                  ),


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
                      style: TextStyle(fontFamily: 'Poppins-Medium', fontSize: 18,fontWeight: FontWeight.w500),
                      textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis,
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.only(left: 30,right: 20),
                    child: Column(
                      children: [
                        ///Owner Profile
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
                                    child: Text(driverImageFile!.imagePath == null ?"Upload Profile" : driverImageFile!.imagePath!.split('/').last.toString(),
                                      style: TextStyle(fontFamily: 'Poppins-Medium',color: Colors.black.withOpacity(0.5)),
                                      maxLines: 2, overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: (){
                                    _driverProfileOpenGallery(context);
                                  },
                                  child: Container(
                                    height: 30,
                                    color: ThemeColors.textFieldHintColor.withOpacity(0.3),
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 4,right: 4),
                                      child: Center(child: Text("+Add Image",
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


                        ///Name
                        TextFormField(
                          // initialValue: Application.customerLogin!.name.toString(),
                          controller: _driverNameController,
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


                        ///Phone Number
                        TextFormField(
                          // initialValue: Application.customerLogin!.name.toString(),
                          controller: _driverPhoneController,
                          textAlign: TextAlign.start,
                          keyboardType: TextInputType.number,
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

                        ///Driver License Validity
                        TextFormField(
                          // initialValue: Application.customerLogin!.name.toString(),
                          controller: _driverLicenseValidityController,
                          textAlign: TextAlign.start,
                          keyboardType: TextInputType.text,
                          style: TextStyle(
                            fontSize: 18,
                            height: 1.5,
                          ),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: ThemeColors.textFieldBackgroundColor,
                            hintText: "Driver License Validity",
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
                            // Pattern pattern = r'^([0][1-9]|[1-2][0-9]|[3][0-7])([a-zA-Z]{5}[0-9]{4}[a-zA-Z]{1}[1-9a-zA-Z]{1}[zZ]{1}[0-9a-zA-Z]{1})+$';
                            // RegExp regex = new RegExp(pattern.toString());
                            if (value == null || value.isEmpty) {
                              return 'Please Enter Driver License Validity';
                            }
                            // else if(!regex.hasMatch(value)){
                            //   return 'Please enter valid GST Number';
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

                        ///Driver License Number
                        TextFormField(
                          // initialValue: Application.customerLogin!.name.toString(),
                          controller: _driverLicenseNumberController,
                          textAlign: TextAlign.start,
                          keyboardType: TextInputType.text,
                          style: TextStyle(
                            fontSize: 18,
                            height: 1.5,
                          ),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: ThemeColors.textFieldBackgroundColor,
                            hintText: "Driver License Number",
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
                            // Pattern pattern = r'^([0][1-9]|[1-2][0-9]|[3][0-7])([a-zA-Z]{5}[0-9]{4}[a-zA-Z]{1}[1-9a-zA-Z]{1}[zZ]{1}[0-9a-zA-Z]{1})+$';
                            // RegExp regex = new RegExp(pattern.toString());
                            if (value == null || value.isEmpty) {
                              return 'Please Enter Driver License Number';
                            }
                            // else if(!regex.hasMatch(value)){
                            //   return 'Please enter valid GST Number';
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

                        ///Driving License Image
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
                                    child: Text(drivingLicenseImageFile!.imagePath == null ?"Upload Driving License" : drivingLicenseImageFile!.imagePath!.split('/').last.toString(),
                                      style: TextStyle(fontFamily: 'Poppins-Medium',color: Colors.black.withOpacity(0.5)),
                                      maxLines: 2, overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: (){
                                    _drivingLicenseOpenGallery(context);
                                  },
                                  child: Container(
                                    height: 30,
                                    color: ThemeColors.textFieldHintColor.withOpacity(0.3),
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 4,right: 4),
                                      child: Center(child: Text("+Add Image",
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

                        ///Driver Id Proof
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
                                    child: Text(driverIdProofImageFile!.imagePath == null ?"Upload Driver Id Proof" : driverIdProofImageFile!.imagePath!.split('/').last.toString(),
                                      style: TextStyle(fontFamily: 'Poppins-Medium',color: Colors.black.withOpacity(0.5)),
                                      maxLines: 2, overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: (){
                                    _drivingIdProofOpenGallery(context);
                                  },
                                  child: Container(
                                    height: 30,
                                    color: ThemeColors.textFieldHintColor.withOpacity(0.3),
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 4,right: 4),
                                      child: Center(child: Text("+Add Image",
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
                      ],
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
                                      style: TextStyle(fontFamily: 'Poppins-Medium', fontSize: 18,fontWeight: FontWeight.w500),
                                      textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis,
                                    ),
                                    Icon(Icons.my_location_rounded,color: Colors.red,)
                                  ],
                                ),
                              ),
                            ),
                          ),

                          SizedBox(height: 15,),

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
                      style: TextStyle(fontFamily: 'Poppins-Medium', fontSize: 18,fontWeight: FontWeight.w500),
                      textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis,
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.only(left: 30,right: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        vehicleInfoForms.isNotEmpty
                            ? Column(
                          children: [
                            ListView.builder(
                                itemCount: vehicleInfoForms.length,
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (_, index) {
                                  return vehicleInfoForms[index];
                                }),
                          ],
                        )
                            : SizedBox(),

                        ///Add More
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(vehicleInfoForms.isNotEmpty?"Add More":"Add",
                              style: TextStyle(fontFamily: 'Poppins-SemiBold', fontSize: 14,fontWeight: FontWeight.w600,color: Colors.black),
                              textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(width: 5,),
                            InkWell(
                                onTap: (){
                                  vehicleInfoOnAdd();
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
                  //     children: [
                  //       ///Vehicle Name
                  //       TextFormField(
                  //         // initialValue: Application.customerLogin!.name.toString(),
                  //         controller: _vehicleNameController,
                  //         textAlign: TextAlign.start,
                  //         keyboardType: TextInputType.text,
                  //         style: TextStyle(
                  //           fontSize: 18,
                  //           height: 1.5,
                  //         ),
                  //         decoration: InputDecoration(
                  //           filled: true,
                  //           fillColor: ThemeColors.textFieldBackgroundColor,
                  //           hintText: "Vehicle Name",
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
                  //             return 'Please enter vehicle name';
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
                  //       ///Vehicle Type
                  //       TextFormField(
                  //         // initialValue: Application.customerLogin!.name.toString(),
                  //         controller: _vehicleTypeController,
                  //         textAlign: TextAlign.start,
                  //         keyboardType: TextInputType.text,
                  //         style: TextStyle(
                  //           fontSize: 18,
                  //           height: 1.5,
                  //         ),
                  //         decoration: InputDecoration(
                  //           filled: true,
                  //           fillColor: ThemeColors.textFieldBackgroundColor,
                  //           hintText: "Vehicle Type",
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
                  //             return 'Please enter vehicle type';
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
                  //
                  //       ///Chassis Number
                  //       TextFormField(
                  //         // initialValue: Application.customerLogin!.name.toString(),
                  //         controller: _chassisNumberController,
                  //         textAlign: TextAlign.start,
                  //         keyboardType: TextInputType.text,
                  //         style: TextStyle(
                  //           fontSize: 18,
                  //           height: 1.5,
                  //         ),
                  //         decoration: InputDecoration(
                  //           filled: true,
                  //           fillColor: ThemeColors.textFieldBackgroundColor,
                  //           hintText: "Chassis Number",
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
                  //           // Pattern pattern = r'^([0][1-9]|[1-2][0-9]|[3][0-7])([a-zA-Z]{5}[0-9]{4}[a-zA-Z]{1}[1-9a-zA-Z]{1}[zZ]{1}[0-9a-zA-Z]{1})+$';
                  //           // RegExp regex = new RegExp(pattern.toString());
                  //           if (value == null || value.isEmpty) {
                  //             return 'Please Enter Chassis Number';
                  //           }
                  //           // else if(!regex.hasMatch(value)){
                  //           //   return 'Please enter valid GST Number';
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
                  //       ///Registration Upto
                  //       TextFormField(
                  //         // initialValue: Application.customerLogin!.name.toString(),
                  //         controller: _registrationUptoController,
                  //         textAlign: TextAlign.start,
                  //         keyboardType: TextInputType.text,
                  //         style: TextStyle(
                  //           fontSize: 18,
                  //           height: 1.5,
                  //         ),
                  //         decoration: InputDecoration(
                  //           filled: true,
                  //           fillColor: ThemeColors.textFieldBackgroundColor,
                  //           hintText: "Registration Upto",
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
                  //           // Pattern pattern = r'^([0][1-9]|[1-2][0-9]|[3][0-7])([a-zA-Z]{5}[0-9]{4}[a-zA-Z]{1}[1-9a-zA-Z]{1}[zZ]{1}[0-9a-zA-Z]{1})+$';
                  //           // RegExp regex = new RegExp(pattern.toString());
                  //           if (value == null || value.isEmpty) {
                  //             return 'Please Enter Registration Upto';
                  //           }
                  //           // else if(!regex.hasMatch(value)){
                  //           //   return 'Please enter valid GST Number';
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
                  //       ///Vehicle Number
                  //       TextFormField(
                  //         // initialValue: Application.customerLogin!.name.toString(),
                  //         controller: _vehicleNumberController,
                  //         textAlign: TextAlign.start,
                  //         keyboardType: TextInputType.text,
                  //         style: TextStyle(
                  //           fontSize: 18,
                  //           height: 1.5,
                  //         ),
                  //         decoration: InputDecoration(
                  //           filled: true,
                  //           fillColor: ThemeColors.textFieldBackgroundColor,
                  //           hintText: "Vehicle Number",
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
                  //           // Pattern pattern = r'^([0][1-9]|[1-2][0-9]|[3][0-7])([a-zA-Z]{5}[0-9]{4}[a-zA-Z]{1}[1-9a-zA-Z]{1}[zZ]{1}[0-9a-zA-Z]{1})+$';
                  //           // RegExp regex = new RegExp(pattern.toString());
                  //           if (value == null || value.isEmpty) {
                  //             return 'Please Enter Vehicle Number';
                  //           }
                  //           // else if(!regex.hasMatch(value)){
                  //           //   return 'Please enter valid GST Number';
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
                  //
                  //       ///Upload Vehicle Image
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
                  //                 child: Text("Upload Vehicle Image",
                  //                   style: TextStyle(fontFamily: 'Poppins-Medium',color: Colors.black.withOpacity(0.5)),
                  //                   textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis,
                  //                 ),
                  //               ),
                  //               InkWell(
                  //                 onTap: (){
                  //                   // _openGallery(context);
                  //                 },
                  //                 child: Container(
                  //                   height: 30,
                  //                   color: ThemeColors.textFieldHintColor.withOpacity(0.3),
                  //                   child: Padding(
                  //                     padding: const EdgeInsets.only(left: 4,right: 4),
                  //                     child: Center(child: Text("+Add Image",
                  //                       style: TextStyle(fontFamily: 'Poppins-Regular',color: Colors.black.withOpacity(0.5)),
                  //                       textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis,
                  //                     )),
                  //                   ),
                  //                 ),
                  //               )
                  //             ],
                  //           ),
                  //         ),
                  //       ),
                  //
                  //       SizedBox(height: 15,),
                  //
                  //       ///Upload your RC
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
                  //                 child: Text("Upload your RC",
                  //                   style: TextStyle(fontFamily: 'Poppins-Medium',color: Colors.black.withOpacity(0.5)),
                  //                   textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis,
                  //                 ),
                  //               ),
                  //               InkWell(
                  //                 onTap: (){
                  //                   // _openGallery(context);
                  //                 },
                  //                 child: Container(
                  //                   height: 30,
                  //                   color: ThemeColors.textFieldHintColor.withOpacity(0.3),
                  //                   child: Padding(
                  //                     padding: const EdgeInsets.only(left: 4,right: 4),
                  //                     child: Center(child: Text("+Add Image",
                  //                       style: TextStyle(fontFamily: 'Poppins-Regular',color: Colors.black.withOpacity(0.5)),
                  //                       textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis,
                  //                     )),
                  //                   ),
                  //                 ),
                  //               )
                  //             ],
                  //           ),
                  //         ),
                  //       ),
                  //
                  //       SizedBox(height: 15,),
                  //
                  //       ///Upload your PVC
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
                  //                 child: Text("Upload your PVC",
                  //                   style: TextStyle(fontFamily: 'Poppins-Medium',color: Colors.black.withOpacity(0.5)),
                  //                   textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis,
                  //                 ),
                  //               ),
                  //               InkWell(
                  //                 onTap: (){
                  //                   // _openGallery(context);
                  //                 },
                  //                 child: Container(
                  //                   height: 30,
                  //                   color: ThemeColors.textFieldHintColor.withOpacity(0.3),
                  //                   child: Padding(
                  //                     padding: const EdgeInsets.only(left: 4,right: 4),
                  //                     child: Center(child: Text("+Add Image",
                  //                       style: TextStyle(fontFamily: 'Poppins-Regular',color: Colors.black.withOpacity(0.5)),
                  //                       textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis,
                  //                     )),
                  //                   ),
                  //                 ),
                  //               )
                  //             ],
                  //           ),
                  //         ),
                  //       ),
                  //
                  //       SizedBox(height: 15,),
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
                  //     ],
                  //   ),
                  // ),

                  const SizedBox(height: 10,),


                  const Divider(
                    // height: 2,
                    thickness: 2.0,
                  ),

                  const Divider(
                    // height: 2,
                    thickness: 2.0,
                  ),


                  ///Total Expirence
                  const Padding(
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


                  const Divider(
                    // height: 2,
                    thickness: 2.0,
                  ),

                  const Divider(
                    // height: 2,
                    thickness: 2.0,
                  ),

                  ///Expirence
                  const Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text("Experince",
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


                  const Divider(
                    // height: 2,
                    thickness: 2.0,
                  ),

                  const Divider(
                    // height: 2,
                    thickness: 2.0,
                  ),

                  SizedBox(height: 10),

                  ///Bank Details
                  const Padding(
                    padding: EdgeInsets.all(20.0),
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


                  const Divider(
                    // height: 2,
                    thickness: 2.0,
                  ),

                  const Divider(
                    // height: 2,
                    thickness: 2.0,
                  ),
                  ///KYC
                  const Padding(
                    padding: EdgeInsets.all(20.0),
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
                                    child: Container(
                                      width: MediaQuery.of(context).size.width * 0.4,
                                      child: Text(companyCertificateImageFile!.imagePath == null ?"Company Certificate" : companyCertificateImageFile!.imagePath!.split('/').last.toString(),
                                        style: TextStyle(fontFamily: 'Poppins-Medium',color: Colors.black.withOpacity(0.5)),
                                        maxLines: 2, overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: (){
                                      _companyCertificateopenGallery(context);
                                    },
                                    child: Container(
                                      height: 30,
                                      color: ThemeColors.textFieldHintColor.withOpacity(0.3),
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 4,right: 4),
                                        child: Center(child: Text("+Add Image",
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
                                        style: TextStyle(fontFamily: 'Poppins-Medium',color: Colors.black.withOpacity(0.5)),
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
                                        style: TextStyle(fontFamily: 'Poppins-Medium',color: Colors.black.withOpacity(0.5)),
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
                                        style: TextStyle(fontFamily: 'Poppins-Medium',color: Colors.black.withOpacity(0.5)),
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
                                          style: TextStyle(fontFamily: 'Poppins-Medium',color: Colors.black.withOpacity(0.5)),
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
                                          style: TextStyle(fontFamily: 'Poppins-Regular',color: Colors.black.withOpacity(0.5)),
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

                  const Divider(
                    // height: 2,
                    thickness: 3.0,
                  ),

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
                                    if(_companyNameController.text == ""){
                                      showCustomSnackBar(context,'Enter Company Name',isError: true);
                                    }
                                    else if(_formKey.currentState!.validate()) {
                                      _profileBloc!.add(UpdateTransportProfile(
                                        serviceUserId: Application.customerLogin!.id
                                            .toString(),
                                        userProfileImg: imageFile!.imagePath.toString(),
                                        ownerName: _nameController.text,
                                        email: _emailController.text,
                                        mobile: _phoneController.text,
                                        gstNo: _gstController.text,
                                        driverProfileImg: driverImageFile!.imagePath.toString(),
                                        driverName: _driverNameController.text,
                                        driverNumber: _driverPhoneController.text,
                                        driverLicenseValidity: _driverLicenseValidityController.text,
                                        driverLicenseNumber: _driverLicenseNumberController.text,
                                        driverLicenseImage: drivingLicenseImageFile!.imagePath.toString(),
                                        driverIdProofImage: driverIdProofImageFile!.imagePath.toString(),
                                        location: _addressController.text,
                                        currentLocation: _addressController.text,
                                        pinCode: _pinCodeController.text,
                                        city: _cityController.text,
                                        state: _stateController.text,
                                        country: _countryController.text,
                                        totalYears: _yearsController.text,
                                        totalMonths: _monthsController.text,
                                        companyName: _companyNameController.text,
                                        bankName: _bankNameController.text,
                                        accountNumber: _accountNumberController.text,
                                        ifscCode: _iFSCCodeController.text,
                                        branchName: _branchNameController.text,
                                        upiId: _upiIdController.text,
                                        companyCertificateImg:
                                        imageFile!.imagePath.toString(),
                                        gstCertificateImg:
                                        gstImageFile!.imagePath.toString(),
                                        panCardImg:
                                        panImageFile!.imagePath.toString(),
                                        shopActLicenseImg:
                                        shopActImageFile!.imagePath.toString(),
                                        addharCardImg:
                                        aadharImageFile!.imagePath.toString(),
                                        vehicleInfoList: vehicleInfoForms,
                                        experienceCompanyList: expCompanyForms,

                                      ));
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    primary: ThemeColors.defaultbuttonColor,
                                    shape: StadiumBorder(),
                                  ),
                                  child: loading ? Text(
                                    "Update Profile",
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