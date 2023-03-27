import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:service_engineer/Bloc/home/home_bloc.dart';
import 'package:service_engineer/Bloc/home/home_event.dart';
import 'package:service_engineer/Bloc/home/home_state.dart';
import 'package:service_engineer/Model/track_process_repo.dart';
import 'package:service_engineer/Screen/MachineMaintenance/MyTask/service_provider_list.dart';
import 'package:service_engineer/Widget/custom_snackbar.dart';

import '../../../../Constant/theme_colors.dart';
import '../../../../Model/JobWorkEnquiry/my_task_model.dart';
import '../../../../Model/JobWorkEnquiry/track_process_report_model.dart';
import 'job_work_enquiry_service_provider_list.dart';
import 'my_task_detail.dart';




class ProcessDetailScreen extends StatefulWidget {
  TrackProcessJobWorkEnquiryModel trackProgressData;
  JobWorkEnquiryMyTaskModel myTaskJobWorkEnquiryData;
  ProcessDetailScreen({Key? key,required this.trackProgressData,required this.myTaskJobWorkEnquiryData}) : super(key: key);

  @override
  _ProcessDetailScreenState createState() => _ProcessDetailScreenState();
}

class _ProcessDetailScreenState extends State<ProcessDetailScreen> {
  HomeBloc? _homeBloc;


  @override
  void initState() {
    // TODO: implement initState
    //saveDeviceTokenAndId();
    super.initState();
    _homeBloc = BlocProvider.of<HomeBloc>(this.context);

  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // getroleofstudent();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: (){
              Navigator.of(context).pop();
            },
            child: Icon(Icons.arrow_back_ios,)),
        title: Text(""
        ),
        backgroundColor: ThemeColors.backGroundColor,

      ),
      body:Container(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.trackProgressData.heading.toString(),
                  style: TextStyle(fontFamily: 'Poppins-Medium',
                      fontSize: 18,
                      fontWeight: FontWeight.w500)),

              SizedBox(height: 8,),
              Text(widget.trackProgressData.description.toString()),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: widget.trackProgressData.status == 1 ? Container():
      Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
            return BlocListener<HomeBloc, HomeState>(
              listener: (context, state) {

                if(state is TaskCompleteLoading){
                  // _isLoading = state.isLoading;
                }
                if(state is TaskCompleteSuccess){
                  showCustomSnackBar(context,state.message.toString(),isError: false);
                  // Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>
                  //     MyTaskDetailsScreen(myTaskData: widget.myTaskData,)));

                }
                if(state is TaskCompleteFail){
                  showCustomSnackBar(context,state.msg.toString(),isError: true);
                }
              },
              child: InkWell(
                onTap: (){
                  _homeBloc!.add(TaskComplete(serviceUserId: widget.trackProgressData.serviceUserId.toString(),machineEnquiryId: widget.trackProgressData.machineEnquiryId.toString(),
                      transportEnquiryId: '0',jobWorkEnquiryId: '0', dailyTaskId: widget.trackProgressData.id.toString(), status: 1));
                },
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: ThemeColors.defaultbuttonColor,
                        borderRadius: BorderRadius.circular(30)),
                    child: Center(child: Text("Mark As Complete",
                        style: TextStyle(fontFamily: 'Poppins-Medium',
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ))),
                  ),
                ),
              ),

            );


          }),

        ],
      ),

    );
  }
}
