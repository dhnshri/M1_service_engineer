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
import 'package:service_engineer/Model/product_model.dart';
import 'package:service_engineer/Model/product_repo.dart';
import 'package:service_engineer/Screen/MachineMaintenance/MakeQuotations/preview.dart';
import 'package:service_engineer/Screen/MachineMaintenance/MakeQuotations/service_charges.dart';
import 'package:service_engineer/Utils/application.dart';
import 'package:service_engineer/Widget/custom_snackbar.dart';
import 'package:service_engineer/app.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter/src/material/date_picker.dart';
import '../../../Config/font.dart';
import '../../../Constant/theme_colors.dart';
import '../../../Model/item_not_available_model.dart';
import '../../../Widget/app_button.dart';
import '../../../Widget/common.dart';
import '../../../Widget/function_button.dart';
import '../../../Widget/stepper_button.dart';
import '../../bottom_navbar.dart';
import '../ServiceRequest/serviceRequestDetails.dart';
import 'item_required.dart';
import 'item_required_filter.dart';

class MakeQuotationScreen extends StatefulWidget {
  const MakeQuotationScreen({Key? key}) : super(key: key);

  @override
  _MakeQuotationScreenState createState() => _MakeQuotationScreenState();
}

class _MakeQuotationScreenState extends State<MakeQuotationScreen> {
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

  DateTime selectedDate = DateTime.now();

  var quantity = 0;
  var totalValue = 0;
  int prodValue = 15000;

  bool _cartLoading = true;
  bool _isLoading = false;

  HomeBloc? _homeBloc;
  List<ProductDetails>? productDetail = [];
  var productQuantity = new Map<int, int>();



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

  onAdd() {
    setState(() {
      ItemNotAvailableModel _contactModel = ItemNotAvailableModel(id: itemNotAvailabeList.length);
      itemNotAvailabeList.add(ItemNotAvailableModel(
        id: itemNo++,
        itemName: _itemNameController.text,
        quantity: _quantityController.text,
        amount: _amountController.text,
        rate: _rateController.text,
      ));
    });
  }

  Widget buildItemRequiredList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      itemCount: itemNotAvailabeList.length,
      padding: EdgeInsets.only(top: 0, bottom: 1),
      itemBuilder: (context, index) {
        return  Padding(
            padding: const EdgeInsets.only(bottom:0.0),
            child: Container(
              // color: Color(0xffFFE4E5),
                decoration: BoxDecoration(
                  color: Color(0xffFFE4E5),
                ),
                child:Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(

                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(itemNotAvailabeList[index].id.toString())
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(itemNotAvailabeList[index].itemName.toString())
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(itemNotAvailabeList[index].quantity.toString())
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("₹ ${itemNotAvailabeList[index].rate.toString()}")
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("₹ ${itemNotAvailabeList[index].amount.toString()}")
                        ],
                      ),
                    ],
                  ),
                )
            )
        );
      },

    );
  }



  int _itemCount = 0;

  ///Item Required Widget
  Widget ItemRequired(BuildContext context, List<ProductDetails>? productList) {
    mainHeight = MediaQuery.of(context).size.height;
    mainWidth = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(Icons.search),
                SizedBox(width: 5,),
                Text("Search all Orders")
              ],
            ),

            InkWell(
              onTap: ()
              {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ItemRequiredFilterScreen()));
              },
              child: Row(
                children: [
                  Icon(Icons.filter_list),
                  SizedBox(width: 5,),
                  Text("Filter")
                ],
              ),
            )

          ],
        ),
        _isLoading ?
        Container(
          height: 350,
          child:SingleChildScrollView(
            child: ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemCount: productList!.length,
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
                          title: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(productList[index].productName.toString(),style:itemRequiredCardHeading,),
                                        Text("ID: ${productList[index].id.toString()}",style: itemRequiredCardSubtitle),
                                        Text("₹ ${productList[index].discountPrice.toString()}",style:itemRequiredCardSubtitle),
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
                                            _itemCount != 0?
                                            IconButton(
                                              icon: Icon(
                                                Icons.remove_circle,
                                                color: Colors.grey,
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  if (quantity > 0) {
                                                    quantity--;
                                                    totalValue = prodValue * quantity;
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
                                            _itemCount != 0 ?
                                            Text(
                                              _itemCount.toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 18),
                                            ): SizedBox(),
                                            IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  // if (quantity < 10) {
                                                  //   quantity++;
                                                  //   totalValue = prodValue * quantity;
                                                  // }
                                                  _homeBloc!.add(AddToCart(prodId: productList[index].id.toString(),userId: Application.customerLogin!.id.toString(),quantity: '1'));

                                                });
                                              },
                                              icon: Icon(
                                                Icons.add_circle,
                                                color: ThemeColors.baseThemeColor,
                                              ),
                                            ),
                                          ],
                                        ),

                                      ),
                                    )
                                  ],
                                ),
                                Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(productList[index].aboutProduct.toString(),style: itemRequiredCardSubtitle)),
                              ]
                          ),
                        )));
              },
            ),
          ),
        ):Center(child: CircularProgressIndicator(),),
        SizedBox(height: 15,),
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
                    Text("S no.",style: TextStyle(color: Colors.white),),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Item Name",style: TextStyle(color: Colors.white),),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SizedBox(width: 50,),
                        Text("QTY",style: TextStyle(color: Colors.white),),
                      ],
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Rate",style: TextStyle(color: Colors.white),),
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
        buildItemRequiredList(),
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
                    controller: _amountController,
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
                      hintText: 'Amount',
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
                        _amountController.clear();
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
          content: BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
            return BlocListener<HomeBloc, HomeState>(
                listener: (context, state) {
                  if(state is ProductListLoading){
                    _isLoading = state.isLoading;
                  }
                  if(state is ProductListSuccess){
                    productDetail = state.productList;
                  }
                  if(state is ProductListFail){
                    // Fluttertoast.showToast(msg: state.msg.toString());
                  }
                  if(state is AddToCartSuccess){
                    showCustomSnackBar(context,state.message,isError: false);
                  }
                  if(state is AddToCartFail){
                    showCustomSnackBar(context,state.msg.toString(),isError: true);
                  }
                  if(state is AddToCartLoading){
                    _cartLoading = state.isLoading;
                  }
                },
                child: ItemRequired(context,productDetail),

            );


          })
          // ItemRequired(context),
        ),
        Step(
          state: StepState.complete,
          isActive: _currentStep >= 2,
          title: Text(
            'Preview',
            style: StepperHeadingStyle,
          ),
          content: PreviewScreen(),
        ),
      ];

  @override
  void initState() {
    // TODO: implement initState
    //saveDeviceTokenAndId();
    super.initState();
    _homeBloc = BlocProvider.of<HomeBloc>(this.context);
    _homeBloc!.add(ProductList(prodId: '0',offSet: '0'));

    selectedDate;
    dateofJoiningController.text = DateFormat.yMd('es').format(DateTime.now());
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
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
        body: isCompleted
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
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BottomNavigation(
                                        index: 0,
                                        dropValue: 'Machine Maintenance',
                                      )));
                        },
                        style: TextButton.styleFrom(
                            backgroundColor: ThemeColors.defaultbuttonColor),
                      ),
                    ],
                  ),
                ],
              )
            : Stepper(
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

                            print(
                                "Working Time: ${workingTimeController.text}");
                            final isLastStep =
                                _currentStep == stepList().length - 1;
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
      ),
    );
  }

  ///Service Charges
  Widget ServiceCharges(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
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

          ///Date of Joining Field
          InkWell(
            onTap: () {
              _selectDate(context);
            },
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              height: 60,
              child: Row(
                children: [
                  Flexible(
                    child: Container(
                      // alignment:
                      // Alignment.center,
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                      ),
                      child: TextFormField(
                        // style: robotoRegular,
                        textAlign: TextAlign.start,
                        enabled: false,
                        keyboardType: TextInputType.text,
                        controller: dateofJoiningController,
                        onSaved: (String? val) {
                          dataOfJoiningValue = val!;
                        },
                        decoration: InputDecoration(
                            // labelText: 'Date & Time',
                            //   labelStyle: TextStyle(fontSize: 20),
                          suffixIcon:  Icon(
                              Icons.calendar_month,
                              color: Colors.grey,
                              ),
                            disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: const BorderSide(
                                color: Colors.white,
                                width: 1.0,
                              ),
                            ),
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
                            fillColor: Color(0xffF5F5F5),
                            filled: true,
                            // labelText: 'Time',
                            contentPadding:
                                EdgeInsets.only(top: 0.0, left: 15.0)),
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ),

          ///Service/Call Charges Field
          serviceValue
              ? Column(
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: InkWell(
                        onTap: () => setState(() => serviceValue = false),
                        child: Icon(
                          Icons.clear,
                          color: ThemeColors.buttonColor,
                        ),
                      ),
                    ),
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
                  ],
                )
              : Container(),

          ///Handling Charges Field
          handlingValue
              ? Column(
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: InkWell(
                        onTap: () => setState(() => handlingValue = false),
                        child: Icon(
                          Icons.clear,
                          color: ThemeColors.buttonColor,
                        ),
                      ),
                    ),
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
                  ],
                )
              : Container(),

          ///Other Charges Field
          otherValue
              ? Column(
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: InkWell(
                        onTap: () => setState(() => otherValue = false),
                        child: Icon(
                          Icons.clear,
                          color: ThemeColors.buttonColor,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: 60,
                      child: TextFormField(
                        controller: otherChargesController,
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
                          hintText: 'Other Charges',
                          contentPadding:
                              const EdgeInsets.fromLTRB(20.0, 20.0, 0.0, 0.0),
                          hintStyle: GoogleFonts.poppins(
                              color: Colors.grey,
                              fontSize: 12.0,
                              fontWeight: FontWeight.w500),
                        ),
                        onChanged: (val) {
                          setState(() {
                            otherChargesValue = val;
                            // _phoneNumberController.text = val;
                          });
                        },
                      ),
                    ),
                  ],
                )
              : Container(),

          ///Transport Charges Field
          transportValue
              ? Column(
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: InkWell(
                        onTap: () => setState(() => transportValue = false),
                        child: Icon(
                          Icons.clear,
                          color: ThemeColors.buttonColor,
                        ),
                      ),
                    ),
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
                  ],
                )
              : Container(),

          SizedBox(
            height: 20,
          ),

          ///Addd Charges Button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(),
              InkWell(
                onTap: () {},
                child: Row(
                  children: [
                    Text("Add Charges",
                        style: TextStyle(
                            fontFamily: 'Poppins-Bold',
                            fontSize: 14,
                            fontWeight: FontWeight.w600)),
                    SizedBox(
                      width: 8,
                    ),
                    // addIcon(),
                    SpeedDial(
                      openCloseDial: isDialOpen,
                      backgroundColor: ThemeColors.buttonColor,
                      foregroundColor: Colors.white,
                      icon: Icons.add,
                      buttonSize: const Size(45.0, 45.0),
                      children: [
                        SpeedDialChild(
                          // child: const Icon(Icons.accessibility) ,
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          label: 'Transport Charges',
                          labelBackgroundColor: ThemeColors.imageContainerBG,
                          labelStyle: TextStyle(color: ThemeColors.buttonColor),
                          onTap: () => setState(() => transportValue = true),
                        ),
                        SpeedDialChild(
                          // child: const Icon(Icons.accessibility) ,
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          label: 'Other Charges',
                          labelBackgroundColor: ThemeColors.imageContainerBG,
                          labelStyle: TextStyle(color: ThemeColors.buttonColor),
                          onTap: () => setState(() => otherValue = true),
                        ),
                        SpeedDialChild(
                          // child: const Icon(Icons.accessibility) ,
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          label: 'Handling Charges',
                          labelBackgroundColor: ThemeColors.imageContainerBG,
                          labelStyle: TextStyle(color: ThemeColors.buttonColor),
                          onTap: () => setState(() => handlingValue = true),
                        ),
                        SpeedDialChild(
                          // child: const Icon(Icons.accessibility) ,
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          label: 'Service/Call Charges',
                          labelBackgroundColor: ThemeColors.imageContainerBG,
                          labelStyle: TextStyle(color: ThemeColors.buttonColor),
                          onTap: () => setState(() => serviceValue = true),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }


}




class _Preview extends StatelessWidget {
  const _Preview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PreviewScreen();
  }
}
