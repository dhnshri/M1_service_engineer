import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:service_engineer/app.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

import '../../../Config/font.dart';
import '../../../Widget/app_button.dart';
import '../../../Widget/function_button.dart';
import '../../bottom_navbar.dart';



class MyTaskTransportationFilterScreen extends StatefulWidget {
  const MyTaskTransportationFilterScreen({Key? key}) : super(key: key);

  @override
  _MyTaskTransportationFilterScreenState createState() => _MyTaskTransportationFilterScreenState();
}

class _MyTaskTransportationFilterScreenState extends State<MyTaskTransportationFilterScreen> {

  final _formKey = GlobalKey<FormState>();


  String pickuptimingBtnType = "8-9 AM";
  int pickuptimingId = 1;

  String pickandDropDistanceBtnType = "5-10 KM";
  int pickandDropDistanceId = 1;

  String  loadWeightBtnType = "10 - 20 tonne";
  int loadWeightId = 1;


  bool loading = true;


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
                    MaterialPageRoute(builder: (context) => BottomNavigation (index:0,dropValue: 'Transportation',)));
              },
              child: Icon(Icons.arrow_back_ios)),
          title: Text('Filter for Service Requests',style:appBarheadingStyle ,),
        ),
        bottomNavigationBar:Padding(
          padding: const EdgeInsets.all(10.0),
          child: FunctionButton(
            onPressed: () async {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => BottomNavigation (index:0,dropValue: 'Transportation',)));
            },
            shape: const RoundedRectangleBorder(
                borderRadius:
                BorderRadius.all(Radius.circular(50))),
            text: 'Apply',
            loading: loading,


          ),
        ),
        body: ListView(
          children: [

            Padding(
              padding: const EdgeInsets.only(top:8.0),
              child: Container(
                child: Column(
                  children: [
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.only(top:5.0,bottom: 5.0),
                        child: Container(
                          //decoration: BoxDecoration(
                          // border: Border.all(color: Colors.black12),
                          // borderRadius: BorderRadius.circular(12),
                          // ),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Column(
                              children: [
                                Align(
                                    alignment: Alignment.topLeft,
                                    child: Text('Pickup timing',style:filterHeadingRadiobtnStyle,)),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(children: [
                                  Radio(
                                    value: 1,
                                    groupValue: pickuptimingId,
                                    onChanged: (val) {
                                      setState(() {
                                        pickuptimingBtnType = '8-9 AM';
                                        pickuptimingId = 1;
                                      });
                                    },
                                  ),
                                  Text(
                                    'Machine',
                                    style:filterRadiobtnStyle,
                                  ),
                                ],),
                                Row(children: [
                                  Radio(
                                    value: 2,
                                    groupValue: pickuptimingId,
                                    onChanged: (val) {
                                      setState(() {
                                        pickuptimingBtnType = '9-10 AM';
                                        pickuptimingId = 2;
                                      });
                                    },
                                  ),
                                  Text(
                                    'Machine',
                                    style:filterRadiobtnStyle,
                                  ),
                                ],),
                                Row(children: [
                                  Radio(
                                    value: 3,
                                    groupValue: pickuptimingId,
                                    onChanged: (val) {
                                      setState(() {
                                        pickuptimingBtnType = '10-11 AM';
                                        pickuptimingId = 3;
                                      });
                                    },
                                  ),
                                  Text(
                                    'Machine',
                                    style:filterRadiobtnStyle,
                                  ),
                                ],),
                                Row(children: [
                                  Radio(
                                    value: 4,
                                    groupValue: pickuptimingId,
                                    onChanged: (val) {
                                      setState(() {
                                        pickuptimingBtnType = '11-12 PM';
                                        pickuptimingId = 4;
                                      });
                                    },
                                  ),
                                  Text(
                                    'Machine',
                                    style:filterRadiobtnStyle,
                                  ),
                                ],),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.only(top:5.0,bottom: 5.0),
                        child: Container(
                          //decoration: BoxDecoration(
                          // border: Border.all(color: Colors.black12),
                          // borderRadius: BorderRadius.circular(12),
                          // ),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Column(
                              children: [
                                Align(
                                    alignment: Alignment.topLeft,
                                    child: Text('Pick and Drop Distance',style:filterHeadingRadiobtnStyle,)),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(children: [
                                  Radio(
                                    value: 1,
                                    groupValue: pickandDropDistanceId,
                                    onChanged: (val) {
                                      setState(() {
                                        pickandDropDistanceBtnType = '5-10 KM';
                                        pickandDropDistanceId = 1;
                                      });
                                    },
                                  ),
                                  Text(
                                    'Machine',
                                    style:filterRadiobtnStyle,
                                  ),
                                ],),
                                Row(children: [
                                  Radio(
                                    value: 2,
                                    groupValue: pickandDropDistanceId,
                                    onChanged: (val) {
                                      setState(() {
                                        pickandDropDistanceBtnType = '10-20 KM';
                                        pickandDropDistanceId = 2;
                                      });
                                    },
                                  ),
                                  Text(
                                    'Machine',
                                    style:filterRadiobtnStyle,
                                  ),
                                ],),
                                Row(children: [
                                  Radio(
                                    value: 3,
                                    groupValue: pickandDropDistanceId,
                                    onChanged: (val) {
                                      setState(() {
                                        pickandDropDistanceBtnType = '20-30 KM';
                                        pickandDropDistanceId = 3;
                                      });
                                    },
                                  ),
                                  Text(
                                    'Machine',
                                    style:filterRadiobtnStyle,
                                  ),
                                ],),
                                Row(children: [
                                  Radio(
                                    value: 4,
                                    groupValue: pickandDropDistanceId,
                                    onChanged: (val) {
                                      setState(() {
                                        pickandDropDistanceBtnType = '30-40 KM';
                                        pickandDropDistanceId = 4;
                                      });
                                    },
                                  ),
                                  Text(
                                    'Machine',
                                    style:filterRadiobtnStyle,
                                  ),
                                ],),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.only(top:5.0,bottom: 5.0),
                        child: Container(
                          //decoration: BoxDecoration(
                          // border: Border.all(color: Colors.black12),
                          // borderRadius: BorderRadius.circular(12),
                          // ),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Column(
                              children: [
                                Align(
                                    alignment: Alignment.topLeft,
                                    child: Text('Load Weight',style:filterHeadingRadiobtnStyle,)),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(children: [
                                  Radio(
                                    value: 1,
                                    groupValue: loadWeightId,
                                    onChanged: (val) {
                                      setState(() {
                                        loadWeightBtnType = '10 - 20 tonne';
                                        loadWeightId = 1;
                                      });
                                    },
                                  ),
                                  Text(
                                    '10 - 20 tonne',
                                    style:filterRadiobtnStyle,
                                  ),
                                ],),
                                Row(children: [
                                  Radio(
                                    value: 2,
                                    groupValue: loadWeightId,
                                    onChanged: (val) {
                                      setState(() {
                                        loadWeightBtnType = '20 - 30 tonne';
                                        loadWeightId = 2;
                                      });
                                    },
                                  ),
                                  Text(
                                    '20 - 30 tonne',
                                    style:filterRadiobtnStyle,
                                  ),
                                ],),
                                Row(children: [
                                  Radio(
                                    value: 3,
                                    groupValue: loadWeightId,
                                    onChanged: (val) {
                                      setState(() {
                                        loadWeightBtnType = '30- 40 tonne';
                                        loadWeightId = 3;
                                      });
                                    },
                                  ),
                                  Text(
                                    '30- 40 tonne',
                                    style:filterRadiobtnStyle,
                                  ),
                                ],),
                                Row(children: [
                                  Radio(
                                    value: 4,
                                    groupValue: loadWeightId,
                                    onChanged: (val) {
                                      setState(() {
                                        loadWeightBtnType = '40 - 50 tonne';
                                        loadWeightId = 4;
                                      });
                                    },
                                  ),
                                  Text(
                                    '40 - 50 tonne',
                                    style:filterRadiobtnStyle,
                                  ),
                                ],),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),

                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
