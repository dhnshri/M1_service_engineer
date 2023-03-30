import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:service_engineer/Bloc/order/order_bloc.dart';
import 'package:service_engineer/Bloc/order/order_event.dart';
import 'package:service_engineer/Bloc/order/order_state.dart';
import 'package:service_engineer/Constant/theme_colors.dart';
import 'package:service_engineer/Model/order_list_repo.dart';
import 'package:service_engineer/Screen/MachineMaintenance/Order/order_item_details.dart';
import 'package:service_engineer/Utils/application.dart';
import 'package:service_engineer/Widget/custom_snackbar.dart';
import 'package:shimmer/shimmer.dart';

class OrderItemsScreen extends StatefulWidget {
  const OrderItemsScreen({Key? key}) : super(key: key);

  @override
  _OrderItemsState createState() => _OrderItemsState();
}

class _OrderItemsState extends State<OrderItemsScreen> {
  final TextEditingController _phoneNumberController = TextEditingController();
  String dropdownValue = '+ 91';
  String? phoneNum;
  String? role;
  bool isLoading = true;
  OrderBloc? _orderBloc;

  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ExpansionTileCardState> cardA = new GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardB = new GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardC = new GlobalKey();
  final _searchController = TextEditingController();
  List<OrderList> orderList=[];
  bool _loadData = false;
  bool flagSearchResult=false;
  bool _isSearching=false;
  List<OrderList> searchResult=[];

  @override
  void initState() {
    // TODO: implement initState
    //saveDeviceTokenAndId();
    super.initState();
    _orderBloc = BlocProvider.of<OrderBloc>(context);
    _orderBloc!.add(GetOrderList(serviceUserId: Application.customerLogin!.id.toString()));
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
      for (int i = 0; i < orderList.length; i++) {
        OrderList orderListData = new OrderList();
        orderListData.machineEnquiryId = orderList[i].machineEnquiryId;
        orderListData.orderTrackingStatus = orderList[i].orderTrackingStatus;
        orderListData.itemName = orderList[i].itemName.toString();
        orderListData.productImage = orderList[i].productImage.toString();
        orderListData.cancelOrder = orderList[i].cancelOrder;
        orderListData.orderPlacedOn = orderList[i].orderPlacedOn;

        if (orderListData.machineEnquiryId.toString().toLowerCase().contains(searchText.toLowerCase()) ||
            orderListData.orderTrackingStatus.toString().toLowerCase().contains(searchText.toLowerCase()) ||
            orderListData.itemName.toString().toLowerCase().contains(searchText.toLowerCase()) ||
            orderListData.productImage.toString().toLowerCase().contains(searchText.toLowerCase()) ||
            orderListData.cancelOrder.toString().toLowerCase().contains(searchText.toLowerCase()) ||
            orderListData.orderPlacedOn.toString().toLowerCase().contains(searchText.toLowerCase())
        ) {
          flagSearchResult=false;
          searchResult.add(orderListData);
        }
      }
      setState(() {
        if(searchResult.length==0){
          flagSearchResult=true;
        }
      });
    }
  }

  Widget buildOrderItemsList(BuildContext context, List<OrderList> orderList) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      padding: EdgeInsets.only(top: 10, bottom: 15),
      itemCount: orderList.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => OrderItemDetailsScreen(orderList: orderList[index],)));
          },
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0.0),
              ),
              // color: Colors.white70,
              elevation: 5,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(9.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Order Placed On:",
                              style:
                              TextStyle(fontFamily: 'Poppins', fontSize: 12),
                            ),
                            Text(
                              DateFormat('MM-dd-yyyy h:mm a').format(DateTime.parse(orderList[index].orderPlacedOn.toString())).toString(),
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "Order ID:",
                              style:
                              TextStyle(fontFamily: 'Poppins', fontSize: 12),
                            ),
                            Text(
                              orderList[index].machineEnquiryId.toString(),
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    thickness: 1,
                  ),
                  Row(
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
                            imageUrl: orderList[index].productImage.toString(),
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
                                // width: MediaQuery.of(context).size.width / 1.8,
                                // width: MediaQuery.of(context).size.width / 1.9,
                                child: Text(
                                  orderList[index].itemName.toString(),
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),

                              orderList[index].orderTrackingStatus == 5 ?
                              Row(
                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(Icons.circle,color: Colors.green,size: 15,),
                                  SizedBox(width: 4,),
                                  Container(
                                    // width: MediaQuery.of(context).size.width*0.2,
                                    child: Text(
                                      'Delivered',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 12,
                                        // fontWeight: FontWeight.bold
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  )

                                ],
                              ):
                              orderList[index].cancelOrder == 1 ?
                              Row(
                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(Icons.circle,color: Colors.red,size: 15,),
                                  SizedBox(width: 4,),
                                  Container(
                                    // width: MediaQuery.of(context).size.width*0.2,
                                    child: Text(
                                      'Cancelled',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 12,
                                        // fontWeight: FontWeight.bold
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  )

                                ],
                              ):
                              Row(
                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(Icons.circle,color: Colors.orange,size: 15,),
                                  SizedBox(width: 4,),
                                  Container(
                                    // width: MediaQuery.of(context).size.width*0.2,
                                    child: Text(
                                      'On the way',
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
                      Padding(
                        padding: const EdgeInsets.only(top: 40.0,right: 2),
                        child: Icon(Icons.arrow_forward_ios),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: InkWell(
            onTap: () {
              // Navigator.pop(context);
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => BottomNavigation (index:0)));
            },
            child: Icon(Icons.arrow_back_ios)),
        title: Text(
          'Ordered Items',
        ),
      ),
      body: BlocBuilder<OrderBloc, OrderState>(builder: (context, state) {
        return BlocListener<OrderBloc, OrderState>(
          listener: (context, state) {
            if(state is OrderListLoading){
              isLoading = state.isLoading;
            }
            if(state is OrderListSuccess){
              orderList.addAll(state.orderList);
              if(orderList!=null){
                _loadData=true;
              }
            }
            if(state is OrderListFail){
              showCustomSnackBar(context,state.msg.toString());
            }
          },
          child: _loadData ? orderList.length <= 0 ? Center(child: CircularProgressIndicator(),):
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
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(1.0)),
                                  borderSide: BorderSide(
                                      width: 0.8, color: ThemeColors.bottomNavColor)),
                            ),
                            onChanged: (value) {
                              searchOperation(value);

                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                flagSearchResult == false? (searchResult.length != 0 || _searchController.text.isNotEmpty) ?
                buildOrderItemsList(context,searchResult):
                buildOrderItemsList(context,orderList) : Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: const Center(child: Text("No Data"),),),
              ],
            ),
          ) : Center(child: CircularProgressIndicator(),),

          // Center(
          //   child: CircularProgressIndicator(),
          // )

        );
      })

    );
  }
}
