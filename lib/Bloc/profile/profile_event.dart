import 'package:service_engineer/Screen/Transportation/Profile/widget/vehicle_info_widget.dart';
import '../../Model/education_model.dart';
import '../../Model/experience_company_model.dart';
import '../../Model/machine_list_model.dart';
import '../../Screen/MachineMaintenance/Profile/widget/education_form.dart';
import '../../Screen/MachineMaintenance/Profile/widget/expirence_company.dart';

abstract class ProfileEvent {}

class UpdateProfile extends ProfileEvent {

  String fullName;
  String email;
  String mobile;
  String gstNo;
  String catId;
  String subCatId;
  String age;
  String gender;
  String location;
  String currentAddress;
  String pincode;
  String city;
  String state;
  String yearOfExp;
  String monthOfExp;
  String bankName;
  String accountNo;
  String ifscCode;
  String upiId;
  String branchName;
  String companyName;
  String serviceUserId;
  String companyCertificateImg;
  String gstCertificateImg;
  String panCardImg;
  String shopActLicenseImg;
  String addharCardImg;
  List<ExpCompanyFormWidget> experienceCompanyList;
  List<EducationFormWidget> educationList;
  List<EducationFormWidget> certificate;
  // EducationCertificateModel certificate;

  UpdateProfile({
    required this.certificate,
    required this.fullName,
    required this.email,
    required this.mobile,
    required this.gstNo,
    required this.catId,
    required this.subCatId,
    required this.age,
    required this.gender,
    required this.location,
    required this.currentAddress,
    required this.pincode,
    required this.city,
    required this.state,
    required this.yearOfExp,
    required this.monthOfExp,
    required this.bankName,
    required this.accountNo,
    required this.ifscCode,
    required this.upiId,
    required this.branchName,
    required this.companyName,
    required this.serviceUserId,
    required this.companyCertificateImg,
    required this.gstCertificateImg,
    required this.panCardImg,
    required this.shopActLicenseImg,
    required this.addharCardImg,
    required this.experienceCompanyList,
    required this.educationList,
});

}

class UpdateJobWorkProfile extends ProfileEvent {

  String companyName;
  String coOrdinateName;
  String email;
  String mobile;
  String gstNo;
  String catId;
  String subCatId;
  String location;
  String currentAddress;
  String pincode;
  String city;
  String state;
  String country;
  String companyProfilePic;
  String userProfilePic;
  // String companyName;
  String serviceUserId;
  String companyCertificateImg;
  String gstCertificateImg;
  String panCardImg;
  String shopActLicenseImg;
  String addharCardImg;
  List<MachineList> machineList;

  UpdateJobWorkProfile({
    required this.companyName,
    required this.coOrdinateName,
    required this.email,
    required this.mobile,
    required this.gstNo,
    required this.catId,
    required this.subCatId,
    required this.location,
    required this.currentAddress,
    required this.pincode,
    required this.city,
    required this.state,
    required this.country,
    required this.companyProfilePic,
    required this.userProfilePic,
    // required this.companyName,
    required this.serviceUserId,
    required this.companyCertificateImg,
    required this.gstCertificateImg,
    required this.panCardImg,
    required this.shopActLicenseImg,
    required this.addharCardImg,
    required this.machineList,
  });

}

class GetJobWorkProfile extends ProfileEvent {
  String serviceUserId;
  String roleId;

  GetJobWorkProfile({ required this.serviceUserId, required this.roleId,});
}

class GetTransportProfile extends ProfileEvent {
  String serviceUserId;
  String roleId;

  GetTransportProfile({ required this.serviceUserId, required this.roleId,});
}

class GetMachineProfile extends ProfileEvent {
  String serviceUserId;
  String roleId;
  GetMachineProfile({ required this.serviceUserId, required this.roleId,});
}

class MachineTaskHandover extends ProfileEvent {
  String serviceUserId;
  String machineEnquiryId;
  String dailyTaskId;
  String description;
  String price;
  MachineTaskHandover({ required this.serviceUserId, required this.machineEnquiryId,required this.dailyTaskId,
    required this.description,required this.price});
}

class JobWorkTaskHandover extends ProfileEvent {
  String serviceUserId;
  String jobWorkEnquiryId;
  String description;
  JobWorkTaskHandover({ required this.serviceUserId, required this.jobWorkEnquiryId,
    required this.description});
}


class UpdateTransportProfile extends ProfileEvent {

  String userProfileImg;
  String ownerName;
  String email;
  String mobile;
  String gstNo;
  String driverProfileImg;
  String driverName;
  String driverNumber;
  String driverLicenseValidity;
  String driverLicenseNumber;
  String driverLicenseImage;
  String driverIdProofImage;
  String location;
  String currentLocation;
  String pinCode;
  String city;
  String state;
  String country;
  String totalYears;
  String totalMonths;
  String companyName;
  String serviceUserId;
  String bankName;
  String accountNumber;
  String ifscCode;
  String branchName;
  String upiId;
  String companyCertificateImg;
  String gstCertificateImg;
  String panCardImg;
  String shopActLicenseImg;
  String addharCardImg;
  List<VehicleInfFormWidget> vehicleInfoList;
  List<ExpCompanyFormWidget> experienceCompanyList;


  UpdateTransportProfile({
    required this.userProfileImg,
    required this.ownerName,
    required this.email,
    required this.mobile,
    required this.gstNo,
    required this.driverProfileImg,
    required this.driverName,
    required this.driverNumber,
    required this.driverLicenseValidity,
    required this.driverLicenseNumber,
    required this.driverLicenseImage,
    required this.driverIdProofImage,
    required this.location,
    required this.currentLocation,
    required this.pinCode,
    required this.city,
    required this.state,
    required this.country,
    required this.totalYears,
    required this.totalMonths,
    required this.companyName,
    required this.serviceUserId,
    required this.bankName,
    required this.accountNumber,
    required this.ifscCode,
    required this.branchName,
    required this.upiId,
    required this.companyCertificateImg,
    required this.gstCertificateImg,
    required this.panCardImg,
    required this.shopActLicenseImg,
    required this.addharCardImg,
    required this.vehicleInfoList,
    required this.experienceCompanyList,
  });

}