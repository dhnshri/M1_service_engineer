import 'dart:convert';
import '../Api/api.dart';
import '../Model/Transpotation/vehicle_name_model.dart';
import 'package:http/http.dart' as http;

import '../Model/Transpotation/vehicle_number_model.dart';
import '../Model/Transpotation/vehicle_type_model.dart';

Future<List<VehicleNumberModel>> fetchVehicleNumber(String userId) async{

  Map<String, String> params;
  params = {
    'service_user_id':'7',
    'transport_profile_vehicle_information_id':'1',
  };

  var response = await http.post(
      Uri.parse(Api.VEHICLE_NUMBER),
      body: params
  );

  try{
    final resp = json.decode(response.body);
    List<VehicleNumberModel> listOfVehicleNumber=[];
    if( response.statusCode==200) {
      listOfVehicleNumber = resp['data'].map<VehicleNumberModel>((item) {
        return VehicleNumberModel.fromJson(item);
      }).toList();

    }
    return listOfVehicleNumber;
  }catch(e){
    print(e);
    rethrow;
  }
}