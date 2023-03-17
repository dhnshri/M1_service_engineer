import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:service_engineer/Bloc/home/home_bloc.dart';
import 'package:service_engineer/Bloc/home/home_event.dart';
import 'package:service_engineer/Bloc/home/home_state.dart';
import 'package:service_engineer/Bloc/quotationReply/quotationReply_bloc.dart';
import 'package:service_engineer/Bloc/quotationReply/quotationReply_event.dart';
import 'package:service_engineer/Bloc/quotationReply/quotationReply_state.dart';
import 'package:service_engineer/Config/font.dart';
import 'package:service_engineer/Constant/theme_colors.dart';
import 'package:service_engineer/Model/cart_list_repo.dart';
import 'package:service_engineer/Model/item_not_available_model.dart';
import 'package:service_engineer/Model/product_model.dart';
import 'package:service_engineer/Model/product_repo.dart';
import 'package:service_engineer/Model/quotation_reply_detail_repo.dart';
import 'package:service_engineer/Model/service_request_detail_repo.dart';
import 'package:service_engineer/Screen/MachineMaintenance/MakeQuotations/preview.dart';
import 'package:service_engineer/Screen/MachineMaintenance/MakeQuotations/service_charges.dart';
import 'package:service_engineer/Screen/MachineMaintenance/Quotations/ReviceQuotations/revice_preview.dart';
import 'package:service_engineer/Screen/bottom_navbar.dart';
import 'package:service_engineer/Utils/application.dart';
import 'package:service_engineer/Widget/app_button.dart';
import 'package:service_engineer/Widget/custom_snackbar.dart';
import 'package:service_engineer/Widget/stepper_button.dart';
import 'package:service_engineer/app.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter/src/material/date_picker.dart';


class MachineRevisedQuotationScreen extends StatefulWidget {
  List<QuotationRequiredItems>? quotationRequiredItemList;
  List<QuotationRequiredItems>? quotationOtherItemList;
  List<QuotationCharges>? quotationChargesList;
  MachineRevisedQuotationScreen({Key? key,required this.quotationRequiredItemList,required this.quotationOtherItemList, required this.quotationChargesList}) : super(key: key);

  @override
  _MachineRevisedQuotationScreenState createState() => _MachineRevisedQuotationScreenState();
}

class _MachineRevisedQuotationScreenState extends State<MachineRevisedQuotationScreen> {
  int _currentStep = 0;
  bool loading = true;
  final _formKey = GlobalKey<FormState>();
  bool isCompleted = false;
  String? workingTimeValue;
  String? dataOfJoiningValue;
  String? serviceChargesValue;
  String? handlingChargesValue;
  String? otherChargesValue;
  String? transportChargesValue;
  ValueNotifier<bool> isDialOpen = ValueNotifier(false);
  bool serviceValue = false;
  bool handlingValue = false;
  bool otherValue = false;
  bool transportValue = false;
  TextEditingController workingTimeController = TextEditingController();
  TextEditingController dateofJoiningController = TextEditingController();
  TextEditingController serviceCallChargesController = TextEditingController();
  TextEditingController handlingChargesController = TextEditingController();
  TextEditingController otherChargesController = TextEditingController();
  TextEditingController transportChargesController = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  final TextEditingController _srNumberController = TextEditingController();
  final TextEditingController _itemNameController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _rateController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _gstController = TextEditingController();

  DateTime selectedDate = DateTime.now();

  var quantity = 0;
  var totalValue = 0;
  int prodValue = 15000;

  bool _cartLoading = true;
  bool _isLoading = false;

  QuotationReplyBloc? _quotationBloc;
  List<ProductDetails>? productDetail = [];
  List<CartListModel>? cartList=[];


  Future<Null> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        // initialDate: selectedDate,
        initialDate: selectedDate == null ? DateTime.now() : selectedDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime.now(),
        lastDate: DateTime(2101));
    if (picked != null)
      setState(() {
        selectedDate = picked;
        if (selectedDate != null) {
          dateofJoiningController.text =
              DateFormat.yMd('es').format(selectedDate);
        }
      });
  }

  var mainHeight, mainWidth;

  int itemNo = 0;
  List<ItemNotAvailableModel> itemNotAvailabeList = List.empty(growable: true);
  List<ItemNotAvailableModel> itemList = List.empty(growable: true);

  onAdd() {
    setState(() {
      ItemNotAvailableModel _contactModel = ItemNotAvailableModel(id: itemNotAvailabeList.length);

      double amount = int.parse(_rateController.text) * 100/100+int.parse(_gstController.text);

      double amountWithGST = amount *
          int.parse(_quantityController.text);

      itemNotAvailabeList.add(ItemNotAvailableModel(
          id: itemNotAvailabeList.length,
          itemName: _itemNameController.text,
          quantity: _quantityController.text,
          amount: amountWithGST.toString(),
          rate: _rateController.text,
          gst: _gstController.text
      ));
    });
  }

  // Widget buildItemRequiredList() {
  //   return ListView.builder(
  //     shrinkWrap: true,
  //     physics: NeverScrollableScrollPhysics(),
  //     scrollDirection: Axis.vertical,
  //     itemCount: itemNotAvailabeList.length,
  //     padding: EdgeInsets.only(top: 0, bottom: 1),
  //     itemBuilder: (context, index) {
  //       return  Padding(
  //           padding: const EdgeInsets.only(bottom:0.0),
  //           child: Container(
  //             // color: Color(0xffFFE4E5),
  //               decoration: BoxDecoration(
  //                 color: Color(0xffFFE4E5),
  //               ),
  //               child:Padding(
  //                 padding: const EdgeInsets.all(8.0),
  //                 child: Row(
  //
  //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                   children: [
  //                     Column(
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       children: [
  //                         Text(itemNotAvailabeList[index].id.toString())
  //                       ],
  //                     ),
  //                     Column(
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       children: [
  //                         Text(itemNotAvailabeList[index].itemName.toString())
  //                       ],
  //                     ),
  //                     Column(
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       children: [
  //                         Text(itemNotAvailabeList[index].quantity.toString())
  //                       ],
  //                     ),
  //                     Column(
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       children: [
  //                         Text("₹ ${itemNotAvailabeList[index].rate.toString()}")
  //                       ],
  //                     ),
  //                     // Column(
  //                     //   crossAxisAlignment: CrossAxisAlignment.start,
  //                     //   children: [
  //                     //     Text("₹ ${itemNotAvailabeList[index].amount.toString()}")
  //                     //   ],
  //                     // ),
  //                   ],
  //                 ),
  //               )
  //           )
  //       );
  //     },
  //
  //   );
  // }


  DataRow _buildItemRequiredList(ItemNotAvailableModel? itemNotAvailabeList,index) {
    return DataRow(
      color: MaterialStateColor.resolveWith((states) {
        return Color(0xffFFE4E5); //make tha magic!
      }),
      cells: <DataCell>[
        DataCell(Text(itemNotAvailabeList!.id.toString())),
        DataCell(Text(itemNotAvailabeList.itemName.toString())),
        DataCell(Text(itemNotAvailabeList.quantity.toString())),
        DataCell(Text('₹${itemNotAvailabeList.rate.toString()}')),
        // DataCell(Text('₹${amount.toString()}')),
      ],
    );
  }



  ///Item Required Widget
  Widget ItemRequired(BuildContext context) {
    mainHeight = MediaQuery.of(context).size.height;
    mainWidth = MediaQuery.of(context).size.width;
    return Column(
      children: [
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: [
        //     Row(
        //       children: [
        //         Icon(Icons.search),
        //         SizedBox(width: 5,),
        //         Text("Search all Orders")
        //       ],
        //     ),
        //
        //     InkWell(
        //       onTap: ()
        //       {
        //         Navigator.push(context,
        //             MaterialPageRoute(builder: (context) => ItemRequiredFilterScreen()));
        //       },
        //       child: Row(
        //         children: [
        //           Icon(Icons.filter_list),
        //           SizedBox(width: 5,),
        //           Text("Filter")
        //         ],
        //       ),
        //     )
        //
        //   ],
        // ),
        Container(
          // height: 350,
          child:SingleChildScrollView(
            child: ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemCount: widget.quotationRequiredItemList!.length,
              padding: EdgeInsets.only(top: 10, bottom: 15),
              itemBuilder: (context, index) {
                return  Padding(
                    padding: const EdgeInsets.only(bottom:8.0),
                    child: Card(
                        elevation: 1,
                        child: ListTile(
                          leading: CachedNetworkImage(
                            filterQuality: FilterQuality.medium,
                            // imageUrl: Api.PHOTO_URL + widget.users.avatar,
                            // imageUrl: "https://picsum.photos/250?image=9",
                            imageUrl: widget.quotationRequiredItemList![index].prodImg.toString(),
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
                          title: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(widget.quotationRequiredItemList![index].itemName.toString(),style:itemRequiredCardHeading,),
                                        // Text("ID: ${widget.quotationRequiredItemList![index].id.toString()}",style: itemRequiredCardSubtitle),
                                        Text("₹ ${widget.quotationRequiredItemList![index].rate.toString()}",style:itemRequiredCardSubtitle),
                                      ],

                                    ),

                                    Flexible(
                                      child: Container(
                                        height: 40,
                                        // width: 110,
                                        width: MediaQuery.of(context).size.width*0.266,
                                        decoration: BoxDecoration(
                                          border: Border.all(color: Colors.black),
                                          borderRadius: BorderRadius.all(Radius.circular(30)),
                                        ),
                                        child: Row(
                                          children: [
                                            widget.quotationRequiredItemList![index].itemQty != 0?
                                            IconButton(
                                              icon: Icon(
                                                Icons.remove_circle,
                                                color: Colors.grey,
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  if (widget.quotationRequiredItemList![index].itemQty! > 0) {
                                                    widget.quotationRequiredItemList![index].itemQty = widget.quotationRequiredItemList![index].itemQty! - 1;
                                                    // _quotationBloc!.add(AddToCart(prodId: productList[index].id.toString(),userId: Application.customerLogin!.id.toString(),quantity: productList[index].cartQuantity.toString()));
                                                    // loadApi();
                                                    itemList[index].quantity = widget.quotationRequiredItemList![index].itemQty.toString();
                                                    print(itemList);

                                                  }
                                                });
                                              },
                                            ):Padding(
                                              padding: const EdgeInsets.only(left:20.0),
                                              child: const Text('Add',style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: 'Poppins-Medium'
                                              )),
                                            ),
                                            widget.quotationRequiredItemList![index].itemQty != 0 ?
                                            Text(
                                              widget.quotationRequiredItemList![index].itemQty.toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 18),
                                            ): SizedBox(),
                                            Expanded(
                                              child: IconButton(
                                                onPressed: () {
                                                  setState(() {

                                                    if(widget.quotationRequiredItemList![index].itemQty! <= widget.quotationRequiredItemList![index].productQty!){
                                                      if( widget.quotationRequiredItemList![index].productQty! > 0){
                                                        widget.quotationRequiredItemList![index].itemQty = widget.quotationRequiredItemList![index].itemQty! + 1;
                                                        itemList[index].quantity = widget.quotationRequiredItemList![index].itemQty.toString();

                                                      }else{
                                                        showCustomSnackBar(context,'Quantity is not available.',isError: true);
                                                      }

                                                    }else{
                                                      showCustomSnackBar(context,'Quantity is not available.',isError: true);
                                                    }
                                                  });
                                                },
                                                icon: Icon(
                                                  Icons.add_circle,
                                                  color: ThemeColors.baseThemeColor,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),

                                      ),
                                    )
                                  ],
                                ),
                              ]
                          ),
                        )));
              },
            ),
          ),
        ),
        SizedBox(height: 15,),
        itemNotAvailabeList.length <= 0? Container():
        Align(
            alignment: Alignment.topLeft,
            child: Text("Add Items not available in list here.",style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins-Medium'
            ),)),
        SizedBox(height: 5,),
        itemNotAvailabeList.length <= 0? Container():

        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DataTable(
              headingRowHeight: 40,
              headingRowColor: MaterialStateColor.resolveWith(
                      (states) => Color(0xffE47273)),
              columnSpacing: 15.0,
              columns: const [
                DataColumn(
                  label: Expanded(child: Text('S no')),
                ),
                DataColumn(
                  label: Text('Item Name'),
                ),
                DataColumn(
                  label: Text('QTY'),
                ),
                DataColumn(
                  label: Text('Rate'),
                ),
              ],
              rows: List.generate(itemNotAvailabeList.length, (index) {
                return _buildItemRequiredList(itemNotAvailabeList[index],index);
              }),
            ),
          ],
        ),

        SizedBox(height: 7,),
        SizedBox(width: 5,),
        InkWell(
          onTap: (){
            //AddOtherCharges();
            AddItemNotAvailable(context);

          },
          child:  Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(),
              ///Add More
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(itemNotAvailabeList.length <= 0? "Add Items":"Add More",
                    style: TextStyle(fontFamily: 'Poppins-SemiBold', fontSize: 14,fontWeight: FontWeight.w600,color: Colors.black),
                    textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(width: 5,),
                  InkWell(
                    onTap: (){
                      // AddOtherCharges();
                      AddItemNotAvailable(context);
                    },
                    child: CircleAvatar(
                      backgroundColor: ThemeColors.redTextColor,
                      child: Icon(Icons.add,color: Colors.white,),
                    ),
                  )
                ],
              ),

            ],
          ),

        )
      ],
    );
  }


  ///Item which are added manualy widget
  AddItemNotAvailable(BuildContext context) {
    return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          return Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Wrap(
              alignment: WrapAlignment.center,
              children: [
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: SizedBox(
                    width:
                    MediaQuery.of(context).size.width * 0.8,
                    height: 60,
                    child: TextFormField(
                      controller: _itemNameController,
                      keyboardType: TextInputType.text,
                      maxLength: 10,
                      cursorColor: primaryAppColor,
                      decoration: InputDecoration(
                        disabledBorder: OutlineInputBorder(
                          borderRadius:
                          BorderRadius.circular(8.0),
                          borderSide: const BorderSide(
                            color: Colors.black,
                            width: 1.0,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius:
                          BorderRadius.circular(8.0),
                          borderSide: const BorderSide(
                            color: Colors.red,
                            width: 1.0,
                          ),
                        ),
                        fillColor: Colors.white,
                        filled: true,
                        focusedBorder: OutlineInputBorder(
                          borderRadius:
                          BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                              color: Colors.black, width: 1.0),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                            borderRadius:
                            BorderRadius.circular(8.0),
                            borderSide: const BorderSide(
                              color: Colors.black,
                              width: 1.0,
                            )),
                        enabledBorder: OutlineInputBorder(
                          borderRadius:
                          BorderRadius.circular(8.0),
                          borderSide: const BorderSide(
                            color: Colors.black,
                            width: 1.0,
                          ),
                        ),
                        hintText: 'Item Name',
                        contentPadding: const EdgeInsets.fromLTRB(
                            20.0, 20.0, 0.0, 0.0),
                        hintStyle: GoogleFonts.poppins(
                            color: Colors.grey,
                            fontSize: 12.0,
                            fontWeight: FontWeight.w500),
                      ),
                      onChanged: (val) {
                        setState(() {
                          if ( _formKey.currentState!.validate()) {}
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(
                  width:
                  MediaQuery.of(context).size.width * 0.8,
                  height: 60,
                  child: TextFormField(
                    controller: _quantityController,
                    keyboardType: TextInputType.number,
                    maxLength: 10,
                    cursorColor: primaryAppColor,
                    decoration: InputDecoration(
                      disabledBorder: OutlineInputBorder(
                        borderRadius:
                        BorderRadius.circular(8.0),
                        borderSide: const BorderSide(
                          color: Colors.black,
                          width: 1.0,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius:
                        BorderRadius.circular(8.0),
                        borderSide: const BorderSide(
                          color: Colors.red,
                          width: 1.0,
                        ),
                      ),
                      fillColor: Colors.white,
                      filled: true,
                      focusedBorder: OutlineInputBorder(
                        borderRadius:
                        BorderRadius.circular(10.0),
                        borderSide: const BorderSide(
                            color: Colors.black, width: 1.0),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                          borderRadius:
                          BorderRadius.circular(8.0),
                          borderSide: const BorderSide(
                            color: Colors.black,
                            width: 1.0,
                          )),
                      enabledBorder: OutlineInputBorder(
                        borderRadius:
                        BorderRadius.circular(8.0),
                        borderSide: const BorderSide(
                          color: Colors.black,
                          width: 1.0,
                        ),
                      ),
                      hintText: 'Quantity',
                      contentPadding: const EdgeInsets.fromLTRB(
                          20.0, 20.0, 0.0, 0.0),
                      hintStyle: GoogleFonts.poppins(
                          color: Colors.grey,
                          fontSize: 12.0,
                          fontWeight: FontWeight.w500),
                    ),
                    onChanged: (val) {
                      setState(() {
                        if ( _formKey.currentState!.validate()) {}
                      });
                    },
                  ),
                ),
                SizedBox(
                  width:
                  MediaQuery.of(context).size.width * 0.8,
                  height: 60,
                  child: TextFormField(
                    controller: _rateController,
                    keyboardType: TextInputType.number,
                    maxLength: 10,
                    cursorColor: primaryAppColor,
                    decoration: InputDecoration(
                      disabledBorder: OutlineInputBorder(
                        borderRadius:
                        BorderRadius.circular(8.0),
                        borderSide: const BorderSide(
                          color: Colors.black,
                          width: 1.0,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius:
                        BorderRadius.circular(8.0),
                        borderSide: const BorderSide(
                          color: Colors.red,
                          width: 1.0,
                        ),
                      ),
                      fillColor: Colors.white,
                      filled: true,
                      focusedBorder: OutlineInputBorder(
                        borderRadius:
                        BorderRadius.circular(10.0),
                        borderSide: const BorderSide(
                            color: Colors.black, width: 1.0),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                          borderRadius:
                          BorderRadius.circular(8.0),
                          borderSide: const BorderSide(
                            color: Colors.black,
                            width: 1.0,
                          )),
                      enabledBorder: OutlineInputBorder(
                        borderRadius:
                        BorderRadius.circular(8.0),
                        borderSide: const BorderSide(
                          color: Colors.black,
                          width: 1.0,
                        ),
                      ),
                      hintText: 'Rate',
                      contentPadding: const EdgeInsets.fromLTRB(
                          20.0, 20.0, 0.0, 0.0),
                      hintStyle: GoogleFonts.poppins(
                          color: Colors.grey,
                          fontSize: 12.0,
                          fontWeight: FontWeight.w500),
                    ),
                    onChanged: (val) {
                      setState(() {
                        if ( _formKey.currentState!.validate()) {}
                      });
                    },
                  ),
                ),
                SizedBox(
                  width:
                  MediaQuery.of(context).size.width * 0.8,
                  height: 60,
                  child: TextFormField(
                    controller: _gstController,
                    keyboardType: TextInputType.number,
                    // maxLength: 10,
                    cursorColor: primaryAppColor,
                    decoration: InputDecoration(
                      disabledBorder: OutlineInputBorder(
                        borderRadius:
                        BorderRadius.circular(8.0),
                        borderSide: const BorderSide(
                          color: Colors.black,
                          width: 1.0,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius:
                        BorderRadius.circular(8.0),
                        borderSide: const BorderSide(
                          color: Colors.red,
                          width: 1.0,
                        ),
                      ),
                      fillColor: Colors.white,
                      filled: true,
                      focusedBorder: OutlineInputBorder(
                        borderRadius:
                        BorderRadius.circular(10.0),
                        borderSide: const BorderSide(
                            color: Colors.black, width: 1.0),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                          borderRadius:
                          BorderRadius.circular(8.0),
                          borderSide: const BorderSide(
                            color: Colors.black,
                            width: 1.0,
                          )),
                      enabledBorder: OutlineInputBorder(
                        borderRadius:
                        BorderRadius.circular(8.0),
                        borderSide: const BorderSide(
                          color: Colors.black,
                          width: 1.0,
                        ),
                      ),
                      hintText: 'Add GST',
                      contentPadding: const EdgeInsets.fromLTRB(
                          20.0, 20.0, 0.0, 0.0),
                      hintStyle: GoogleFonts.poppins(
                          color: Colors.grey,
                          fontSize: 12.0,
                          fontWeight: FontWeight.w500),
                    ),
                    onChanged: (val) {
                      setState(() {
                        if ( _formKey.currentState!.validate()) {}
                      });
                    },
                  ),
                ),

                Padding(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 40.0),
                    child: AppButton(
                      onPressed: () async {
                        onAdd();
                        print(itemNotAvailabeList);
                        _itemNameController.clear();
                        _rateController.clear();
                        _gstController.clear();
                        _quantityController.clear();
                        Navigator.of(context).pop();
                        showCustomSnackBar(context,'Item Added Successfully',isError: false);

                      },
                      shape: const RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.all(Radius.circular(50))),
                      text: 'Add Product',
                      loading: loading,


                    )
                ),

              ],
            ),
          );

        });
  }




  List<Step> stepList() => [
    Step(
      state: _currentStep <= 0 ? StepState.editing : StepState.complete,
      // state: _currentStep <= 0 ? Icon(Icons.circle): StepState.complete,
      isActive: _currentStep >= 0,
      title: Text(
        'Service Charges',
        style: StepperHeadingStyle,
      ),
      content: ServiceCharges(context),
    ),
    Step(
      state: _currentStep <= 1 ? StepState.editing : StepState.complete,
      isActive: _currentStep >= 1,
      title: Text(
        'Item Required',
        style: StepperHeadingStyle,
      ),
      content: ItemRequired(context),
      // ItemRequired(context),
    ),
    ///Preview
    Step(
      state: StepState.complete,
      isActive: _currentStep >= 2,
      title: Text(
        'Preview',
        style: StepperHeadingStyle,
      ),
      content: RevisedQuotationPreviewScreen(cartList: itemList,itemNotAvailableList: itemNotAvailabeList,
          workingTimeController: workingTimeController,
          dateofJoiningController: dateofJoiningController,
          serviceCallChargesController: serviceCallChargesController,
          transportChargesController: transportChargesController,
          otherChargesController: otherChargesController,
          handlingChargesController: handlingChargesController),
    ),
  ];

  int total=0;
  @override
  void initState() {
    // TODO: implement initState
    //saveDeviceTokenAndId();
    super.initState();
    _quotationBloc = BlocProvider.of<QuotationReplyBloc>(this.context);
    selectedDate;
    getData();
  }

  getData(){
    workingTimeController.text = widget.quotationRequiredItemList![0].workingTime.toString();
    serviceCallChargesController.text = widget.quotationChargesList![0].serviceCharge.toString();
    handlingChargesController.text = widget.quotationChargesList![0].handlingCharge.toString();
    transportChargesController.text = widget.quotationChargesList![0].transportCharge.toString();
    int itemIndex = 0;
    for(int i = 0; i < widget.quotationOtherItemList!.length ; i++) {
      itemIndex = itemIndex + 1;
      itemNotAvailabeList.add(ItemNotAvailableModel(
          id: i, itemName: widget.quotationOtherItemList![i].itemName,rate: widget.quotationOtherItemList![i].rate.toString(),
          quantity: widget.quotationOtherItemList![i].itemQty.toString(),gst: widget.quotationOtherItemList![i].gst.toString(),
          amount: widget.quotationOtherItemList![i].amount.toString()));
    }
    for(int i = 0; i < widget.quotationRequiredItemList!.length ; i++) {
      itemList.add(ItemNotAvailableModel(
          id: widget.quotationRequiredItemList![i].id, itemName: widget.quotationRequiredItemList![i].itemName,rate: widget.quotationRequiredItemList![i].rate.toString(),
          quantity: widget.quotationRequiredItemList![i].itemQty.toString(),gst: widget.quotationRequiredItemList![i].gst.toString(),
          amount: widget.quotationRequiredItemList![i].amount.toString()));
      cartList!.add(CartListModel());
    }
  }



  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _rateController.dispose();
    _quantityController.dispose();
    _amountController.dispose();
    _itemNameController.dispose();
    _gstController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            leading: InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (context) => ServiceRequestDetailsScreen()));
                },
                child: Icon(Icons.arrow_back_ios)),
            title: Text(
              'Quotation for #102GRDSA36987',
              style: appBarheadingStyle,
            ),
          ),
          body: BlocBuilder<QuotationReplyBloc, QuotationReplyState>(builder: (context, state) {
            return BlocListener<QuotationReplyBloc, QuotationReplyState>(
              listener: (context, state) {
                if(state is MacineSendQuotationReplySuccess){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BottomNavigation(
                            index: 0,
                            dropValue: Application.customerLogin!.role.toString(),
                          )));
                  showCustomSnackBar(context,state.message,isError: false);
                }
                if(state is MachineSendQuotationReplyFail){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BottomNavigation(
                            index: 0,
                            dropValue: Application.customerLogin!.role.toString(),
                          )));
                  showCustomSnackBar(context,state.msg.toString(),isError: false);
                }
              },
              child: isCompleted
                  ? AlertDialog(
                title:
                new Text("Are you sure, you want to send this quotation ?"),
                // content: new Text(""),
                actions: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                          child: new Text(
                            "No",
                            style: TextStyle(color: Colors.black),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          style: TextButton.styleFrom(
                              side: BorderSide(
                                  color: ThemeColors.defaultbuttonColor,
                                  width: 1.5))),
                      SizedBox(
                        width: 7,
                      ),
                      TextButton(
                        child: new Text(
                          "Yes",
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          if(workingTimeController.text == ""){
                            showCustomSnackBar(context,'Please add working time.',isError: true);
                          }else {
                            _quotationBloc!.add(MachineSendQuotationReply(
                                serviceUserId: Application.customerLogin!.id
                                    .toString(),
                                workingTime: workingTimeController.text,
                                dateOfJoining: DateTime.now().toString(),
                                serviceCharge: serviceCallChargesController
                                    .text,
                                handlingCharge: handlingChargesController.text,
                                transportCharge: transportChargesController
                                    .text,
                                itemList: itemList,
                                itemNotAvailableList: itemNotAvailabeList,
                                commission: '10',
                                // machineEnquiryDate: widget.serviceRequestData!.createdAt.toString(),
                                machineEnquiryDate: DateTime.parse(
                                    widget.quotationRequiredItemList![0].dateAndTime
                                        .toString()).toString(),
                                machineEnquiryId: widget.quotationRequiredItemList![0].machineEnquiryId!
                                    .toInt()
                            ));
                          }
                        },
                        style: TextButton.styleFrom(
                            backgroundColor: ThemeColors.defaultbuttonColor),
                      ),
                    ],
                  ),
                ],
              )
                  : Stepper(
                physics: ScrollPhysics(),
                type: StepperType.horizontal,
                currentStep: _currentStep,
                steps: stepList(),
                controlsBuilder:
                    (BuildContext context, ControlsDetails controls) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        if (_currentStep != 0)
                          StepperButton(
                            onPressed: () async {
                              if (_currentStep == 0) {
                                return;
                              }

                              setState(() {
                                _currentStep -= 1;
                              });
                            },
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(50))),
                            text: 'Back',
                            loading: loading,
                          ),
                        StepperButton(
                          onPressed: () async {
                            final isLastStep =
                                _currentStep == stepList().length - 1;
                            if(_currentStep == 0){
                              if(workingTimeController.text == ""){
                                showCustomSnackBar(context,'Please add working time.',isError: true);
                              }
                            }
                            if (isLastStep) {
                              setState(() {
                                isCompleted = true;
                              });
                            } else {
                              setState(() {
                                _currentStep += 1;
                              });
                            }
                          },
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(50))),
                          text: 'Next',
                          loading: loading,
                        ),
                      ],
                    ),
                  );
                },
              ),

            );


          })

      ),
    );
  }

  ///Service Charges
  Widget ServiceCharges(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Working Time',style: TextStyle(
              color: Colors.black,
              fontFamily: 'Poppins-Medium',
              fontSize: 16,
              fontWeight: FontWeight.w400
          )),
          SizedBox(height: 5,),
          ///Working Time Field
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            height: 60,
            child: TextFormField(
              controller: workingTimeController,
              keyboardType: TextInputType.number,
              // maxLength: 10,
              cursorColor: primaryAppColor,
              decoration: InputDecoration(
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(
                    color: Colors.white,
                    width: 1.0,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(
                    color: Colors.red,
                    width: 1.0,
                  ),
                ),
                fillColor: Color(0xffF5F5F5),
                filled: true,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(color: Colors.white, width: 1.0),
                ),
                focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(
                      color: Colors.white,
                      width: 1.0,
                    )),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(
                    color: Colors.white,
                    width: 1.0,
                  ),
                ),
                hintText: 'Working Time',
                contentPadding: const EdgeInsets.fromLTRB(20.0, 20.0, 0.0, 0.0),
                hintStyle: GoogleFonts.poppins(
                    color: Colors.grey,
                    fontSize: 12.0,
                    fontWeight: FontWeight.w500),
              ),
              onChanged: (val) {
                setState(() {
                  workingTimeValue = val;
                  // _phoneNumberController.text = val;
                });
              },
            ),
          ),

          Text('Service/Call Charges',style: TextStyle(
              color: Colors.black,
              fontFamily: 'Poppins-Medium',
              fontSize: 16,
              fontWeight: FontWeight.w400
          )),
          SizedBox(height: 5,),

          ///Service/Call Charges Field
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            height: 60,
            child: TextFormField(
              controller: serviceCallChargesController,
              keyboardType: TextInputType.number,
              // maxLength: 10,
              cursorColor: primaryAppColor,
              decoration: InputDecoration(
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(
                    color: Colors.white,
                    width: 1.0,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(
                    color: Colors.red,
                    width: 1.0,
                  ),
                ),
                fillColor: Color(0xffF5F5F5),
                filled: true,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(
                      color: Colors.white, width: 1.0),
                ),
                focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(
                      color: Colors.white,
                      width: 1.0,
                    )),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(
                    color: Colors.white,
                    width: 1.0,
                  ),
                ),
                hintText: 'Service/Call Charges',
                contentPadding:
                const EdgeInsets.fromLTRB(20.0, 20.0, 0.0, 0.0),
                hintStyle: GoogleFonts.poppins(
                    color: Colors.grey,
                    fontSize: 12.0,
                    fontWeight: FontWeight.w500),
              ),
              onChanged: (val) {
                setState(() {
                  serviceChargesValue = val;
                  // _phoneNumberController.text = val;
                });
              },
            ),
          ),

          Text('Handling Charges',style: TextStyle(
              color: Colors.black,
              fontFamily: 'Poppins-Medium',
              fontSize: 16,
              fontWeight: FontWeight.w400
          )),
          SizedBox(height: 5,),

          ///Handling Charges Field
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            height: 60,
            child: TextFormField(
              controller: handlingChargesController,
              keyboardType: TextInputType.number,
              // maxLength: 10,
              cursorColor: primaryAppColor,
              decoration: InputDecoration(
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(
                    color: Colors.white,
                    width: 1.0,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(
                    color: Colors.red,
                    width: 1.0,
                  ),
                ),
                fillColor: Color(0xffF5F5F5),
                filled: true,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(
                      color: Colors.white, width: 1.0),
                ),
                focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(
                      color: Colors.white,
                      width: 1.0,
                    )),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(
                    color: Colors.white,
                    width: 1.0,
                  ),
                ),
                hintText: 'Handling Charges',
                contentPadding:
                const EdgeInsets.fromLTRB(20.0, 20.0, 0.0, 0.0),
                hintStyle: GoogleFonts.poppins(
                    color: Colors.grey,
                    fontSize: 12.0,
                    fontWeight: FontWeight.w500),
              ),
              onChanged: (val) {
                setState(() {
                  handlingChargesValue = val;
                  // _phoneNumberController.text = val;
                });
              },
            ),
          ),

          Text('Transport Charges',style: TextStyle(
              color: Colors.black,
              fontFamily: 'Poppins-Medium',
              fontSize: 16,
              fontWeight: FontWeight.w400
          )),
          SizedBox(height: 5,),

          ///Transport Charges Field
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            height: 60,
            child: TextFormField(
              controller: transportChargesController,
              keyboardType: TextInputType.number,
              // maxLength: 10,
              cursorColor: primaryAppColor,
              decoration: InputDecoration(
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(
                    color: Colors.white,
                    width: 1.0,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(
                    color: Colors.red,
                    width: 1.0,
                  ),
                ),
                fillColor: Color(0xffF5F5F5),
                filled: true,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(
                      color: Colors.white, width: 1.0),
                ),
                focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(
                      color: Colors.white,
                      width: 1.0,
                    )),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(
                    color: Colors.white,
                    width: 1.0,
                  ),
                ),
                hintText: 'Transport Charges',
                contentPadding:
                const EdgeInsets.fromLTRB(20.0, 20.0, 0.0, 0.0),
                hintStyle: GoogleFonts.poppins(
                    color: Colors.grey,
                    fontSize: 12.0,
                    fontWeight: FontWeight.w500),
              ),
              onChanged: (val) {
                setState(() {
                  transportChargesValue = val;
                  // _phoneNumberController.text = val;
                });
              },
            ),
          ),

          SizedBox(
            height: 20,
          ),

        ],
      ),
    );
  }


}





