import 'dart:convert';
import '../Api/api.dart';
import '../Model/Transpotation/vehicle_name_model.dart';
import 'package:http/http.dart' as http;

Future<List<VehicleNameModel>> fetchVehicleName(String userId) async{

  Map<String, String> params;
  params = {
    'service_user_id':'7',
  };

  var response = await http.post(
      Uri.parse(Api.VEHICLE_NAME),
      body: params
  );

  try{
    final resp = json.decode(response.body);
    List<VehicleNameModel> listOfVehicleName=[];
    if( response.statusCode==200) {
      listOfVehicleName = resp['data'].map<VehicleNameModel>((item) {
        return VehicleNameModel.fromJson(item);
      }).toList();

    }
    return listOfVehicleName;
  }catch(e){
    print(e);
    rethrow;
  }
}