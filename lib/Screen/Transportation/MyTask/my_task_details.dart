import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:service_engineer/Config/font.dart';
import 'package:service_engineer/Constant/theme_colors.dart';
import 'package:service_engineer/Screen/JobWorkEnquiry/Home/MyTask/process_detail.dart';
import 'package:service_engineer/Screen/bottom_navbar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'add_task.dart';



class TransportationMyTaskDetailsScreen extends StatefulWidget {
  const TransportationMyTaskDetailsScreen({Key? key}) : super(key: key);

  @override
  _TransportationMyTaskDetailsScreenState createState() => _TransportationMyTaskDetailsScreenState();
}

class _TransportationMyTaskDetailsScreenState extends State<TransportationMyTaskDetailsScreen> {
  final TextEditingController _phoneNumberController = TextEditingController();
  String dropdownValue = '+ 91';
  String? phoneNum;
  String? role;
  bool loading = true;

  // String? smsCode;
  // bool smsCodeSent = false;
  // String? verificationId;
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ExpansionTileCardState> cardA = new GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardB = new GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardC = new GlobalKey();
  final Set<Marker> _markers = {};
  late LatLng _lastMapPosition;
  double? addressLat;
  double? addressLong;
  Completer<GoogleMapController> controller1 = Completer();


  _onCameraMove(CameraPosition position) {
    _lastMapPosition = position.target;
  }

  _onMapCreated(GoogleMapController controller) {
    setState(() {
      controller1.complete(controller);
    });
  }

  MapType _currentMapType = MapType.normal;


  @override
  void initState() {
    // TODO: implement initState
    //saveDeviceTokenAndId();
    super.initState();
    addressLat = double.parse(21.1458.toString());
    addressLong = double.parse(79.0882.toString());
    _lastMapPosition = LatLng(addressLat!, addressLong!);

    _markers.add(Marker(
        markerId: MarkerId(151.toString()),
        position: _lastMapPosition,
        infoWindow: InfoWindow(
            title: "You are here",
            snippet: "This is a current location snippet",
            onTap: () {}),
        onTap: () {},
        icon: BitmapDescriptor.defaultMarker));

  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _phoneNumberController.clear();

    // getroleofstudent();
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
        title: Text('#102GRDSA36987',),
      ),
      floatingActionButton:Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              backgroundColor: ThemeColors.defaultbuttonColor,
              heroTag: "btn1",
              child: Icon(
                Icons.messenger,color: ThemeColors.whiteTextColor,size: 30,
              ),
              onPressed: () {
                //...
              },
            ),
            SizedBox(width: 8,),
            FloatingActionButton(
              backgroundColor: ThemeColors.defaultbuttonColor,
              heroTag: "btn2",
              child: Icon(
                Icons.call,color: ThemeColors.whiteTextColor,size: 30,
              ),
              onPressed: () {
                //...
              },
            ),
          ],
        ),
      ),
      body: ListView(
        children: [
          SizedBox(height: 7,),
          //Basic Info
          ExpansionTileCard(
            initiallyExpanded: true,
            key: cardA,
            leading: Text("Basic Info",
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Poppins-Medium',
                  fontSize: 16,
                  fontWeight: FontWeight.w500
              ),),

            title: SizedBox(),
            subtitle:SizedBox(),
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right:16.0,left: 16.0,bottom: 8.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Company Name:",style: ExpanstionTileLeftDataStyle,),
                        Text("Lorem Ipsume",style: ExpanstionTileRightDataStyle,),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Email ID:",style: ExpanstionTileLeftDataStyle,),
                        Text("abcd12@gmail.com",style: ExpanstionTileRightDataStyle,),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Enquiry ID:",style: ExpanstionTileLeftDataStyle,),
                        Text("#102GRDSA36987",style: ExpanstionTileRightDataStyle,),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Enquiry Date:",style: ExpanstionTileLeftDataStyle,),
                        Text("24-Sep-2022",style: ExpanstionTileRightDataStyle,),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Divider(
            // height: 2,
            thickness: 2.0,
          ),
          ///Item Required
          ExpansionTileCard(
            key: cardB,
            initiallyExpanded: true,
            leading: Text("Load Details",
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Poppins-Medium',
                    fontSize: 16,
                    fontWeight: FontWeight.w500
                )),
            title: SizedBox(),
            subtitle:SizedBox(),
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right:16.0,left: 16.0,bottom: 8.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Load Type:",style: ExpanstionTileLeftDataStyle,),
                        Text("Machine",style: ExpanstionTileRightDataStyle,),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Load Weight:",style: ExpanstionTileLeftDataStyle,),
                        Text("10 tonne",style: ExpanstionTileRightDataStyle,),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Load Size:",style: ExpanstionTileLeftDataStyle,),
                        Text("12 * 12",style: ExpanstionTileRightDataStyle,),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Pickup Location:",style: ExpanstionTileLeftDataStyle,),
                        Text("Pune Railway Station",style: ExpanstionTileRightDataStyle,),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Drop Location:",style: ExpanstionTileLeftDataStyle,),
                        Text("Pune factory",style: ExpanstionTileRightDataStyle,),
                      ],
                    ),
                    SizedBox(height: 5,),
                    Container(

                        height: MediaQuery.of(context).size.height * 0.21,
                        width: MediaQuery.of(context).size.width * 0.99,
                        decoration: BoxDecoration(
                            color: Color(0Xfffdf1f5),
                            borderRadius: BorderRadius.circular(8)),
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () {},
                              child: Container(
                                height: MediaQuery.of(context).size.height * 0.21,
                                width: MediaQuery.of(context).size.width * 0.99,
                                child: GoogleMap(
                                  markers: _markers,
                                  zoomControlsEnabled: true,
                                  zoomGesturesEnabled: true,
                                  rotateGesturesEnabled: false,
                                  scrollGesturesEnabled: true,
                                  mapType: _currentMapType,
                                  initialCameraPosition: CameraPosition(
                                    target: _lastMapPosition,
                                    zoom: 16.4746,
                                  ),
                                  onMapCreated: _onMapCreated,
                                  onCameraMove: _onCameraMove,
                                  myLocationEnabled: false,
                                  compassEnabled: false,
                                  myLocationButtonEnabled: false,
                                ),
                              ),
                            ),
                            Container(
                              child: Row(
                                children: [
                                  Column(
                                    children: [
                                      // Radio(
                                      //   value: 'current',
                                      //   activeColor: Colors.pink,
                                      //   focusColor: Colors.white,
                                      //   groupValue: addressLabel.toString(),
                                      //   onChanged: (value) {
                                      //     setState(() {
                                      //       addressLabel = value!;
                                      //     });
                                      //     addressController.addAddress(
                                      //         addressLabel,
                                      //         addressCurrent,
                                      //         addressLat.toString(),
                                      //         addressLong.toString());
                                      //     Get.off(CheckoutPage());
                                      //   },
                                      // ),
                                    ],
                                  ),
                                  // InkWell(
                                  //   onTap: () {
                                  //     setState(() {
                                  //       addressLabel = 'current';
                                  //     });
                                  //     addressController.addAddress(
                                  //         addressLabel,
                                  //         addressCurrent,
                                  //         addressLat.toString(),
                                  //         addressLong.toString());
                                  //     Get.off(CheckoutPage());
                                  //   },
                                  //   child: Column(
                                  //     crossAxisAlignment:
                                  //     CrossAxisAlignment.start,
                                  //     children: [
                                  //       Container(
                                  //         child: Text(
                                  //           'Current Location',
                                  //           style: TextStyle(
                                  //             fontWeight:
                                  //             FontWeight.bold,
                                  //             color: Color(0Xff3f3639),
                                  //             fontSize: width * 0.04,
                                  //           ),
                                  //         ),
                                  //       ),
                                  //       Container(
                                  //         width: width * 0.6,
                                  //         child: Text(
                                  //           addressCurrent.toString(),
                                  //           style: TextStyle(
                                  //             fontWeight:
                                  //             FontWeight.bold,
                                  //             color: const Color(
                                  //                 0Xffaaa4a6),
                                  //             fontSize: width * 0.032,
                                  //           ),
                                  //           overflow: TextOverflow.fade,
                                  //           maxLines: 2,
                                  //         ),
                                  //       )
                                  //     ],
                                  //   ),
                                  // )
                                ],
                              ),
                            ),
                          ],
                        )),
                    SizedBox(height: 10,),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text("Drawing Attachment:",
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Poppins-Medium',
                              fontSize: 14,
                              fontWeight: FontWeight.w500
                          )),
                    ),
                    SizedBox(height: 5,),
                    Container(
                      height:180,
                      width: 340,
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
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          );
                        },
                        imageBuilder: (context, imageProvider) {
                          return Container(
                            height: 80,
                            width: 80,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(8),
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
                    SizedBox(height: 10,),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black,width: 1),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Vestibulum blandit viverra convallis. Pellentesque ligula urna,"
                            " fermentum ut semper in, tincidunt nec dui. Morbi mauris lacus, consequat"
                            " eget justo in, semper gravida enim. Donec ultrices varius ligula. "
                            "Ut non pretium augue. Etiam non rutrum metus. In varius sit amet "
                            "lorem tempus sagittis. Cras sed maximus enim, vel ultricies tortor.",
                          style:ExpanstionTileOtherInfoStyle ,),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          Divider(
            // height: 2,
            thickness: 2.0,
          ),

          ///Track PRocess
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text("Track Process",
                style: TextStyle(fontFamily: 'Poppins-Medium',
                    fontSize: 16,
                    fontWeight: FontWeight.w500)
            ),
          ),

          ///Track Process List
          Flexible(
            // height: MediaQuery.of(context).size.height,
            child: ListView.builder(
                itemCount: 3,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (_, index) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 10.0,bottom: 10,right: 10),
                    child: Material(
                      elevation: 5,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context)=> ProcessDetailScreen()));
                        },
                        child: Container(
                          // height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: ListTile(
                            title: Padding(
                              padding: const EdgeInsets.only(bottom: 8,top: 5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Reached at Pickup Location',
                                      style: TextStyle(

                                          fontSize: 14,
                                          fontWeight: FontWeight.w400)),
                                  Text("Process",
                                    style: TextStyle(color: Colors.red),)
                                ],
                              ),
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Text('Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry',
                                  maxLines: 2, overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontFamily: 'Poppins-Regular',fontSize: 12,color: Colors.black
                                  )),
                            ),
                            trailing: Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Icon(
                                Icons.arrow_forward_ios,),
                            ),
                          ),
                        ),

                      ),
                    ),
                  );
                }),
          ),

          ///Add task Button
          Padding(
            padding: EdgeInsets.all(15.0),
            child: Material(
              elevation: 5,
              child: Container(
                height: 60,
                child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(ThemeColors.textFieldBackgroundColor),

                    ),
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>AddTask ()));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add, color: Colors.black.withOpacity(0.55)),
                        Text("Daily Update Task",
                          style: TextStyle(fontFamily: 'Poppins-Medium',
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.black.withOpacity(0.55)
                          ),)
                      ],
                    )),
              ),
            ),),

          ///Mark as Completed Button
          InkWell(
            onTap: (){
              // Navigator.of(context).pop();
              showDialog(
                  context: context,
                  builder: (context) =>  AlertDialog(
                    title: new Text("Are you sure, you want to mark it as complete?"),
                    // content: new Text(""),
                    actions: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                              child: new Text("No",style: TextStyle(
                                  color: Colors.black
                              ),),
                              onPressed: () {
                                Navigator.of(context).pop();
                              }, style: TextButton.styleFrom(
                              side: BorderSide(
                                  color: ThemeColors.defaultbuttonColor,
                                  width: 1.5)
                          )
                          ),
                          SizedBox(width: 7,),
                          TextButton(
                            child: new Text("Yes",style: TextStyle(
                                color: Colors.white
                            ),),
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>
                                  BottomNavigation(index: 0,dropValue: 'Transportation',)));
                            },
                            style: TextButton.styleFrom(
                                backgroundColor: ThemeColors.defaultbuttonColor
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
              );            },
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                height: 40,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: ThemeColors.defaultbuttonColor,
                    borderRadius: BorderRadius.circular(30)),
                child: Center(child: Text("Mark As Completed",
                    style: TextStyle(fontFamily: 'Poppins-Medium',
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ))),
              ),
            ),
          ),


          SizedBox(
            height: 80,
          )


        ],
      ),
    );
  }
}
