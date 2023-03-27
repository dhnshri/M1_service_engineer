import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:async/async.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:service_engineer/Bloc/profile/profile_event.dart';
import 'package:service_engineer/Bloc/profile/profile_state.dart';
import 'package:service_engineer/Model/track_process_repo.dart';
import 'package:service_engineer/Repository/UserRepository.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:mime/mime.dart';
import '../../Model/profile_model.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http_parser/http_parser.dart';

import '../../Model/profile_repo.dart';



class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc({this.userRepository}) : super(InitialProfileState());
  final UserRepository? userRepository;


  @override
  Stream<ProfileState> mapEventToState(event) async* {


    //Update Profile for Machine Maintanence
    if (event is UpdateProfile) {
      ///Notify loading to UI
      yield UpdateProfileLoading(
        isLoading: false,
      );

      var expCompanyList = [];
      var educationList = [];

      for(int j = 0; j < event.experienceCompanyList.length; j++){
        var innerObj ={};
        innerObj["company_name"] = event.experienceCompanyList[j].expCompanyModel!.companyName;
        innerObj["job_post"] = event.experienceCompanyList[j].expCompanyModel!.jobPost;
        innerObj["description"] = event.experienceCompanyList[j].expCompanyModel!.desciption;
        innerObj["work_from"] = event.experienceCompanyList[j].expCompanyModel!.fromYear;
        innerObj["work_till"] = event.experienceCompanyList[j].expCompanyModel!.tillYear;
        expCompanyList.add(innerObj);
      }


      List<MultipartFile>? files;

      for(int j = 0; j < event.educationList.length; j++){
        var innerObj ={};
        innerObj["school_name"] = event.educationList[j].educationModel!.schoolName;
        innerObj["course_name"] = event.educationList[j].educationModel!.courseName ;
        innerObj["passing_year"] = event.educationList[j].educationModel!.passYear ;
        // innerObj["certificate"] = event.educationList[j].educationModel!.certificateImg;
        // innerObj["certificate"] = multipartFile;
        educationList.add(innerObj);

      }


      var gstCertFile = await http.MultipartFile.fromPath(
          'gst_certificate', event.gstCertificateImg.toString());

      var panCardFile = await http.MultipartFile.fromPath(
          'pan_card', event.panCardImg.toString());

      var shopActFile = await http.MultipartFile.fromPath(
          'shop_act_licence', event.shopActLicenseImg.toString());

      var aadharFile = await http.MultipartFile.fromPath(
          'udhyog_adhar_licence', event.addharCardImg.toString());

      var companyCertiFile = await http.MultipartFile.fromPath(
          'company_certificate', event.companyCertificateImg.toString());

      var userProfileImgFile = await http.MultipartFile.fromPath(
          'user_profile_pic', event.companyCertificateImg.toString());

      Map<String, String> params = {
        "full_name": event.fullName.toString(),
        "email":event.email,
        "mobile":event.mobile,
        "gst_no":event.gstNo,
        "work_category_id":event.catId,
        "work_sub_category_id":event.subCatId,
        "age": event.age,
        "gender": event.gender,
        "location": event.location,
        "current_address": event.location,
        "pincode": event.pincode,
        "city": event.city,
        "state": event.state,
        "year_of_experience": event.yearOfExp,
        "month_of_experience": event.monthOfExp,
        "bank_name": event.bankName,
        "account_number": event.accountNo,
        "ifsc_code": event.ifscCode,
        "upi_id": event.upiId,
        "branch_name": event.bankName,
        "company_name": event.companyName,
        "experience_companies": jsonEncode(expCompanyList),
        // "educations": jsonEncode(educationList),
        "educations": jsonEncode(educationList),
        "service_user_id": event.serviceUserId,
        "certificate[]": files.toString()
      };


      http.MultipartRequest _request = http.MultipartRequest('POST', Uri.parse('http://mone.ezii.live/service_engineer/add_machine_maintainence_profile'));
      // ..fields.addAll(params);
      _request.files.add(companyCertiFile);
      _request.files.add(gstCertFile);
      _request.files.add(panCardFile);
      _request.files.add(shopActFile);
      _request.files.add(aadharFile);
      _request.files.add(userProfileImgFile);

      List<http.MultipartFile> imageUploadReqListSingle = <http.MultipartFile>[];

      for(int j = 0; j < event.educationList.length; j++) {
        final mimeTypeDataProfile = lookupMimeType(
            event.educationList[j].educationModel!.certificateImg
                .toString(), headerBytes: [0xFF, 0xD8])!.split('/');
        //initialize multipart request
        //attach the file in the request
        final certi = await http.MultipartFile.fromPath(
            'certificate[]', event.educationList[j].imageFile!.imagePath.toString(),
            contentType: MediaType(
                mimeTypeDataProfile[0], mimeTypeDataProfile[1]));

        imageUploadReqListSingle.add(certi);
      }

      _request = jsonToFormData(_request, params);
      _request.files.addAll(imageUploadReqListSingle);

      print(jsonEncode(_request.fields));
      var streamResponse = await _request.send();
      var response = await http.Response.fromStream(streamResponse);
      final responseJson = json.decode(response.body);
      print(responseJson);
      ProfileRepo result =  ProfileRepo.fromJson(responseJson);
      print(result.msg);

      ///Case API fail but not have token
      if (result.success == true) {

        try {
          ///Begin start AuthBloc Event AuthenticationSave
          yield UpdateProfileLoading(
            isLoading: true,
          );
          yield UpdateProfileSuccess(message: result.msg.toString());
        } catch (error) {
          ///Notify loading to UI
          yield UpdateProfileLoading(
                      isLoading: true,
                    );
          yield UpdateProfileFail(msg: result.msg.toString());
        }
      } else {
        ///Notify loading to UI
        yield UpdateProfileLoading(isLoading: true);
        yield UpdateProfileFail(msg: result.msg.toString());
      }
    }

    if (event is GetMachineProfile) {
      ///Notify loading to UI
      yield GetMachineProfileLoading(
        isLoading: false,
      );

      ///Fetch API via repository
      final JobWorkProfileRepo result = await userRepository!
          .geMachineProfile(
          serviceUserId: event.serviceUserId,
          roleId: event.roleId
      );
      print(result);


      if (result.success == true) {

        final profileData = result.profileData['ServiceUserData'];
        print(profileData);
        ///For Service User Data
        final Iterable refactorUserProfileDataList = result.profileData['ServiceUserData'] ?? [];
        final userDetailsList = refactorUserProfileDataList.map((item) {
          return ServiceUserData.fromJson(item);
        }).toList();
        print('Quotation Reply List: $userDetailsList');

        //
        ///For Kyc Details
        final Iterable refactorProfileKYCDetailsList = result.profileData!['ProfileBankDetails'] ?? [];
        final profileKycDetailsList = refactorProfileKYCDetailsList.map((item) {
          return ProfileKYCDetails.fromJson(item);
        }).toList();
        print('Quotation Reply List: $profileKycDetailsList');
        //
        ///For Machine Maintainance Experience
        final Iterable refactorProfileMachineEcperienceList = result.profileData!['MachineMaintenanceExperiences'] ?? [];
        final profileMachineExperienceList = refactorProfileMachineEcperienceList.map((item) {
          return MachineMaintenanceExperiences.fromJson(item);
        }).toList();
        print('Quotation Reply List: $profileMachineExperienceList');

        ///Education Details
        final Iterable refactorProfileMachineEducationList = result.profileData!['MachineMaintenanceEducations'] ?? [];
        final profileMachineEducationList = refactorProfileMachineEducationList.map((item) {
          return MachineMaintenanceEducations.fromJson(item);
        }).toList();
        print('Quotation Reply List: $profileMachineEducationList');

        try {
          ///Begin start AuthBloc Event AuthenticationSave
          yield GetMachineProfileLoading(
            isLoading: true,
          );
          yield GetMachineProfileSuccess(serviceUserdataList: userDetailsList,profileKycList: profileKycDetailsList,
                  profileMachineEducationList: profileMachineEducationList,profileMachineExperienceList: profileMachineExperienceList);
        } catch (error) {
          ///Notify loading to UI
          yield GetMachineProfileFail(msg: result.msg.toString());
        }
      } else {
        ///Notify loading to UI
        yield GetMachineProfileLoading(isLoading: false);
        yield GetMachineProfileFail(msg: result.msg.toString());
      }
    }

    ///Machine Maintainance Task HandOver
    if (event is MachineTaskHandover) {
      ///Notify loading to UI
      yield MachineTaskHandoverLoading(
        isLoading: false,
      );

      ///Fetch API via repository
      final TrackProcessRepo result = await userRepository!
          .machineTaskHandOver(
          serviceUserId: event.serviceUserId,
          machineEnqId: event.machineEnquiryId,
          dailyTaskId: event.dailyTaskId,
          description: event.description,
          price: event.price,
      );
      print(result);


      if (result.success == true) {


        try {
          ///Begin start AuthBloc Event AuthenticationSave
          yield MachineTaskHandoverLoading(
            isLoading: true,
          );
          yield MachineTaskHandoverSuccess(msg: result.msg.toString());
        } catch (error) {
          ///Notify loading to UI
          yield MachineTaskHandoverFail(msg: result.msg.toString());
        }
      } else {
        ///Notify loading to UI
        yield MachineTaskHandoverFail(msg: result.msg.toString());
      }
    }


    /// Update Profile for Job Work Enquiry
    if (event is UpdateJobWorkProfile) {
      ///Notify loading to UI
      yield UpdateJobWorkProfileLoading(
        isLoading: false,
      );

      var machineList = [];

      for(int j = 0; j < event.machineList.length; j++){
        var innerObj ={};
        innerObj["machine_name"] = event.machineList[j].machineName;
        innerObj["quantity"] = event.machineList[j].quantity;
        machineList.add(innerObj);
      }


      // var companyProfileImg = await http.MultipartFile.fromBytes('company_profile_pic', await File.fromUri(Uri.parse(event.companyProfilePic.toString())).readAsBytes(), contentType: new MediaType('image', 'jpeg'));
      // var _base64 = base64Encode(event.companyProfilePic);

      var companyProfileImg = await http.MultipartFile.fromPath(
          'company_profile_pic', event.companyProfilePic.toString(),);

      var gstCertFile = await http.MultipartFile.fromPath(
          'gst_certificate', event.gstCertificateImg.toString());

      var panCardFile = await http.MultipartFile.fromPath(
          'pan_card', event.panCardImg.toString());

      var shopActFile = await http.MultipartFile.fromPath(
          'shop_act_licence', event.shopActLicenseImg.toString());

      var aadharFile = await http.MultipartFile.fromPath(
          'udhyog_adhar_licence', event.addharCardImg.toString());

      var companyCertiFile = await http.MultipartFile.fromPath(
          'company_certificate', event.companyCertificateImg.toString());

      var userProfileImg = await http.MultipartFile.fromPath(
          'user_profile_pic', event.userProfilePic.toString());

      Map<String, String> params = {
        "company_name": event.companyName.toString(),
        "coordinate_name": event.coOrdinateName.toString(),
        "email":event.email,
        "mobile":event.mobile,
        "gst_no":event.gstNo,
        "category_id":event.catId,
        "sub_category_id":event.subCatId,
        "location": event.location,
        "current_address": event.location,
        "pincode": event.pincode,
        "city_id": event.city,
        "state_id": event.state,
        "country": event.country,
        "company_name": event.companyName.toString(),
        "machine_list": jsonEncode(machineList),
        "service_user_id":event.serviceUserId,
      };


      http.MultipartRequest _request = http.MultipartRequest('POST', Uri.parse('http://mone.ezii.live/service_engineer/add_job_work_enquiry_profile'));
      // ..fields.addAll(params);
      _request.files.add(companyCertiFile);
      _request.files.add(gstCertFile);
      _request.files.add(panCardFile);
      _request.files.add(shopActFile);
      _request.files.add(aadharFile);
      _request.files.add(companyProfileImg);
      _request.files.add(userProfileImg);
      _request = jsonToFormData(_request, params);
      print(jsonEncode(_request.fields));
      var streamResponse = await _request.send();
      var response = await http.Response.fromStream(streamResponse);
      final responseJson = json.decode(response.body);
      print(responseJson);
      ProfileRepo result =  ProfileRepo.fromJson(responseJson);
      print(result.msg);

      ///Case API fail but not have token
      if (result.success == true) {

        try {
          ///Begin start AuthBloc Event AuthenticationSave
          yield UpdateJobWorkProfileLoading(
            isLoading: true,
          );
          yield UpdateJobWorkProfileSuccess(message: result.msg.toString());
        } catch (error) {
          ///Notify loading to UI
          yield UpdateJobWorkProfileLoading(
            isLoading: true,
          );
          yield UpdateJobWorkProfileFail(msg: result.msg.toString());
        }
      } else {
        ///Notify loading to UI
        yield UpdateJobWorkProfileLoading(isLoading: true);
        yield UpdateJobWorkProfileFail(msg: result.msg.toString());
      }
    }

    ///Get Jow Work Profile
    if (event is GetJobWorkProfile) {
      ///Notify loading to UI
      yield GetJobWorkProfileLoading(
        isLoading: false,
      );

      ///Fetch API via repository
      final JobWorkProfileRepo result = await userRepository!
          .geJobWorkProfile(
          serviceUserId: event.serviceUserId,
          roleId: event.roleId
      );
      print(result);


      if (result.success == true) {

        final profileData = result.profileData['ServiceUserData'];
        print(profileData);
        ///For Service User Data
        final Iterable refactorUserProfileDataList = result.profileData['ServiceUserData'] ?? [];
        final userDetailsList = refactorUserProfileDataList.map((item) {
          return ServiceUserData.fromJson(item);
        }).toList();
        print('Quotation Reply List: $userDetailsList');

        //
        ///For Quotation Charges
        final Iterable refactorProfileKYCDetailsList = result.profileData!['ProfileKYCDetails'] ?? [];
        final profileKycDetailsList = refactorProfileKYCDetailsList.map((item) {
          return ProfileKYCDetails.fromJson(item);
        }).toList();
        print('Quotation Reply List: $profileKycDetailsList');
        //
        ///For Quotation Charges
        final Iterable refactorProfileMachineList = result.profileData!['JobWorkMachineList'] ?? [];
        final profileMachineList = refactorProfileMachineList.map((item) {
          return JobWorkMachineList.fromJson(item);
        }).toList();
        print('Quotation Reply List: $profileMachineList');


        try {
          ///Begin start AuthBloc Event AuthenticationSave
          yield GetJobWorkProfileLoading(
            isLoading: true,
          );
          yield GetJobWorkProfileSuccess(serviceUserdataList: userDetailsList,profileKycList: profileKycDetailsList,profileMachineList: profileMachineList);
        } catch (error) {
          ///Notify loading to UI
          yield GetJobWorkProfileFail(msg: result.msg.toString());
        }
      } else {
        ///Notify loading to UI
        yield GetJobWorkProfileLoading(isLoading: false);
        yield GetJobWorkProfileFail(msg: result.msg.toString());
      }
    }


    /// Update Profile for Transport
    if (event is UpdateTransportProfile) {
      ///Notify loading to UI
      yield UpdateTransportProfileLoading(
        isLoading: false,
      );

      var expCompanyList = [];

      for(int j = 0; j < event.experienceCompanyList.length; j++){
        var innerObj ={};
        innerObj["company_name"] = event.experienceCompanyList[j].expCompanyModel!.companyName;
        innerObj["description"] = event.experienceCompanyList[j].expCompanyModel!.desciption;
        innerObj["work_from"] = event.experienceCompanyList[j].expCompanyModel!.fromYear;
        innerObj["work_till"] = event.experienceCompanyList[j].expCompanyModel!.tillYear;
        expCompanyList.add(innerObj);
      }

      var vehicleInfoList = [];

      for(int j = 0; j < event.vehicleInfoList.length; j++){
        var innerObj ={};
        innerObj["vehicle_name"] = event.vehicleInfoList[j].vehicleInfoModel!.vehicleName;
        innerObj["vehicle_type"] = event.vehicleInfoList[j].vehicleInfoModel!.vehicleType;
        innerObj["chassis_number"] = event.vehicleInfoList[j].vehicleInfoModel!.chasisNumber;
        innerObj["registration_upto"] = event.vehicleInfoList[j].vehicleInfoModel!.registrationUpto;
        innerObj["vehicle_number"] = event.vehicleInfoList[j].vehicleInfoModel!.vehicleNumber;
        vehicleInfoList.add(innerObj);
      }

      var userProfileImg = await http.MultipartFile.fromPath(
          'user_profile_pic', event.userProfileImg.toString());

      var gstCertFile = await http.MultipartFile.fromPath(
          'gst_certificate', event.gstCertificateImg.toString());

      var panCardFile = await http.MultipartFile.fromPath(
          'pan_card', event.panCardImg.toString());

      var shopActFile = await http.MultipartFile.fromPath(
          'shop_act_licence', event.shopActLicenseImg.toString());

      var aadharFile = await http.MultipartFile.fromPath(
          'udhyog_adhar_licence', event.addharCardImg.toString());

      var companyCertiFile = await http.MultipartFile.fromPath(
          'company_certificate', event.companyCertificateImg.toString());

      var driverPhoto = await http.MultipartFile.fromPath(
          'driver_pic', event.driverProfileImg.toString());

      var drivingLicensePhoto = await http.MultipartFile.fromPath(
          'driving_licence', event.driverLicenseImage.toString());

      var driverIdProofPhoto = await http.MultipartFile.fromPath(
          'id_proof', event.driverIdProofImage.toString());

      Map<String, String> params = {
        "full_name": event.ownerName.toString(),
        "email":event.email,
        "mobile":event.mobile,
        "gst_no":event.gstNo,
        "location": event.location,
        "current_address": event.location,
        "pincode": event.pinCode,
        "city_id": event.city,
        "state_id": event.state,
        "country": event.country,
        "years": event.totalYears.toString(),
        "months": event.totalMonths.toString(),
        "bank_name": event.bankName,
        "account_number": event.accountNumber,
        "ifsc_code": event.ifscCode,
        "upi_id": event.upiId,
        "branch_name": event.bankName,
        "company_name": event.companyName,
        "full_name": event.driverName,
        "mobile_no": event.driverNumber,
        "driving_licence_validity": event.driverLicenseValidity,
        "driving_licence_number": event.driverLicenseNumber,
        "experience": jsonEncode(expCompanyList),
        "VehicleInformation": jsonEncode(vehicleInfoList),
        "service_user_id":event.serviceUserId,
      };


      http.MultipartRequest _request = http.MultipartRequest('POST', Uri.parse('http://mone.ezii.live/service_engineer/add_transport_profile'));
      // ..fields.addAll(params);
      _request.files.add(companyCertiFile);
      _request.files.add(gstCertFile);
      _request.files.add(panCardFile);
      _request.files.add(shopActFile);
      _request.files.add(aadharFile);
      _request.files.add(userProfileImg);
      _request.files.add(driverPhoto);
      _request.files.add(drivingLicensePhoto);
      _request.files.add(driverIdProofPhoto);

      // for(MultipartBody multipart in event.userProfileImg) {
      //   if(multipart.file != null) {
      //     Uint8List _list = await multipart.file.readAsBytes();
      //     _request.files.add(http.MultipartFile(
      //       "user_profile_pic", multipart.file.readAsBytes().asStream(), _list.length,
      //       filename: '${DateTime.now().toString()}.jpg',
      //     ));
      //   }
      // }
      // for(MultipartBody multipart in event.gstCertificateImg) {
      //   if(multipart.file != null) {
      //     Uint8List _list = await multipart.file.readAsBytes();
      //     _request.files.add(http.MultipartFile(
      //       "gst_certificate", multipart.file.readAsBytes().asStream(), _list.length,
      //       filename: '${DateTime.now().toString()}.jpg',
      //     ));
      //   }
      // }
      // for(MultipartBody multipart in event.panCardImg) {
      //   if(multipart.file != null) {
      //     Uint8List _list = await multipart.file.readAsBytes();
      //     _request.files.add(http.MultipartFile(
      //       "pan_card", multipart.file.readAsBytes().asStream(), _list.length,
      //       filename: '${DateTime.now().toString()}.jpg',
      //     ));
      //   }
      // }
      // for(MultipartBody multipart in event.shopActLicenseImg) {
      //   if(multipart.file != null) {
      //     Uint8List _list = await multipart.file.readAsBytes();
      //     _request.files.add(http.MultipartFile(
      //       "shop_act_licence", multipart.file.readAsBytes().asStream(), _list.length,
      //       filename: '${DateTime.now().toString()}.jpg',
      //     ));
      //   }
      // }
      // for(MultipartBody multipart in event.addharCardImg) {
      //   if(multipart.file != null) {
      //     Uint8List _list = await multipart.file.readAsBytes();
      //     _request.files.add(http.MultipartFile(
      //       "udhyog_adhar_licence", multipart.file.readAsBytes().asStream(), _list.length,
      //       filename: '${DateTime.now().toString()}.jpg',
      //     ));
      //   }
      // }
      // for(MultipartBody multipart in event.companyCertificateImg) {
      //   if(multipart.file != null) {
      //     Uint8List _list = await multipart.file.readAsBytes();
      //     _request.files.add(http.MultipartFile(
      //       "company_certificate", multipart.file.readAsBytes().asStream(), _list.length,
      //       filename: '${DateTime.now().toString()}.jpg',
      //     ));
      //   }
      // }
      // for(MultipartBody multipart in event.driverProfileImg) {
      //   if(multipart.file != null) {
      //     Uint8List _list = await multipart.file.readAsBytes();
      //     _request.files.add(http.MultipartFile(
      //       "driver_pic", multipart.file.readAsBytes().asStream(), _list.length,
      //       filename: '${DateTime.now().toString()}.jpg',
      //     ));
      //   }
      // }
      // for(MultipartBody multipart in event.driverLicenseImage) {
      //   if(multipart.file != null) {
      //     Uint8List _list = await multipart.file.readAsBytes();
      //     _request.files.add(http.MultipartFile(
      //       "driving_licence", multipart.file.readAsBytes().asStream(), _list.length,
      //       filename: '${DateTime.now().toString()}.jpg',
      //     ));
      //   }
      // }
      // for(MultipartBody multipart in event.driverIdProofImage) {
      //   if(multipart.file != null) {
      //     Uint8List _list = await multipart.file.readAsBytes();
      //     _request.files.add(http.MultipartFile(
      //       "id_proof", multipart.file.readAsBytes().asStream(), _list.length,
      //       filename: '${DateTime.now().toString()}.jpg',
      //     ));
      //   }
      // }

      /// Upload Multiple Vehicle Images
      List<http.MultipartFile> vehicleImageList = <http.MultipartFile>[];
      for(int j = 0; j < event.vehicleInfoList.length; j++) {
        final mimeTypeDataProfile = lookupMimeType(
            event.vehicleInfoList[j].vehicleImageModel!.vehicleImage
                .toString(), headerBytes: [0xFF, 0xD8])!.split('/');
        //initialize multipart request
        //attach the file in the request
        final certi = await http.MultipartFile.fromPath(
            'vehicle_images[]', event.vehicleInfoList[j].vehicleImageModel!.vehicleImage.toString(),
            contentType: MediaType(
                mimeTypeDataProfile[0], mimeTypeDataProfile[1]));

        vehicleImageList.add(certi);
      }

      /// Upload Multiple Vehicle RC Images
      List<http.MultipartFile> vehicleRCImageList = <http.MultipartFile>[];
      for(int j = 0; j < event.vehicleInfoList.length; j++) {
        final mimeTypeDataProfile = lookupMimeType(
            event.vehicleInfoList[j].vehicleRCImageModel!.vehicleRCImage
                .toString(), headerBytes: [0xFF, 0xD8])!.split('/');
        //initialize multipart request
        //attach the file in the request
        final certi = await http.MultipartFile.fromPath(
            'upload_rcs[]', event.vehicleInfoList[j].vehicleRCImageModel!.vehicleRCImage.toString(),
            contentType: MediaType(
                mimeTypeDataProfile[0], mimeTypeDataProfile[1]));

        vehicleRCImageList.add(certi);
      }

      /// Upload Multiple Vehicle PUC Images
      List<http.MultipartFile> vehiclePUCImageList = <http.MultipartFile>[];
      for(int j = 0; j < event.vehicleInfoList.length; j++) {
        final mimeTypeDataProfile = lookupMimeType(
            event.vehicleInfoList[j].vehiclePUCImageModel!.vehiclePUCImage
                .toString(), headerBytes: [0xFF, 0xD8])!.split('/');
        //initialize multipart request
        //attach the file in the request
        final certi = await http.MultipartFile.fromPath(
            'upload_pocs[]', event.vehicleInfoList[j].vehiclePUCImageModel!.vehiclePUCImage.toString(),
            contentType: MediaType(
                mimeTypeDataProfile[0], mimeTypeDataProfile[1]));

        vehiclePUCImageList.add(certi);
      }

      _request.files.addAll(vehicleImageList);
      _request.files.addAll(vehicleRCImageList);
      _request.files.addAll(vehiclePUCImageList);
      _request = jsonToFormData(_request, params);
      print(jsonEncode(_request.fields));
      var streamResponse = await _request.send();
      var response = await http.Response.fromStream(streamResponse);
      final responseJson = json.decode(response.body);
      print(responseJson);
      ProfileRepo result =  ProfileRepo.fromJson(responseJson);
      print(result.msg);

      ///Case API fail but not have token
      if (result.success == true) {

        try {
          ///Begin start AuthBloc Event AuthenticationSave
          yield UpdateTransportProfileLoading(
            isLoading: true,
          );
          yield UpdateTransportProfileSuccess(message: result.msg.toString());
        } catch (error) {
          ///Notify loading to UI
          yield UpdateTransportProfileLoading(
            isLoading: true,
          );
          yield UpdateTransportProfileFail(msg: result.msg.toString());
        }
      } else {
        ///Notify loading to UI
        yield UpdateTransportProfileLoading(isLoading: true);
        yield UpdateTransportProfileFail(msg: result.msg.toString());
      }
    }

    /// Get Transport Profile
    if (event is GetTransportProfile) {
      ///Notify loading to UI
      yield GetTransportProfileLoading(
        isLoading: false,
      );

      ///Fetch API via repository
      final JobWorkProfileRepo result = await userRepository!
          .geTransportProfile(
          serviceUserId: event.serviceUserId,
          roleId: event.roleId
      );
      print(result);


      if (result.success == true) {

        final profileData = result.profileData['ServiceUserData'];
        print(profileData);
        ///For Service User Data
        final Iterable refactorUserProfileDataList = result.profileData['ServiceUserData'] ?? [];
        final userDetailsList = refactorUserProfileDataList.map((item) {
          return ServiceUserData.fromJson(item);
        }).toList();
        print('Quotation Reply List: $userDetailsList');

        //
        ///For Bank Data
        final Iterable refactorProfileKYCDetailsList = result.profileData!['ProfileBankDetails'] ?? [];
        final profileKycDetailsList = refactorProfileKYCDetailsList.map((item) {
          return ProfileKYCDetails.fromJson(item);
        }).toList();
        print('Quotation Reply List: $profileKycDetailsList');
        //
        ///For Driver Detail
        final Iterable refactorProfileDriverDetailsList = result.profileData!['DriverProfileDetails'] ?? [];
        final profileDriverDetailsList = refactorProfileDriverDetailsList.map((item) {
          return DriverProfileDetails.fromJson(item);
        }).toList();
        print('Quotation Reply List: $profileDriverDetailsList');

        ///For Vehicle Information
        final Iterable refactorProfileVehicleInfoList = result.profileData!['ProfileVehicleInformation'] ?? [];
        final profileVehicleInfoList = refactorProfileVehicleInfoList.map((item) {
          return ProfileVehicleInformation.fromJson(item);
        }).toList();
        print('Quotation Reply List: $profileVehicleInfoList');

        ///For Vehicle Information
        final Iterable refactorProfileExperienceList = result.profileData!['TransportProfileExperience'] ?? [];
        final profileExperienceList = refactorProfileExperienceList.map((item) {
          return TransportProfileExperience.fromJson(item);
        }).toList();
        print('Quotation Reply List: $profileExperienceList');


        try {
          ///Begin start AuthBloc Event AuthenticationSave
          yield GetTransportProfileLoading(
            isLoading: true,
          );
          yield GetTransportProfileSuccess(serviceUserdataList: userDetailsList,profileKycList: profileKycDetailsList,
                  profileDriverDetailsList: profileDriverDetailsList,profileVehicleInfoList: profileVehicleInfoList, profileExperienceList: profileExperienceList);
        } catch (error) {
          ///Notify loading to UI
          yield GetTransportProfileFail(msg: result.msg.toString());
        }
      } else {
        ///Notify loading to UI
        yield GetTransportProfileLoading(isLoading: false);
        yield GetTransportProfileFail(msg: result.msg.toString());
      }
    }

  }
  jsonToFormData(http.MultipartRequest request, Map<String, dynamic> data) {
    for (var key in data.keys) {
      request.fields[key] = data[key].toString();
    }
    return request;
  }
 }
class MultipartBody {
  String key;
  XFile file;

  MultipartBody(this.key, this.file);
}