import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:service_engineer/Bloc/authentication/authentication_event.dart';
import 'package:service_engineer/Utils/application.dart';
import 'package:service_engineer/app_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Config/font.dart';
import '../../Widget/app_button.dart';
import '../../Widget/common.dart';
import 'MyTask/myTaskTab.dart';
import 'ServiceRequest/serviceRequest.dart';


class MachineMaintenanceHomeScreen extends StatefulWidget {
  const MachineMaintenanceHomeScreen({Key? key}) : super(key: key);

  @override
  _MachineMaintenanceHomeScreenState createState() => _MachineMaintenanceHomeScreenState();
}

class _MachineMaintenanceHomeScreenState extends State<MachineMaintenanceHomeScreen> {
  bool loading = true;
  bool isSwitched = false;

  final _formKey = GlobalKey<FormState>();



  @override
  void initState() {
    // TODO: implement initState
    //saveDeviceTokenAndId();
    super.initState();
    isSwitchOn();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  isSwitchOn(){
    if(Application.isOnline!=null){
      isSwitched = Application.isOnline!;
      setState(() {
      });
    }
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
      onChanged: (value)=> setState(()
      {
      isSwitched = value;
      AppBloc.authBloc.add(OnSaveOnlineOffline(value));
      }
      ),
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
          ServiceRequestScreen(isSwitched: isSwitched),
          MyTaskScreen(isSwitched: isSwitched)
        ],
      ) ,
    )
      );
  }
}
