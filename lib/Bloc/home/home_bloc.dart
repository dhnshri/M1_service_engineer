import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:bloc/bloc.dart';
import 'package:service_engineer/Model/cart_repo.dart';
import 'package:service_engineer/Model/product_repo.dart';
import 'package:service_engineer/Model/service_request_detail_repo.dart';
import 'package:service_engineer/Model/service_request_repo.dart';
import 'package:service_engineer/Model/track_process_repo.dart';
import 'package:service_engineer/Repository/UserRepository.dart';

import '../../Model/MachineMaintance/myTaskModel.dart';
import '../../Model/cart_list_repo.dart';
import 'home_event.dart';
import 'home_state.dart';


class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({this.userRepository}) : super(InitialHomeState());
  final UserRepository? userRepository;


  @override
  Stream<HomeState> mapEventToState(event) async* {


    //Event for Service Request
    if (event is OnServiceRequest) {
      ///Notify loading to UI
      yield ServiceRequestLoading(
        isLoading: false,
      );

      ///Fetch API via repository
      final ServiceRequestRepo result = await userRepository!
          .fetchServiceRequestList(
        offSet: event.offSet,
        userID: event.userID,
      );
      print(result);

      ///Case API fail but not have token
      if (result.success == true) {
        ///Home API success
        final Iterable refactorServiceRequestList = result.data! ?? [];
        final serviceRequestList = refactorServiceRequestList.map((item) {
          return ServiceRequestModel.fromJson(item);
        }).toList();
        print('Service Request List: $serviceRequestList');
        try {
          ///Begin start AuthBloc Event AuthenticationSave
          yield ServiceRequestLoading(
              isLoading: true,
          );
          yield ServiceRequestSuccess(serviceListData: serviceRequestList, message: result.msg!);
        } catch (error) {
          ///Notify loading to UI
          yield ServiceRequestFail(msg: result.msg!);
        }
      } else {
        ///Notify loading to UI
        yield MyTaskLoading(isLoading: false);
        yield ServiceRequestFail(msg: result.msg!);
      }
    }

    //Event for My Task List
    if (event is MyTaskList) {
      ///Notify loading to UI
      yield MyTaskLoading(isLoading: false);

      ///Fetch API via repository
      final MyTaskRepo response = await userRepository!
          .fetchMachineMaintainceMyTaskList(
          userId: event.userid,
          offset:event.offset
      );
      print(response);

      if(response.success == true){
        final Iterable refactorMyTask = response.data ?? [];
        final listMyTask = refactorMyTask.map((item) {
          return MyTaskModel.fromJson(item);
        }).toList();

        print("Task List: $listMyTask");

        try{
          yield MyTaskLoading(isLoading: true);
          yield MyTaskListSuccess(MyTaskList: listMyTask);
        }catch(error){
          yield MyTaskLoading(isLoading: false);
          yield MyTaskListLoadFail(msg: response.msg);
        }
      }
      else {
        ///Notify loading to UI
        yield MyTaskLoading(isLoading: false);
        yield MyTaskListLoadFail(msg: response.msg);
      }
    }


    //Event for Service Request Detail
    if (event is OnServiceRequestDetail) {
      ///Notify loading to UI
      yield ServiceRequestDetailLoading(isLoading: false);

      ///Fetch API via repository
      final ServiceRequestDetailRepo result = await userRepository!
          .fetchServiceRequestDetail(
        userID: event.userID,
        machineEnquiryId: event.machineServiceId,
        jobWorkEnquiryId: event.jobWorkServiceId,
        transportEnquiryId: event.transportServiceId
      );
      print(result);

      ///Case API fail but not have token
      if (result.success == true) {
        ///Home API success
        final Iterable refactorServiceRequestDetail = result.machineServiceDetails! ?? [];
        final serviceRequestDetail = refactorServiceRequestDetail.map((item) {
          return MachineServiceDetailsModel.fromJson(item);
        }).toList();
        // MachineServiceDetailsModel data = MachineServiceDetailsModel();
        // data = refactorServiceRequestList as MachineServiceDetailsModel;
        print('Service Request Data: $serviceRequestDetail');
        try {
          ///Begin start AuthBloc Event AuthenticationSave
          yield ServiceRequestLoading(
            isLoading: true,
          );
          yield ServiceRequestDetailSuccess(machineServiceDetail: serviceRequestDetail, message: result.msg!);
        } catch (error) {
          ///Notify loading to UI
          yield ServiceRequestDetailFail(msg: result.msg!);
        }
      } else {
        ///Notify loading to UI
        yield ServiceRequestDetailFail(msg: result.msg!);
      }
    }

    //Product List
    if (event is ProductList) {
      ///Notify loading to UI
      yield ProductListLoading(isLoading: false);

      ///Fetch API via repository
      final ProductRepo result = await userRepository!
          .fetchProductList(
        prodId: event.prodId,
        offset: event.offSet
      );
      print(result);

      ///Case API fail but not have token
      if (result.success == true) {
        ///Home API success
        final Iterable refactorProductList = result.data!['product_details'] ?? [];
        final productList = refactorProductList.map((item) {
          return ProductDetails.fromJson(item);
        }).toList();
        // MachineServiceDetailsModel data = MachineServiceDetailsModel();
        // data = refactorServiceRequestList as MachineServiceDetailsModel;
        print('Service Request Data: $productList');
        try {
          ///Begin start AuthBloc Event AuthenticationSave
          yield ProductListLoading(
            isLoading: true,
          );
          yield ProductListSuccess(productList: productList, message: '');
        } catch (error) {
          ///Notify loading to UI
          yield ProductListFail(msg: 'Failed to fetch data.');
        }
      } else {
        ///Notify loading to UI
        yield ProductListFail(msg: 'Failed to fetch data.');
      }
    }

    //Add to Cart
    if (event is AddToCart) {
      ///Notify loading to UI
      yield AddToCartLoading(isLoading: false);

      ///Fetch API via repository
      final CartRepo result = await userRepository!
          .addToCart(
          prodId: event.prodId,
          userId: event.userId,
          quantity: event.quantity
      );
      print(result);

      ///Case API fail but not have token
      if (result.success == true) {

        try {
          ///Begin start AuthBloc Event AuthenticationSave
          yield AddToCartLoading(
            isLoading: true,
          );
          yield AddToCartSuccess( message: result.data);
        } catch (error) {
          ///Notify loading to UI
          yield AddToCartFail(msg: result.data);
        }
      } else {
        ///Notify loading to UI
        yield AddToCartFail(msg: result.data);
      }
    }

    //Cart List
    if (event is CartList) {
      ///Notify loading to UI
      yield CartListLoading(isLoading: false);

      ///Fetch API via repository
      final CartListRepo result = await userRepository!
          .fetchCartList(
          userId: event.userId,
      );
      print(result);

      ///Case API fail but not have token
      if (result.success == true) {
        final Iterable refactorCartList = result.data! ?? [];
        final cartList = refactorCartList.map((item) {
          return CartListModel.fromJson(item);
        }).toList();
        // MachineServiceDetailsModel data = MachineServiceDetailsModel();
        // data = refactorServiceRequestList as MachineServiceDetailsModel;
        print('Service Request Data: $cartList');

        try {
          ///Begin start AuthBloc Event AuthenticationSave
          yield CartListLoading(
            isLoading: true,
          );
          yield CartListSuccess(cartList: cartList, message: result.msg!);
        } catch (error) {
          ///Notify loading to UI
          yield CartListFail(msg: result.msg);
        }
      } else {
        ///Notify loading to UI
        yield CartListFail(msg: result.msg);
      }
    }


    //My Task Track Process
    if (event is TrackProcessList) {
      ///Notify loading to UI
      yield TrackProcssListLoading(isLoading: false);

      ///Fetch API via repository
      final TrackProcessRepo result = await userRepository!
          .fetchTrackProgressList(
        userId: event.userId,
        machineEnquiryId: event.machineEnquiryId,
        transportEnquiryId: event.transportEnquiryId,
        jobWorkWnquiryId: event.jobWorkEnquiryId
      );
      print(result);

      ///Case API fail but not have token
      if (result.success == true) {
        final Iterable refactorTrackProgrssList = result.data! ?? [];
        final trackProgressList = refactorTrackProgrssList.map((item) {
          return TrackProcessModel.fromJson(item);
        }).toList();
        // MachineServiceDetailsModel data = MachineServiceDetailsModel();
        // data = refactorServiceRequestList as MachineServiceDetailsModel;
        print('Service Request Data: $trackProgressList');

        try {
          ///Begin start AuthBloc Event AuthenticationSave
          yield TrackProcssListLoading(
            isLoading: true,
          );
          yield TrackProcssListSuccess(trackProgressList: trackProgressList, message: result.msg!);
        } catch (error) {
          ///Notify loading to UI
          yield TrackProcssListFail(msg: result.msg);
        }
      } else {
        ///Notify loading to UI
        yield TrackProcssListFail(msg: result.msg);
      }
    }

    //Create Task
    if (event is CreateTask) {
      ///Notify loading to UI
      yield CreateTaskLoading(isLoading: false);

      ///Fetch API via repository
      final CreateTaskRepo result = await userRepository!
          .createTask(
        userId: event.userId,
        machineEnquiryId: event.machineEnquiryId,
        transportEnquiryId: event.transportEnquiryId,
        jobWorkWnquiryId: event.jobWorkEnquiryId,
        heading: event.heading,
        description: event.description,
        status: event.status
      );
      print(result);

      ///Case API fail but not have token
      if (result.success == true) {
        try {
          ///Begin start AuthBloc Event AuthenticationSave
          yield CreateTaskLoading(
            isLoading: true,
          );
          yield CreateTaskSuccess( message: result.msg!);
        } catch (error) {
          ///Notify loading to UI
          yield CreateTaskFail(msg: result.msg);
        }
      } else {
        ///Notify loading to UI
        yield CreateTaskFail(msg: result.msg);
      }
    }

    //Mark Task Complete
    if (event is TaskComplete) {
      ///Notify loading to UI
      yield TaskCompleteLoading(isLoading: false);

      ///Fetch API via repository
      final CreateTaskRepo result = await userRepository!
          .completeTask(
          serviceUserId: event.serviceUserId,
          machineEnquiryId: event.machineEnquiryId,
          transportEnquiryId: event.transportEnquiryId,
          jobWorkWnquiryId: event.jobWorkEnquiryId,
          dailyTaskId: event.dailyTaskId,
          status: event.status
      );
      print(result);

      ///Case API fail but not have token
      if (result.success == true) {
        try {
          ///Begin start AuthBloc Event AuthenticationSave
          yield TaskCompleteLoading(
            isLoading: true,
          );
          yield TaskCompleteSuccess( message: result.msg!);
        } catch (error) {
          ///Notify loading to UI
          yield TaskCompleteFail(msg: result.msg);
        }
      } else {
        ///Notify loading to UI
        yield TaskCompleteFail(msg: result.msg);
      }
    }

    //Send Quotation
    if (event is SendQuotation) {
      ///Notify loading to UI
      yield SendQuotationLoading(isLoading: false);

      ///Fetch API via repository
      // final CreateTaskRepo result = await userRepository!
      //     .SendQuotationPara(
      //     serviceUserId: event.serviceUserId,
      //     workingTime: event.workingTime,
      //     dateOfJoining: event.dateOfJoining,
      //     serviceCharge: event.serviceCharge,
      //     handlingCharge: event.handlingCharge,
      //     transportCharge: event.handlingCharge,
      //     itemList: event.itemList,
      //     itemNotAvailableList: event.itemNotAvailableList,
      //     commission: event.commission,
      //     machineEnqDate: event.machineEnquiryDate,
      //     machineEnqId: event.machineEnquiryId,
      //
      // );
      var itemList = [];
      var itemNotAvalList = [];

      for(int j = 0; j < event.itemList.length; j++){

        var innerObj ={};
        double amount = int.parse(event.itemList[j].discountPrice.toString()) * 100/100+int.parse(event.itemList[j].gst.toString());

        double amountWithGST = amount *
            int.parse(event.itemList[j].qty.toString());

        innerObj["item_id"] = event.itemList[j].productId;
        innerObj["item_qty"] = event.itemList[j].qty;
        innerObj["item_size"] = '';
        innerObj["rate"] = event.itemList[j].discountPrice;
        innerObj["amount"] = amountWithGST;
        innerObj["gst"] = event.itemList[j].gst;
        itemList.add(innerObj);
      }

      for(int j = 0; j < event.itemNotAvailableList.length; j++){

        var innerObj ={};

        innerObj["item_id"] = event.itemNotAvailableList[j].id;
        innerObj["item_qty"] = event.itemNotAvailableList[j].quantity;
        innerObj["item_size"] = '';
        innerObj["rate"] = event.itemNotAvailableList[j].rate;
        innerObj["amount"] = event.itemNotAvailableList[j].amount;
        innerObj["gst"] = event.itemNotAvailableList[j].gst;
        itemNotAvalList.add(innerObj);
      }

      Map<String, String> params = {
        "machine_enquiry_id": event.machineEnquiryId.toString(),
        "service_user_id":event.serviceUserId,
        "working_time":event.workingTime,
        "date_of_joining":event.dateOfJoining,
        "service_charge":event.serviceCharge == "" ? '0' : event.serviceCharge,
        "handling_charge":event.handlingCharge == "" ? '0' : event.handlingCharge,
        "transport_charge": event.transportCharge == "" ? '0' : event.transportCharge,
        "items_available": jsonEncode(itemList),
        "items_not_available": jsonEncode(itemNotAvalList),
        "commission": event.commission,
        "machine_enquiry_date": event.machineEnquiryDate,
        // 'machine_enquiry_id': event.machineEnquiryId,
      };



      // var response = await http.MultipartRequest(
      //     'POST',Uri.parse('http://mone.ezii.live/service_engineer/machine_maintainence_quatation')
      // );
      // response.fields.addAll(params);
      // var _response = await response.send();

      // final response = await http.post(
      //     Uri.parse('http://mone.ezii.live/service_engineer/machine_maintainence_quatation'),
      //     body: jsonEncode(params)
      // );



      http.MultipartRequest _request = http.MultipartRequest('POST', Uri.parse('http://mone.ezii.live/service_engineer/machine_maintainence_quatation'));
      // ..fields.addAll(params);
      _request = jsonToFormData(_request, params);
      print(jsonEncode(_request.fields));
      // print(jsonDecode(_request.fields));
      var streamResponse = await _request.send();
      var response = await http.Response.fromStream(streamResponse);
      // var responseData = json.decode(jsonEncode(response.body));
      // print(responseData);
      final responseJson = json.decode(response.body);
      print(responseJson);
      CreateTaskRepo res =  CreateTaskRepo.fromJson(responseJson);
      print(res.msg);
      // print(response);
      // _request.fields['']
      // _request.fields['machine_enquiry_id']= event.machineEnquiryId.toString();
      // _request.fields["service_user_id"]=event.serviceUserId;
      // _request.fields['working_time']=event.workingTime;
      // _request.fields['date_of_joining']=event.dateOfJoining;
      // _request.fields['service_charge']=event.serviceCharge == "" ? '0' : event.serviceCharge;
      // _request.fields["handling_charge"]=event.handlingCharge == "" ? '0' : event.handlingCharge;
      // _request.fields['transport_charge']= event.transportCharge == "" ? '0' : event.transportCharge;
      // _request.fields['items_available']= itemList.toString();
      // _request.fields['items_not_available']= itemNotAvalList.toString();
      // _request.fields['commission']= event.commission;
      // _request.fields['machine_enquiry_date']= event.machineEnquiryDate;
      // var _response = await _request.send();
      // print(_response.statusCode);
      // var data= jsonEncode(_request.fields);
      // print(jsonEncode(_request.fields));
      // final response = await http.Response.fromStream(_response);
      // var responseData = json.decode(jsonEncode(response.body));
      // print(responseData);
      // print(jsonEncode(params));

      // if (response.statusCode == 200) {
      //   print(response);
      //
      // }

      ///Case API fail but not have token
      if (res.success == true) {
        print(response.body);
        yield SendQuotationSuccess(message: res.msg.toString());

      } else {
        ///Notify loading to UI
        yield SendQuotationFail(msg: res.msg.toString());
        print(response.body);
      }
    }


  }
  jsonToFormData(http.MultipartRequest request, Map<String, dynamic> data) {
    for (var key in data.keys) {
      request.fields[key] = data[key].toString();
    }
    return request;
  }

}
