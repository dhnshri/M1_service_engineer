import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:service_engineer/Api/commission_api.dart';
import 'package:service_engineer/Bloc/home/home_bloc.dart';
import 'package:service_engineer/Bloc/home/home_event.dart';
import 'package:service_engineer/Bloc/home/home_state.dart';
import 'package:service_engineer/Model/cart_list_repo.dart';
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
import '../../../Model/service_request_detail_repo.dart';
import '../../../Widget/app_button.dart';
import '../../../Widget/common.dart';
import '../../../Widget/function_button.dart';
import '../../../Widget/stepper_button.dart';
import '../../bottom_navbar.dart';
import '../ServiceRequest/serviceRequestDetails.dart';
import 'item_required.dart';
import 'item_required_filter.dart';

class MakeQuotationScreen extends StatefulWidget {
  MachineServiceDetailsModel? serviceRequestData;
  MakeQuotationScreen({Key? key, this.serviceRequestData}) : super(key: key);

  @override
  _MakeQuotationScreenState createState() => _MakeQuotationScreenState();
}

class _MakeQuotationScreenState extends State<MakeQuotationScreen> {
  int _currentStep = 0;
  bool loading = true;
  final _formKey = GlobalKey<FormState>();
  bool isCompleted = false;
  String? workingTimeValue;
  String? gstChargesValue;
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
  final TextEditingController _gstChargesController = TextEditingController();
  final _searchController = TextEditingController();
  ScrollController _scrollController = ScrollController();
  DateTime selectedDate = DateTime.now();

  var quantity = 0;
  var totalValue = 0;
  int prodValue = 15000;
  double totalAmount = 0.0;

  bool _cartLoading = true;
  bool _isLoading = false;
  bool _loadData = false;

  HomeBloc? _homeBloc;
  List<ProductDetails>? productDetail = [];
  List<CartListModel>? cartList = [];
  bool flagSearchResult = false;
  bool _isSearching = false;
  List<ProductDetails> searchResult = [];
  int? catId = 0;
  int? brandId = 0;
  int? priceId = 0;
  int offset = 0;
  int commision = 0;

  void _handleSearchStart() {
    setState(() {
      _isSearching = true;
    });
  }

  void searchOperation(String searchText) {
    searchResult.clear();
    if (_isSearching != null) {
      for (int i = 0; i < productDetail!.length; i++) {
        ProductDetails serviceListData = new ProductDetails();
        serviceListData.productName = productDetail![i].productName.toString();
        serviceListData.price = productDetail![i].price.toString();
        serviceListData.id = productDetail![i].id;
        serviceListData.prodImg = productDetail![i].prodImg;
        serviceListData.discountPrice = productDetail![i].discountPrice;
        serviceListData.aboutProduct = productDetail![i].aboutProduct;
        serviceListData.cartQuantity = productDetail![i].cartQuantity;
        serviceListData.productQty = productDetail![i].productQty;

        if (serviceListData.productName
                .toString()
                .toLowerCase()
                .contains(searchText.toLowerCase()) ||
            serviceListData.price
                .toString()
                .toLowerCase()
                .contains(searchText.toLowerCase()) ||
            serviceListData.id
                .toString()
                .toLowerCase()
                .contains(searchText.toLowerCase()) ||
            serviceListData.prodImg
                .toString()
                .toLowerCase()
                .contains(searchText.toLowerCase()) ||
            serviceListData.discountPrice
                .toString()
                .toLowerCase()
                .contains(searchText.toLowerCase()) ||
            serviceListData.aboutProduct
                .toString()
                .toLowerCase()
                .contains(searchText.toLowerCase()) ||
            serviceListData.cartQuantity
                .toString()
                .toLowerCase()
                .contains(searchText.toLowerCase()) ||
            serviceListData.productQty
                .toString()
                .toLowerCase()
                .contains(searchText.toLowerCase())) {
          flagSearchResult = false;
          searchResult.add(serviceListData);
        }
      }
      setState(() {
        if (searchResult.length == 0) {
          flagSearchResult = true;
        }
      });
    }
  }

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

  TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00);
  String? _hour, _minute, _time, _am;
  TextEditingController _timeController = TextEditingController();

  Future<Null> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null)
      setState(() {
        selectedTime = picked;

        _hour = selectedTime.hour.toString();
        _minute = selectedTime.minute.toString();
        _am = selectedTime.format(context).toString();
        // _time = _hour + ':' + _minute + ' ' + am;
        _time = _am;
        workingTimeController.text = _time!;
        print(picked);
      });
  }

  var mainHeight, mainWidth;

  int itemNo = 0;
  List<ItemNotAvailableModel> itemNotAvailabeList = List.empty(growable: true);

  onAdd() {
    setState(() {
      ItemNotAvailableModel _contactModel =
          ItemNotAvailableModel(id: itemNotAvailabeList.length);

      double amount = int.parse(_rateController.text) * 100 / 100 +
          int.parse(_gstController.text);

      double amountWithGST = amount * int.parse(_quantityController.text);

      itemNotAvailabeList.add(ItemNotAvailableModel(
          id: itemNo++,
          itemName: _itemNameController.text,
          quantity: _quantityController.text,
          amount: amountWithGST.toString(),
          rate: _rateController.text,
          gst: _gstController.text));
    });
  }

  DataRow _buildItemRequiredList(
      ItemNotAvailableModel? itemNotAvailabeList, index) {
    int itemIndex = index + 1;
    return DataRow(
      color: MaterialStateColor.resolveWith((states) {
        return Color(0xffFFE4E5); //make tha magic!
      }),
      cells: <DataCell>[
        DataCell(Text(itemIndex.toString())),
        DataCell(Text(itemNotAvailabeList!.itemName.toString())),
        DataCell(Text(itemNotAvailabeList.quantity.toString())),
        DataCell(Text('₹${itemNotAvailabeList.rate.toString()}')),
        // DataCell(Text('₹${amount.toString()}')),
      ],
    );
  }

  ///Item Required Widget
  Widget ItemRequired(BuildContext context, List<ProductDetails>? productList) {
    mainHeight = MediaQuery.of(context).size.height;
    mainWidth = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Row(
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
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                  hintStyle: TextStyle(fontSize: 15),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(1.0)),
                    borderSide: BorderSide(
                        width: 0.8, color: ThemeColors.bottomNavColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(1.0)),
                    borderSide: BorderSide(
                        width: 0.8, color: ThemeColors.bottomNavColor),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(1.0)),
                      borderSide: BorderSide(
                          width: 0.8, color: ThemeColors.bottomNavColor)),
                ),
                validator: (value) {},
                onChanged: (value) {
                  // profile.name = value;
                  searchOperation(value);
                },
              ),
            ),
            InkWell(
              onTap: () async {
                var filterResult = await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ItemRequiredFilterScreen()));

                if (filterResult != null) {
                  print(filterResult['product_list']);
                  print(filterResult['brand_id']);
                  print(filterResult['ascending_descending_id']);
                  print(filterResult['category_id']);
                  productDetail = filterResult['product_list'];
                  catId = filterResult['category_id'];
                  priceId = filterResult['ascending_descending_id'];
                  brandId = filterResult['brand_id'];
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
        _loadData
            ? Container(
                height: 350,
                child: Column(children: <Widget>[
                  flagSearchResult == false
                      ? (searchResult.length != 0 ||
                              _searchController.text.isNotEmpty)
                          ? Expanded(child: ProdductList(context, searchResult))
                          : Expanded(child: ProdductList(context, productList))
                      : Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: const Center(
                            child: Text("No Data"),
                          ),
                        )
                ]),
              )
            : Center(
                child: CircularProgressIndicator(),
              ),
        SizedBox(
          height: 15,
        ),
        Align(
            alignment: Alignment.topLeft,
            child: Text(
              "Add Items not available in list here.",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins'),
            )),
        SizedBox(
          height: 5,
        ),
        itemNotAvailabeList.length <= 0
            ? Container()
            : Column(
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
                      return _buildItemRequiredList(
                          itemNotAvailabeList[index], index);
                    }),
                  ),
                ],
              ),
        SizedBox(
          height: 7,
        ),
        SizedBox(
          width: 5,
        ),
        InkWell(
          onTap: () {
            //AddOtherCharges();
            AddItemNotAvailable(context);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(),

              ///Add More
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    itemNotAvailabeList.length <= 0 ? "Add Items" : "Add More",
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  InkWell(
                    onTap: () {
                      // AddOtherCharges();
                      AddItemNotAvailable(context);
                    },
                    child: CircleAvatar(
                      backgroundColor: ThemeColors.redTextColor,
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
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

  Widget ProdductList(BuildContext context, List<ProductDetails>? productList) {
    return ListView.builder(
      controller: _scrollController
        ..addListener(() {
          if (_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent) {
            offset++;
            print("Offset : ${offset}");
            BlocProvider.of<HomeBloc>(context)
              ..isFetching = true
              ..add(getApi());
            // serviceList.addAll(serviceList);
          }
        }),
      shrinkWrap: true,
      // physics: ScrollPhysics(),
      scrollDirection: Axis.vertical,
      itemCount: productList!.length,
      padding: EdgeInsets.only(top: 10, bottom: 15),
      itemBuilder: (context, index) {
        return Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Card(
                elevation: 1,
                child: ListTile(
                  leading: CachedNetworkImage(
                    filterQuality: FilterQuality.medium,
                    // imageUrl: Api.PHOTO_URL + widget.users.avatar,
                    // imageUrl: "https://picsum.photos/250?image=9",
                    imageUrl: productList[index].prodImg.toString(),
                    placeholder: (context, url) {
                      return Shimmer.fromColors(
                        baseColor: Theme.of(context).hoverColor,
                        highlightColor: Theme.of(context).highlightColor,
                        enabled: true,
                        child: Container(
                          height: 90,
                          width: 70,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      );
                    },
                    imageBuilder: (context, imageProvider) {
                      return Container(
                        height: 90,
                        width: 70,
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
                  title: Column(children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              productList[index].productName.toString(),
                              style: itemRequiredCardHeading,
                            ),
                            Text("ID: ${productList[index].id.toString()}",
                                style: itemRequiredCardSubtitle),
                            Text(
                                "₹ ${productList[index].discountPrice.toString()}",
                                style: itemRequiredCardSubtitle),
                          ],
                        ),
                        Flexible(
                          child: Container(
                            height: 40,
                            // width: 110,
                            width: MediaQuery.of(context).size.width * 0.5,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30)),
                            ),
                            child: Row(
                              children: [
                                productList[index].cartQuantity != 0
                                    ? IconButton(
                                        icon: Icon(
                                          Icons.remove_circle,
                                          color: Colors.grey,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            if (productList[index]
                                                    .cartQuantity! >
                                                0) {
                                              productList[index].cartQuantity =
                                                  productList[index]
                                                          .cartQuantity! -
                                                      1;
                                              _homeBloc!.add(AddToCart(
                                                  prodId: productList[index]
                                                      .id
                                                      .toString(),
                                                  userId: Application
                                                      .customerLogin!.id
                                                      .toString(),
                                                  quantity: productList[index]
                                                      .cartQuantity
                                                      .toString()));
                                              loadApi();
                                            }
                                          });
                                        },
                                      )
                                    : Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10.0),
                                        child: const Text('Add',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'Poppins')),
                                      ),
                                productList[index].cartQuantity != 0
                                    ? Text(
                                        productList[index]
                                            .cartQuantity
                                            .toString(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 18),
                                      )
                                    : SizedBox(),
                                Expanded(
                                  child: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        // if (quantity < 10) {
                                        //   quantity++;
                                        //   totalValue = prodValue * quantity;
                                        // }
                                        // _homeBloc!.add(AddToCart(prodId: productList[index].id.toString(),userId: Application.customerLogin!.id.toString(),quantity: '1'));
                                        if (productList[index].cartQuantity! <=
                                            productList[index].productQty!) {
                                          if (productList[index].productQty! >
                                              0) {
                                            productList[index].cartQuantity =
                                                productList[index]
                                                        .cartQuantity! +
                                                    1;
                                            _homeBloc!.add(AddToCart(
                                                prodId: productList[index]
                                                    .id
                                                    .toString(),
                                                userId: Application
                                                    .customerLogin!.id
                                                    .toString(),
                                                quantity: productList[index]
                                                    .cartQuantity
                                                    .toString()));
                                            loadApi();
                                          } else {
                                            showCustomSnackBar(context,
                                                'Quantity is not available.',
                                                isError: true);
                                          }
                                        } else {
                                          showCustomSnackBar(context,
                                              'Quantity is not available.',
                                              isError: true);
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
                    Align(
                        alignment: Alignment.topLeft,
                        child: Text(productList[index].aboutProduct.toString(),
                            style: itemRequiredCardSubtitle)),
                  ]),
                )));
      },
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
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: 60,
                    child: TextFormField(
                      controller: _itemNameController,
                      keyboardType: TextInputType.text,
                      maxLength: 10,
                      cursorColor: primaryAppColor,
                      decoration: InputDecoration(
                        disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: const BorderSide(
                            color: Colors.black,
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
                        fillColor: Colors.white,
                        filled: true,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide:
                              const BorderSide(color: Colors.black, width: 1.0),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: const BorderSide(
                              color: Colors.black,
                              width: 1.0,
                            )),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: const BorderSide(
                            color: Colors.black,
                            width: 1.0,
                          ),
                        ),
                        hintText: 'Item Name',
                        contentPadding:
                            const EdgeInsets.fromLTRB(20.0, 20.0, 0.0, 0.0),
                        hintStyle: GoogleFonts.poppins(
                            color: Colors.grey,
                            fontSize: 12.0,
                            fontWeight: FontWeight.w500),
                      ),
                      onChanged: (val) {
                        setState(() {
                          if (_formKey.currentState!.validate()) {}
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 60,
                  child: TextFormField(
                    controller: _quantityController,
                    keyboardType: TextInputType.number,
                    maxLength: 10,
                    cursorColor: primaryAppColor,
                    decoration: InputDecoration(
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: const BorderSide(
                          color: Colors.black,
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
                      fillColor: Colors.white,
                      filled: true,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide:
                            const BorderSide(color: Colors.black, width: 1.0),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: const BorderSide(
                            color: Colors.black,
                            width: 1.0,
                          )),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: const BorderSide(
                          color: Colors.black,
                          width: 1.0,
                        ),
                      ),
                      hintText: 'Quantity',
                      contentPadding:
                          const EdgeInsets.fromLTRB(20.0, 20.0, 0.0, 0.0),
                      hintStyle: GoogleFonts.poppins(
                          color: Colors.grey,
                          fontSize: 12.0,
                          fontWeight: FontWeight.w500),
                    ),
                    onChanged: (val) {
                      setState(() {
                        if (_formKey.currentState!.validate()) {}
                      });
                    },
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 60,
                  child: TextFormField(
                    controller: _rateController,
                    keyboardType: TextInputType.number,
                    maxLength: 10,
                    cursorColor: primaryAppColor,
                    decoration: InputDecoration(
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: const BorderSide(
                          color: Colors.black,
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
                      fillColor: Colors.white,
                      filled: true,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide:
                            const BorderSide(color: Colors.black, width: 1.0),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: const BorderSide(
                            color: Colors.black,
                            width: 1.0,
                          )),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: const BorderSide(
                          color: Colors.black,
                          width: 1.0,
                        ),
                      ),
                      hintText: 'Rate',
                      contentPadding:
                          const EdgeInsets.fromLTRB(20.0, 20.0, 0.0, 0.0),
                      hintStyle: GoogleFonts.poppins(
                          color: Colors.grey,
                          fontSize: 12.0,
                          fontWeight: FontWeight.w500),
                    ),
                    onChanged: (val) {
                      setState(() {
                        if (_formKey.currentState!.validate()) {}
                      });
                    },
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 60,
                  child: TextFormField(
                    controller: _gstController,
                    keyboardType: TextInputType.number,
                    // maxLength: 10,
                    cursorColor: primaryAppColor,
                    decoration: InputDecoration(
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: const BorderSide(
                          color: Colors.black,
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
                      fillColor: Colors.white,
                      filled: true,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide:
                            const BorderSide(color: Colors.black, width: 1.0),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: const BorderSide(
                            color: Colors.black,
                            width: 1.0,
                          )),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: const BorderSide(
                          color: Colors.black,
                          width: 1.0,
                        ),
                      ),
                      hintText: 'Add GST',
                      contentPadding:
                          const EdgeInsets.fromLTRB(20.0, 20.0, 0.0, 0.0),
                      hintStyle: GoogleFonts.poppins(
                          color: Colors.grey,
                          fontSize: 12.0,
                          fontWeight: FontWeight.w500),
                    ),
                    onChanged: (val) {
                      setState(() {
                        if (_formKey.currentState!.validate()) {}
                      });
                    },
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: AppButton(
                      onPressed: () async {
                        onAdd();
                        print(itemNotAvailabeList);
                        _itemNameController.clear();
                        _rateController.clear();
                        _gstController.clear();
                        _quantityController.clear();
                        Navigator.of(context).pop();
                        showCustomSnackBar(context, 'Item Added Successfully',
                            isError: false);
                      },
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(50))),
                      text: 'Add Product',
                      loading: loading,
                      color: ThemeColors.redTextColor,
                    )),
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
          content: ItemRequired(context, productDetail),
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
          content: PreviewScreen(
            cartList: cartList,
            itemNotAvailableList: itemNotAvailabeList,
            workingTimeController: workingTimeController,
            dateofJoiningController: dateofJoiningController,
            serviceCallChargesController: serviceCallChargesController,
            transportChargesController: transportChargesController,
            otherChargesController: otherChargesController,
            handlingChargesController: handlingChargesController,
            gstChargesController: _gstChargesController,
            commission: commision,
          ),
        ),
      ];

  int total = 0;

  @override
  void initState() {
    // TODO: implement initState
    //saveDeviceTokenAndId();
    super.initState();
    _homeBloc = BlocProvider.of<HomeBloc>(this.context);
    getApi();
    loadApi();
    selectedDate;
    dateofJoiningController.text = DateFormat.yMd('es').format(DateTime.now());
    getCommissionApi();
  }

  getCommissionApi() async {
    var com = await fetchCommision(Application.customerLogin!.id.toString(),
            Application.customerLogin!.role.toString())
        .then((value) => value);
    print(com);
    print(com['data']);
    commision = com['data'];
  }

  getApi() {
    _homeBloc!.add(ProductList(
        prodId: '0',
        offSet: offset.toString(),
        brandId: brandId.toString(),
        priceId: priceId.toString(),
        catId: catId.toString()));
  }

  loadApi() {
    _homeBloc!.add(CartList(userId: Application.customerLogin!.id.toString()));
    // _homeBloc!.add(CartList(userId: '1'));
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
                 // Navigator.of(context).pop();
                 //  Navigator.push(context,
                 //      MaterialPageRoute(builder: (context) => ServiceRequestDetailsScreen(serviceRequestData:widget.serviceRequestData![0])));
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BottomNavigation(
                            index: 0,
                            dropValue: Application.customerLogin!.role.toString(),
                          )));
                },
                child: Icon(Icons.arrow_back_ios)),
            title: Text(
              'Quotation for #${widget.serviceRequestData!.machineEnquiryId.toString()}',
              style: appBarheadingStyle,
            ),
          ),
          body: BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
            return BlocListener<HomeBloc, HomeState>(
              listener: (context, state) {
                if (state is ProductListLoading) {
                  _isLoading = state.isLoading;
                }
                if (state is ProductListSuccess) {
                  // productDetail = state.productList;
                  productDetail!.addAll(state.productList);
                  if (productDetail != null) {
                    _loadData = true;
                  }
                }
                if (state is ProductListFail) {
                  // Fluttertoast.showToast(msg: state.msg.toString());
                }
                if (state is AddToCartSuccess) {
                  showCustomSnackBar(context, state.message, isError: false);
                }
                if (state is AddToCartFail) {
                  showCustomSnackBar(context, state.msg.toString(),
                      isError: true);
                }
                if (state is AddToCartLoading) {
                  _cartLoading = state.isLoading;
                }
                if (state is CartListLoading) {
                  // showCustomSnackBar(context,'',isError: false);
                }
                if (state is CartListSuccess) {
                  // showCustomSnackBar(context,state.message.toString(),isError: true);
                  cartList = state.cartList;
                }
                if (state is CartListFail) {
                  // _cartLoading = state.isLoading;
                }
                if (state is SendQuotationSuccess) {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BottomNavigation(
                                index: 0,
                                dropValue:
                                    Application.customerLogin!.role.toString(),
                              )));
                  showCustomSnackBar(context, state.message, isError: false);
                  for (int i = 0; i < cartList!.length; i++) {
                    _homeBloc!.add(AddToCart(
                        prodId: cartList![i].productId.toString(),
                        userId: Application.customerLogin!.id.toString(),
                        quantity: '0'));
                  }
                  Application.preferences!.remove('amount');
                }
              },
              child: isCompleted
                  ? AlertDialog(
                      title: new Text(
                          "Are you sure, you want to send this quotation ?"),
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
                                    side: const BorderSide(
                                        color: ThemeColors.defaultbuttonColor,
                                        width: 1.5))),
                            const SizedBox(
                              width: 7,
                            ),
                            TextButton(
                              child: const Text(
                                "Yes",
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () {
                                // TotalAmount(){
                                //   if(serviceCallChargesController.text==""){
                                //     serviceCallChargesController.text = "0";
                                //   }
                                //   if(transportChargesController.text==""){
                                //     transportChargesController.text = "0";
                                //   }
                                //   if(handlingChargesController.text==""){
                                //     handlingChargesController.text = "0";
                                //   }
                                //
                                //   totalAmount = itemRequiredTotalAmount! + otherItemTotalAmount! + double.parse(widget.serviceCallChargesController.text) +
                                //       double.parse(widget.transportChargesController.text) + double.parse(widget.handlingChargesController.text) +
                                //       double.parse(widget.gstChargesController.text) + commission!;
                                //   setState(() {
                                //   });
                                // }

                                if (workingTimeController.text == "") {
                                  showCustomSnackBar(
                                      context, 'Please add working time.',
                                      isError: true);
                                } else if (itemNotAvailabeList == null) {
                                  showCustomSnackBar(
                                      context, 'Please add items.',
                                      isError: true);
                                } else {
                                  _homeBloc!.add(SendQuotation(
                                      serviceUserId: Application
                                          .customerLogin!.id
                                          .toString(),
                                      workingTime: workingTimeController.text,
                                      dateOfJoining: dateofJoiningController
                                          .text,
                                      serviceCharge:
                                          serviceCallChargesController.text,
                                      handlingCharge: handlingChargesController
                                          .text,
                                      transportCharge:
                                          transportChargesController.text,
                                      itemList: cartList!,
                                      itemNotAvailableList: itemNotAvailabeList,
                                      commission: commision.toString(),
                                      // machineEnquiryDate: widget.serviceRequestData!.createdAt.toString(),
                                      machineEnquiryDate: DateTime.parse(widget
                                              .serviceRequestData!.createdAt
                                              .toString())
                                          .toString(),
                                      machineEnquiryId: widget
                                          .serviceRequestData!.machineEnquiryId!
                                          .toInt(),
                                      totalAmount:
                                          Application.totalAmount.toString()));
                                }
                              },
                              style: TextButton.styleFrom(
                                  backgroundColor:
                                      ThemeColors.defaultbuttonColor),
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
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(50))),
                                  text: 'Back',
                                  loading: loading,
                                ),
                              StepperButton(
                                onPressed: () async {
                                  final isLastStep =
                                      _currentStep == stepList().length - 1;

                                  if (isLastStep) {
                                    setState(() {
                                      isCompleted = true;
                                    });
                                  } else {
                                    if (workingTimeController.text == "") {
                                      showCustomSnackBar(
                                          context, 'Please add working time.',
                                          isError: true);
                                    } else if (_gstChargesController.text ==
                                        "") {
                                      showCustomSnackBar(
                                          context, 'Please add GST.',
                                          isError: true);
                                    } else {
                                      setState(() {
                                        _currentStep += 1;
                                      });
                                    }
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
          })),
    );
  }

  ///Service Charges
  Widget ServiceCharges(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          ///Working Time Field
          InkWell(
            onTap: () {
              _selectTime(context);
            },
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              height: 60,
              child: TextFormField(
                controller: workingTimeController,
                keyboardType: TextInputType.number,
                enabled: false,
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
                    borderSide:
                        const BorderSide(color: Colors.white, width: 1.0),
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
                  contentPadding:
                      const EdgeInsets.fromLTRB(20.0, 20.0, 0.0, 0.0),
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
                            suffixIcon: Icon(
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

          SizedBox(
            height: 10,
          ),

          ///GST
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            height: 60,
            child: TextFormField(
              controller: _gstChargesController,
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
                hintText: 'GST',
                contentPadding: const EdgeInsets.fromLTRB(20.0, 20.0, 0.0, 0.0),
                hintStyle: GoogleFonts.poppins(
                    color: Colors.grey,
                    fontSize: 12.0,
                    fontWeight: FontWeight.w500),
              ),
              onChanged: (val) {
                setState(() {
                  gstChargesValue = val;
                  // _phoneNumberController.text = val;
                });
              },
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
                            fontFamily: 'Poppins',
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
