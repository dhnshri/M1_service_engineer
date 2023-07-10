import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:service_engineer/Bloc/profile/profile_bloc.dart';
import 'package:service_engineer/Bloc/profile/profile_event.dart';
import 'package:service_engineer/Bloc/profile/profile_state.dart';
import 'package:service_engineer/Model/profile_repo.dart';
import 'package:service_engineer/Model/service_request_repo.dart';
import 'package:service_engineer/Screen/JobWorkEnquiry/Dashboard/dashboard_screen.dart';
import 'package:service_engineer/Screen/JobWorkEnquiry/Home/home.dart';
import 'package:service_engineer/Screen/JobWorkEnquiry/Quotations/enquiry_quotations_reply.dart';
import 'package:service_engineer/Screen/MachineMaintenance/Dashboard/dashboard_screen.dart';
import 'package:service_engineer/Screen/MachineMaintenance/Order/order_items.dart';
import 'package:service_engineer/Screen/Transportation/Dashboard/dashboard_screen.dart';
import 'package:service_engineer/Screen/Transportation/Profile/transportation_profile.dart';
import 'package:service_engineer/Utils/application.dart';

import '../Constant/theme_colors.dart';
import '../Widget/custom_snackbar.dart';
import 'JobWorkEnquiry/Profile/job_work_enquiry_profile.dart';
import 'MachineMaintenance/MakeQuotations/quotationslist.dart';
import 'MachineMaintenance/Profile/profile.dart';
import 'MachineMaintenance/Quotations/quotations_reply.dart';
import 'MachineMaintenance/home.dart';
import 'Transportation/QuotationTransportation/quotation_reply_transportation.dart';
import 'Transportation/transportation_home.dart';




class BottomNavigation extends StatefulWidget {
  int index;
  final String? dropValue;
   BottomNavigation({Key? key, required this.index,this.dropValue}) : super(key: key);

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _selectedIndex = 0;
  bool backIcon = false;
  static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  bool _isLoading = false;
  List<ServiceRequestModel>? serviceList = [];


  void _onItemTapped(int index) {

      setState(() {
        _selectedIndex = index;
      });

  }
  List<BottomNavigationBarItem> _bottomBarItem(BuildContext context) {
    if(widget.dropValue == "1"){
      return[
        BottomNavigationBarItem(
          backgroundColor: ThemeColors.bottomNavColor,
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          backgroundColor: ThemeColors.bottomNavColor,
          icon:  Icon(Icons.dashboard),
          label: 'Dashboard',
        ),
        BottomNavigationBarItem(
          backgroundColor: ThemeColors.bottomNavColor,
          icon: Icon(Icons.folder),
          label: 'Order',
        ),

        BottomNavigationBarItem(
          backgroundColor: ThemeColors.bottomNavColor,
          icon:  Icon(CupertinoIcons.calendar),
          label: 'Quotations',
        ),

        BottomNavigationBarItem(
          backgroundColor: ThemeColors.bottomNavColor,
          icon: Icon(Icons.person),
          label: 'My Profile',
        ),
      ];
    }else{
      return[
        BottomNavigationBarItem(
          backgroundColor: ThemeColors.bottomNavColor,
          icon: Icon(Icons.home),
          label: 'Home',
        ),

        BottomNavigationBarItem(
          backgroundColor: ThemeColors.bottomNavColor,
          icon:  Icon(Icons.dashboard),
          label: 'Dashboard',
        ),

        BottomNavigationBarItem(
          backgroundColor: ThemeColors.bottomNavColor,
          icon:  Icon(CupertinoIcons.calendar),
          label: 'Quotations',
        ),

        BottomNavigationBarItem(
          backgroundColor: ThemeColors.bottomNavColor,
          icon: Icon(Icons.person),
          label: 'My Profile',
        ),
      ];
    }
  }

  ProfileBloc? _profileBloc;
  List<ServiceUserData>? serviceUserdataList;
  List<ProfileKYCDetails>? profileKycList;
  List<JobWorkMachineList>? profileMachineList;
  List<DriverProfileDetails>? profileDriverDetailsList;
  List<ProfileVehicleInformation>? profileVehicleInfoList;
  List<TransportProfileExperience>? profileExperienceList;
  List<MachineMaintenanceExperiences>? profileMachineExperienceList;
  List<MachineMaintenanceEducations>? profileMachineEducationList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _profileBloc = BlocProvider.of<ProfileBloc>(this.context);
    getProfile();
    if(widget.index!=null){
      setState(() {
        _selectedIndex = widget.index;
      });
    }
  }

  getProfile(){
    if(widget.dropValue == '1'){
      _profileBloc!.add(GetMachineProfile(
          serviceUserId: Application.customerLogin!.id.toString(),
          roleId: Application.customerLogin!.role.toString()));
    }else
      if(widget.dropValue == "2") {
      _profileBloc!.add(GetJobWorkProfile(
          serviceUserId: Application.customerLogin!.id.toString(),
          roleId: Application.customerLogin!.role.toString()));
    }else if(widget.dropValue == "3"){
      _profileBloc!.add(GetTransportProfile(
          serviceUserId: Application.customerLogin!.id.toString(),
          roleId: Application.customerLogin!.role.toString()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
        return BlocListener<ProfileBloc, ProfileState>(
          listener: (context, state) {
            if(state is GetJobWorkProfileLoading){
              _isLoading = state.isLoading;
            }
            if(state is GetJobWorkProfileSuccess){
              serviceUserdataList = state.serviceUserdataList;
              profileKycList = state.profileKycList;
              profileMachineList = state.profileMachineList;
            }
            if(state is GetJobWorkProfileFail){
              showCustomSnackBar(context,state.msg.toString(),isError: true);
            }
            if(state is GetTransportProfileLoading){
              _isLoading = state.isLoading;
            }
            if(state is GetTransportProfileSuccess){
              serviceUserdataList = state.serviceUserdataList;
              profileKycList = state.profileKycList;
              profileDriverDetailsList = state.profileDriverDetailsList;
              profileVehicleInfoList = state.profileVehicleInfoList;
              profileExperienceList = state.profileExperienceList;
            }
            if(state is GetTransportProfileFail){
              showCustomSnackBar(context,state.msg.toString(),isError: true);
            }
            if(state is GetMachineProfileLoading){
              _isLoading = state.isLoading;
            }
            if(state is GetMachineProfileSuccess){
              serviceUserdataList = state.serviceUserdataList;
              profileKycList = state.profileKycList;
              profileMachineExperienceList = state.profileMachineExperienceList;
              profileMachineEducationList = state.profileMachineEducationList;
              // serviceUserdataList!.asMap().containsValue(2);
            }
            if(state is GetMachineProfileFail){
              showCustomSnackBar(context,state.msg.toString(),isError: true);
            }
          },
          child: _isLoading ?
          // serviceUserdataList!.length <= 0 ?
          // Center(child: CircularProgressIndicator(),):
          IndexedStack(
            index: _selectedIndex,
            children:
            <Widget>[
              // bottomOptions(context)
              widget.dropValue == "1"? MachineMaintenanceHomeScreen():widget.dropValue == "2"?EnquiryHomeScreen(): widget.dropValue == "3"? TransportationQuotationsHomeScreen():SizedBox(),
              widget.dropValue == "1"? MachineDashboardScreen():widget.dropValue == "2"?JobWorkDashboardScreen(): widget.dropValue == "3"? TransportDashboardScreen():SizedBox(),
              if(widget.dropValue == "1")
                OrderItemsScreen(),
              widget.dropValue == "1"? QuotationsReplyScreen():widget.dropValue == "2"?EnquiryQuotationsReplyScreen(): widget.dropValue == "3"? QuotationsReplyTransportationScreen():SizedBox(),
              widget.dropValue == "1"? MachineProfileScreen(serviceUserdataList: serviceUserdataList,profileKycList: profileKycList,
                  profileMachineExperienceList: profileMachineExperienceList,profileMachineEducationList: profileMachineEducationList,):widget.dropValue == "2"?JobWorkProfileScreen(
                      serviceUserdataList: serviceUserdataList,profileKycList: profileKycList,profileMachineList: profileMachineList,)
                  : widget.dropValue == "3"? TransportationProfileScreen(serviceUserdataList: serviceUserdataList,profileDriverDetailsList: profileDriverDetailsList,
                    profileExperienceList: profileExperienceList,profileKycList: profileKycList,profileVehicleInfoList: profileVehicleInfoList,):SizedBox(),
            ],
          )
              : Center(child: CircularProgressIndicator(),),

        );


      }),

      bottomNavigationBar:
          BottomNavigationBar(
            items: _bottomBarItem(context),
            currentIndex: _selectedIndex,
            selectedItemColor: ThemeColors.redTextColor,
            selectedLabelStyle: TextStyle(
              fontFamily: 'SF-Pro-Display-Regular',
                  fontSize: 10
            ),
            showUnselectedLabels: true,
            unselectedItemColor: ThemeColors.blackColor,
            type: BottomNavigationBarType.fixed,
            // backgroundColor: Colors.red,
            onTap: _onItemTapped,
            elevation: 20,
          ),
    );
  }
}
