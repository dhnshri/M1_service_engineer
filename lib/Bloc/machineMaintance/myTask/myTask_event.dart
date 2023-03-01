import 'package:meta/meta.dart';

@immutable
abstract class MyTaskEvent {}


class OnLoadingMyTaskList extends MyTaskEvent {
  String userid;
  String offset;
  // String prodid;
  OnLoadingMyTaskList({required this.userid, required this.offset });
}


// class OnLoadingProductDetail extends ProductEvent {
//   String prodId;
//   OnLoadingProductDetail({required this.prodId});
// }