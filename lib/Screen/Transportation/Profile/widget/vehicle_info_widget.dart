
import 'dart:io';
import 'package:image_cropper/image_cropper.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:service_engineer/Model/vehicle_info_model.dart';
import '../../../../Constant/theme_colors.dart';
import '../../../../Model/education_model.dart';
import '../../../../Model/experience_company_model.dart';
import '../../../../image_file.dart';



class VehicleInfFormWidget extends StatefulWidget {
  VehicleInfFormWidget(
      {Key? key, this.vehicleInfoModel,this.vehiclePUCImageModel,this.vehicleRCImageModel,required this.onRemove,required this.vehicleImageModel, this.index})
      : super(key: key);

  final index;
  VehicleInfoModel? vehicleInfoModel;
  VehicleImageModel? vehicleImageModel;
  VehicleRCImageModel? vehicleRCImageModel;
  VehiclePUCImageModel? vehiclePUCImageModel;
  final Function onRemove;
  final state = _VehicleInfFormWidgetState();

  @override
  State<StatefulWidget> createState() {
    return state;
  }

  TextEditingController _vehicleNameController = TextEditingController();
  TextEditingController _vehicleTypeController = TextEditingController();
  TextEditingController _chassisNumberController = TextEditingController();
  TextEditingController _registrationUptoController = TextEditingController();
  TextEditingController _vehicleNumberController = TextEditingController();
  VehicleImage? vehicleImageFile;
  VehicleRCImage? vehicleRCImageFile;
  VehiclePUCImage? vehiclePUCImageFile;


  bool isValidated() => state.validate();
}

class _VehicleInfFormWidgetState extends State<VehicleInfFormWidget> {
  final formKey = GlobalKey<FormState>();
  bool loading = true;
  File? _vehicleImage;
  File? _vehicleRCImage;
  File? _vehiclePUCImage;
  final picker = ImagePicker();
  DateTime selectedRegistrationUptoDate = DateTime.now();


  Future<Null> _selectWorkFromDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        // initialDate: selectedDate,
        initialDate: DateTime.now(),
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(1950),
        lastDate: DateTime(2101));
    if (picked != null)
      setState(() {
        selectedRegistrationUptoDate = picked;
        if (selectedRegistrationUptoDate != null) {
          widget._registrationUptoController.text =
              DateFormat.yMd('es').format(selectedRegistrationUptoDate);
          widget.vehicleInfoModel!.registrationUpto =
              DateFormat.yMd('es').format(selectedRegistrationUptoDate);
        }
      });
  }

  ///vehicle Image
  _openvehicleImageGallery(BuildContext context) async {
    final image =
    await picker.getImage(source: ImageSource.gallery, imageQuality: 25);
    widget.vehicleImageFile = new VehicleImage();
    if (image != null) {
      _vehicleImagecropImage(image);
    }
  }
  // For crop image
  Future<Null> _vehicleImagecropImage(PickedFile imageCropped) async {
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
        _vehicleImage = croppedFile;
        widget.vehicleImageFile!.imagePath = _vehicleImage!.path;
        print(widget.vehicleImageFile!.imagePath);
        widget.vehicleInfoModel!.vehicleImg = widget.vehicleImageFile!.imagePath!;
        widget.vehicleImageModel!.vehicleImage = widget.vehicleImageFile!.imagePath!;
      });
      // Navigator.pop(context);
    }
  }

  ///vehicle RC Image
  _openvehicleRCImageGallery(BuildContext context) async {
    final image =
    await picker.getImage(source: ImageSource.gallery, imageQuality: 25);
    widget.vehicleRCImageFile = new VehicleRCImage();
    if (image != null) {
      _vehicleRCImagecropImage(image);
    }
  }
  // For crop image
  Future<Null> _vehicleRCImagecropImage(PickedFile imageCropped) async {
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
        _vehicleRCImage = croppedFile;
        widget.vehicleRCImageFile!.imagePath = _vehicleRCImage!.path;
        print(widget.vehicleImageFile!.imagePath);
        widget.vehicleInfoModel!.vehicleRcImage = widget.vehicleRCImageFile!.imagePath;
        widget.vehicleRCImageModel!.vehicleRCImage = widget.vehicleRCImageFile!.imagePath;
      });
      // Navigator.pop(context);
    }
  }

  ///vehicle Image
  _openvehiclePUCImageGallery(BuildContext context) async {
    final image =
    await picker.getImage(source: ImageSource.gallery, imageQuality: 25);
    widget.vehiclePUCImageFile = new VehiclePUCImage();
    if (image != null) {
      _vehiclePUCImagecropImage(image);
    }
  }
  // For crop image

  Future<Null> _vehiclePUCImagecropImage(PickedFile imageCropped) async {
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
        _vehiclePUCImage = croppedFile;
        widget.vehiclePUCImageFile!.imagePath = _vehiclePUCImage!.path;
        print(widget.vehiclePUCImageFile!.imagePath);
        widget.vehicleInfoModel!.vehiclePucImg = widget.vehiclePUCImageFile!.imagePath;
        widget.vehiclePUCImageModel!.vehiclePUCImage = widget.vehiclePUCImageFile!.imagePath;
      });
      // Navigator.pop(context);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    //saveDeviceTokenAndId();
    super.initState();
    widget.vehicleImageFile = new VehicleImage();
    widget.vehicleRCImageFile = new VehicleRCImage();
    widget.vehiclePUCImageFile = new VehiclePUCImage();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                    onTap: (){
                      widget.onRemove();
                    },
                    child: Icon(Icons.clear, color: ThemeColors.buttonColor,))
              ],
            ),
            ///Vehicle Name
            TextFormField(
              // initialValue: Application.customerLogin!.name.toString(),
              controller: widget._vehicleNameController,
              textAlign: TextAlign.start,
              keyboardType: TextInputType.text,
              style: TextStyle(
                fontSize: 18,
                height: 1.5,
              ),
              decoration: InputDecoration(
                filled: true,
                fillColor: ThemeColors.textFieldBackgroundColor,
                hintText: "Vehicle Name",
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
                  return 'Please enter Vehicle Name';
                }

                return null;
              },
              onSaved: (value) => widget.vehicleInfoModel!.vehicleName = value!,
              onChanged: (value) {
                widget.vehicleInfoModel!.vehicleName=value;
                setState(() {
                  // _nameController.text = value;
                  if (formKey.currentState!.validate()) {}
                });
              },
            ),

            SizedBox(height: 15,),

            ///Vehicle Type
            TextFormField(
              controller: widget._vehicleTypeController,
              textAlign: TextAlign.start,
              keyboardType: TextInputType.text,
              style: TextStyle(
                fontSize: 18,
                height: 1.5,
              ),
              decoration: InputDecoration(
                filled: true,
                fillColor: ThemeColors.textFieldBackgroundColor,
                hintText: "Vehicle Type",
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
                  return 'Please enter Vehicle Type';
                }
                return null;
              },
              onSaved: (value) => widget.vehicleInfoModel!.vehicleType = value!,
              onChanged: (value) {
                widget.vehicleInfoModel!.vehicleType=value;
                setState(() {
                  // _nameController.text = value;
                  if (formKey.currentState!.validate()) {}
                });
              },
            ),

            SizedBox(height: 15,),

            ///Chasis Number
            TextFormField(
              // initialValue: Application.customerLogin!.name.toString(),
              controller: widget._chassisNumberController,
              textAlign: TextAlign.start,
              keyboardType: TextInputType.number,
              style: TextStyle(
                fontSize: 18,
                height: 1.5,
              ),
              decoration: InputDecoration(
                filled: true,
                fillColor: ThemeColors.textFieldBackgroundColor,
                hintText: "Chasis Number",
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
                  return 'Please enter Chasis Number';
                }
                return null;
              },
              onSaved: (value) => widget.vehicleInfoModel!.chasisNumber = value!,
              onChanged: (value) {
                widget.vehicleInfoModel!.chasisNumber=value;
                setState(() {
                  // _nameController.text = value;
                  if (formKey.currentState!.validate()) {}
                });
              },
            ),

            SizedBox(height: 15,),

            ///Registration Upto
            InkWell(
              onTap: (){
                _selectWorkFromDate(context);
              },
              child: TextFormField(
                enabled: false,
                // initialValue: Application.customerLogin!.name.toString(),
                controller: widget._registrationUptoController,
                textAlign: TextAlign.start,
                keyboardType: TextInputType.number,
                style: TextStyle(
                  fontSize: 18,
                  height: 1.5,
                ),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: ThemeColors.textFieldBackgroundColor,
                  hintText: "Registration Upto",
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
                    return 'Please enter Registration Upto';
                  }
                  return null;
                },
                onSaved: (value) => widget.vehicleInfoModel!.registrationUpto = value!,
                onChanged: (value) {
                  widget.vehicleInfoModel!.registrationUpto=value;
                  setState(() {
                    // _nameController.text = value;
                    if (formKey.currentState!.validate()) {}
                  });
                },
              ),
            ),

            SizedBox(height: 15,),

            ///Vehicle Number
            TextFormField(
              // initialValue: Application.customerLogin!.name.toString(),
              controller: widget._vehicleNumberController,
              textAlign: TextAlign.start,
              keyboardType: TextInputType.number,
              style: TextStyle(
                fontSize: 18,
                height: 1.5,
              ),
              decoration: InputDecoration(
                filled: true,
                fillColor: ThemeColors.textFieldBackgroundColor,
                hintText: "Vehicle Number",
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
                  return 'Please enter Vehicle Number';
                }
                return null;
              },
              onSaved: (value) => widget.vehicleInfoModel!.vehicleNumber = value!,
              onChanged: (value) {
                widget.vehicleInfoModel!.vehicleNumber=value;
                setState(() {
                  // _nameController.text = value;
                  if (formKey.currentState!.validate()) {}
                });
              },
            ),

            SizedBox(height: 15,),

            ///Vehicle Image
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
                        // alignment: Alignment.bottomLeft,
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Text(widget.vehicleImageFile!.imagePath == null ? "Upload Vehicle Image": widget.vehicleImageFile!.imagePath!.split('/').last.toString(),
                          style: TextStyle(fontFamily: 'Poppins-Medium',color: Colors.black.withOpacity(0.5)),
                          maxLines: 2, overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        _openvehicleImageGallery(context);
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

            ///Vehicle RC Image
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
                        // alignment: Alignment.bottomLeft,
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Text(widget.vehicleRCImageFile!.imagePath == null ? "Upload RC Image": widget.vehicleRCImageFile!.imagePath!.split('/').last.toString(),
                          style: TextStyle(fontFamily: 'Poppins-Medium',color: Colors.black.withOpacity(0.5)),
                          maxLines: 2, overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        _openvehicleRCImageGallery(context);
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

            ///Vehicle PUC Image
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
                        // alignment: Alignment.bottomLeft,
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Text(widget.vehiclePUCImageFile!.imagePath == null ? "Upload PUC Image": widget.vehiclePUCImageFile!.imagePath!.split('/').last.toString(),
                          style: TextStyle(fontFamily: 'Poppins-Medium',color: Colors.black.withOpacity(0.5)),
                          maxLines: 2, overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        _openvehiclePUCImageGallery(context);
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
    );
  }

  bool validate() {
    //Validate Form Fields
    bool validate = formKey.currentState!.validate();
    if (validate) formKey.currentState!.save();
    return validate;
  }
}