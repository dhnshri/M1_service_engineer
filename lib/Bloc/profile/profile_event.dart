
import '../../Model/education_model.dart';
import '../../Model/experience_company_model.dart';
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

  UpdateProfile({
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