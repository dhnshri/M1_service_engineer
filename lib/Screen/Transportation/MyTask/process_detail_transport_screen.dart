import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:service_engineer/Bloc/home/home_bloc.dart';
import 'package:service_engineer/Bloc/home/home_event.dart';
import 'package:service_engineer/Bloc/home/home_state.dart';
import 'package:service_engineer/Model/MachineMaintance/myTaskModel.dart';
import 'package:service_engineer/Model/track_process_repo.dart';
import 'package:service_engineer/Screen/MachineMaintenance/MyTask/my_task_detail.dart';
import 'package:service_engineer/Screen/MachineMaintenance/MyTask/service_provider_list.dart';
import 'package:service_engineer/Screen/Transportation/MyTask/transpotation_service_provider_list.dart';
import 'package:service_engineer/Widget/custom_snackbar.dart';
import '../../../Constant/theme_colors.dart';
import '../../../Model/Transpotation/MyTaskTransportDetailModel.dart';
import '../../../Model/Transpotation/myTaskListModel.dart';
import 'my_task_details.dart';



class ProcessDetailTransportScreen extends StatefulWidget {
  TrackProcessModel trackProgressData;
  MyTaskTransportationModel myTaskData;

  ProcessDetailTransportScreen({Key? key,required this.trackProgressData,required this.myTaskData}) : super(key: key);

  @override
  _ProcessDetailTransportScreenState createState() => _ProcessDetailTransportScreenState();
}

class _ProcessDetailTransportScreenState extends State<ProcessDetailTransportScreen> {
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
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>TransportServiceProviderListScreen()));
            },
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: ThemeColors.defaultbuttonColor,
                    borderRadius: BorderRadius.circular(30)),
                child: Center(child: Text("Assign to Other",
                    style: TextStyle(fontFamily: 'Poppins-Medium',
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ))),
              ),
            ),
          ),
          BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
            return BlocListener<HomeBloc, HomeState>(
              listener: (context, state) {

                if(state is TaskCompleteLoading){
                  // _isLoading = state.isLoading;
                }
                if(state is TaskCompleteSuccess){
                  showCustomSnackBar(context,state.message.toString(),isError: false);
                  // Navigator.of(context).pop();
                  Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>
                      TransportationMyTaskDetailsScreen(myTaskData:widget.myTaskData,)));

                }
                if(state is TaskCompleteFail){
                  showCustomSnackBar(context,state.msg.toString(),isError: true);
                }
              },
              child: InkWell(
                onTap: (){
                  // _homeBloc!.add(TaskComplete(serviceUserId: widget.trackProgressData.serviceUserId.toString(),machineEnquiryId: '0',
                  //     transportEnquiryId:widget.trackProgressData.machineEnquiryId.toString(),jobWorkEnquiryId: '0', dailyTaskId: widget.trackProgressData.id.toString(), status: 1));

                  _homeBloc!.add(TaskComplete(serviceUserId:'1',machineEnquiryId: '0',
    transportEnquiryId:'1',jobWorkEnquiryId: '0', dailyTaskId: widget.trackProgressData.id.toString(), status: 1));

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
