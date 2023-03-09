
import 'dart:io';
import 'package:image_cropper/image_cropper.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../Constant/theme_colors.dart';
import '../../../../Model/education_model.dart';
import '../../../../Model/experience_company_model.dart';
import '../../../../image_file.dart';



class EducationFormWidget extends StatefulWidget {
  EducationFormWidget(
      {Key? key, this.educationModel,required this.onRemove, this.index})
      : super(key: key);

  final index;
  EducationModel? educationModel;
  final Function onRemove;
  final state = _EducationFormWidgetState();

  @override
  State<StatefulWidget> createState() {
    return state;
  }

  TextEditingController _schoolNameController = TextEditingController();
  TextEditingController _courseNameController = TextEditingController();
  TextEditingController _passingYearController = TextEditingController();


  bool isValidated() => state.validate();
}

class _EducationFormWidgetState extends State<EducationFormWidget> {
  final formKey = GlobalKey<FormState>();
  bool loading = true;
  ImageFile? imageFile;
  File? _image;
  final picker = ImagePicker();

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


  @override
  void initState() {
    // TODO: implement initState
    //saveDeviceTokenAndId();
    super.initState();
    imageFile = new ImageFile();

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
            ///School/College Name
            TextFormField(
              // initialValue: Application.customerLogin!.name.toString(),
              controller: widget._schoolNameController,
              textAlign: TextAlign.start,
              keyboardType: TextInputType.text,
              style: TextStyle(
                fontSize: 18,
                height: 1.5,
              ),
              decoration: InputDecoration(
                filled: true,
                fillColor: ThemeColors.textFieldBackgroundColor,
                hintText: "School/College Name",
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
                  return 'Please enter School/College Name';
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
                  if (formKey.currentState!.validate()) {}
                });
              },
            ),

            SizedBox(height: 15,),

            ///Class/Course Name
            TextFormField(
              // initialValue: Application.customerLogin!.name.toString(),
              controller: widget._courseNameController,
              textAlign: TextAlign.start,
              keyboardType: TextInputType.text,
              style: TextStyle(
                fontSize: 18,
                height: 1.5,
              ),
              decoration: InputDecoration(
                filled: true,
                fillColor: ThemeColors.textFieldBackgroundColor,
                hintText: "Class/Course Name",
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
                  return 'Please enter Class/Course Name';
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
                  if (formKey.currentState!.validate()) {}
                });
              },
            ),

            SizedBox(height: 15,),

            ///Passing Year
            TextFormField(
              // initialValue: Application.customerLogin!.name.toString(),
              controller: widget._passingYearController,
              textAlign: TextAlign.start,
              keyboardType: TextInputType.text,
              style: TextStyle(
                fontSize: 18,
                height: 1.5,
              ),
              decoration: InputDecoration(
                filled: true,
                fillColor: ThemeColors.textFieldBackgroundColor,
                hintText: "Passing Year",
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
                  return 'Please enter Passing Year';
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
                  if (formKey.currentState!.validate()) {}
                });
              },
            ),

            SizedBox(height: 15,),

            SizedBox(height: 15,),

            ///Certificate
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
                      child: Text(imageFile!.imagePath!.isEmpty ? "":imageFile!.imagePath.toString(),
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