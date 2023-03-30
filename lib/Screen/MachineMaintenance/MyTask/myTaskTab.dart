import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:service_engineer/Bloc/home/home_bloc.dart';
import 'package:service_engineer/Bloc/home/home_event.dart';
import 'package:service_engineer/Bloc/home/home_state.dart';
import 'package:service_engineer/Constant/theme_colors.dart';
import 'package:service_engineer/Widget/custom_snackbar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import '../../../Config/font.dart';
import '../../../Model/MachineMaintance/myTaskModel.dart';
import '../../../Utils/application.dart';
import 'myTaskFilter.dart';
import 'my_task_detail.dart';



class MyTaskScreen extends StatefulWidget {
  bool isSwitched;
  MyTaskScreen({Key? key,required this.isSwitched}) : super(key: key);

  @override
  _MyTaskScreenState createState() => _MyTaskScreenState();
}

class _MyTaskScreenState extends State<MyTaskScreen> {
  HomeBloc? _homeBloc;
  List<MyTaskModel> myTaskList=[];
  List<MyTaskModel> searchResult=[];

  final _formKey = GlobalKey<FormState>();
  final _searchController = TextEditingController();
  ScrollController _scrollController = ScrollController();
  bool _isLoading = false;
  double? _progressValue;
  bool flagSearchResult=false;
  bool _isSearching=false;
  int offset = 0;
  int? timePeriod=0;
  bool _loadData=false;

  @override
  void initState() {
    // TODO: implement initState
    //saveDeviceTokenAndId();
    super.initState();
    _progressValue = 0.5;
    _homeBloc = BlocProvider.of<HomeBloc>(context);
    // _homeBloc!.add(MyTaskList(userid: '6', offset: '0'));
    getApi();
  }

  getApi(){
    _homeBloc!.add(MyTaskList(userid: Application.customerLogin!.id.toString(), offset: '$offset',timePeriod: timePeriod.toString()));
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
      for (int i = 0; i < myTaskList.length; i++) {
        MyTaskModel myTaskListData = new MyTaskModel();
        myTaskListData.machineImg = myTaskList[i].machineProblemImg.toString();
        myTaskListData.machineName = myTaskList[i].machineName.toString();
        myTaskListData.enquiryId = myTaskList[i].enquiryId;
        myTaskListData.dateAndTime = myTaskList[i].dateAndTime.toString();
        myTaskListData.taskStatus = myTaskList[i].taskStatus.toString();



        if (myTaskListData.machineImg.toString().toLowerCase().contains(searchText.toLowerCase()) ||
            myTaskListData.machineName.toString().toLowerCase().contains(searchText.toLowerCase()) ||
            myTaskListData.enquiryId.toString().toLowerCase().contains(searchText.toLowerCase()) ||
            myTaskListData.dateAndTime.toString().toLowerCase().contains(searchText.toLowerCase()) ) {
          flagSearchResult=false;
          searchResult.add(myTaskListData);
        }
      }
      setState(() {
        if(searchResult.length==0){
          flagSearchResult=true;
        }
      });
    }
  }


  Widget buildCustomerEnquiriesList(List<MyTaskModel> myTaskList) {

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
      physics: ScrollPhysics(),
      scrollDirection: Axis.vertical,
      padding: EdgeInsets.only(top: 10, bottom: 15),
      itemBuilder: (context, index) {
        return InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) => MyTaskDetailsScreen(myTaskData: myTaskList[index],)));
            },
            child: myTaskCard(context,myTaskList[index]));
      },
      itemCount: myTaskList.length,
    );
  }

  Widget myTaskCard(BuildContext context,MyTaskModel myTaskData)
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
                  imageUrl: myTaskData.machineImg == null
                      ? "https://picsum.photos/250?image=9"
                      : myTaskData.machineImg.toString(),
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
                        myTaskData.machineName.toString(),
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
                          "Enquiry ID:",
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
                          child: Text(
                            myTaskData.enquiryId.toString(),
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
                          "Task Status:",
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
                            myTaskData.taskStatus.toString(),
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
                    //       "Progress:",
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
                    //       width: MediaQuery.of(context).size.width*0.3,
                    //       height: 7,
                    //       child: ClipRRect(
                    //         borderRadius: BorderRadius.all(Radius.circular(10)),
                    //         child: LinearProgressIndicator(
                    //           backgroundColor: ThemeColors.greyBackgrounColor,
                    //           valueColor: new AlwaysStoppedAnimation<Color>(Colors.red),
                    //           value: _progressValue,
                    //         ),
                    //       ),
                    //     ),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
        return BlocListener<HomeBloc, HomeState>(
            listener: (context, state) {
              if(state is MyTaskLoading){
                _isLoading = state.isLoading;
              }
              if(state is MyTaskListSuccess){
                // myTaskList = state.MyTaskList;
                myTaskList.addAll(state.MyTaskList);
                if(myTaskList!=null){
                  _loadData=true;
                }
              }
              if(state is MyTaskListLoadFail){
                showCustomSnackBar(context,state.msg.toString());
              }
            },
            child: widget.isSwitched
                ?_loadData ? myTaskList.length <= 0 ? Center(child: Text('No Data'),):
            Container(
              child: Column(
                children: <Widget>[
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
                            onTap: ()async {
                              var filterResult = await Navigator.push(context,
                                  MaterialPageRoute(builder: (context) =>
                                      MyTaskFilterScreen()));

                              if(filterResult != null){
                                myTaskList = filterResult["taskList"];
                                timePeriod = filterResult["time_period"];
                              }
                            },
                            child: Row(
                              children: const [
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
                  flagSearchResult == false? (searchResult.length != 0 || _searchController.text.isNotEmpty) ?
                    buildCustomerEnquiriesList(searchResult): Expanded(child: buildCustomerEnquiriesList(myTaskList)) : Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: const Center(child: Text("No Data"),),),
                ],
              ),
            ) : ShimmerCard()  : Center(
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
