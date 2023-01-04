import 'dart:io';
import 'package:flutter/material.dart';
import '../../../Config/font.dart';
import '../../../Widget/common.dart';
import 'MyTask/myTaskTab.dart';
import 'ServiceRequest/enquiry_serviceRequest.dart';


class EnquiryHomeScreen extends StatefulWidget {
  const EnquiryHomeScreen({Key? key}) : super(key: key);

  @override
  _EnquiryHomeScreenState createState() => _EnquiryHomeScreenState();
}

class _EnquiryHomeScreenState extends State<EnquiryHomeScreen> {
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
      activeColor: Colors.red,
      activeTrackColor: Color(0xffFFBBBC),
      inactiveThumbColor: Colors.grey,
      inactiveTrackColor: Color(0xffe1d6d6),
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
          leading: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(child: Padding(
                padding: const EdgeInsets.only(left:30.0),
                child: androidSwitch(),
              )),
            ],
          ),
          title: Text(isSwitched? "Online" : "Offline",style: onlineOfflineStyle,),
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
          EnquiryServiceRequestScreen(),
          EnquiryMyTaskScreen()
        ],
      ) ,
    )
      );
  }
}
