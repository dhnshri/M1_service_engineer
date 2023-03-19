import 'dart:convert';
import '../Api/api.dart';
import '../Model/Transpotation/vehicle_name_model.dart';
import 'package:http/http.dart' as http;

import '../Model/Transpotation/vehicle_type_model.dart';

Future<List<VehicleTypeModel>> fetchVehicleType(String userId) async{

  Map<String, String> params;
  params = {
    'service_user_id':'7',
    'transport_profile_vehicle_information_id':'1',
  };

  var response = await http.post(
      Uri.parse(Api.VEHICLE_TYPE),
      body: params
  );

  try{
    final resp = json.decode(response.body);
    List<VehicleTypeModel> listOfVehicleType=[];
    if( response.statusCode==200) {
      listOfVehicleType = resp['data'].map<VehicleTypeModel>((item) {
        return VehicleTypeModel.fromJson(item);
      }).toList();

    }
    return listOfVehicleType;
  }catch(e){
    print(e);
    rethrow;
  }
}