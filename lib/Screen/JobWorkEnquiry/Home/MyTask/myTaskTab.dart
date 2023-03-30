import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:service_engineer/Config/font.dart';
import 'package:service_engineer/Constant/theme_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../Bloc/home/home_bloc.dart';
import '../../../../Bloc/home/home_event.dart';
import '../../../../Bloc/home/home_state.dart';
import '../../../../Model/JobWorkEnquiry/my_task_model.dart';
import '../../../../Utils/application.dart';
import '../../../../Widget/custom_snackbar.dart';
import 'myTaskFilter.dart';
import 'my_task_detail.dart';



class EnquiryMyTaskScreen extends StatefulWidget {
  EnquiryMyTaskScreen({Key? key,required this.isSwitched}) : super(key: key);
  bool isSwitched;
  @override
  _EnquiryMyTaskScreenState createState() => _EnquiryMyTaskScreenState();
}

class _EnquiryMyTaskScreenState extends State<EnquiryMyTaskScreen> {
  HomeBloc? _homeBloc;
  List<JobWorkEnquiryMyTaskModel> myTaskJobWorkEnquiryList = [];
  final _formKey = GlobalKey<FormState>();
  final _searchController = TextEditingController();
  double? _progressValue;
  bool _isLoading = false;
  bool flagSearchResult=false;
  bool _isSearching=false;
  List<JobWorkEnquiryMyTaskModel> searchResult=[];
  bool _loadData=false;
  ScrollController _scrollController = ScrollController();
  int offset = 0;
  int? timeId=0;

  @override
  void initState() {
    // TODO: implement initState
    //saveDeviceTokenAndId();
    super.initState();
    _progressValue = 0.5;
    _homeBloc = BlocProvider.of<HomeBloc>(context);
    // _homeBloc!.add(OnMyTaskJWEList(userid:'1', offset: '0',timeId: '0'));
    getApi();
  }

  getApi(){
    _homeBloc!.add(OnMyTaskJWEList(userid: Application.customerLogin!.id.toString(), offset: '$offset',timeId: '$timeId'));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // getroleofstudent();
  }

  void _handleSearchStart() {
    setState(() {
      _isSearching = true;
    });
  }

  void searchOperation(String searchText) {
    searchResult.clear();
    if (_isSearching != null) {
      for (int i = 0; i < myTaskJobWorkEnquiryList.length; i++) {
        JobWorkEnquiryMyTaskModel taskListData = new JobWorkEnquiryMyTaskModel();
        taskListData.itemName = myTaskJobWorkEnquiryList[i].itemName.toString();
        taskListData.enquiryId = myTaskJobWorkEnquiryList[i].enquiryId;
        taskListData.dateAndTime = myTaskJobWorkEnquiryList[i].dateAndTime;

        if (taskListData.itemName.toString().toLowerCase().contains(searchText.toLowerCase()) ||
            taskListData.enquiryId.toString().toLowerCase().contains(searchText.toLowerCase()) ||
            taskListData.dateAndTime.toString().toLowerCase().contains(searchText.toLowerCase()) ) {
          flagSearchResult=false;
          searchResult.add(taskListData);
        }
      }
      setState(() {
        if(searchResult.length==0){
          flagSearchResult=true;
        }
      });
    }
  }

  Widget buildmyTaskJobWorkEnquiryList(List<JobWorkEnquiryMyTaskModel> myTaskJobWorkEnquiryList) {

    // return ListView.builder(
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
        return   InkWell(
            onTap: (){
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => EnquiryMyTaskDetailsScreen(myTaskJobWorkEnquiryData:myTaskJobWorkEnquiryList[index],)));
            },
            child: myTaskCard(context,myTaskJobWorkEnquiryList[index]));
      },
      itemCount: myTaskJobWorkEnquiryList.length,
    );
  }

  Widget myTaskCard(BuildContext context,JobWorkEnquiryMyTaskModel jobWorkEnquiryMyTaskData)
  {
    return Container(
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
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisAlignment: MainAxisAlignment.start,
                  children: [

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text(
                            "Items Name",
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 12,
                                // fontWeight: FontWeight.bold
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Text(
                          jobWorkEnquiryMyTaskData.itemName.toString(),
                          // "Items:",
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 12,
                              fontWeight: FontWeight.bold
                          ),
                        ),
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
                            // fontWeight: FontWeight.bold
                          ),

                        ),

                        Container(
                          child: Text(
                            DateFormat('MM-dd-yyyy h:mm a').format(DateTime.parse(jobWorkEnquiryMyTaskData.dateAndTime.toString())).toString(),
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 12,
                                fontWeight: FontWeight.bold
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body:BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
          return BlocListener<HomeBloc, HomeState>(
              listener: (context, state) {
                if(state is MyTaskJWELoading){
                  _isLoading = state.isLoading;
                }
                if(state is MyTaskJWEListSuccess){
                  // myTaskJobWorkEnquiryList = state.MyTaskJWEList;
                  myTaskJobWorkEnquiryList.addAll(state.MyTaskJWEList);
                  if(myTaskJobWorkEnquiryList!=null){
                    _loadData=true;
                  }
                }
                if(state is MyTaskJWEListLoadFail){
                  showCustomSnackBar(context,state.msg.toString());
                }
              },
              child:  widget.isSwitched
                  ? _loadData ? myTaskJobWorkEnquiryList.length <= 0 ? Center(child: Text('No Data'),):
              Container(
                child: ListView(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(width: 0.2,),
                          )
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 10.0, left: 10, right: 10, bottom: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: TextFormField(
                                // initialValue: Application.customerLogin!.name.toString(),
                                controller: _searchController,
                                textAlign: TextAlign.start,
                                keyboardType: TextInputType.text,
                                style: TextStyle(
                                  fontSize: 18,
                                  height: 1.5,
                                ),
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: ThemeColors.bottomNavColor,
                                  prefixIcon: IconButton(
                                    icon: Icon(
                                      Icons.search,
                                      size: 25.0,
                                      color: ThemeColors.blackColor,
                                    ),
                                    onPressed: () {
                                      _handleSearchStart();
                                    },
                                  ),
                                  hintText: "Search all Orders",
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 15.0),
                                  hintStyle: TextStyle(fontSize: 15),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(1.0)),
                                    borderSide: BorderSide(
                                        width: 0.8, color: ThemeColors.bottomNavColor),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(1.0)),
                                    borderSide: BorderSide(
                                        width: 0.8, color: ThemeColors.bottomNavColor),
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(1.0)),
                                      borderSide: BorderSide(
                                          width: 0.8,
                                          color: ThemeColors.bottomNavColor)),
                                ),
                                validator: (value) {
                                  return null;
                                },
                                onChanged: (value) {
                                  searchOperation(value);

                                },
                              ),
                            ),
                            InkWell(
                              onTap: () async {
                                var filterResult = await Navigator.push(context,
                                    MaterialPageRoute(builder: (context) =>
                                        const JobWorkMyTaskFilterScreen()));

                                if(filterResult != null ){
                                  myTaskJobWorkEnquiryList = filterResult['taskList'];
                                  timeId = filterResult['time_period'];
                                }
                              },
                              child: Row(
                                children: [
                                  Icon(Icons.filter_list),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text("Filter")
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SingleChildScrollView(
                        child:
                          Container(
                              child:
                              flagSearchResult == false? (searchResult.length != 0 || _searchController.text.isNotEmpty) ?
                              buildmyTaskJobWorkEnquiryList(searchResult):
                              buildmyTaskJobWorkEnquiryList(myTaskJobWorkEnquiryList):
                              Padding(
                                padding: const EdgeInsets.only(top: 20.0),
                                child: const Center(child: Text("No Data"),),
                              )
                          )),
                  ],
                ),
              ) : ShimmerCard(): Center(
          child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Nothing to show",
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 20,
                      fontWeight: FontWeight.bold)),
              SizedBox(
                height: 5,
              ),
              Text("You are currently",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16,
                  )),
              SizedBox(
                height: 5,
              ),
              Text("offline",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16,
                  )),
            ],
          ),
          ),

            // Center(
            //   child: CircularProgressIndicator(),
            // )

          );


        })


      // body:Container(
      //   child: ListView(
      //     children: [
      //       Container(
      //         decoration: BoxDecoration(
      //             border: Border(
      //               bottom: BorderSide(width: 0.2,),
      //             )
      //         ),
      //         child: Padding(
      //           padding: const EdgeInsets.only(
      //               top: 15.0, left: 10, right: 10, bottom: 5),              child: Row(
      //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //             children: [
      //
      //               Expanded(
      //                 child: TextFormField(
      //                   // initialValue: Application.customerLogin!.name.toString(),
      //                   controller: _searchController,
      //                   textAlign: TextAlign.start,
      //                   keyboardType: TextInputType.text,
      //                   style: TextStyle(
      //                     fontSize: 18,
      //                     height: 1.5,
      //                   ),
      //                   decoration: InputDecoration(
      //                     filled: true,
      //                     fillColor: ThemeColors.bottomNavColor,
      //                     prefixIcon: Icon(Icons.search,color: ThemeColors.textFieldHintColor,),
      //                     hintText: "Search all Orders",
      //                     contentPadding: EdgeInsets.symmetric(
      //                         vertical: 10.0, horizontal: 15.0),
      //                     hintStyle: TextStyle(fontSize: 15),
      //                     enabledBorder: OutlineInputBorder(
      //                       borderRadius:
      //                       BorderRadius.all(Radius.circular(1.0)),
      //                       borderSide: BorderSide(
      //                           width: 0.8,
      //                           color: ThemeColors.bottomNavColor
      //                       ),
      //                     ),
      //                     focusedBorder: OutlineInputBorder(
      //                       borderRadius:
      //                       BorderRadius.all(Radius.circular(1.0)),
      //                       borderSide: BorderSide(
      //                           width: 0.8,
      //                           color: ThemeColors.bottomNavColor),
      //                     ),
      //                     border: OutlineInputBorder(
      //                         borderRadius:
      //                         BorderRadius.all(Radius.circular(1.0)),
      //                         borderSide: BorderSide(
      //                             width: 0.8,
      //                             color: ThemeColors.bottomNavColor)),
      //                   ),
      //                   validator: (value) {
      //                     Pattern pattern = r'^([0][1-9]|[1-2][0-9]|[3][0-7])([a-zA-Z]{5}[0-9]{4}[a-zA-Z]{1}[1-9a-zA-Z]{1}[zZ]{1}[0-9a-zA-Z]{1})+$';
      //                     RegExp regex = new RegExp(pattern.toString());
      //                     if (value == null || value.isEmpty) {
      //                       return 'Please Enter GST Number';
      //                     }else if(!regex.hasMatch(value)){
      //                       return 'Please enter valid GST Number';
      //                     }
      //                     return null;
      //                   },
      //                   onChanged: (value) {
      //                     // profile.name = value;
      //                     setState(() {
      //                       // _nameController.text = value;
      //                       if (_formKey.currentState!.validate()) {}
      //                     });
      //                   },
      //                 ),
      //               ),
      //
      //
      //               InkWell(
      //                 onTap: ()
      //                 {
      //                   Navigator.push(context,
      //                       MaterialPageRoute(builder: (context) =>  EnquiryMyTaskFilterScreen()));
      //                 },
      //                 child: Row(
      //                   children: [
      //                     Icon(Icons.filter_list),
      //                     SizedBox(width: 5,),
      //                     Text("Filter")
      //                   ],
      //                 ),
      //               )
      //             ],
      //           ),
      //         ),
      //       ),
      //       SingleChildScrollView(child: Container(child: InkWell(
      //           onTap: (){
      //             Navigator.push(context, MaterialPageRoute(builder: (context)=>EnquiryMyTaskDetailsScreen()));
      //           },
      //           child: buildCustomerEnquiriesList()))),
      //     ],
      //   ),
      // ),

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
}
