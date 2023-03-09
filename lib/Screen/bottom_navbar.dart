import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:service_engineer/Screen/JobWorkEnquiry/Home/home.dart';
import 'package:service_engineer/Screen/JobWorkEnquiry/Quotations/enquiry_quotations_reply.dart';
import 'package:service_engineer/Screen/MachineMaintenance/Order/order_items.dart';
import 'package:service_engineer/Screen/Transportation/Profile/transportation_profile.dart';

import '../Constant/theme_colors.dart';
import 'Dashboard/dashboard_screen.dart';
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
          icon:  Icon(Icons.dashboard),
          label: 'Dashboard',
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
          icon:  Icon(CupertinoIcons.calendar),
          label: 'Quotations',
        ),

        BottomNavigationBarItem(
          backgroundColor: ThemeColors.bottomNavColor,
          icon:  Icon(Icons.dashboard),
          label: 'Dashboard',
        ),

        BottomNavigationBarItem(
          backgroundColor: ThemeColors.bottomNavColor,
          icon: Icon(Icons.person),
          label: 'My Profile',
        ),
      ];
    }

  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.index!=null){
      setState(() {
        _selectedIndex = widget.index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('BottomNavigationBar Sample'),
      // ),
      // drawer: DrawerWidget(context),
      body: IndexedStack(
        index: _selectedIndex,
        children:
        <Widget>[
          // bottomOptions(context)
          widget.dropValue == "1"? MachineMaintenanceHomeScreen():widget.dropValue == "2"?EnquiryHomeScreen(): widget.dropValue == "3"? TransportationQuotationsHomeScreen():SizedBox(),
          // widget.dropValue == "Machine Maintenance"?OrderScreen():SizedBox(),
          if(widget.dropValue == "1")
            OrderItemsScreen(),
          widget.dropValue == "1"? QuotationsReplyScreen():widget.dropValue == "2"?EnquiryQuotationsReplyScreen(): widget.dropValue == "3"? QuotationsReplyTransportationScreen():SizedBox(),
          DashboardScreen(),
          widget.dropValue == "1"? MachineProfileScreen():widget.dropValue == "2"?JobWorkProfileScreen(): widget.dropValue == "3"? TransportationProfileScreen():SizedBox(),
        ],
      ),
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
