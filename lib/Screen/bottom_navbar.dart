import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:service_engineer/Screen/Transportation/Profile/transportation_profile.dart';

import '../Constant/theme_colors.dart';
import 'Home/home.dart';
import 'JobWorkEnquiry/Profile/job_work_enquiry_profile.dart';
import 'Order/orderlist.dart';
import 'Profile/profile.dart';
import 'Quotations/quotationslist.dart';



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
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);



  static List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    OrderScreen(),
    QuotationsScreen(),
    MachineProfileScreen(),
    // CartPage(backIcon: false),
    // MyOrders(),
    // MyProfile(),
  ];

  static List<Widget> _jobWorkEnquiryOptions = <Widget>[
    HomeScreen(),
    QuotationsScreen(),
    MachineProfileScreen(),
  ];

   bottomOptions(BuildContext context){
    if(widget.dropValue == "Machine Maintenance"){
      List<Widget> _widgetOptions = <Widget>[
        HomeScreen(),
        OrderScreen(),
        QuotationsScreen(),
        MachineProfileScreen(),
        // CartPage(backIcon: false),
        // MyOrders(),
        // MyProfile(),
      ];
    }
    else if(widget.dropValue=="Job Work Enquiry"){
      List<Widget> _widgetOptions = <Widget>[
        HomeScreen(),
        QuotationsScreen(),
        MachineProfileScreen(),
      ];
    }
    else if(widget.dropValue=="Transportation"){
      List<Widget> _widgetOptions = <Widget>[
        HomeScreen(),
        QuotationsScreen(),
        MachineProfileScreen(),
      ];
    }

  }

  void _onItemTapped(int index) {

      setState(() {
        _selectedIndex = index;
      });

  }
  List<BottomNavigationBarItem> _bottomBarItem(BuildContext context) {
    if(widget.dropValue == "Machine Maintenance"){
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
          widget.dropValue == "Machine Maintenance"? HomeScreen():widget.dropValue == "Job Work Enquiry"?MachineProfileScreen(): widget.dropValue == "Transportation"? HomeScreen():SizedBox(),
          // widget.dropValue == "Machine Maintenance"?OrderScreen():SizedBox(),
          if(widget.dropValue == "Machine Maintenance")
            OrderScreen(),
          widget.dropValue == "Machine Maintenance"? QuotationsScreen():widget.dropValue == "Job Work Enquiry"?QuotationsScreen(): widget.dropValue == "Transportation"? QuotationsScreen():SizedBox(),
          widget.dropValue == "Machine Maintenance"? MachineProfileScreen():widget.dropValue == "Job Work Enquiry"?JobWorkProfileScreen(): widget.dropValue == "Transportation"? TransportationProfileScreen():SizedBox(),
        ],
      ),
      // Center(
      //   child:
      //   _widgetOptions.elementAt(_selectedIndex),
      // ),
      bottomNavigationBar:
          // MyBottomNavigation(_onItemTapped, _selectedIndex)
          SizedBox(
            height: 70,
            child: ClipRRect(
        borderRadius: const BorderRadius.only(
            topRight: Radius.circular(15),
            topLeft: Radius.circular(15),
        ),
        child: BottomNavigationBar(
            items: _bottomBarItem(context),
            // <BottomNavigationBarItem>[
            //   BottomNavigationBarItem(
            //     backgroundColor: ThemeColors.bottomNavColor,
            //     icon: Icon(Icons.home),
            //     label: 'Home',
            //   ),
            //   BottomNavigationBarItem(
            //     backgroundColor: ThemeColors.bottomNavColor,
            //     icon: Icon(Icons.folder),
            //     label: 'Order',
            //   ),
            //
            //   BottomNavigationBarItem(
            //     backgroundColor: ThemeColors.bottomNavColor,
            //     icon:  Icon(CupertinoIcons.calendar),
            //     label: 'Quotations',
            //   ),
            //
            //   BottomNavigationBarItem(
            //     backgroundColor: ThemeColors.bottomNavColor,
            //     icon: Icon(Icons.person),
            //     label: 'My Profile',
            //   ),
            //
            // ],
            currentIndex: _selectedIndex,
            selectedItemColor: ThemeColors.redTextColor,
            selectedLabelStyle: TextStyle(
              fontFamily: 'SF-Pro-Display-Regular',
                  fontSize: 10
            ),
            showUnselectedLabels: true,
            unselectedItemColor: ThemeColors.blackColor,

            // backgroundColor: Colors.red,
            onTap: _onItemTapped,
            elevation: 20,
        ),
      ),
          ),
    );
  }
}
