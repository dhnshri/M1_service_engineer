import 'dart:io';
import 'package:flutter/material.dart';
import 'package:service_engineer/Bloc/authentication/authentication_event.dart';
import 'package:service_engineer/Utils/application.dart';
import 'package:service_engineer/app_bloc.dart';
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
    isSwitchOn();

  }

  isSwitchOn(){
    if(Application.isOnline!=null){
      isSwitched = Application.isOnline!;
      setState(() {
      });
    }
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
      onChanged: (value)=> setState(() {
        isSwitched = value;
        AppBloc.authBloc.add(OnSaveOnlineOffline(value));
      })
    ),
  );

  Future<bool> _onPop() async {
    return (await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: new Text('Are you sure?'),
        content: new Text('Exit the App'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            //<-- SEE HERE
            child: new Text('No'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            // <-- SEE HERE
            child: new Text('Yes'),
          ),
        ],
      ),
    )) ??
        false;
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onPop,
      child: DefaultTabController(
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
            EnquiryServiceRequestScreen(isSwitched: isSwitched),
            EnquiryMyTaskScreen(isSwitched: isSwitched)
          ],
        ) ,
      )
        ),
    );
  }
}
