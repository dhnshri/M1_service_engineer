import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:service_engineer/Api/commission_api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../Bloc/home/home_bloc.dart';
import '../../../../Bloc/home/home_event.dart';
import '../../../../Bloc/home/home_state.dart';
import '../../../../Config/font.dart';
import '../../../../Constant/theme_colors.dart';
import '../../../../Model/Transpotation/serviceRequestDetailModel.dart';
import '../../../../Model/Transpotation/vehicle_name_model.dart';
import '../../../../Model/Transpotation/vehicle_number_model.dart';
import '../../../../Model/Transpotation/vehicle_type_model.dart';
import '../../../../Utils/application.dart';
import '../../../../Widget/common.dart';
import '../../../../Widget/custom_snackbar.dart';
import '../../../../Widget/function_button.dart';
import '../../../MachineMaintenance/MakeQuotations/item_required_filter.dart';
import '../../../bottom_navbar.dart';


class QuotationFor extends StatefulWidget {
  VehicleNameModel? vehicleNameselected;
  VehicleTypeModel? vehicleTypeselected;
  VehicleNumberModel? vehicleNumberselected;
  // String dropdownValue4;
  TextEditingController ServiceCallChargesController = TextEditingController();
  TextEditingController HandlingChargesController = TextEditingController();
 // TextEditingController gstController = TextEditingController();
  TextEditingController cgstController = TextEditingController();
  TextEditingController sgstController = TextEditingController();
  TextEditingController igstController = TextEditingController();

  QuotationFor({Key? key,required this.vehicleNameselected,required this.vehicleTypeselected,
    required this.vehicleNumberselected,required this.HandlingChargesController,
    required this.ServiceCallChargesController,
    required this.cgstController,
    required this.sgstController,
    required this.igstController,
    required this.requestDetailList,
  }) : super(key: key,);

  TransportDetailsModel? requestDetailList;


  @override
  State<QuotationFor> createState() => QuotationForState();
}

class QuotationForState extends State<QuotationFor> {
  final TextEditingController _itemNameController = TextEditingController();
  final TextEditingController _itemPriceController = TextEditingController();

  String dropdownValue = '+ 91';
  String? phoneNum;
  String? role;
  bool loading = true;
  bool isSwitched = false;

  var mainHeight, mainWidth;
  var quantity = 0;
  var totalValue = 0;
  int prodValue = 15000;
  bool value = false;
  int commission = 0;
  HomeBloc? _homeBloc;

  final GlobalKey<ExpansionTileCardState> cardVehicleDetailsTransposation = new GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardOtherItemRequiredTransposation = new GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardQuotationsTransposation = new GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardQuotations = new GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardTermsConditionsTransposation = new GlobalKey();


  final _formKey = GlobalKey<FormState>();


  @override
  void initState() {
    // TODO: implement initState
    //saveDeviceTokenAndId();
    super.initState();
   // _phoneNumberController.clear();
    _homeBloc = BlocProvider.of<HomeBloc>(this.context);
    getCommissionApi();
  }

  getCommissionApi()async{
    var com = await fetchCommision(Application.customerLogin!.id.toString(),Application.customerLogin!.role.toString()).
    then((value) => value);
    print(com);
    print(com['data']);
    commission = com['data'];
    setState(() {
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // getroleofstudent();
  }

  Widget VehicleDetailsCard()
  {
    return Padding(
        padding: const EdgeInsets.only(bottom:0.0),
        child: Container(
          // color: Color(0xffFFE4E5),
            decoration: BoxDecoration(
              color: Color(0xffFFE4E5),
            ),
            child:Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("1",),
                          SizedBox(width: 55,),
                          Text("Vehicle Name",),
                        ],
                      ),
                      Text(widget.vehicleNameselected!.vehicleName.toString(),style: TextStyle(fontWeight: FontWeight.bold),),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("2"),
                          SizedBox(width: 55,),
                          Text("Vehicle Type",),
                        ],
                      ),
                      Text(widget.vehicleTypeselected!.vehicleType.toString(),style: TextStyle(fontWeight: FontWeight.bold),),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("3"),
                          SizedBox(width: 55,),
                          Text("Vehicle Number",),
                        ],
                      ),
                      Text(widget.vehicleNumberselected!.vehicleNumber.toString(),style: TextStyle(fontWeight: FontWeight.bold),),
                    ],
                  ),
                ],
              ),
            )
        )
    );
  }



  Widget QuotationCard()
  {
    return Padding(
        padding: const EdgeInsets.only(bottom:0.0),
        child: Container(
          // color: Color(0xffFFE4E5),
            decoration: BoxDecoration(
              color: Color(0xffFFE4E5),
            ),
            child:Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("1",),
                          SizedBox(width: 55,),
                          Text("Service/Call Charges"),
                        ],
                      ),
                      Text('₹${widget.ServiceCallChargesController.text}'),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("2",),
                          SizedBox(width: 55,),
                          Text("Handling Charges"),
                        ],
                      ),
                      Text('₹${widget.HandlingChargesController.text}'),
                    ],
                  ),
                ],
              ),
            )
        )
    );
  }


  @override
  Widget build(BuildContext context) {
    int sum = int.parse(widget.ServiceCallChargesController.text) +
        int.parse(widget.HandlingChargesController.text);

    double totalQuotation = 100/100+(int.parse(widget.cgstController.text))+(int.parse(widget.sgstController.text))
        +(int.parse(widget.igstController.text))+sum+commission;

    String gstNumber = '07AAGFF2194N1Z1';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: InkWell(
            onTap: (){
              Navigator.pop(context);
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => BottomNavigation (index:0,dropValue:"Transportation")));
            },
            child: Icon(Icons.arrow_back_ios)),
        title: Text('Quotation for #${widget.requestDetailList!.transportEnquiryId}'),
      ),
      bottomNavigationBar:Padding(
        padding: const EdgeInsets.all(10.0),
        child: FunctionButton(
          onPressed: () async {
           // Alertmessage(context);
            if(value==true){
              showDialog(
                  context: context,
                  builder: (context) =>  AlertDialog(
                    title: new Text("Are you sure, you want to send this quotation ?"),
                    // content: new Text(""),
                    actions: <Widget>[
                      Row(
                        mainAxisAlignment:
                        MainAxisAlignment.center,
                        children: [
                          TextButton(
                              child: new Text(
                                "No",
                                style: TextStyle(
                                    color: Colors.black),
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              style: TextButton.styleFrom(
                                fixedSize: const Size(120, 30),
                                shape:
                                const RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.all(
                                        Radius.circular(
                                            25))),
                                side: BorderSide(
                                    color: ThemeColors
                                        .defaultbuttonColor,
                                    width: 1.5),
                              )),
                          SizedBox(
                            width: 7,
                          ),
                          // TextButton(
                          //   child: new Text(
                          //     "Yes",
                          //     style:
                          //     TextStyle(color: Colors.white),
                          //   ),
                          //   onPressed: () {
                          //     Navigator.push(
                          //         context,
                          //         MaterialPageRoute(
                          //             builder: (context) =>
                          //                 BottomNavigation(
                          //                   index: 0,
                          //                   dropValue:
                          //                   'Transportation',
                          //                 )));
                          //   },
                          //   style: TextButton.styleFrom(
                          //     fixedSize: const Size(120, 30),
                          //     backgroundColor: ThemeColors
                          //         .defaultbuttonColor,
                          //     shape:
                          //     const RoundedRectangleBorder(
                          //         borderRadius:
                          //         BorderRadius.all(
                          //             Radius.circular(
                          //                 25))),),
                          //
                          // ),
                          BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
                            return BlocListener<HomeBloc, HomeState>(
                              listener: (context, state) {
                                if(state is TranspotationSendQuotationSuccess){
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => BottomNavigation(
                                            index: 0,
                                            dropValue: Application.customerLogin!.role.toString(),
                                          )));
                                  showCustomSnackBar(context,state.message,isError: false);
                                }
                              },
                              child: TextButton(
                                child: new Text(
                                  "Yes",
                                  style:
                                  TextStyle(color: Colors.white),
                                ),
                                onPressed: () {
                                  print("Print Date : ${widget.requestDetailList!}");
                                  _homeBloc!.add(TranspotationSendQuotation(
                                    service_user_id: Application.customerLogin!.id.toString(),
                                    transport_enquiry_date: widget.requestDetailList!.createdAt.toString(),
                                    transport_enquiry_id: widget.requestDetailList!.transportEnquiryId.toString(),
                                    handlingCharges: widget.HandlingChargesController.text == "" ? '0':widget.HandlingChargesController.text,
                                    serviceCharges: widget.ServiceCallChargesController.text == "" ? '0':widget.ServiceCallChargesController.text,
                                    vehicleType: widget.vehicleTypeselected.toString(),
                                    vehicleNumber: widget.vehicleNumberselected.toString(),
                                    vehicleName: widget.vehicleNameselected.toString(),
                                    gst_no:gstNumber.toString(),
                                    commision: commission.toString(),
                                    total_amount:totalQuotation.toString(),
                                    cgst:widget.cgstController.text.toString(),
                                    sgst:widget.sgstController.text.toString(),
                                    igst:widget.igstController.text.toString(),
                                  ));
                                },
                                style: TextButton.styleFrom(
                                  fixedSize: const Size(120, 30),
                                  backgroundColor: ThemeColors
                                      .defaultbuttonColor,
                                  shape:
                                  const RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.all(
                                          Radius.circular(
                                              25))),),

                              ),

                            );


                          })
                        ],
                      ),
                    ],
                  )
              );
            }else{
              showCustomSnackBar(context,"Please Agree to Terms And Conditions.",isError: true);
            }

          },
          shape: const RoundedRectangleBorder(
              borderRadius:
              BorderRadius.all(Radius.circular(50))),
          text: 'Next',
          loading: loading,


        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            SizedBox(height: 7,),
            // Item Required
            ExpansionTileCard(
              key: cardVehicleDetailsTransposation,
              initiallyExpanded: true,
              title: Text("Vehicle Details",style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Poppins',
                  fontSize: 16,
                  fontWeight: FontWeight.w500
              )),
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 8.0,right: 8.0,bottom: 8.0),
                  child: Column(
                    children: [
                      Container(
                        color: Color(0xffE47273),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Sr.no",style: TextStyle(color: Colors.white),),
                                      SizedBox(width: 30,),
                                      Text("Content",style: TextStyle(color: Colors.white),),
                                    ],
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Vehicle Detail",style: TextStyle(color: Colors.white),),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      VehicleDetailsCard(),
                    ],
                  ),
                )


              ],
            ),
            // Others Items
            ExpansionTileCard(
              key: cardQuotationsTransposation,
              initiallyExpanded: true,
              title: Text("Quotations",style: TextStyle(
                color: Colors.black,
                fontFamily: 'Poppins',
                fontSize: 16,
                fontWeight: FontWeight.w500
            )),
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 8.0,right: 8.0,bottom: 8.0),
                  child: Column(
                    children: [
                      Container(
                        color: Color(0xffE47273),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Sr.no",style: TextStyle(color: Colors.white),),
                                      SizedBox(width: 30,),
                                      Text("Charges",style: TextStyle(color: Colors.white),),
                                    ],
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Amount",style: TextStyle(color: Colors.white),),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      QuotationCard(),
                      Container(
                        color: Color(0xffFFE4E5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(),
                            Padding(
                              padding: const EdgeInsets.only(top:8.0,right: 8.0,bottom: 8.0),
                              child: Row(
                                children: [
                                  Text("Total",style: TextStyle(fontWeight: FontWeight.bold),),
                                  SizedBox(width: 15,),
                                  Text('₹${sum.toString()}',style: TextStyle(fontWeight: FontWeight.bold),)
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )

              ],
            ),

            Divider(thickness: 2,),
            ///GST

            // Padding(
            //   padding: const EdgeInsets.only(right: 16.0,left: 16.0,bottom: 16.0,top: 16.0),
            //   child: Container(
            //       child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //         children: [
            //           Text("GST Number",
            //               style: TextStyle(fontFamily: 'Poppins',
            //                   fontSize: 16,
            //                   fontWeight: FontWeight.w500)),
            //           Text(gstNumber.toString(),
            //               style: TextStyle(fontFamily: 'Poppins',
            //                   fontSize: 16,
            //                   fontWeight: FontWeight.w500)),
            //         ],
            //       )
            //   ),
            // ),

            // Divider(thickness: 2,),

            ///Quotations
            ExpansionTileCard(
              initiallyExpanded: true,
              key: cardQuotations,
              title: Text("Quotation",
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Poppins',
                      fontSize: 16,
                      fontWeight: FontWeight.w500
                  )),
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 12.0,left: 12.0, bottom: 8.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Quotation Charges"),
                          Text('₹${sum.toString()}',style: TextStyle(fontWeight: FontWeight.bold),),
                        ],
                      ),
                      SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Professional Charges"),
                          Text('₹${commission.toString()}',style: TextStyle(fontWeight: FontWeight.bold),),
                        ],
                      ),
                      SizedBox(height: 10,),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("CGST "),
                          Text('${widget.cgstController.text.toString()} ₹',style: TextStyle(fontWeight: FontWeight.bold),),
                        ],
                      ),
                      SizedBox(height: 10,),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("SGST "),
                          Text('${widget.sgstController.text.toString()} ₹',style: TextStyle(fontWeight: FontWeight.bold),),
                        ],
                      ),
                      SizedBox(height: 10,),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("IGST "),
                          Text('${widget.igstController.text.toString()} ₹',style: TextStyle(fontWeight: FontWeight.bold),),
                        ],
                      ),

                      Divider(
                        thickness: 1.5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Total",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Poppins',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500
                              )),
                          Text(totalQuotation.toString(),
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Poppins',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500
                              )),
                        ],
                      ),
                    ],
                  ),
                )


              ],
            ),

            ExpansionTileCard(
              key: cardTermsConditionsTransposation,
              initiallyExpanded: true,
              title: Text("Terms and Conditions",
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Poppins',
                    fontSize: 16,
                    fontWeight: FontWeight.w500
                )),
              children: <Widget>[
                Row(
                  children: [
                    Checkbox(
                      value: this.value,
                      activeColor: Colors.red,
                      onChanged: (value) {
                        setState(() {
                          this.value = value!;
                        });
                      },
                    ),
                    const Text("I agree to the terms and conditions.",
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Poppins',
                            fontSize: 14,
                            fontWeight: FontWeight.w400))
                  ],
                )

              ],
            ),
          ],
        ),
      ),
    );
  }
}
