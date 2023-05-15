import 'dart:convert';
import '../Api/api.dart';
import '../Model/MachineMaintance/machine_maintaince_category_list_model.dart';
import '../Model/Transpotation/vehicle_name_model.dart';
import 'package:http/http.dart' as http;

// Future<List<MachineMaintenanceCategoryListModel>> fetchCategoryList() async{
//
//   Map<String, String> params;
//   params = {
//   };
//
//   var response = await http.post(
//       Uri.parse(Api.MACHINE_MAINTAINCE_CATEGORY_LIST),
//       body: params
//   );
//
//   try{
//     final resp = json.decode(response.body);
//     List<MachineMaintenanceCategoryListModel> listOfCategory=[];
//     if( response.statusCode==200) {
//       listOfCategory = resp['data'].map<MachineMaintenanceCategoryListModel>((item) {
//         return MachineMaintenanceCategoryListModel.fromJson(item);
//       }).toList();
//
//     }
//     return listOfCategory;
//   }catch(e){
//     print(e);
//     rethrow;
//   }
// }

Future<List<MachineMaintenanceCategoryListModel>> fetchCategoryList() async{
  var response = await http.post(
    Uri.parse(Api.MACHINE_MAINTAINCE_CATEGORY_LIST),
    // body: params
  );
  try{
    final resp = json.decode(response.body);
    List<MachineMaintenanceCategoryListModel> listOfCategory=[];
    if( response.statusCode==200) {
      listOfCategory = resp['data'].map<MachineMaintenanceCategoryListModel>((item) {
        return MachineMaintenanceCategoryListModel.fromJson(item);
      }).toList();

    }
    return listOfCategory;
  }catch(e){
    print(e);
    rethrow;
  }
}