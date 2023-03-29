import 'dart:convert';
import '../Api/api.dart';
import '../Model/JobWorkEnquiry/category_list_selected_model.dart';
import '../Model/MachineMaintance/machine_maintaince_category_list_model.dart';
import '../Model/Transpotation/vehicle_name_model.dart';
import 'package:http/http.dart' as http;

Future<List<JobWorkEnquiryCategoryListModel>> fetchJWECategoryList() async{

  Map<String, String> params;
  params = {
  };

  var response = await http.post(
      Uri.parse(Api.JOB_WORK_ENQUIRY_CATEGORY_LIST),
      body: params
  );

  try{
    final resp = json.decode(response.body);
    List<JobWorkEnquiryCategoryListModel> listOfCategory=[];
    if( response.statusCode==200) {
      listOfCategory = resp['data'].map<JobWorkEnquiryCategoryListModel>((item) {
        return JobWorkEnquiryCategoryListModel.fromJson(item);
      }).toList();

    }
    return listOfCategory;
  }catch(e){
    print(e);
    rethrow;
  }
}