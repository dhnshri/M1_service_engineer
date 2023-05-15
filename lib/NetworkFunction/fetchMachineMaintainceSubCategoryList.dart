import 'dart:convert';
import '../Api/api.dart';
import '../Model/MachineMaintance/machine_maintaince_sub_category_list.dart';
import '../Model/Transpotation/vehicle_name_model.dart';
import 'package:http/http.dart' as http;

// Future<List<MachineMaintenanceSubCategoryListModel>> fetchSubCategory(String userId) async{
//
//   Map<String, String> params;
//   params = {
//     'service_category_id':'1',
//   };
//
//   var response = await http.post(
//       Uri.parse(Api.MACHINE_MAINTAINCE_SUB_CATEGORY_LIST),
//       body: params
//   );
//
//   try{
//     final resp = json.decode(response.body);
//     List<MachineMaintenanceSubCategoryListModel> listOfSubCategory=[];
//     if( response.statusCode==200) {
//       listOfSubCategory = resp['data'].map<MachineMaintenanceSubCategoryListModel>((item) {
//         return MachineMaintenanceSubCategoryListModel.fromJson(item);
//       }).toList();
//
//     }
//     return listOfSubCategory;
//   }catch(e){
//     print(e);
//     rethrow;
//   }
// }

Future<List<MachineMaintenanceSubCategoryListModel>> fetchSubCategory(String userId) async{

  Map<String, String> params;
  params = {
    // 'category_id': categoryData==null?"":categoryData.catId.toString(),
    'service_category_id': userId.toString(),
  };

  var response = await http.post(
      Uri.parse(Api.MACHINE_MAINTAINCE_SUB_CATEGORY_LIST),
      body: params
  );

  try{
    final resp = json.decode(response.body);
    List<MachineMaintenanceSubCategoryListModel> listOfsubCategory=[];
    MachineMaintenanceSubCategoryListModel subcategory;
    if (response.statusCode == 200) {
      listOfsubCategory = resp['data'].map<MachineMaintenanceSubCategoryListModel>((item) {
        return MachineMaintenanceSubCategoryListModel.fromJson(item);
      }).toList();
    }else{
      subcategory=MachineMaintenanceSubCategoryListModel();
      subcategory.serviceSubCategoryName='Select Category';
      listOfsubCategory.add(subcategory);
    }
    return listOfsubCategory;
  }catch(e){
    print(e);
    rethrow;
  }
}