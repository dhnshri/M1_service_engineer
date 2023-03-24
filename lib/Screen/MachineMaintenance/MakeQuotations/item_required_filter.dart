import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:service_engineer/Bloc/home/home_bloc.dart';
import 'package:service_engineer/Bloc/home/home_event.dart';
import 'package:service_engineer/Bloc/home/home_state.dart';
import 'package:service_engineer/Model/filter_repo.dart';
import 'package:service_engineer/Model/product_repo.dart';
import 'package:service_engineer/Widget/custom_snackbar.dart';
import 'package:service_engineer/app.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

import '../../../Config/font.dart';
import '../../../Widget/app_button.dart';
import '../../../Widget/function_button.dart';
import 'make_quotatons.dart';




class ItemRequiredFilterScreen extends StatefulWidget {
  const ItemRequiredFilterScreen({Key? key}) : super(key: key);

  @override
  _ItemRequiredFilterScreenState createState() => _ItemRequiredFilterScreenState();
}

class _ItemRequiredFilterScreenState extends State<ItemRequiredFilterScreen> {

  final _formKey = GlobalKey<FormState>();
  String priceBtnType = "Price";
  int priceId = 1;
  String  brandsBtnType = "Brands";
  int brandsId = 1;

  String  discountBtnType = 'Discount';
  int discountId = 1;

  String ratingBtnType = 'Rating';
  int ratingId = 1;

  bool loading = true;
  List<BrandModule> brandList=[];
  HomeBloc? _homeBloc;
  List<ProductDetails>? productDetail = [];


  @override
  void initState() {
    // TODO: implement initState
    //saveDeviceTokenAndId();
    super.initState();
    _homeBloc = BlocProvider.of<HomeBloc>(this.context);
    _homeBloc!.add(ItemFilter());
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
              onTap: (){
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => MakeQuotationScreen  ()));
                Navigator.of(context).pop();
              },
              child: Icon(Icons.arrow_back_ios)),
          title: Text('Filter',style:appBarheadingStyle ,),
        ),
        bottomNavigationBar:Padding(
          padding: const EdgeInsets.all(10.0),
          child: FunctionButton(
            onPressed: () async {
              _homeBloc!.add(ProductList(prodId: '0',offSet: '0',priceId: priceId.toString(),brandId: brandsId.toString()));
            },
            shape: const RoundedRectangleBorder(
                borderRadius:
                BorderRadius.all(Radius.circular(50))),
            text: 'Apply',
            loading: loading,


          ),
        ),
        body: BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
          return BlocListener<HomeBloc, HomeState>(
            listener: (context, state) {
              if(state is ItemFilterLoading){
                loading = state.isLoading;
              }
              if(state is ItemFilterSuccess){
                brandList = state.brandListData;
                // brandList.reversed;
              }
              if(state is ItemFilterFail){
                showCustomSnackBar(context,state.msg.toString(),isError: true);
              }
              if(state is ProductListLoading){
                loading = state.isLoading;
              }
              if(state is ProductListSuccess){
                productDetail = state.productList;
                Navigator.pop(context,{'brand_id': brandsId.toInt(),'ascending_descending_id': priceId,'product_list':productDetail});
              }
              if(state is ProductListFail){
                // Fluttertoast.showToast(msg: state.msg.toString());
              }
            },
            child: loading ? ListView(
              children: [

                Padding(
                  padding: const EdgeInsets.only(top:8.0),
                  child: Container(
                    child: Column(
                      children: [
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.only(top:5.0,bottom: 5.0),
                            child: Container(
                              //decoration: BoxDecoration(
                              // border: Border.all(color: Colors.black12),
                              // borderRadius: BorderRadius.circular(12),
                              // ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Column(
                                  children: [
                                    Align(
                                        alignment: Alignment.topLeft,
                                        child: Text('Price',style:filterHeadingRadiobtnStyle,)),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(children: [
                                      Radio(
                                        value: 1,
                                        groupValue: priceId,
                                        onChanged: (val) {
                                          setState(() {
                                            priceBtnType = 'Ascending';
                                            priceId = 1;
                                          });
                                        },
                                      ),
                                      Text(
                                        'Ascending',
                                        style:filterRadiobtnStyle,
                                      ),
                                    ],),
                                    Row(
                                      children: [
                                        Radio(
                                          value: 2,
                                          groupValue: priceId,
                                          onChanged: (val) {
                                            setState(() {
                                              priceBtnType =
                                              'Descending';
                                              priceId = 2;
                                            });
                                          },
                                        ),
                                        Text(
                                          'Descending',
                                          style: filterRadiobtnStyle,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.only(top:5.0,bottom: 5.0),
                            child: Container(
                              //decoration: BoxDecoration(
                              // border: Border.all(color: Colors.black12),
                              // borderRadius: BorderRadius.circular(12),
                              // ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Column(
                                  children: [
                                    Align(
                                        alignment: Alignment.topLeft,
                                        child: Text('Brands',style:filterHeadingRadiobtnStyle,)),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    ListView.builder(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      scrollDirection: Axis.vertical,
                                      itemCount: brandList.length,
                                      padding: EdgeInsets.only(top: 10, bottom: 15),
                                      itemBuilder: (context, index) {
                                        return Row(children: [
                                          Radio(
                                            value: brandList[index].brandId!,
                                            groupValue: brandsId,
                                            onChanged: (val) {
                                              setState(() {
                                                brandsBtnType = brandList[index].name!;
                                                brandsId = brandList[index].brandId!.toInt();
                                              });
                                            },
                                          ),
                                          Text(
                                            brandList[index].name!,
                                            style:filterRadiobtnStyle,
                                          ),
                                        ],
                                        );

                                      }
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                ),
              ],
            ) : Center(child: CircularProgressIndicator(),),

          );


        })

      ),
    );
  }
}
