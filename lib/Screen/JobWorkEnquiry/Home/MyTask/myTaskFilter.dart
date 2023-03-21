import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:service_engineer/Bloc/home/home_bloc.dart';
import 'package:service_engineer/Bloc/home/home_event.dart';
import 'package:service_engineer/Bloc/home/home_state.dart';
import 'package:service_engineer/Config/font.dart';
import 'package:service_engineer/Constant/theme_colors.dart';
import 'package:service_engineer/Model/JobWorkEnquiry/my_task_model.dart';
import 'package:service_engineer/Model/MachineMaintance/myTaskModel.dart';
import 'package:service_engineer/Utils/application.dart';
import 'package:service_engineer/Widget/app_button.dart';
import 'package:service_engineer/Widget/custom_snackbar.dart';



class JobWorkMyTaskFilterScreen extends StatefulWidget {
  const JobWorkMyTaskFilterScreen({Key? key}) : super(key: key);

  @override
  _JobWorkMyTaskFilterScreenState createState() => _JobWorkMyTaskFilterScreenState();
}

class _JobWorkMyTaskFilterScreenState extends State<JobWorkMyTaskFilterScreen> {

  final _formKey = GlobalKey<FormState>();
  String radioBtnType = "for week";
  int timePeriodId = 1;

  bool loading = true;
  HomeBloc? _homeBloc;
  List<JobWorkEnquiryMyTaskModel> myTaskList=[];


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
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => BottomNavigation (index:0,dropValue:"Machine Maintenance")));
              },
              child: Icon(Icons.arrow_back_ios)),
          title: Text('My Task Filter',style:appBarheadingStyle ,),
        ),
        bottomNavigationBar:Padding(
            padding: const EdgeInsets.all(10.0),
            child: BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
              return BlocListener<HomeBloc, HomeState>(
                listener: (context, state) {
                  if(state is MyTaskJWELoading){
                    loading = state.isLoading;
                  }
                  if(state is MyTaskJWEListSuccess){
                    myTaskList = state.MyTaskJWEList;
                    Navigator.pop(context,{"taskList": myTaskList});
                  }
                  if(state is MyTaskJWEListLoadFail){
                    showCustomSnackBar(context,state.msg.toString());
                  }
                },
                child:  AppButton(
                  onPressed: () async {
                    _homeBloc!.add(OnMyTaskJWEList(userid: Application.customerLogin!.id.toString(), offset: '0',timeId: timePeriodId.toString()));
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
                                    groupValue: timePeriodId,
                                    onChanged: (val) {
                                      setState(() {
                                        radioBtnType = 'for week';
                                        timePeriodId = 1;
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
                                      groupValue: timePeriodId,
                                      onChanged: (val) {
                                        setState(() {
                                          radioBtnType =
                                          'for 30 days';
                                          timePeriodId = 2;
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
                                      groupValue: timePeriodId,
                                      onChanged: (val) {
                                        setState(() {
                                          radioBtnType = 'for 6 month';
                                          timePeriodId = 3;
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
                                      groupValue: timePeriodId,
                                      onChanged: (val) {
                                        setState(() {
                                          radioBtnType = 'for last year';
                                          timePeriodId = 4;
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
