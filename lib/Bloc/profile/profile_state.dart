import 'package:flutter/cupertino.dart';

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