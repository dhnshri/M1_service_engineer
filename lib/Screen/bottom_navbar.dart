import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Constant/theme_colors.dart';
import 'Home/home.dart';
import 'Order/orderlist.dart';
import 'Profile/profile.dart';
import 'Quotations/quotationslist.dart';



class BottomNavigation extends StatefulWidget {
  int index;
   BottomNavigation({Key? key, required this.index}) : super(key: key);

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
    ProfileScreen(),
    // CartPage(backIcon: false),
    // MyOrders(),
    // MyProfile(),
  ];

  void _onItemTapped(int index) {

      setState(() {
        _selectedIndex = index;
      });

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
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
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
            items: <BottomNavigationBarItem>[
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
                // Stack(
                //   children: [
                //     Icon(
                //       Icons.shopping_cart_rounded,
                //     ),
                //     // Application.cart!.cartQuantity != null ?
                //     Application.cart == null ? Container() :
                //     Positioned(
                //       top: -3,
                //       right: 2,
                //       child: Center(
                //           child: Text(Application.cart!.cartQuantity.toString(),
                //             style: TextStyle(
                //                 fontSize: 15,
                //                 fontWeight: FontWeight.bold,
                //                 color: ThemeColors.whiteTextColor
                //             ),
                //           )),
                //     )
                //     // : Container(),
                //   ],
                // ),
                label: 'Quotations',
              ),

              BottomNavigationBarItem(
                backgroundColor: ThemeColors.bottomNavColor,
                icon: Icon(Icons.person),
                label: 'My Profile',
              ),

            ],
            currentIndex: _selectedIndex,
            selectedItemColor: ThemeColors.redTextColor,
            selectedLabelStyle: TextStyle(
              fontFamily: 'SF-Pro-Display-Regular',
                  fontSize: 10
            ),
            showUnselectedLabels: true,
            unselectedItemColor: ThemeColors.scaffoldBgColor,

            // backgroundColor: Colors.red,
            onTap: _onItemTapped,
            elevation: 20,
        ),
      ),
          ),
    );
  }
}
