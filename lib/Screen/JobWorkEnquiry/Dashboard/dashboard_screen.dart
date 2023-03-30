import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:service_engineer/Bloc/dashboard/dashboard_bloc.dart';
import 'package:service_engineer/Bloc/dashboard/dashboard_event.dart';
import 'package:service_engineer/Bloc/dashboard/dashboard_state.dart';
import 'package:service_engineer/Config/image.dart';
import 'package:service_engineer/Utils/application.dart';
import 'package:service_engineer/Widget/custom_snackbar.dart';
import 'package:shimmer/shimmer.dart';


class JobWorkDashboardScreen extends StatefulWidget {
  const JobWorkDashboardScreen({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<JobWorkDashboardScreen> {

  DashboardBloc? _dashboardBloc;
  bool _isLoading = true;
  int? totalServiceDone;
  int? totalEarning;
  int? totalPaymentPending;
  int? totalPaymentReceived;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _dashboardBloc = BlocProvider.of<DashboardBloc>(this.context);
    _dashboardBloc!.add(GetJobWorkDashboardCount(
        serviceUserId: Application.customerLogin!.id.toString(),
       ));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

  }



  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2.7;
    final double itemWidth = size.width / 2;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: InkWell(
            onTap: () {
              // Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_ios)),
        title: Text(
          'Dashboard',
        ),
      ),
      body: BlocBuilder<DashboardBloc, DashboardState>(builder: (context, state) {
        return BlocListener<DashboardBloc, DashboardState>(
          listener: (context, state) {
            if(state is DashboardCountLoading){
              _isLoading = state.isLoading;
            }
            if(state is DashboardCountSuccess){
              totalServiceDone = state.totalServiceDone;
              totalEarning = state.totalEarning;
              totalPaymentPending = state.totalPaymentPending;
              totalPaymentReceived = state.totalPaymentReceived;
            }
            if(state is DashboardCountFail){
              showCustomSnackBar(context,state.msg.toString(),isError: true);
            }

          },
          child: _isLoading ? SingleChildScrollView(
            child: Column(
              children: [
                GridView.count(
                  primary: false,
                  padding: const EdgeInsets.only(top: 20,left: 10,right: 10),
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  crossAxisCount: 2,
                  childAspectRatio: (itemWidth / itemHeight),
                  // childAspectRatio: .7,

                  shrinkWrap: true,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(Images.dashboardBG),
                              fit: BoxFit.fill
                          )
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 25.0,bottom: 10),
                        child: Column(
                          children: [
                            Text(totalServiceDone!=null ? totalServiceDone.toString() : "0",
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold
                              ),),
                            Text("Total Service Done",
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500
                              ),),
                            Spacer(),
                            Text('Total Service Done',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Poppins',
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold
                              ),)
                          ],
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(Images.dashboardBG),
                              fit: BoxFit.fill
                          )
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 25.0,bottom: 10),
                        child: Column(
                          children: [
                            Text(totalEarning!=null ? "\u{20B9} ${totalEarning.toString()}" : "\u{20B9} 0",
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold
                              ),),
                            Text("Total Earning",
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500
                              ),),
                            Spacer(),
                            Text('Total Earning',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Poppins',
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold
                              ),)
                          ],
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(Images.dashboardBG),
                              fit: BoxFit.fill
                          )
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 25.0,bottom: 10),
                        child: Column(
                          children: [
                            Text(totalPaymentPending!=null ? totalPaymentPending.toString() : "0",
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold
                              ),),
                            Text("Payment Pending",
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500
                              ),),
                            Spacer(),
                            Text('Payment Pending',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Poppins',
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold
                              ),)
                          ],
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(Images.dashboardBG),
                              fit: BoxFit.fill
                          )
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 25.0,bottom: 10),
                        child: Column(
                          children: [
                            Text(totalPaymentReceived!=null ? totalPaymentReceived.toString() : "0",
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold
                              ),),
                            Text("Received Payments",
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500
                              ),),
                            Spacer(),
                            Text('Received Payments',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Poppins',
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold
                              ),)
                          ],
                        ),
                      ),
                    ),


                  ],
                )
              ],
            ),
          ): Center(child: CircularProgressIndicator(),),

        );


      }),

    );
  }
}
