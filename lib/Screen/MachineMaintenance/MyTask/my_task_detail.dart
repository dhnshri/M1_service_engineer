import 'package:cached_network_image/cached_network_image.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:service_engineer/Constant/theme_colors.dart';
import 'package:service_engineer/Screen/MachineMaintenance/MyTask/process_detail.dart';
import 'package:service_engineer/Widget/pdfViewer.dart';
import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';
import 'package:flutter/foundation.dart';
import '../../../Config/font.dart';
import 'package:path_provider/path_provider.dart';
import '../../Chat/chat_listing.dart';
import '../../bottom_navbar.dart';
import 'add_task.dart';



class MyTaskDetailsScreen extends StatefulWidget {
  const MyTaskDetailsScreen({Key? key}) : super(key: key);

  @override
  _MyTaskDetailsScreenState createState() => _MyTaskDetailsScreenState();
}

class _MyTaskDetailsScreenState extends State<MyTaskDetailsScreen> {
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
  String? url =
      "http://www.africau.edu/images/default/sample.pdf";

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
        title: Text('#102GRDSA36987',style:appBarheadingStyle ,),
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
                Navigator.push(context, MaterialPageRoute(builder: (context)=>chatListing()));
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
            title: Text("Basic Info",
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
                        Text("Company ID",style: ExpanstionTileLeftDataStyle,),
                        Text("#102GRDSA36987",style: ExpanstionTileRightDataStyle,),
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
                    SizedBox(height: 5,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Location :",style: ExpanstionTileLeftDataStyle,),
                        Text("Pune Railway Station",style: ExpanstionTileRightDataStyle,),
                      ],
                    ),
                    SizedBox(height: 5,),

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
          /// Machin Info
          ExpansionTileCard(
            key: cardB,
            initiallyExpanded: true,
            title: Text("Machine Information",
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
                    Container(
                      height:200,
                      width: MediaQuery.of(context).size.width,
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Category",style: ExpanstionTileLeftDataStyle,),
                                Text("Heavy",style: ExpanstionTileRightDataStyle,),
                              ],
                            ),
                            SizedBox(height: 7,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Machine Name",style: ExpanstionTileLeftDataStyle,),
                                Text("Grinder 2LA",style: ExpanstionTileRightDataStyle,),
                              ],
                            ),
                            SizedBox(height: 7,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Manufacturer (Brand)",style: ExpanstionTileLeftDataStyle,),
                                Text("John Deer",style: ExpanstionTileRightDataStyle,),
                              ],
                            ),
                            SizedBox(height: 7,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Make",style: ExpanstionTileLeftDataStyle,),
                                Text("Some Value here",style: ExpanstionTileRightDataStyle,),
                              ],
                            ),
                            SizedBox(height: 7,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Machine No.",style: ExpanstionTileLeftDataStyle,),
                                Text("032154CS32",style: ExpanstionTileRightDataStyle,),
                              ],
                            ),
                            SizedBox(height: 7,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Controler",style: ExpanstionTileLeftDataStyle,),
                                Text("Mitsubishi",style: ExpanstionTileRightDataStyle,),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Sub-Category",style: ExpanstionTileLeftDataStyle,),
                                Text("Semi Iron",style: ExpanstionTileRightDataStyle,),
                              ],
                            ),
                            SizedBox(height: 7,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Machine Type",style: ExpanstionTileLeftDataStyle,),
                                Text("Latte",style: ExpanstionTileRightDataStyle,),
                              ],
                            ),
                            SizedBox(height: 7,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("System name",style: ExpanstionTileLeftDataStyle,),
                                Text("MH23GTSF",style: ExpanstionTileRightDataStyle,),
                              ],
                            ),
                            SizedBox(height: 7,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Model no.",style: ExpanstionTileLeftDataStyle,),
                                Text("02GRDSA36",style: ExpanstionTileRightDataStyle,),
                              ],
                            ),
                            SizedBox(height: 7,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Machine Size",style: ExpanstionTileLeftDataStyle,),
                                Text("255m",style: ExpanstionTileRightDataStyle,),
                              ],
                            ),
                            SizedBox(height: 7,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Manufacture Date",style: ExpanstionTileLeftDataStyle,),
                                Text("24-July-2022",style: ExpanstionTileRightDataStyle,),
                              ],
                            ),
                          ],
                        )
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
          /// Other Info
          ExpansionTileCard(
            key: cardC,
            initiallyExpanded: true,
            leading: Text("Other Info",
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
                        Text("Priority",style: TextStyle(fontFamily: 'Poppins-Medium',
                            fontSize: 16,
                            )),
                        Text("High",style: TextStyle(fontFamily: 'Poppins-Medium',
                            fontSize: 16,
                            fontWeight: FontWeight.w500)),
                      ],
                    ),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Maintenance Type",style: TextStyle(fontFamily: 'Poppins-Medium',
                            fontSize: 16,
                            )),
                        Text("Some Value here",style: TextStyle(fontFamily: 'Poppins-Medium',
                            fontSize: 16,
                            fontWeight: FontWeight.w500)),
                      ],
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
                    SizedBox(height: 10,),

                    Container(
                      decoration: BoxDecoration(
                          color: ThemeColors.imageContainerBG
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(right:16.0,left: 16.0,bottom: 8.0,top: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Text('Image-abc',
                                  style: TextStyle(
                                      color: ThemeColors.buttonColor,
                                      fontFamily: 'Poppins-Regular',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400
                                  )),
                            ),
                            InkWell(
                              onTap: () async {
                                final file = await loadPdfFromNetwork(url.toString());

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        PDFScreen(file: file,url: url.toString(),),
                                  ),
                                );
                              },
                              child: Container(
                                child: Text('View',
                                    style: TextStyle(
                                        color: ThemeColors.buttonColor,
                                        fontFamily: 'Poppins-Regular',
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500
                                    )),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: 10,),

                    Container(
                      decoration: BoxDecoration(
                          color: ThemeColors.imageContainerBG
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(right:16.0,left: 16.0,bottom: 8.0,top: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Text('Image-abc',
                                  style: TextStyle(
                                      color: ThemeColors.buttonColor,
                                      fontFamily: 'Poppins-Regular',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400
                                  )),
                            ),
                            InkWell(
                              onTap: () async {
                                final file = await loadPdfFromNetwork(url.toString());

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        PDFScreen(file: file,url: url.toString(),),
                                  ),
                                );
                              },
                              child: Container(
                                child: Text('View',
                                    style: TextStyle(
                                        color: ThemeColors.buttonColor,
                                        fontFamily: 'Poppins-Regular',
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500
                                    )),
                              ),
                            )
                          ],
                        ),
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

          ///Working Days
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Working Days :",
                style: TextStyle(fontFamily: 'Poppins-Medium',
                fontSize: 16,
                fontWeight: FontWeight.w500)),
                Text("4 Days",
                    style: TextStyle(fontFamily: 'Poppins-Medium',
                        fontSize: 16,
                        fontWeight: FontWeight.w500))
              ],
            ),
          ),

          SizedBox(height: 5,),


          Divider(
            // height: 2,
            thickness: 2.0,
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
          Column(
            // height: MediaQuery.of(context).size.height,
            children: [
              ListView.builder(
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
                  })
            ],
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

  Future<File> loadPdfFromNetwork(String url) async {
    final response = await http.get(Uri.parse(url));
    final bytes = response.bodyBytes;
    return _storeFile(url, bytes);
  }
  Future<File> _storeFile(String url, List<int> bytes) async {
    final filename = basename(url);
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$filename');
    await file.writeAsBytes(bytes, flush: true);
    if (kDebugMode) {
      print('$file');
    }
    return file;
  }
}
