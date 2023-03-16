import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:bloc/bloc.dart';
import 'package:service_engineer/Model/product_repo.dart';
import 'package:service_engineer/Model/quotation_reply_detail_repo.dart';
import 'package:service_engineer/Model/service_request_detail_repo.dart';
import 'package:service_engineer/Model/service_request_repo.dart';
import 'package:service_engineer/Repository/UserRepository.dart';

import '../../Model/JobWorkEnquiry/my_task_model.dart';
import '../../Model/JobWorkEnquiry/quotation_reply.dart';
import '../../Model/JobWorkEnquiry/service_request_model.dart';
import '../../Model/MachineMaintance/myTaskModel.dart';
import '../../Model/MachineMaintance/quotationReply.dart';
import '../../Model/Transpotation/quotationReplyModel.dart';
import '../../Model/track_process_repo.dart';
import 'quotationReply_event.dart';
import 'quotationReply_state.dart';


class QuotationReplyBloc extends Bloc<QuotationReplyEvent, QuotationReplyState> {
  QuotationReplyBloc({this.userRepository}) : super(InitialQuotationReplyState());
  final UserRepository? userRepository;


  @override
  Stream<QuotationReplyState> mapEventToState(event) async* {

    // Machine Maintaince QuotationReply List
    if (event is OnQuotationReplyMachineMaintainceList) {
      ///Notify loading to UI
      yield QuotationReplyLoading(
        isLoading: false,
      );

      ///Fetch API via repository
      final QuotationReplyRepo result = await userRepository!
          .fetchQuotationReplyList(
        offSet: event.offSet,
        userId: event.userId

      );
      print(result);

      ///Case API fail but not have token
      if (result.success == true) {
        ///Home API success
        final Iterable refactorQuotationReplyList = result.data! ?? [];
        final quotationReplyList = refactorQuotationReplyList.map((item) {
          return QuotationReplyModel.fromJson(item);
        }).toList();
        print('Quotation Reply List: $QuotationReplySuccess');
        try {
          ///Begin start AuthBloc Event AuthenticationSave
          yield QuotationReplyLoading(
            isLoading: true,
          );
          yield QuotationReplySuccess(quotationReplyListData: quotationReplyList, message: result.msg!);
        } catch (error) {
          ///Notify loading to UI
          yield QuotationReplyFail(msg: result.msg!);
        }
      } else {
        ///Notify loading to UI
        yield QuotationReplyLoading(isLoading: false);
        yield QuotationReplyFail(msg: result.msg!);
      }
    }

    //Machine Maintainance Quotation reply detail
    if (event is MachineQuotationReplyDetail) {
      ///Notify loading to UI
      yield MachineQuotationReplyDetailLoading(
        isLoading: false,
      );

      ///Fetch API via repository
      final QuotaionReplyDetailRepo result = await userRepository!
          .fetchMachineQuotationReplyDetail(
          machineEnquiryId: event.machineEnquiryId,
          customerUserId: event.customerUserId
      );
      print(result);


      if (result.success == true) {
        ///For Required Item List
        final Iterable refactorRequiredItemList = result.quotationRequiredItems! ?? [];
        final requiredItemList = refactorRequiredItemList.map((item) {
          return QuotationRequiredItems.fromJson(item);
        }).toList();
        print('Quotation Reply List: $requiredItemList');

        ///For other Item List
        final Iterable refactorOtherItemList = result.quotationOtherItems! ?? [];
        final otherItemList = refactorOtherItemList.map((item) {
          return QuotationRequiredItems.fromJson(item);
        }).toList();
        print('Quotation Reply List: $otherItemList');

        ///For Quotation Charges
        final Iterable refactorQuotationChargesList = result.quotationCharges! ?? [];
        final quotationChargesList = refactorQuotationChargesList.map((item) {
          return QuotationCharges.fromJson(item);
        }).toList();
        print('Quotation Reply List: $quotationChargesList');

        ///For Customer Message
        final Iterable refactormMsgList = result.customerReplyMsg! ?? [];
        final msgsList = refactormMsgList.map((item) {
          return CustomerReplyMsg.fromJson(item);
        }).toList();
        print('Quotation Reply List: $msgsList');

        try {
          ///Begin start AuthBloc Event AuthenticationSave
          yield MachineQuotationReplyDetailLoading(
            isLoading: true,
          );
          yield MachineQuotationReplyDetailSuccess(quotationRequiredItemList: requiredItemList,
            quotationOtherItemList: otherItemList,quotationChargesList: quotationChargesList,quotationMsgList: msgsList);
        } catch (error) {
          ///Notify loading to UI
          yield MachineQuotationReplyDetailFail(msg: '');
        }
      } else {
        ///Notify loading to UI
        yield MachineQuotationReplyDetailLoading(isLoading: false);
        yield MachineQuotationReplyDetailFail(msg: '');
      }
    }


    // job work enquiry QuotationReply List
    if (event is OnQuotationReplyJWEList) {
      ///Notify loading to UI
      yield QuotationReplyJWELoading(
        isLoading: false,
      );

      ///Fetch API via repository
      final QuotationReplyJWERepo result = await userRepository!
          .fetchQuotationReplyJWEList(
        offSet: event.offSet,
        userId: event.userId
      );
      print(result);

      ///Case API fail but not have token
      if (result.success == true) {
        ///Home API success
        final Iterable refactorQuotationReplyJWEList = result.data! ?? [];
        final quotationReplyJWList = refactorQuotationReplyJWEList.map((item) {
          return QuotationReplyJobWorkEnquiryModel.fromJson(item);
        }).toList();
        print('Quotation Reply List: $QuotationReplyJWESuccess');
        try {
          ///Begin start AuthBloc Event AuthenticationSave
          yield QuotationReplyJWELoading(
            isLoading: true,
          );
          yield QuotationReplyJWESuccess(quotationReplyJWEListData:quotationReplyJWList, message: result.msg!);
        } catch (error) {
          ///Notify loading to UI
          yield QuotationReplyJWEFail(msg: result.msg!);
        }
      } else {
        ///Notify loading to UI
        yield QuotationReplyJWELoading(isLoading: false);
        yield QuotationReplyJWEFail(msg: result.msg!);
      }
    }


    //Job Work Quotation reply detail
    if (event is JobWorkQuotationReplyDetail) {
      ///Notify loading to UI
      yield JobWorkQuotationReplyDetailLoading(
        isLoading: false,
      );

      ///Fetch API via repository
      final JobWorkQuotaionReplyDetailRepo result = await userRepository!
          .fetchJobWorkQuotationReplyDetail(
          jobWorkEnquiryId: event.jobWorkEnquiryId,
          customerUserId: event.customerUserId
      );
      print(result);


      if (result.success == true) {
        ///For Required Item List
        final Iterable refactorRequiredItemList = result.quotationRequiredItems! ?? [];
        final requiredItemList = refactorRequiredItemList.map((item) {
          return QuotationRequiredItems.fromJson(item);
        }).toList();
        print('Quotation Reply List: $requiredItemList');


        ///For Quotation Charges
        final Iterable refactorQuotationChargesList = result.quotationCharges! ?? [];
        final quotationChargesList = refactorQuotationChargesList.map((item) {
          return QuotationCharges.fromJson(item);
        }).toList();
        print('Quotation Reply List: $quotationChargesList');

        ///For Customer Message
        final Iterable refactormMsgList = result.customerReplyMsg! ?? [];
        final msgsList = refactormMsgList.map((item) {
          return CustomerReplyMsg.fromJson(item);
        }).toList();
        print('Quotation Reply List: $msgsList');

        try {
          ///Begin start AuthBloc Event AuthenticationSave
          yield JobWorkQuotationReplyDetailLoading(
            isLoading: true,
          );
          yield JobWorkQuotationReplyDetailSuccess(quotationRequiredItemList: requiredItemList,
              quotationChargesList: quotationChargesList,quotationMsgList: msgsList);
        } catch (error) {
          ///Notify loading to UI
          yield JobWorkQuotationReplyDetailFail(msg: '');
        }
      } else {
        ///Notify loading to UI
        yield JobWorkQuotationReplyDetailLoading(isLoading: false);
        yield JobWorkQuotationReplyDetailFail(msg: '');
      }
    }

    if (event is JobWorkSendRevisedQuotation) {
      ///Notify loading to UI
      yield JobWorkSendRevisedQuotationLoading(isLoading: false);

      var itemList = [];

      for(int j = 0; j < event.itemList.length; j++){
        var innerObj ={};
        double amount = double.parse(event.itemList[j].itemQty
            .toString()) * int.parse(event.itemRateController[j].text);

        innerObj["item_name"] = event.itemList[j].itemName;
        innerObj["item_qty"] = event.itemList[j].itemQty;
        innerObj["volume"] = event.volumeController[j].text;
        innerObj["rate"] = event.itemRateController[j].text;
        innerObj["amount"] = amount;
        itemList.add(innerObj);
      }


      Map<String, String> params = {
        "job_work_enquiry_id": event.jobWorkEnquiryId.toString(),
        "service_user_id":event.serviceUserId,
        "job_work_enquiry_date":event.jobWorkEnquirydate,
        "transport_charge":event.transportCharge,
        "packing_charge":event.packingCharge,
        "testing_charge":event.testingCharge,
        "cgst": event.cgst,
        "sgst": event.sgst,
        "igst": event.igst,
        "commission": event.commission,
        "itemslist": jsonEncode(itemList),
        // 'machine_enquiry_id': event.machineEnquiryId,
      };

      http.MultipartRequest _request = http.MultipartRequest('POST', Uri.parse('http://mone.ezii.live/service_engineer/job_work_enquiry_quatation'));
      // ..fields.addAll(params);
      _request = jsonToFormData(_request, params);
      print(jsonEncode(_request.fields));
      var streamResponse = await _request.send();
      var response = await http.Response.fromStream(streamResponse);
      final responseJson = json.decode(response.body);
      print(responseJson);
      CreateTaskRepo res =  CreateTaskRepo.fromJson(responseJson);
      print(res.msg);


      ///Case API fail but not have token
      if (res.success == true) {
        print(response.body);
        yield JobWorkSendRevisedQuotationSuccess(message: res.msg.toString());

      } else {
        ///Notify loading to UI
        yield JobWorkSendRevisedQuotationFail(msg: res.msg.toString());
        print(response.body);
      }
    }


    // Transpotation QuotationReply List
    if (event is OnQuotationReplyTranspotationList) {
      ///Notify loading to UI
      yield QuotationReplyTransportLoading(
        isLoading: false,
      );

      ///Fetch API via repository
      final QuotationReplyTransportRepo result = await userRepository!
          .fetchQuotationReplyTranspotationList(
        offSet: event.offSet,
        service_user_id:event.service_user_id,
      );
      print(result);

      ///Case API fail but not have token
      if (result.success == true) {
        ///Home API success
        final Iterable refactorQuotationReplyList = result.data! ?? [];
        final quotationReplyList = refactorQuotationReplyList.map((item) {
          return QuotationReplyTransportModel.fromJson(item);
        }).toList();
        print('Quotation Reply List: $QuotationReplySuccess');
        try {
          ///Begin start AuthBloc Event AuthenticationSave
          yield QuotationReplyTransportLoading(
            isLoading: true,
          );
          yield QuotationReplyTransportSuccess(quotationReplyTransportListData: quotationReplyList, message: result.msg!);
        } catch (error) {
          ///Notify loading to UI
          yield QuotationReplyTransportFail(msg: result.msg!);
        }
      } else {
        ///Notify loading to UI
        yield QuotationReplyTransportLoading(isLoading: false);
        yield QuotationReplyTransportFail(msg: result.msg!);
      }
    }

    //Job Work Quotation reply detail
    if (event is TransportQuotationReplyDetail) {
      ///Notify loading to UI
      yield TransportQuotationReplyDetailLoading(
        isLoading: false,
      );

      ///Fetch API via repository
      final TransportQuotaionReplyDetailRepo result = await userRepository!
          .fetchTransportQuotationReplyDetail(
          transportEnquiryId: event.transportEnquiryId,
          customerUserId: event.customerUserId
      );
      print(result);


      if (result.success == true) {
        ///For Required Item List
        final Iterable refactorVehicleDetailsList = result.vehicleDetails! ?? [];
        final vehicleDetailsList = refactorVehicleDetailsList.map((item) {
          return VehicleDetails.fromJson(item);
        }).toList();
        print('Quotation Reply List: $vehicleDetailsList');


        ///For Quotation Charges
        final Iterable refactorQuotationDetailsList = result.quotationDetails! ?? [];
        final quotationDetailsList = refactorQuotationDetailsList.map((item) {
          return QuotationCharges.fromJson(item);
        }).toList();
        print('Quotation Reply List: $quotationDetailsList');

        ///For Quotation Charges
        final Iterable refactorQuotationChargesList = result.quotationCharges! ?? [];
        final quotationChargesList = refactorQuotationChargesList.map((item) {
          return QuotationCharges.fromJson(item);
        }).toList();
        print('Quotation Reply List: $quotationChargesList');

        ///For Customer Message
        final Iterable refactormMsgList = result.customerReplyMsg! ?? [];
        final msgsList = refactormMsgList.map((item) {
          return CustomerReplyMsg.fromJson(item);
        }).toList();
        print('Quotation Reply List: $msgsList');

        try {
          ///Begin start AuthBloc Event AuthenticationSave
          yield TransportQuotationReplyDetailLoading(
            isLoading: true,
          );
          yield TransportQuotationReplyDetailSuccess(vehicleDetailsList: vehicleDetailsList,
              quotationChargesList: quotationChargesList,quotationMsgList: msgsList, quotationDetailsList: quotationDetailsList);
        } catch (error) {
          ///Notify loading to UI
          yield TransportQuotationReplyDetailFail(msg: '');
        }
      } else {
        ///Notify loading to UI
        yield TransportQuotationReplyDetailLoading(isLoading: false);
        yield TransportQuotationReplyDetailFail(msg: '');
      }
    }
  }


}
jsonToFormData(http.MultipartRequest request, Map<String, dynamic> data) {
  for (var key in data.keys) {
    request.fields[key] = data[key].toString();
  }
  return request;
}