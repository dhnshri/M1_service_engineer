import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Config/font.dart';
import '../../Widget/app_button.dart';
import '../../Widget/common.dart';
import 'MyTask/myTaskTab.dart';
import 'ServiceRequest/serviceRequest.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool loading = true;
  bool isSwitched = false;

  final _formKey = GlobalKey<FormState>();



  @override
  void initState() {
    // TODO: implement initState
    //saveDeviceTokenAndId();
    super.initState();

  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

  }

  Widget androidSwitch() => Transform.scale(
    scale: 1.2,
    child: Switch(
      activeColor: Colors.deepOrangeAccent,
      activeTrackColor: Color(0xffFFBBBC),
      inactiveThumbColor: Colors.red,
      inactiveTrackColor: Color(0xffFFBBBC),
      splashRadius: 50.0,
      value: isSwitched,
      onChanged: (value)=> setState(() =>
      isSwitched = value),
    ),
  );


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          // leading: Row(
          //   children: [
          //     Icon(Icons.circle,color: Colors.red,),
          //     SizedBox(width: 5,),
          //     Text("Online"),
          //   ],
          // ),
          leading: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(child: Padding(
                padding: const EdgeInsets.only(left:30.0),
                child: androidSwitch(),
              )),
              // SizedBox(width:17.0,),
              // Expanded(
              //   child: Padding(
              //     padding: const EdgeInsets.only(left:0.0),
              //     child: Text('$isSwitched', style: TextStyle(color: Colors.red,
              //         fontSize: 14.0),),
              //   ),
              // )

              //  Center(child: Text("Offline",style: TextStyle(fontSize: 14,color: Colors.red,fontWeight: FontWeight.bold),)),
            ],
          ),
          title: Text("Online",style: onlineOfflineStyle,),
          actions: [
            notification(context),
            SizedBox(width: 10,)
          ],
          bottom:   TabBar(
            labelColor: Colors.red,
            unselectedLabelColor: Colors.black,
            indicatorColor: Colors.red,
            tabs: [
              Tab(
                text: "Service Requests",
              ),
              Tab(
                text: "My Tasks",
              ),
            ],
          ),
        ),
        body: TabBarView(
        children: [
          ServiceRequestScreen(),
          MyTaskScreen()
        ],
      ) ,
    )
      );
  }
}
