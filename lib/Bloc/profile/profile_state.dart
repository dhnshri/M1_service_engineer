import 'package:flutter/cupertino.dart';
import 'package:service_engineer/Model/profile_repo.dart';

@immutable
abstract class ProfileState {}

class InitialProfileState extends ProfileState {}

class UpdateProfileLoading extends ProfileState {
  bool isLoading;
  UpdateProfileLoading({required this.isLoading});
}

class UpdateProfileFail extends ProfileState {
  final String? msg;
  UpdateProfileFail({this.msg});
}

class UpdateProfileSuccess extends ProfileState {
  String message;
  UpdateProfileSuccess({ required this.message});
}

class UpdateJobWorkProfileLoading extends ProfileState {
  bool isLoading;
  UpdateJobWorkProfileLoading({required this.isLoading});
}

class UpdateJobWorkProfileFail extends ProfileState {
  final String? msg;
  UpdateJobWorkProfileFail({this.msg});
}

class UpdateJobWorkProfileSuccess extends ProfileState {
  String message;
  UpdateJobWorkProfileSuccess({ required this.message});
}

class UpdateTransportProfileLoading extends ProfileState {
  bool isLoading;
  UpdateTransportProfileLoading({required this.isLoading});
}

class UpdateTransportProfileFail extends ProfileState {
  final String? msg;
  UpdateTransportProfileFail({this.msg});
}

class UpdateTransportProfileSuccess extends ProfileState {
  String message;
  UpdateTransportProfileSuccess({ required this.message});
}

class GetJobWorkProfileLoading extends ProfileState {
  bool isLoading;
  GetJobWorkProfileLoading({required this.isLoading});
}

class GetJobWorkProfileFail extends ProfileState {
  final String? msg;
  GetJobWorkProfileFail({this.msg});
}

class GetJobWorkProfileSuccess extends ProfileState {
  List<ServiceUserData> serviceUserdataList;
  List<ProfileKYCDetails> profileKycList;
  List<JobWorkMachineList> profileMachineList;
  GetJobWorkProfileSuccess({required this.serviceUserdataList,required this.profileKycList,
    required this.profileMachineList,});
}

class GetMachineProfileLoading extends ProfileState {
  bool isLoading;
  GetMachineProfileLoading({required this.isLoading});
}

class GetMachineProfileFail extends ProfileState {
  final String? msg;
  GetMachineProfileFail({this.msg});
}

class GetMachineProfileSuccess extends ProfileState {
  List<ServiceUserData> serviceUserdataList;
  List<ProfileKYCDetails> profileKycList;
  List<MachineMaintenanceExperiences> profileMachineExperienceList;
  List<MachineMaintenanceEducations> profileMachineEducationList;
  GetMachineProfileSuccess({required this.serviceUserdataList,required this.profileKycList,
    required this.profileMachineEducationList, required this.profileMachineExperienceList});
}

class MachineTaskHandoverLoading extends ProfileState {
  bool isLoading;
  MachineTaskHandoverLoading({required this.isLoading});
}

class MachineTaskHandoverFail extends ProfileState {
  final String? msg;
  MachineTaskHandoverFail({this.msg});
}

class MachineTaskHandoverSuccess extends ProfileState {
  String msg;
  MachineTaskHandoverSuccess({required this.msg});
}

class JobWorkTaskHandoverLoading extends ProfileState {
  bool isLoading;
  JobWorkTaskHandoverLoading({required this.isLoading});
}

class JobWorkTaskHandoverFail extends ProfileState {
  final String? msg;
  JobWorkTaskHandoverFail({this.msg});
}

class JobWorkTaskHandoverSuccess extends ProfileState {
  String msg;
  JobWorkTaskHandoverSuccess({required this.msg});
}

class GetTransportProfileLoading extends ProfileState {
  bool isLoading;
  GetTransportProfileLoading({required this.isLoading});
}

class GetTransportProfileFail extends ProfileState {
  final String? msg;
  GetTransportProfileFail({this.msg});
}

class GetTransportProfileSuccess extends ProfileState {
  List<ServiceUserData> serviceUserdataList;
  List<ProfileKYCDetails> profileKycList;
  List<DriverProfileDetails> profileDriverDetailsList;
  List<ProfileVehicleInformation> profileVehicleInfoList;
  List<TransportProfileExperience> profileExperienceList;
  GetTransportProfileSuccess({required this.serviceUserdataList,required this.profileKycList,
    required this.profileDriverDetailsList,required this.profileVehicleInfoList,required this.profileExperienceList});
}