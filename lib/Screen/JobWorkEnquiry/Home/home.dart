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
          EnquiryServiceRequestScreen(),
          EnquiryMyTaskScreen()
        ],
      ) ,
    )
      );
  }
}
