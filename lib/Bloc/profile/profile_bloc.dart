import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:service_engineer/Bloc/profile/profile_event.dart';
import 'package:service_engineer/Bloc/profile/profile_state.dart';
import 'package:service_engineer/Model/track_process_repo.dart';
import 'package:service_engineer/Repository/UserRepository.dart';
import 'package:http/http.dart' as http;

import '../../Model/profile_model.dart';



class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc({this.userRepository}) : super(InitialProfileState());
  final UserRepository? userRepository;


  @override
  Stream<ProfileState> mapEventToState(event) async* {


    //Update Profile
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

      for(int j = 0; j < event.educationList.length; j++){
        var innerObj ={};
        // var multipartFile = MultipartFile.fromFileSync(event.educationList[j].educationModel!.certificateImg.toString(),
        //     filename: event.educationList[j].educationModel!.certificateImg!.split('/').last.toString());
        innerObj["school_name"] = event.educationList[j].educationModel!.schoolName;
        innerObj["course_name"] = event.educationList[j].educationModel!.courseName ;
        innerObj["passing_year"] = event.educationList[j].educationModel!.passYear ;
        innerObj["certificate"] = event.educationList[j].educationModel!.certificateImg;
        // innerObj["certificate"] = multipartFile;
        educationList.add(innerObj);
      }

      // var companyCertiFile = MultipartFile.fromFileSync(event.companyCertificateImg.toString(),
      //     filename: event.companyCertificateImg.split('/').last.toString());

      var gstCertFile = await http.MultipartFile.fromPath(
          'gst_certificate', event.gstCertificateImg.toString());

      var panCardFile = await http.MultipartFile.fromPath(
          'pan_card', event.panCardImg.toString());

      var shopActFile = await http.MultipartFile.fromPath(
          'shop_act_licence', event.shopActLicenseImg.toString());

      var aadharFile = await http.MultipartFile.fromPath(
          'udhyog_adhar_licence', event.addharCardImg.toString());

      http.MultipartFile companyCertiFile = await http.MultipartFile.fromPath(
          'company_certificate', event.addharCardImg.toString());

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
        // "company_certificate ": event.companyCertificateImg,
        // "gst_certificate ": event.gstCertificateImg,
        // "pan_card ": event.panCardImg,
        // "shop_act_licence ": event.shopActLicenseImg,
        // "udhyog_adhar_licence": event.addharCardImg,
      };


      http.MultipartRequest _request = http.MultipartRequest('POST', Uri.parse('http://mone.ezii.live/service_engineer/add_machine_maintainence_profile'));
      // ..fields.addAll(params);
      _request.files.add(companyCertiFile);
      _request.files.add(gstCertFile);
      _request.files.add(panCardFile);
      _request.files.add(shopActFile);
      _request.files.add(aadharFile);
      _request = jsonToFormData(_request, params);
      print(jsonEncode(_request.fields));
      var streamResponse = await _request.send();
      var response = await http.Response.fromStream(streamResponse);
      final responseJson = json.decode(response.body);
      print(responseJson);
      ProfileRepo result =  ProfileRepo.fromJson(responseJson);
      print(result.data);

      ///Case API fail but not have token
      if (result.success == true) {

        try {
          ///Begin start AuthBloc Event AuthenticationSave
          yield UpdateProfileLoading(
            isLoading: true,
          );
          yield UpdateProfileSuccess(message: result.data!);
        } catch (error) {
          ///Notify loading to UI
          yield UpdateProfileLoading(
                      isLoading: true,
                    );
          yield UpdateProfileFail(msg: result.data!);
        }
      } else {
        ///Notify loading to UI
        yield UpdateProfileLoading(isLoading: true);
        yield UpdateProfileFail(msg: result.data!);
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
