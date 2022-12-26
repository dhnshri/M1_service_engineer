import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:service_engineer/Screen/Home/ServiceRequest/serviceRequest.dart';
import 'package:service_engineer/Screen/Home/home.dart';
import 'package:service_engineer/app.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

import '../../../Config/font.dart';
import '../../bottom_navbar.dart';



class ServiceRequestFilterScreen extends StatefulWidget {
  const ServiceRequestFilterScreen({Key? key}) : super(key: key);

  @override
  _ServiceRequestFilterScreenState createState() => _ServiceRequestFilterScreenState();
}

class _ServiceRequestFilterScreenState extends State<ServiceRequestFilterScreen> {

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



  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: InkWell(
            onTap: (){
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => BottomNavigation (index:0)));
            },
              child: Icon(Icons.arrow_back_ios)),
          title: Text('Service Request Filter',style:appBarheadingStyle ,),
        ),
        body: ListView(
          children: [

          ],
        ),
      ),
    );
  }
}
