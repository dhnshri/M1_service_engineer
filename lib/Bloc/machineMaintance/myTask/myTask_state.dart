import 'package:meta/meta.dart';

import '../../../Model/MachineMaintance/myTaskModel.dart';


@immutable
abstract class MyTaskState {}


class InitialMyTaskListState extends MyTaskState {}


class MyTaskLoading extends MyTaskState {}



class MyTaskListSuccess extends MyTaskState {
 List<MyTaskModel>? MyTaskList;
 MyTaskListSuccess({this.MyTaskList});
}

class MyTaskListLoadFail extends MyTaskState {}



// abstract class ProductDetailState {}


// class InitialProductDetailState extends ProductState {}
//
//
// class ProductDetailLoading extends ProductState {}
//
//
//
// class ProductDetailSuccess extends ProductState {
//  ProductDetail? data;
//  ProductDetailSuccess({this.data});
// }
//
// class ProductDetailLoadFail extends ProductState {}
