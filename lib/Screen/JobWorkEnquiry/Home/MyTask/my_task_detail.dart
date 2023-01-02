import 'package:cached_network_image/cached_network_image.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:service_engineer/Config/font.dart';
import 'package:service_engineer/Constant/theme_colors.dart';
import 'package:service_engineer/Screen/Home/MyTask/process_detail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'add_task.dart';



class EnquiryMyTaskDetailsScreen extends StatefulWidget {
  const EnquiryMyTaskDetailsScreen({Key? key}) : super(key: key);

  @override
  _EnquiryMyTaskDetailsScreenState createState() => _EnquiryMyTaskDetailsScreenState();
}

class _EnquiryMyTaskDetailsScreenState extends State<EnquiryMyTaskDetailsScreen> {
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


  @override
  void initState() {
    // TODO: implement initState
    //saveDeviceTokenAndId();
    super.initState();
    _phoneNumberController.clear();

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
                        Text("Company ID",style: ExpanstionTileLeftDataStyle,),
                        Text("#102GRDSA36987",style: ExpanstionTileRightDataStyle,),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Owner's Name:",style: ExpanstionTileLeftDataStyle,),
                        Text("Lorem Ipsum",style: ExpanstionTileRightDataStyle,),
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
                        Text("Date & Timing :",style: ExpanstionTileLeftDataStyle,),
                        Text("12 Nov 2022, 10AM - 4PM",style: ExpanstionTileRightDataStyle,),
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
            leading: Text("Item Required",
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
                        Text("Item Name:",style: ExpanstionTileLeftDataStyle,),
                        Text("Lorem Ipsum",style: ExpanstionTileRightDataStyle,),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Quantity Required:",style: ExpanstionTileLeftDataStyle,),
                        Text("5,000 Pieces",style: ExpanstionTileRightDataStyle,),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Delivery Location:",style: ExpanstionTileLeftDataStyle,),
                        Text("Pune Railway Station",style: ExpanstionTileRightDataStyle,),
                      ],
                    ),
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
                                  Text('Lorem ipsum',
                                      style: TextStyle(

                                          fontSize: 18,
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
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>AddTaskScreen()));
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
              AlertDialog(
                title: new Text(""),
                content: new Text("Are you sure, you want to mark service as completed?"),
                actions: <Widget>[
                  Row(
                    children: [
                      TextButton(
                        child: new Text("No"),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      SizedBox(width: 7,),
                      TextButton(
                        child: new Text("Yes"),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                ],
              );
            },
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
