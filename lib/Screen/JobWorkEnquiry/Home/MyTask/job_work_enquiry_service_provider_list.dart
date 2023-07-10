import 'package:cached_network_image/cached_network_image.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:service_engineer/Bloc/home/home_bloc.dart';
import 'package:service_engineer/Bloc/home/home_event.dart';
import 'package:service_engineer/Bloc/home/home_state.dart';
import 'package:service_engineer/Model/JobWorkEnquiry/my_task_model.dart';
import 'package:service_engineer/Model/track_process_repo.dart';
import 'package:service_engineer/Screen/JobWorkEnquiry/Home/MyTask/service_provider_profile.dart';
import 'package:service_engineer/Utils/application.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter/foundation.dart';
import '../../../../Config/font.dart';
import '../../../../Model/JobWorkEnquiry/task_hand_over_jwe_model.dart';
import '../../../../Widget/custom_snackbar.dart';




class JobWorkEnquiryServiceProviderListScreen extends StatefulWidget {
  JobWorkEnquiryMyTaskModel myTaskJobWorkEnquiryData;
  JobWorkEnquiryServiceProviderListScreen({Key? key,required this.myTaskJobWorkEnquiryData}) : super(key: key);

  @override
  _JobWorkEnquiryServiceProviderListScreenState createState() => _JobWorkEnquiryServiceProviderListScreenState();
}

class _JobWorkEnquiryServiceProviderListScreenState extends State<JobWorkEnquiryServiceProviderListScreen> {
  String? role;
  bool loading = true;
  bool _isLoading = false;

  HomeBloc? _homeBloc;
  List<JobWorkEnquiryTaskHandOverModel>? serviceList = [];
  ScrollController _scrollController = ScrollController();


  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ExpansionTileCardState> cardA = new GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardB = new GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardC = new GlobalKey();

  List<TrackProcessModel>? trackProgressData = [];
  int offset = 0;
  int handoverOffset = 0;
  int? timeId=0;
  bool _loadData=false;

  @override
  void initState() {
    // TODO: implement initState
    //saveDeviceTokenAndId();
    super.initState();
    _homeBloc = BlocProvider.of<HomeBloc>(this.context);
    // _homeBloc!.add(OnJobWorkEnquiryTaskHandOver(catId: 2.toString(), offSet: '0'));
    getApi();
  }

  getApi(){
    _homeBloc!.add(OnJobWorkEnquiryTaskHandOver(catId: Application.customerLogin!.workCategoryId.toString(), offSet: '$offset'));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // getroleofstudent();
  }

  Widget buildServiceProviderList(List<JobWorkEnquiryTaskHandOverModel> handOverList) {
    return ListView.builder(
      controller: _scrollController
        ..addListener(() {
          if (_scrollController.position.pixels  ==
              _scrollController.position.maxScrollExtent) {
            offset++;
            print("Offser : ${offset}");
            BlocProvider.of<HomeBloc>(context)
              ..isFetching = true
              ..add(getApi());
            // serviceList.addAll(serviceList);
          }
        }),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      padding: EdgeInsets.only(top: 10, bottom: 15),
      itemBuilder: (context, index) {
        return InkWell(
            onTap: (){
              Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (context) => JobWorkServiceProviderProfile(serviceList: handOverList[index],myTaskJobWorkEnquiryData: widget.myTaskJobWorkEnquiryData,)));
            },
            child: TaskHandOverCard(context,handOverList[index]));
      },
      itemCount: handOverList.length,
    );
  }

  Widget TaskHandOverCard(BuildContext context,JobWorkEnquiryTaskHandOverModel TaskData)
  {
    return
      Container(
        width: MediaQuery.of(context).size.width ,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0.0),
          ),
          // color: Colors.white70,
          elevation: 5,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.28,
                    maxHeight: MediaQuery.of(context).size.width * 0.28,
                  ),
                  child: CachedNetworkImage(
                    filterQuality: FilterQuality.medium,
                    // imageUrl: Api.PHOTO_URL + widget.users.avatar,
                    // imageUrl: "https://picsum.photos/250?image=9",
                    imageUrl: "https://picsum.photos/250?image=9",
                    placeholder: (context, url) {
                      return Shimmer.fromColors(
                        baseColor: Theme.of(context).hoverColor,
                        highlightColor: Theme.of(context).highlightColor,
                        enabled: true,
                        child: Container(
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(0),
                          ),
                        ),
                      );
                    },
                    imageBuilder: (context, imageProvider) {
                      return Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(0),
                        ),
                      );
                    },
                    errorWidget: (context, url, error) {
                      return Shimmer.fromColors(
                        baseColor: Theme.of(context).hoverColor,
                        highlightColor: Theme.of(context).highlightColor,
                        enabled: true,
                        child: Container(
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(Icons.error),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        // width: MediaQuery.of(context).size.width/1.8,
                        child: Text(
                          TaskData.username.toString(),
                          // "Job Title/Services Name or Any Other Name",
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 16,
                              fontWeight: FontWeight.bold
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                      SizedBox(height: 4,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Category Id:",
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 12,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          // SizedBox(
                          //   width: MediaQuery.of(context).size.width/9,
                          // ),
                          Container(
                            // width: MediaQuery.of(context).size.width*0.2,
                            child: Text(TaskData.enquiryCategoryId.toString(),
                              // "#102GRDSA36987",
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 12,
                                // fontWeight: FontWeight.bold
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),

                        ],
                      ),
                      SizedBox(height: 3,),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Category Name:",
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 12,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          // SizedBox(
                          //   width: MediaQuery.of(context).size.width/11,
                          // ),
                          Container(
                            // width: MediaQuery.of(context).size.width*0.2,
                            child: Text(
                              TaskData.enquiryDetailsCategory.toString(),
                              //"Step 1",
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 12,
                                // fontWeight: FontWeight.bold
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 3,),

                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     Text(
                      //       "Total Experience:",
                      //       style: TextStyle(
                      //           fontFamily: 'Poppins',
                      //           fontSize: 12,
                      //           fontWeight: FontWeight.bold
                      //       ),
                      //     ),
                      //     // SizedBox(
                      //     //   width: MediaQuery.of(context).size.width/8,
                      //     // ),
                      //     Container(
                      //       // width: MediaQuery.of(context).size.width*0.2,
                      //       child: Text(
                      //         TaskData.years.toString(),
                      //         //"Step 1",
                      //         style: TextStyle(
                      //           fontFamily: 'Poppins',
                      //           fontSize: 12,
                      //           // fontWeight: FontWeight.bold
                      //         ),
                      //         overflow: TextOverflow.ellipsis,
                      //       ),
                      //     )
                      //   ],
                      // ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
  }

  Widget ShimmerCard(){
    return ListView.builder(
      scrollDirection: Axis.vertical,
      // padding: EdgeInsets.only(left: 5, right: 20, top: 10, bottom: 15),
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Theme.of(context).hoverColor,
          highlightColor: Theme.of(context).highlightColor,
          enabled: true,
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0.0),
              ),
              // color: Colors.white70,
              elevation: 5,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.28,
                        maxHeight: MediaQuery.of(context).size.width * 0.28,
                      ),
                      child: CachedNetworkImage(
                        filterQuality: FilterQuality.medium,
                        imageUrl: '',
                        placeholder: (context, url) {
                          return Shimmer.fromColors(
                            baseColor: Theme.of(context).hoverColor,
                            highlightColor: Theme.of(context).highlightColor,
                            enabled: true,
                            child: Container(
                              height: 80,
                              width: 80,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(0),
                              ),
                            ),
                          );
                        },
                        imageBuilder: (context, imageProvider) {
                          return Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(0),
                            ),
                          );
                        },
                        errorWidget: (context, url, error) {
                          return Shimmer.fromColors(
                            baseColor: Theme.of(context).hoverColor,
                            highlightColor: Theme.of(context).highlightColor,
                            enabled: true,
                            child: Container(
                              height: 80,
                              width: 80,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Icon(Icons.error),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            // width: MediaQuery.of(context).size.width/2.5,
                            child: Text(
                              '',
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          ),
                          SizedBox(height: 4,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Enquiry ID:",
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              // SizedBox(
                              //   // width: MediaQuery.of(context).size.width/,
                              // ),
                              Container(
                                // width: MediaQuery.of(context).size.width*0.2,
                                child: Text(
                                  '',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 12,
                                    // fontWeight: FontWeight.bold
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 3,),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Working Timing:",
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              // SizedBox(
                              //   width: MediaQuery.of(context).size.width/6.3,
                              // ),
                              Container(
                                // width: MediaQuery.of(context).size.width*0.2,
                                child: Text(
                                  "10 AM - 6 PM",
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 12,
                                    // fontWeight: FontWeight.bold
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 3,),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Date & Time:",
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              // SizedBox(
                              //   width: MediaQuery.of(context).size.width/6.3,
                              // ),
                              Container(
                                // width: MediaQuery.of(context).size.width*0.2,
                                child: Text(
                                  '',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 12,
                                    // fontWeight: FontWeight.bold
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              )
                            ],
                          ),

                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      itemCount: List.generate(8, (index) => index).length,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: InkWell(
              onTap: (){
                Navigator.pop(context);
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => BottomNavigation (index:0)));
              },
              child: Icon(Icons.arrow_back_ios)),
          title: Text("Service Provider List",style:appBarheadingStyle ,),
        ),
        body:BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
          return BlocListener<HomeBloc, HomeState>(
              listener: (context, state) {
                if(state is JobWorkEnquiryTaskHandOverLoading){
                  _isLoading = state.isLoading;
                }
                if(state is JobWorkEnquiryTaskHandOverSuccess){
                  // serviceList = state.serviceListJWEData;
                  serviceList!.addAll(state.serviceListJWEData);
                  if(serviceList!=null){
                    _loadData=true;
                  }
                }
                if(state is JobWorkEnquiryTaskHandOverFail){
                  showCustomSnackBar(context,state.msg.toString());
                }
              },
              child: _loadData ? serviceList!.length <= 0 ? Center(child: Text('No Data'),):
              Container(
                child: ListView(
                  children: [
                    SingleChildScrollView(child: Container(child:buildServiceProviderList(serviceList!))),
                  ],
                ),
              ) : ShimmerCard()

            // Center(
            //   child: CircularProgressIndicator(),
            // )

          );


        })

    );
  }

}
