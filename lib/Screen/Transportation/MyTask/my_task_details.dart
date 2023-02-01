import 'dart:async';
import 'dart:math' as math;
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

import '../../JobWorkEnquiry/Home/MyTask/show_google_map.dart';
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

  int _currentStep = 0;
  StepperType stepperType = StepperType.vertical;

  tapped(int step){
    setState(() => _currentStep = step);
  }

  continued(){
    _currentStep < 2 ?
    setState(() => _currentStep += 1): null;
  }
  cancel(){
    _currentStep > 0 ?
    setState(() => _currentStep -= 1) : null;
  }

  List<Step> getSteps(){
    return <Step>[
      Step(
        title: new Text('Reached at pickup location',style: TextStyle(
            fontSize: 15,
            fontFamily: 'Poppins-Medium',
            fontWeight: FontWeight.w500
        )),
        content: SizedBox( ),
        isActive: _currentStep >= 0,
        state: _currentStep >= 0 ? StepState.complete : StepState.disabled,
      ),
      Step(
        title: new Text('Loading completed',style: TextStyle(
            fontSize: 15,
            fontFamily: 'Poppins-Medium',
            fontWeight: FontWeight.w500
        )),
        content: SizedBox(),
        isActive: _currentStep >= 0,
        state: _currentStep >= 1 ?
        StepState.complete : StepState.disabled,
      ),
      Step(
        title: new Text('On the way to drop location',style: TextStyle(
            fontSize: 15,
            fontFamily: 'Poppins-Medium',
            fontWeight: FontWeight.w500
        )),
        content: SizedBox(),
        isActive:_currentStep >= 0,
        state: _currentStep >= 2 ? StepState.complete : StepState.disabled,
      ),
      Step(
        title: new Text('Reached on drop location',style: TextStyle(
            fontSize: 15,
            fontFamily: 'Poppins-Medium',
            fontWeight: FontWeight.w500
        )),
        content: SizedBox(),
        isActive:_currentStep >= 0,
        state: _currentStep >= 3 ? StepState.complete : StepState.disabled,
      )
    ];
  }

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
            title:Text("Basic Info",
            style: TextStyle(
                color: Colors.black,
                fontFamily: 'Poppins-Medium',
                fontSize: 16,
                fontWeight: FontWeight.w500
            ),),
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
                    SizedBox(height: 5,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Email ID:",style: ExpanstionTileLeftDataStyle,),
                        Text("abcd12@gmail.com",style: ExpanstionTileRightDataStyle,),
                      ],
                    ),
                    SizedBox(height: 5,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Enquiry ID:",style: ExpanstionTileLeftDataStyle,),
                        Text("#102GRDSA36987",style: ExpanstionTileRightDataStyle,),
                      ],
                    ),
                    SizedBox(height: 5,),

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
            title: Text("Load Details",
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Poppins-Medium',
                  fontSize: 16,
                  fontWeight: FontWeight.w500
              )),
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
                    SizedBox(height: 5,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Load Weight:",style: ExpanstionTileLeftDataStyle,),
                        Text("10 tonne",style: ExpanstionTileRightDataStyle,),
                      ],
                    ),
                    SizedBox(height: 5,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Load Size:",style: ExpanstionTileLeftDataStyle,),
                        Text("12 * 12",style: ExpanstionTileRightDataStyle,),
                      ],
                    ),
                    SizedBox(height: 5,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Pickup Location:",style: ExpanstionTileLeftDataStyle,),
                        Text("Pune Railway Station",style: ExpanstionTileRightDataStyle,),
                      ],
                    ),
                    SizedBox(height: 5,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Drop Location:",style: ExpanstionTileLeftDataStyle,),
                        Text("Pune factory",style: ExpanstionTileRightDataStyle,),
                      ],
                    ),
                    SizedBox(height: 5,),

                    SizedBox(height: 5,),
                    InkWell(
                      onTap: (){
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => MapSample()));
                      },
                      child: Container(
                        color:Color(0xFFFFE0E1),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Transform.rotate (
                                  angle: 180 * math.pi / 100,
                                  child: Icon(Icons.send,color: Colors.red, size: 11,)),
                              SizedBox(width: 10,),
                              Text("Google location Link | Google location Link ….",style: ExpanstionTileRightDataStyle.copyWith(color: Colors.red,fontWeight: FontWeight.normal),),
                            ],
                          ),
                        ),
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
          ExpansionTileCard(
            key: cardC,
            initiallyExpanded: true,
            title: Text("Track Process",
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Poppins-Medium',
                    fontSize: 16,
                    fontWeight: FontWeight.w500
                )),
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right:16.0,left: 16.0,bottom: 8.0),
                child: Column(
                  children: [
                    Theme(
                      data: ThemeData(
                        colorScheme: Theme.of(context).colorScheme.copyWith(
                          primary: Colors.red,
                        ),
                      ),
                      child: Stepper(
                        type: stepperType,
                        physics: ScrollPhysics(),
                        currentStep: _currentStep,
                        onStepTapped: (step) => tapped(step),
                        // onStepContinue:  continued,
                        // onStepCancel: cancel,
                        steps: getSteps(),
                        controlsBuilder: (context,_){
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              // _currentStep == 3 ? SizedBox():
                              TextButton(
                                onPressed: () {
                                  // continued;
                                  setState(() {
                                    if(_currentStep<3) {
                                      _currentStep++;
                                    }
                                  });
                                },
                                child: const Text(
                                    'Update',style: TextStyle(
                                    fontSize: 15,
                                    fontFamily: 'Poppins-Medium',
                                    fontWeight: FontWeight.bold
                                )
                                ),
                              ),

                            ],
                          );
                        },
                      ),
                    )

                  ],
                ),
              ),
            ],
          ),
          // Padding(
          //   padding: const EdgeInsets.all(15.0),
          //   child: Text("Track Process",
          //       style: TextStyle(fontFamily: 'Poppins-Medium',
          //           fontSize: 16,
          //           fontWeight: FontWeight.w500)
          //   ),
          // ),

          ///Track Process List
          // Column(
          //   children: [
          //     Theme(
          //       data: ThemeData(
          //         colorScheme: Theme.of(context).colorScheme.copyWith(
          //           primary: Colors.red,
          //         ),
          //       ),
          //       child: Stepper(
          //           type: stepperType,
          //           physics: ScrollPhysics(),
          //           currentStep: _currentStep,
          //           onStepTapped: (step) => tapped(step),
          //           // onStepContinue:  continued,
          //           // onStepCancel: cancel,
          //           steps: getSteps(),
          //         controlsBuilder: (context,_){
          //             return Row(
          //               mainAxisAlignment: MainAxisAlignment.end,
          //               children: [
          //               // _currentStep == 3 ? SizedBox():
          //                 TextButton(
          //                   onPressed: () {
          //                     // continued;
          //                     setState(() {
          //                       if(_currentStep<3) {
          //                       _currentStep++;
          //                     }
          //                   });
          //                   },
          //                   child: const Text(
          //                     'Update',style: TextStyle(
          //                       fontSize: 15,
          //                       fontFamily: 'Poppins-Medium',
          //                       fontWeight: FontWeight.bold
          //                   )
          //                   ),
          //                 ),
          //
          //               ],
          //             );
          //         },
          //       ),
          //     )
          //   ],
          // ),
          // Column(
          //   children: [
          //     ListView.builder(
          //         itemCount: 3,
          //         physics: NeverScrollableScrollPhysics(),
          //         shrinkWrap: true,
          //         itemBuilder: (_, index) {
          //           return Padding(
          //             padding: const EdgeInsets.only(left: 10.0,bottom: 10,right: 10),
          //             child: Material(
          //               elevation: 5,
          //               child: GestureDetector(
          //                 onTap: () {
          //                   Navigator.push(context,
          //                       MaterialPageRoute(builder: (context)=> ProcessDetailScreen()));
          //                 },
          //                 child: Container(
          //                   // height: 60,
          //                   decoration: BoxDecoration(
          //                     borderRadius: BorderRadius.circular(20),
          //                   ),
          //                   child: ListTile(
          //                     title: Padding(
          //                       padding: const EdgeInsets.only(bottom: 8,top: 5),
          //                       child: Row(
          //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //                         children: [
          //                           Text('Reached at Pickup Location',
          //                               style: TextStyle(
          //
          //                                   fontSize: 14,
          //                                   fontWeight: FontWeight.w400)),
          //                           Text("Process",
          //                             style: TextStyle(color: Colors.red),)
          //                         ],
          //                       ),
          //                     ),
          //                     subtitle: Padding(
          //                       padding: const EdgeInsets.only(bottom: 8.0),
          //                       child: Text('Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry',
          //                           maxLines: 2, overflow: TextOverflow.ellipsis,
          //                           style: TextStyle(
          //                               fontFamily: 'Poppins-Regular',fontSize: 12,color: Colors.black
          //                           )),
          //                     ),
          //                     trailing: Padding(
          //                       padding: const EdgeInsets.only(top: 8.0),
          //                       child: Icon(
          //                         Icons.arrow_forward_ios,),
          //                     ),
          //                   ),
          //                 ),
          //
          //               ),
          //             ),
          //           );
          //         }),
          //   ],
          // ),

          // ///Add task Button
          // Padding(
          //   padding: EdgeInsets.all(15.0),
          //   child: Material(
          //     elevation: 5,
          //     child: Container(
          //       height: 60,
          //       child: ElevatedButton(
          //           style: ButtonStyle(
          //             backgroundColor: MaterialStateProperty.all(ThemeColors.textFieldBackgroundColor),
          //
          //           ),
          //           onPressed: (){
          //             Navigator.push(context, MaterialPageRoute(builder: (context)=>AddTask ()));
          //           },
          //           child: Row(
          //             mainAxisAlignment: MainAxisAlignment.center,
          //             children: [
          //               Icon(Icons.add, color: Colors.black.withOpacity(0.55)),
          //               Text("Daily Update Task",
          //                 style: TextStyle(fontFamily: 'Poppins-Medium',
          //                     fontSize: 16,
          //                     fontWeight: FontWeight.w500,
          //                     color: Colors.black.withOpacity(0.55)
          //                 ),)
          //             ],
          //           )),
          //     ),
          //   ),),

          SizedBox(
            height: 20,
          ),

          ///Upload Receipt Copy
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 50,
              color: ThemeColors.textFieldBackgroundColor,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Text("Upload Receipt Copy",
                        style: TextStyle(fontFamily: 'Poppins-Medium',color: Colors.black.withOpacity(0.5)),
                        textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    InkWell(
                      onTap: (){
                       // _openGallery(context);
                      },
                      child: Container(
                        height: 30,
                        color: ThemeColors.textFieldHintColor.withOpacity(0.3),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 4,right: 4),
                          child: Center(child: Text("+Add Image",
                            style: TextStyle(fontFamily: 'Poppins-Regular',color: Colors.black.withOpacity(0.5)),
                            textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis,
                          )),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),

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
