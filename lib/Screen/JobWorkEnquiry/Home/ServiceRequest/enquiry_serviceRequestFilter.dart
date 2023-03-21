import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:service_engineer/Bloc/home/home_bloc.dart';
import 'package:service_engineer/Bloc/home/home_event.dart';
import 'package:service_engineer/Bloc/home/home_state.dart';
import 'package:service_engineer/Config/font.dart';
import 'package:service_engineer/Constant/theme_colors.dart';
import 'package:service_engineer/Model/JobWorkEnquiry/service_request_model.dart';
import 'package:service_engineer/Screen/bottom_navbar.dart';
import 'package:service_engineer/Widget/app_button.dart';
import 'package:service_engineer/Widget/custom_snackbar.dart';
import 'package:service_engineer/Widget/function_button.dart';



class EnquiryServiceRequestFilterScreen extends StatefulWidget {
  const EnquiryServiceRequestFilterScreen({Key? key}) : super(key: key);

  @override
  _EnquiryServiceRequestFilterScreenState createState() => _EnquiryServiceRequestFilterScreenState();
}

class _EnquiryServiceRequestFilterScreenState extends State<EnquiryServiceRequestFilterScreen> {

  final _formKey = GlobalKey<FormState>();
  String radioBtnType = "Heavy";
  int machineCategoryId = 1;

  bool loading = true;
  HomeBloc? _homeBloc;
  List<JobWorkEnquiryServiceRequestModel>? serviceList = [];

  @override
  void initState() {
    // TODO: implement initState
    //saveDeviceTokenAndId();
    super.initState();
    _homeBloc = BlocProvider.of<HomeBloc>(context);
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
              Navigator.of(context).pop();
            },
              child: Icon(Icons.arrow_back_ios)),
          title: Text('Service Request Filter',style:appBarheadingStyle ,),
        ),
        bottomNavigationBar:Padding(
          padding: const EdgeInsets.all(10.0),
          child: BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
            return BlocListener<HomeBloc, HomeState>(
              listener: (context, state) {
                if(state is ServiceRequestJWELoading){
                  loading = state.isLoading;
                }
                if(state is ServiceRequestJWESuccess){
                  serviceList = state.serviceListData;
                  Navigator.pop(context,{"serviceList": serviceList});
                }
                if(state is ServiceRequestJWEFail){
                  showCustomSnackBar(context,state.msg.toString());
                }
              },
              child:  AppButton(
                onPressed: () async {
                  _homeBloc!.add(OnServiceRequestJWEList(offSet:'0',timePeriod: machineCategoryId.toString()));
                },
                shape: const RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.all(Radius.circular(50))),
                text: 'Apply',
                loading: loading,
                color: ThemeColors.defaultbuttonColor,
              ),

              // Center(
              //   child: CircularProgressIndicator(),
              // )

            );


          })
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
                                    child: Text('Time Period',style:filterHeadingRadiobtnStyle,)),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(children: [
                                  Radio(
                                    value: 1,
                                    groupValue: machineCategoryId,
                                    onChanged: (val) {
                                      setState(() {
                                        radioBtnType = 'for week';
                                        machineCategoryId = 1;
                                      });
                                    },
                                  ),
                                  Text(
                                    'for week',
                                    style:filterRadiobtnStyle,
                                  ),
                                ],),
                                Row(
                                  children: [
                                    Radio(
                                      value: 2,
                                      groupValue: machineCategoryId,
                                      onChanged: (val) {
                                        setState(() {
                                          radioBtnType =
                                          'for 30 days';
                                          machineCategoryId = 2;
                                        });
                                      },
                                    ),
                                    Text(
                                      'for 30 days',
                                      style: filterRadiobtnStyle,
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Radio(
                                      value: 3,
                                      groupValue: machineCategoryId,
                                      onChanged: (val) {
                                        setState(() {
                                          radioBtnType = 'for 6 month';
                                          machineCategoryId = 3;
                                        });
                                      },
                                    ),
                                    Text(
                                      'for 6 month',
                                      style:filterRadiobtnStyle,
                                    ),

                                  ],
                                ),
                                Row(
                                  children: [
                                    Radio(
                                      value: 4,
                                      groupValue: machineCategoryId,
                                      onChanged: (val) {
                                        setState(() {
                                          radioBtnType = 'for last year';
                                          machineCategoryId = 4;
                                        });
                                      },
                                    ),
                                    Text(
                                      'for last year',
                                      style:filterRadiobtnStyle,
                                    ),

                                  ],
                                ),
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
