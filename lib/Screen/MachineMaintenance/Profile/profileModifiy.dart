import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:service_engineer/Bloc/profile/profile_bloc.dart';
import 'package:service_engineer/Bloc/profile/profile_state.dart';
import 'package:service_engineer/Model/profile_repo.dart';
import 'package:service_engineer/Screen/MachineMaintenance/Profile/widget/education_form.dart';
import 'package:service_engineer/Screen/MachineMaintenance/Profile/widget/expirence_company.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_custom_selector/flutter_custom_selector.dart';
import '../../../../Utils/application.dart';

import '../../../Bloc/profile/profile_event.dart';
import '../../../Config/image.dart';
import '../../../Constant/theme_colors.dart';
import '../../../Model/MachineMaintance/machine_maintaince_category_list_model.dart';
import '../../../Model/MachineMaintance/machine_maintaince_sub_category_list.dart';
import '../../../Model/education_model.dart';
import '../../../Model/experience_company_model.dart';
import '../../../NetworkFunction/fetchMachineMaintainceCategoryList.dart';
import '../../../NetworkFunction/fetchMachineMaintainceSubCategoryList.dart';
import '../../../Utils/application.dart';
import '../../../Widget/custom_snackbar.dart';
import '../../../image_file.dart';
import '../../LoginRegistration/signUpAs.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';


class MachineProfileScreen extends StatefulWidget {
  MachineProfileScreen({Key? key,required this.serviceUserdataList,required this.profileKycList,
    required this.profileMachineEducationList,required this.profileMachineExperienceList}) : super(key: key);
  List<ServiceUserData>? serviceUserdataList;
  List<ProfileKYCDetails>? profileKycList;
  List<MachineMaintenanceExperiences>? profileMachineExperienceList;
  List<MachineMaintenanceEducations>? profileMachineEducationList;

  @override
  _MachineProfileScreenState createState() => _MachineProfileScreenState();
}

class _MachineProfileScreenState extends State<MachineProfileScreen> {
  bool loading = true;
  UserProfileImageFile? userProfileImageFile;
  File? _userProfileimage;
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
  File? _uploadUserProfileImage;
  UserProfileImageFile? uploadUserProfileImageFile;
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
  final _locationController = TextEditingController();
  String? _currentAddress;
  Position? _currentPosition;

  List<ExpCompanyFormWidget> expCompanyForms = List.empty(growable: true);


  final List<String> machineName = [];
  final List<String> quantity = [];

  ProfileBloc? _profileBloc;
  MachineMaintenanceCategoryListModel? catrgoryTypeselected;
  MachineMaintenanceSubCategoryListModel? subCatrgoryTypeselected;



  @override
  void initState() {
    // TODO: implement initState
    //saveDeviceTokenAndId();
    super.initState();
    // catrgoryTypeselected = new MachineMaintenanceCategoryListModel();
    // subCatrgoryTypeselected = new MachineMaintenanceSubCategoryListModel();
    imageFile = new ImageFile();
    gstImageFile = new GstImageFile();
    panImageFile = new PanImageFile();
    shopActImageFile = new ShopActImageFile();
    aadharImageFile = new AddharImageFile();
    uploadUserProfileImageFile = new UserProfileImageFile();
    _profileBloc = BlocProvider.of<ProfileBloc>(this.context);

    getData();
  }

  getData()async{
    if(widget.serviceUserdataList!.isNotEmpty && widget.profileKycList!.isNotEmpty ){
      _iDController.text = widget.serviceUserdataList![0].email.toString();
      _companyNameController.text = widget.serviceUserdataList![0].companyName.toString();
      _nameController.text = widget.serviceUserdataList![0].name.toString();
      _emailController.text = widget.serviceUserdataList![0].email.toString();
      _phoneController.text = widget.serviceUserdataList![0].mobile.toString();
      _gstController.text = widget.serviceUserdataList![0].gstNo.toString();
      _ageController.text = widget.serviceUserdataList![0].age.toString();
      _genderController.text = widget.serviceUserdataList![0].gender.toString();
      var userImgFile = await DefaultCacheManager().getSingleFile(widget.serviceUserdataList![0].userProfilePic.toString());
      print(userImgFile);
      uploadUserProfileImageFile!.imagePath = userImgFile.path;
      // uploadUserProfileImageFile!.imagePath = widget.serviceUserdataList![0].userProfilePic.toString();
      _addressController.text = widget.serviceUserdataList![0].currentAddress.toString();
      _locationController.text = widget.serviceUserdataList![0].currentAddress.toString();
      _pinCodeController.text = widget.serviceUserdataList![0].pincode.toString();
      _cityController.text = widget.serviceUserdataList![0].city.toString();
      _stateController.text = widget.serviceUserdataList![0].state.toString();
      _countryController.text = widget.serviceUserdataList![0].country.toString();
      var companyCertificateImgFile = await DefaultCacheManager().getSingleFile(widget.profileKycList![0].companyCertificate.toString());
      print(companyCertificateImgFile);
      imageFile!.imagePath = companyCertificateImgFile.path;
      // imageFile!.imagePath = widget.profileKycList![0].companyCertificate.toString();
      var gstCertificateImgFile = await DefaultCacheManager().getSingleFile(widget.profileKycList![0].gstCertificate.toString());
      print(gstCertificateImgFile);
      gstImageFile!.imagePath = gstCertificateImgFile.path;
      // gstImageFile!.imagePath = widget.profileKycList![0].gstCertificate.toString();
      var panCardImgFile = await DefaultCacheManager().getSingleFile(widget.profileKycList![0].panCard.toString());
      print(panCardImgFile);
      panImageFile!.imagePath = panCardImgFile.path;
      // panImageFile!.imagePath = widget.profileKycList![0].panCard.toString();
      var shopActImgFile = await DefaultCacheManager().getSingleFile(widget.profileKycList![0].shopActLicence.toString());
      print(shopActImgFile);
      shopActImageFile!.imagePath = shopActImgFile.path;
      // shopActImageFile!.imagePath = widget.profileKycList![0].shopActLicence.toString();
      var aadharCardImgFile = await DefaultCacheManager().getSingleFile(widget.profileKycList![0].udhyogAdharLicence.toString());
      print(aadharCardImgFile);
      aadharImageFile!.imagePath = aadharCardImgFile.path;
      // aadharImageFile!.imagePath = widget.profileKycList![0].udhyogAdharLicence.toString();
      _bankNameController.text = widget.profileKycList![0].bankName.toString();
      _accountNumberController.text = widget.profileKycList![0].accountNumber.toString();
      _iFSCCodeController.text = widget.profileKycList![0].ifscCode.toString();
      _branchNameController.text = widget.profileKycList![0].branchName.toString();
      _upiIdController.text = widget.profileKycList![0].upiId.toString();
      _yearsController.text = widget.profileMachineExperienceList![0].yearOfExperience.toString();
      _monthsController.text = widget.profileMachineExperienceList![0].monthOfExperience.toString();

      for(int i=0; i < widget.profileMachineExperienceList!.length;i++){
        ExpCompanyModel _expData = ExpCompanyModel(id: expCompanyForms.length,companyName: widget.profileMachineExperienceList![i].companyName,
            desciption: widget.profileMachineExperienceList![i].description,fromYear: widget.profileMachineExperienceList![i].workFrom,
            tillYear: widget.profileMachineExperienceList![i].workTill);
        expCompanyForms.add(ExpCompanyFormWidget(
          index: expCompanyForms.length,
          expCompanyModel: _expData,
          onRemove: () => onRemove(_expData),
        ));
      }

      for(int i=0; i < widget.profileMachineEducationList!.length;i++){
        EducationModel _eduData = EducationModel(id: educationForms.length,schoolName: widget.profileMachineEducationList![i].schoolName,
            courseName: widget.profileMachineEducationList![i].courseName,passYear: widget.profileMachineEducationList![i].passingYear,
            certificateImg: widget.profileMachineEducationList![i].certificate);
        EducationCertificateModel _educationCertificateModel = EducationCertificateModel(id: educationForms.length,certificateImg: widget.profileMachineEducationList![i].certificate);
        educationForms.add(EducationFormWidget(
          index: educationForms.length,
          educationModel: _eduData,
          educationCertificateModel: _educationCertificateModel,
          onRemove: () => educationOnRemove(_eduData,_educationCertificateModel),
        ));
      }
      setState(() { });
    }else{
      _iDController.text = "";
      _companyNameController.text = "";
      _coOrdinatorNameController.text = "";
      _emailController.text = "";
      _phoneController.text = "";
      _gstController.text = "";
      // uploadCompanyProfileImageFile!.imagePath = "";
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
    _locationController.clear();
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
        _locationController.text = _currentAddress.toString();
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

  EducationCertificateModel _educationCertificateModel = EducationCertificateModel();

  educationOnAdd() {
    setState(() {
      EducationModel _educationModel = EducationModel(id: educationForms.length);
      EducationCertificateModel _educationCertificateModel = EducationCertificateModel(id: educationForms.length);
      educationForms.add(EducationFormWidget(
        index: educationForms.length,
        educationModel: _educationModel,
        educationCertificateModel: _educationCertificateModel,
        onRemove: () => educationOnRemove(_educationModel,_educationCertificateModel),
      ));
      // _educationModel.add();
    });
  }

  educationOnRemove(EducationModel educationModel,EducationCertificateModel educationCertificateModel ) {
    setState(() {
      int index = educationForms
          .indexWhere((element) => element.educationModel!.id == educationModel.id);

      // int certificateIndex = educationForms
      //     .indexWhere((element) => element.educationCertificateModel!.id == educationCertificateModel.id);

      if (educationForms != null) educationForms.removeAt(index);
      // if (educationCertificateModel.id != null) educationForms.removeAt(certificateIndex);
    });
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
                    DefaultCacheManager().emptyCache();
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
                                      child:  SizedBox(
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
                                              : Image.file(
                                            File(uploadUserProfileImageFile!.imagePath.toString()),
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
                                  Container(
                                      child:Text(Application.customerLogin!.name == ""? "": Application.customerLogin!.name.toString(),
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

                  //User Data
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

                        Padding(
                          padding: const EdgeInsets.only(left: 0.0, bottom: 10),
                          child: Text("Name",
                            style: TextStyle(fontFamily: 'Poppins', fontSize: 14,fontWeight: FontWeight.w400,color: Colors.black.withOpacity(0.5)),
                            textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis,
                          ),
                        ),
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
                          padding: const EdgeInsets.only(left: 0.0, bottom:5),
                          child: Text("Category",
                            style: TextStyle(fontFamily: 'Poppins', fontSize: 14,fontWeight: FontWeight.w400,color: Colors.black.withOpacity(0.5)),
                            textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        // ///Category
                        // Padding(
                        //     padding: EdgeInsets.only(top: 8.0, bottom: 0.0),
                        //     //to hide underline
                        //     child: FutureBuilder<List<MachineMaintenanceCategoryListModel>>(
                        //         future: fetchCategoryList(),
                        //         builder: (BuildContext context,
                        //             AsyncSnapshot<List<MachineMaintenanceCategoryListModel>> snapshot) {
                        //           if (!snapshot.hasData) return Container();
                        //
                        //           return DropdownButtonHideUnderline(
                        //               child: Container(
                        //                 width: MediaQuery.of(context).size.width,
                        //                 decoration: BoxDecoration(
                        //                   // color: Theme.of(context).dividerColor,
                        //                     color: ThemeColors.textFieldBackgroundColor,
                        //                     borderRadius: BorderRadius.circular(5.0),
                        //                     border: Border.all(
                        //                         color: ThemeColors.textFieldBgColor)),
                        //                 child: Padding(
                        //                   padding: EdgeInsets.only(
                        //                       left: 15.0, top: 0.0, right: 5.0, bottom: 0.0),
                        //                   child:
                        //                   //updated on 15/06/2021 to change background colour of dropdownbutton
                        //                   new Theme(
                        //                       data: Theme.of(context)
                        //                           .copyWith(canvasColor: Colors.white),
                        //                       child: DropdownButton(
                        //                           items: snapshot.data!
                        //                               .map((categoryname) =>
                        //                               DropdownMenuItem<MachineMaintenanceCategoryListModel>(
                        //                                 value: categoryname,
                        //                                 child: Text(
                        //                                   categoryname.serviceCategoryName.toString(),
                        //                                   style: TextStyle(
                        //                                       color: Colors.black),
                        //                                 ),
                        //                               ))
                        //                               .toList(),
                        //                           style: TextStyle(
                        //                               color: Colors.black,
                        //                               fontWeight: FontWeight.w600),
                        //                           isExpanded: true,
                        //                           hint: Text('Select  Category',
                        //                               style: TextStyle(
                        //                                   color: Color(0xFF3F4141))),
                        //                           value: catrgoryTypeselected == null
                        //                               ? catrgoryTypeselected
                        //                               : snapshot.data!
                        //                               .where((i) =>
                        //                           i.serviceCategoryName ==
                        //                               catrgoryTypeselected!
                        //                                   .serviceCategoryName)
                        //                               .first as MachineMaintenanceCategoryListModel,
                        //                           onChanged: (MachineMaintenanceCategoryListModel? categoryname) {
                        //                             setState(() {
                        //                               catrgoryTypeselected = categoryname;
                        //                               // widget.serviceUserdataList![0].workCatgory = categoryname!.serviceCategoryName;
                        //                               // widget.serviceUserdataList![0].categoryId = categoryname.id;
                        //                             });
                        //                           })),
                        //                 ),
                        //               ));
                        //         })),
                        //for category
                        Padding(
                            padding: EdgeInsets.only(
                                top: 4.0, bottom: 0.0),
                            //to hide underline
                            child: FutureBuilder<List<MachineMaintenanceCategoryListModel>>(
                                future: fetchCategoryList(),
                                builder: (BuildContext context,
                                    AsyncSnapshot<List<
                                        MachineMaintenanceCategoryListModel>> snapshot) {
                                  if (!snapshot.hasData)
                                    return Container();

                                  return DropdownButtonHideUnderline(
                                      child: Container(
                                        margin: EdgeInsets.only(
                                          top: 15.0,
                                        ),
                                        decoration: BoxDecoration(
                                          // border: Border.all(color: Theme.of(context).unselectedWidgetColor.withOpacity(0.5)),
                                          border: Border.all(
                                              color: Color(
                                                  0xFFF5F5F5)),
                                          // color: Theme.of(context).cardColor,
                                          color: Color(0xFFF5F5F5),
                                          borderRadius: BorderRadius
                                              .circular(5),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              left: 15.0,
                                              top: 0.0,
                                              right: 5.0,
                                              bottom: 0.0),
                                          child:
                                          //updated on 15/06/2021 to change background colour of dropdownbutton
                                          new Theme(
                                              data: Theme.of(context)
                                                  .copyWith(
                                                  canvasColor: Colors
                                                      .white),
                                              child: DropdownButton(
                                                  items: snapshot
                                                      .data!
                                                      .map((
                                                      category) =>
                                                      DropdownMenuItem<
                                                          MachineMaintenanceCategoryListModel>(
                                                        value: category,
                                                        child: Text(
                                                          category
                                                              .serviceCategoryName
                                                              .toString(),
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .black),
                                                        ),
                                                      ))
                                                      .toList(),
                                                  style: TextStyle(
                                                      color: Colors
                                                          .black,
                                                      fontWeight: FontWeight
                                                          .w600),
                                                  isExpanded: true,
                                                  hint: Text(
                                                      'Select Category',
                                                      style: TextStyle(
                                                          color: Color(
                                                              0xFF3F4141))),
                                                  value: catrgoryTypeselected ==
                                                      null
                                                      ? catrgoryTypeselected
                                                      : snapshot.data!
                                                      .where((i) =>
                                                  i.serviceCategoryName ==
                                                      catrgoryTypeselected!
                                                          .serviceCategoryName)
                                                      .first as MachineMaintenanceCategoryListModel,
                                                  onChanged: (
                                                      MachineMaintenanceCategoryListModel? category) {
                                                    subCatrgoryTypeselected =
                                                    null;
                                                    setState(() {
                                                      catrgoryTypeselected =
                                                          category;
                                                    });
                                                  })),
                                        ),
                                      ));
                                })),
                        // widget.serviceUserdataList![0].workCatgory != ""
                        //     ?
                        // Padding(
                        //   padding: const EdgeInsets.only(left: 10.0,top: 10),
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //     children: [
                        //       Container(
                        //           // height: 40,
                        //           // width: MediaQuery.of(context).size.width/1.3,
                        //           margin: EdgeInsets.all(2),
                        //           child:Container(
                        //             // height: 40,
                        //             color: ThemeColors.greyBackgrounColor.withOpacity(0.5),
                        //             child: Padding(
                        //               padding: const EdgeInsets.all(4.0),
                        //               child: Row(
                        //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //                 children: [
                        //                   Padding(
                        //                     padding: const EdgeInsets.only(left: 3),
                        //                     child: Container(
                        //                       width: MediaQuery.of(context).size.width * 0.4,
                        //                       child: Text('${widget.serviceUserdataList![0].workCatgory}',
                        //                         style: TextStyle(fontFamily: 'Poppins',color: Colors.black),
                        //                         textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis,
                        //                       ),
                        //                     ),
                        //                   ),
                        //
                        //                 ],
                        //               ),
                        //             ),
                        //           )
                        //
                        //       ),
                        //
                        //       // Padding(
                        //       //   padding: const EdgeInsets.only(right: 6.0),
                        //       //   child: InkWell(
                        //       //     onTap: (){
                        //       //       setState(() {
                        //       //         // int index1 = machineName
                        //       //         //     .indexWhere((element) => element.id! == machineName[index].id);
                        //       //
                        //       //         machineList.removeAt(index);
                        //       //       });
                        //       //
                        //       //     },
                        //       //     child: Icon(Icons.clear,color: ThemeColors.buttonColor,),
                        //       //   ),
                        //       // ),
                        //     ],
                        //   ),
                        // )
                        //     : Container(),
                        SizedBox(height: 7,),

                        Padding(
                          padding: const EdgeInsets.only(left: 0.0, bottom: 5),
                          child: Text("Sub-Category",
                            style: TextStyle(fontFamily: 'Poppins', fontSize: 14,fontWeight: FontWeight.w400,color: Colors.black.withOpacity(0.5)),
                            textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        ///Sub-Category
                        // Padding(
                        //     padding: EdgeInsets.only(top: 8.0, bottom: 0.0),
                        //     //to hide underline
                        //     child: FutureBuilder<List<MachineMaintenanceSubCategoryListModel>>(
                        //         future: fetchSubCategory(catrgoryTypeselected!=null?catrgoryTypeselected!.id.toString():""),
                        //         builder: (BuildContext context,
                        //             AsyncSnapshot<List<MachineMaintenanceSubCategoryListModel>> snapshot) {
                        //           if (!snapshot.hasData) return Container();
                        //
                        //           return DropdownButtonHideUnderline(
                        //               child: Container(
                        //                 width: MediaQuery.of(context).size.width,
                        //                 decoration: BoxDecoration(
                        //                   // color: Theme.of(context).dividerColor,
                        //                     color: ThemeColors.textFieldBackgroundColor,
                        //                     borderRadius: BorderRadius.circular(5.0),
                        //                     border: Border.all(
                        //                         color: ThemeColors.textFieldBgColor)),
                        //                 child: Padding(
                        //                   padding: EdgeInsets.only(
                        //                       left: 15.0, top: 0.0, right: 5.0, bottom: 0.0),
                        //                   child:
                        //                   //updated on 15/06/2021 to change background colour of dropdownbutton
                        //                   new Theme(
                        //                       data: Theme.of(context)
                        //                           .copyWith(canvasColor: Colors.white),
                        //                       child: DropdownButton(
                        //                           items: snapshot.data!
                        //                               .map((categoryname) =>
                        //                               DropdownMenuItem<MachineMaintenanceSubCategoryListModel>(
                        //                                 value: categoryname,
                        //                                 child: Text(
                        //                                   categoryname.serviceSubCategoryName.toString(),
                        //                                   style: TextStyle(
                        //                                       color: Colors.black),
                        //                                 ),
                        //                               ))
                        //                               .toList(),
                        //                           style: TextStyle(
                        //                               color: Colors.black,
                        //                               fontWeight: FontWeight.w600),
                        //                           isExpanded: true,
                        //                           hint: Text('Select Sub Category',
                        //                               style: TextStyle(
                        //                                   color: Color(0xFF3F4141))),
                        //                           value: subCatrgoryTypeselected == null
                        //                               ? subCatrgoryTypeselected
                        //                               : snapshot.data!
                        //                               .where((i) =>
                        //                           i.serviceSubCategoryName ==
                        //                               subCatrgoryTypeselected!
                        //                                   .serviceSubCategoryName)
                        //                               .first as MachineMaintenanceSubCategoryListModel,
                        //                           onChanged: (MachineMaintenanceSubCategoryListModel? categoryname) {
                        //                             setState(() {
                        //                               subCatrgoryTypeselected = categoryname;
                        //                               widget.serviceUserdataList![0].workSubCatgory = categoryname!.serviceSubCategoryName;
                        //                               widget.serviceUserdataList![0].subCategoryId = categoryname.serviceCategoryId;
                        //                             });
                        //                           })),
                        //                 ),
                        //               ));
                        //         })),
                        //for subcategory
                        Padding(
                            padding: EdgeInsets.only(
                                top: 4.0, bottom: 0.0),
                            //to hide underline
                            child: FutureBuilder<List<MachineMaintenanceSubCategoryListModel>>(
                                future: fetchSubCategory(
                                    catrgoryTypeselected != null
                                        ? catrgoryTypeselected!.id
                                        .toString()
                                        : ""),
                                builder: (BuildContext context,
                                    AsyncSnapshot<List<
                                        MachineMaintenanceSubCategoryListModel>> snapshot) {
                                  if (!snapshot.hasData)
                                    return Container();

                                  return DropdownButtonHideUnderline(
                                      child: Container(
                                        margin: EdgeInsets.only(
                                          top: 15.0,
                                        ),
                                        decoration: BoxDecoration(
                                          // border: Border.all(color: Theme.of(context).unselectedWidgetColor.withOpacity(0.5)),
                                          border: Border.all(
                                              color: Color(
                                                  0xFFF5F5F5)),
                                          // color: Theme.of(context).cardColor,
                                          color: Color(0xFFF5F5F5),
                                          borderRadius: BorderRadius
                                              .circular(5),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              left: 15.0,
                                              top: 0.0,
                                              right: 5.0,
                                              bottom: 0.0),
                                          child:
                                          //updated on 15/06/2021 to change background colour of dropdownbutton
                                          Theme(
                                              data: Theme.of(context)
                                                  .copyWith(
                                                  canvasColor: Colors
                                                      .white),
                                              child: DropdownButton(
                                                  items: snapshot
                                                      .data!
                                                      .map((
                                                      subcategory) =>
                                                      DropdownMenuItem<
                                                          MachineMaintenanceSubCategoryListModel>(
                                                        value: subcategory,
                                                        child: subcategory
                                                            .serviceSubCategoryName ==
                                                            "Select Category"
                                                            ?
                                                        Text(
                                                          subcategory
                                                              .serviceSubCategoryName
                                                              .toString(),
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .red),
                                                        )
                                                            :
                                                        Text(
                                                          subcategory
                                                              .serviceSubCategoryName
                                                              .toString(),
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .black),
                                                        ),
                                                      ))
                                                      .toList(),
                                                  style: TextStyle(
                                                      color: Colors
                                                          .black,
                                                      fontWeight: FontWeight
                                                          .w600),
                                                  isExpanded: true,
                                                  hint: Text(
                                                      'Select Sub Category',
                                                      style: TextStyle(
                                                          color: Color(
                                                              0xFF3F4141))),
                                                  value: subCatrgoryTypeselected ==
                                                      null
                                                      ? subCatrgoryTypeselected
                                                      : snapshot.data!
                                                      .where((i) =>
                                                  i.serviceSubCategoryName ==
                                                      subCatrgoryTypeselected!
                                                          .serviceSubCategoryName)
                                                      .first as MachineMaintenanceSubCategoryListModel,
                                                  onChanged: (
                                                      MachineMaintenanceSubCategoryListModel? subCategory) {
                                                    // subsubcategoryModelselected =
                                                    // null;
                                                    setState(() {
                                                      subCatrgoryTypeselected =
                                                          subCategory;
                                                    });
                                                  })),
                                        ),
                                      ));
                                })),

                        // widget.serviceUserdataList![0].workSubCatgory != ""
                        //     ?
                        // Padding(
                        //   padding: const EdgeInsets.only(left: 10.0,top: 10),
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //     children: [
                        //       Container(
                        //           // height: 40,
                        //           // width: MediaQuery.of(context).size.width/1.3,
                        //           margin: EdgeInsets.all(2),
                        //           // color: msgCount[index]>=10? Colors.blue[400]:
                        //           child:Container(
                        //             // height: 40,
                        //             color: ThemeColors.greyBackgrounColor.withOpacity(0.5),
                        //             child: Padding(
                        //               padding: const EdgeInsets.all(4.0),
                        //               child: Row(
                        //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //                 children: [
                        //                   Padding(
                        //                     padding: const EdgeInsets.only(left: 3),
                        //                     child: Container(
                        //                       width: MediaQuery.of(context).size.width * 0.4,
                        //                       child: Text('${widget.serviceUserdataList![0].workSubCatgory}',
                        //                         style: TextStyle(fontFamily: 'Poppins',color: Colors.black),
                        //                         textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis,
                        //                       ),
                        //                     ),
                        //                   ),
                        //
                        //                 ],
                        //               ),
                        //             ),
                        //           )
                        //
                        //       ),
                        //
                        //       // Padding(
                        //       //   padding: const EdgeInsets.only(right: 6.0),
                        //       //   child: InkWell(
                        //       //     onTap: (){
                        //       //       setState(() {
                        //       //         // int index1 = machineName
                        //       //         //     .indexWhere((element) => element.id! == machineName[index].id);
                        //       //
                        //       //         machineList.removeAt(index);
                        //       //       });
                        //       //
                        //       //     },
                        //       //     child: Icon(Icons.clear,color: ThemeColors.buttonColor,),
                        //       //   ),
                        //       // ),
                        //     ],
                        //   ),
                        // ) ,
                        // : Container(),

                        SizedBox(height: 15,),

                        ///AGE and GENDER
                        Row(

                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [

                            ///Age
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 0.0, bottom: 10),
                                  child: Text("Age",
                                    style: TextStyle(fontFamily: 'Poppins', fontSize: 14,fontWeight: FontWeight.w400,color: Colors.black.withOpacity(0.5)),
                                    textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis,
                                  ),
                                ),
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
                              ],
                            ),

                            ///Gender
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [Padding(
                                padding: const EdgeInsets.only(left: 0.0, bottom: 10),
                                child: Text("Gender",
                                  style: TextStyle(fontFamily: 'Poppins', fontSize: 14,fontWeight: FontWeight.w400,color: Colors.black.withOpacity(0.5)),
                                  textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis,
                                ),
                              ),
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
                      ],
                    ),
                  ),
                  SizedBox(height: 10,),


                  Divider(
                    // height: 2,
                    thickness: 2.0,
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
                          child: Text("Current Address",
                            style: TextStyle(fontFamily: 'Poppins', fontSize: 14,fontWeight: FontWeight.w400,color: Colors.black.withOpacity(0.5)),
                            textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        ///Current Address
                        TextFormField(
                          controller: _locationController,
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
                              return 'Please enter your current address...';
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

                  SizedBox(height: 10,),

                  Divider(
                    // height: 2,
                    thickness: 2.0,
                  ),


                  ///Total Expirence
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text("Total Experince",
                      style: TextStyle(fontFamily: 'Poppins', fontSize: 18,fontWeight: FontWeight.w500),
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
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 0.0, bottom: 10),
                                child: Text("Year",
                                  style: TextStyle(fontFamily: 'Poppins', fontSize: 14,fontWeight: FontWeight.w400,color: Colors.black.withOpacity(0.5)),
                                  textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis,
                                ),
                              ),
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
                            ],
                          ),

                          ///Months
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 0.0, bottom: 10),
                                child: Text("Months",
                                  style: TextStyle(fontFamily: 'Poppins', fontSize: 14,fontWeight: FontWeight.w400,color: Colors.black.withOpacity(0.5)),
                                  textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis,
                                ),
                              ),
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
                      style: TextStyle(fontFamily: 'Poppins', fontSize: 18,fontWeight: FontWeight.w500),
                      textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis,
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.only(left: 30,right: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        expCompanyForms.isNotEmpty
                            ?
                        Column(
                          children: [
                            ListView.builder(
                                itemCount: expCompanyForms.length,
                                // itemCount:4,
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
                              style: TextStyle(fontFamily: 'Poppins', fontSize: 14,fontWeight: FontWeight.w600,color: Colors.black),
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
                      style: TextStyle(fontFamily: 'Poppins', fontSize: 18,fontWeight: FontWeight.w500),
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
                              style: TextStyle(fontFamily: 'Poppins', fontSize: 14,fontWeight: FontWeight.w600,color: Colors.black),
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
                          child: Text("Bank Name",
                            style: TextStyle(fontFamily: 'Poppins', fontSize: 14,fontWeight: FontWeight.w400,color: Colors.black.withOpacity(0.5)),
                            textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis,
                          ),
                        ),
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

                        Padding(
                          padding: const EdgeInsets.only(left: 0.0, bottom: 10),
                          child: Text("Account Number",
                            style: TextStyle(fontFamily: 'Poppins', fontSize: 14,fontWeight: FontWeight.w400,color: Colors.black.withOpacity(0.5)),
                            textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        ///Account Number
                        TextFormField(
                          // initialValue: Application.customerLogin!.name.toString(),
                          controller: _accountNumberController,
                          textAlign: TextAlign.start,
                          keyboardType: TextInputType.number,
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

                        Padding(
                          padding: const EdgeInsets.only(left: 0.0, bottom: 10),
                          child: Text("IFSC Code",
                            style: TextStyle(fontFamily: 'Poppins', fontSize: 14,fontWeight: FontWeight.w400,color: Colors.black.withOpacity(0.5)),
                            textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis,
                          ),
                        ),
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

                        Padding(
                          padding: const EdgeInsets.only(left: 0.0, bottom: 10),
                          child: Text("Branch Name",
                            style: TextStyle(fontFamily: 'Poppins', fontSize: 14,fontWeight: FontWeight.w400,color: Colors.black.withOpacity(0.5)),
                            textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis,
                          ),
                        ),
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

                        Padding(
                          padding: const EdgeInsets.only(left: 0.0, bottom: 10),
                          child: Text("UPI Id",
                            style: TextStyle(fontFamily: 'Poppins', fontSize: 14,fontWeight: FontWeight.w400,color: Colors.black.withOpacity(0.5)),
                            textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis,
                          ),
                        ),
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
                            child: Text("SHOP ACT License",
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
                            if(state is UpdateProfileLoading){
                              loading = state.isLoading;
                            }
                            if(state is UpdateProfileSuccess){
                              showCustomSnackBar(context,state.message,isError: false);
                            }
                            if(state is UpdateProfileFail){
                              showCustomSnackBar(context,state.msg.toString(),isError: true);
                            }
                          },
                          child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    // if(_formKey.currentState!.validate()) {
                                    _profileBloc!.add(UpdateProfile(
                                      certificate: educationForms,
                                      serviceUserId: Application.customerLogin!.id
                                          .toString(),
                                      fullName: _nameController.text,
                                      email: _emailController.text,
                                      mobile: _phoneController.text,
                                      gstNo: _gstController.text,
                                      catId:catrgoryTypeselected!.id.toString(),
                                      subCatId:subCatrgoryTypeselected!.serviceCategoryId.toString(),
                                      //  catId:catrgoryTypeselected!.id!=null?catrgoryTypeselected!.id.toString():widget.serviceUserdataList![0].categoryId.toString(),
                                      // subCatId: subCatrgoryTypeselected!.serviceCategoryId!=null?subCatrgoryTypeselected!.serviceCategoryId.toString():widget.serviceUserdataList![0].subCategoryId.toString(),
                                      age: _ageController.text,
                                      gender: _genderController.text,
                                      location: _locationController.text,
                                      pincode: _pinCodeController.text,
                                      city: _cityController.text,
                                      state: _stateController.text,
                                      yearOfExp: _yearsController.text,
                                      monthOfExp: _monthsController.text,
                                      experienceCompanyList: expCompanyForms,
                                      educationList: educationForms,
                                      bankName: _bankNameController.text,
                                      accountNo: _accountNumberController.text,
                                      ifscCode: _iFSCCodeController.text,
                                      branchName: _branchNameController.text,
                                      upiId: _upiIdController.text,
                                      companyName: _companyNameController.text,
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
                                      currentAddress: _locationController.text,
                                    ));
                                    // }else{
                                    //     showCustomSnackBar(context,'Please fill all details.',isError: true);
                                    //   }
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