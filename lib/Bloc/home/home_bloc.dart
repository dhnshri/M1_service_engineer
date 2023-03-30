import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:bloc/bloc.dart';
import 'package:service_engineer/Bloc/home/home_event.dart';
import 'package:service_engineer/Bloc/home/home_state.dart';
import 'package:service_engineer/Model/cart_repo.dart';
import 'package:service_engineer/Model/filter_repo.dart';
import 'package:service_engineer/Model/product_repo.dart';
import 'package:service_engineer/Model/quotation_reply_detail_repo.dart';
import 'package:service_engineer/Model/service_request_detail_repo.dart';
import 'package:service_engineer/Model/service_request_repo.dart';
import 'package:service_engineer/Model/track_model.dart';
import 'package:service_engineer/Model/track_process_repo.dart';
import 'package:service_engineer/Repository/UserRepository.dart';

import '../../../Model/JobWorkEnquiry/my_task_detail_model.dart';
import '../../../Model/JobWorkEnquiry/my_task_model.dart';
import '../../../Model/JobWorkEnquiry/service_request_detail_model.dart';
import '../../../Model/JobWorkEnquiry/task_hand_over_jwe_model.dart';
import '../../../Model/MachineMaintance/myTaskModel.dart';
import '../../../Model/MachineMaintance/task_hand_over_model.dart';
import '../../../Model/Transpotation/MyTaskTransportDetailModel.dart';
import '../../../Model/Transpotation/serviceRequestDetailModel.dart';
import '../../../Model/Transpotation/transport_task_hand_over_model.dart';
import '../../Model/JobWorkEnquiry/daily_Task_Add_model.dart';
import '../../Model/JobWorkEnquiry/my_task_detail_model.dart';
import '../../Model/JobWorkEnquiry/my_task_model.dart';
import '../../Model/JobWorkEnquiry/service_request_detail_model.dart';
import '../../Model/JobWorkEnquiry/service_request_model.dart';
import '../../Model/JobWorkEnquiry/task_hand_over_jwe_model.dart';
import '../../Model/JobWorkEnquiry/track_process_report_model.dart';
import '../../Model/MachineMaintance/myTaskModel.dart';
import '../../Model/MachineMaintance/task_hand_over_model.dart';
import '../../Model/Transpotation/MyTaskTransportDetailModel.dart';
import '../../Model/Transpotation/serviceRequestDetailModel.dart';
import '../../Model/Transpotation/transport_task_hand_over_model.dart';
import '../../Model/cart_list_repo.dart';
import '../../Model/MachineMaintance/quotationReply.dart';
import '../../Model/Transpotation/myTaskListModel.dart';
import '../../Model/Transpotation/serviceRequestListModel.dart';
import 'home_event.dart';
import 'home_state.dart';


class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({this.userRepository}) : super(InitialHomeState());
  final UserRepository? userRepository;
  bool isFetching = false;


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
        timeId: event.timeId
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
        yield MyTaskLoading(isLoading: true);
        yield ServiceRequestFail(msg: result.msg!);
      }
    }

    ///Machine HandOver Service List
    if (event is MachineHandOverServiceRequestList) {  }

    // if (event is ItemFilter) {
    //   ///Notify loading to UI
    //   yield MachineHandOverServiceRequestListLoading(
    //     isLoading: false,
    //   );
    //
    //   ///Fetch API via repository
    //   final ServiceRequestRepo result = await userRepository!
    //       .fetchMachineHandOverServiceRequestListList(
    //     offSet: event.offSet,
    //     timeId: event.timeId,
    //     serviceUserId: event.serviceUserId,
    //   );
    //   print(result);
    //
    //   ///Case API fail but not have token
    //   if (result.success == true) {
    //     ///Home API success
    //     final Iterable refactorServiceRequestList = result.data! ?? [];
    //     final serviceRequestList = refactorServiceRequestList.map((item) {
    //       return ServiceRequestModel.fromJson(item);
    //     }).toList();
    //     print('Service Request List: $serviceRequestList');
    //     try {
    //       ///Begin start AuthBloc Event AuthenticationSave
    //       yield MachineHandOverServiceRequestListLoading(
    //         isLoading: true,
    //       );
    //       yield MachineHandOverServiceRequestListSuccess(serviceListData: serviceRequestList, message: result.msg!);
    //     } catch (error) {
    //       ///Notify loading to UI
    //       yield MachineHandOverServiceRequestListFail(msg: result.msg!);
    //     }
    //   } else {
    //     ///Notify loading to UI
    //     yield MachineHandOverServiceRequestListLoading(isLoading: true);
    //     yield MachineHandOverServiceRequestListFail(msg: result.msg!);
    //   }
    // }

    ///Machine Handover Task Detail
    if (event is MachineHandOverTaskDetail) {
      ///Notify loading to UI
      yield MachineHandOverTaskDetailLoading(
        isLoading: false,
      );

      ///Fetch API via repository
      final ServiceRequestRepo result = await userRepository!
          .fetchMachineHandOverDetailData(
        dailyTaskId: event.dailyTaskId,
        serviceUserId: event.serviceUserID,
      );
      print(result);

      ///Case API fail but not have token
      if (result.success == true) {
        ///Home API success
        final Iterable refactorServiceRequestList = result.data! ?? [];
        final serviceRequestList = refactorServiceRequestList.map((item) {
          return HandOverTaskDetailModel.fromJson(item);
        }).toList();
        print('Service Request List: $serviceRequestList');
        try {
          ///Begin start AuthBloc Event AuthenticationSave
          yield MachineHandOverTaskDetailLoading(
            isLoading: true,
          );
          yield MachineHandOverTaskDetailSuccess(serviceListData: serviceRequestList);
        } catch (error) {
          ///Notify loading to UI
          yield MachineHandOverTaskDetailFail(msg: result.msg!);
        }
      } else {
        ///Notify loading to UI
        yield MachineHandOverTaskDetailLoading(isLoading: true);
        yield MachineHandOverTaskDetailFail(msg: "Error");
      }
    }


    ///Job Work HandOver Service List
    if (event is JobWorkHandOverServiceRequestList) {
      ///Notify loading to UI
      yield JobWorkHandOverServiceRequestListLoading(
        isLoading: false,
      );

      ///Fetch API via repository
      final ServiceRequestRepo result = await userRepository!
          .fetchJobWorkHandOverServiceRequestListList(
        offSet: event.offSet,
        timeId: event.timeId,
        serviceUserId: event.serviceUserId,
      );
      print(result);

      ///Case API fail but not have token
      if (result.success == true) {
        ///Home API success
        final Iterable refactorServiceRequestList = result.data! ?? [];
        final serviceRequestList = refactorServiceRequestList.map((item) {
          return JobWorkEnquiryMyTaskModel.fromJson(item);
        }).toList();
        print('Service Request List: $serviceRequestList');
        try {
          ///Begin start AuthBloc Event AuthenticationSave
          yield JobWorkHandOverServiceRequestListLoading(
            isLoading: true,
          );
          yield JobWorkHandOverServiceRequestListSuccess(serviceListData: serviceRequestList, message: result.msg!);
        } catch (error) {
          ///Notify loading to UI
          yield JobWorkHandOverServiceRequestListFail(msg: result.msg!);
        }
      } else {
        ///Notify loading to UI
        yield JobWorkHandOverServiceRequestListLoading(isLoading: true);
        yield JobWorkHandOverServiceRequestListFail(msg: result.msg!);
      }
    }

    /// Transport HandOver Service List
    if (event is TransportHandOverServiceRequestList) {
      ///Notify loading to UI
      yield TransportHandOverServiceRequestListLoading(
        isLoading: false,
      );

      ///Fetch API via repository
      final ServiceRequestRepo result = await userRepository!
          .fetchTransportHandOverServiceRequestListList(
        offSet: event.offSet,
        timeId: event.timeId,
        serviceUserId: event.serviceUserId,
      );
      print(result);

      ///Case API fail but not have token
      if (result.success == true) {
        ///Home API success
        final Iterable refactorServiceRequestList = result.data! ?? [];
        final serviceRequestList = refactorServiceRequestList.map((item) {
          return JobWorkEnquiryMyTaskModel.fromJson(item);
        }).toList();
        print('Service Request List: $serviceRequestList');
        try {
          ///Begin start AuthBloc Event AuthenticationSave
          yield TransportHandOverServiceRequestListLoading(
            isLoading: true,
          );
          yield TransportHandOverServiceRequestListSuccess(serviceListData: serviceRequestList, message: result.msg!);
        } catch (error) {
          ///Notify loading to UI
          yield TransportHandOverServiceRequestListFail(msg: result.msg!);
        }
      } else {
        ///Notify loading to UI
        yield TransportHandOverServiceRequestListLoading(isLoading: true);
        yield TransportHandOverServiceRequestListFail(msg: result.msg!);
      }
    }


    /// Accept and Reject Handover Task
    if (event is MachineAcceptRejectHandOverTask) {
      ///Notify loading to UI
      yield AcceptRejectHandoverLoading(
        isLoading: false,
      );

      ///Fetch API via repository
      final ServiceRequestRepo result = await userRepository!
          .acceptRejectHandover(
        machineEnquiryId: event.machineEnquiryId,
        dailyTaskId: event.dailyTaskId,
        status: event.status,
        serviceUserId: event.serviceUserId,
      );
      print(result);

      ///Case API fail but not have token
      if (result.success == true) {

        print('${result.msg}');
        try {
          ///Begin start AuthBloc Event AuthenticationSave
          yield AcceptRejectHandoverLoading(
            isLoading: true,
          );
          yield AcceptRejectHandoverSuccess(message: result.msg!);
        } catch (error) {
          ///Notify loading to UI
          yield AcceptRejectHandoverFail(msg: result.msg!);
        }
      } else {
        ///Notify loading to UI
        yield AcceptRejectHandoverLoading(isLoading: true);
        yield AcceptRejectHandoverFail(msg: result.msg!);
      }
    }

    /// Accept Reject Handover task Of Job Work
    if (event is JobWorkAcceptRejectHandOverTask) {
      ///Notify loading to UI
      yield AcceptRejectHandoverLoading(
        isLoading: false,
      );

      ///Fetch API via repository
      final ServiceRequestRepo result = await userRepository!
          .jobworkAcceptRejectHandover(
        jobworkEnquiryId: event.jobWorkEnquiryId,
        status: event.status,
        serviceUserId: event.serviceUserId,
      );
      print(result);

      ///Case API fail but not have token
      if (result.success == true) {

        print('${result.msg}');
        try {
          ///Begin start AuthBloc Event AuthenticationSave
          yield AcceptRejectHandoverLoading(
            isLoading: true,
          );
          yield AcceptRejectHandoverSuccess(message: result.msg!);
        } catch (error) {
          ///Notify loading to UI
          yield AcceptRejectHandoverFail(msg: result.msg!);
        }
      } else {
        ///Notify loading to UI
        yield AcceptRejectHandoverLoading(isLoading: true);
        yield AcceptRejectHandoverFail(msg: result.msg!);
      }
    }

    /// Accept And Request task of transport
    if (event is TransportAcceptRejectHandOverTask) {
      ///Notify loading to UI
      yield AcceptRejectHandoverLoading(
        isLoading: false,
      );

      ///Fetch API via repository
      final ServiceRequestRepo result = await userRepository!
          .transportAcceptRejectHandover(
        transportEnquiryId: event.transportEnquiryId,
        status: event.status,
        serviceUserId: event.serviceUserId,
      );
      print(result);

      ///Case API fail but not have token
      if (result.success == true) {

        print('${result.msg}');
        try {
          ///Begin start AuthBloc Event AuthenticationSave
          yield AcceptRejectHandoverLoading(
            isLoading: true,
          );
          yield AcceptRejectHandoverSuccess(message: result.msg!);
        } catch (error) {
          ///Notify loading to UI
          yield AcceptRejectHandoverFail(msg: result.msg!);
        }
      } else {
        ///Notify loading to UI
        yield AcceptRejectHandoverLoading(isLoading: true);
        yield AcceptRejectHandoverFail(msg: result.msg!);
      }
    }


    if (event is BrandFilter) {
      ///Notify loading to UI
      yield BrandFilterLoading(
      isLoading: false,
      );

      ///Fetch API via repository
      final FilterRepo result = await userRepository!
          .fetchFilterData();
      print(result);

      ///Case API fail but not have token
      if (result.success == true) {
        ///Home API success
        final Iterable refactorFilterList = result.data! ?? [];
        final filterList = refactorFilterList.map((item) {
          return FilterModule.fromJson(item);
        }).toList();
        print('Service Request List: $filterList');
        try {
          ///Begin start AuthBloc Event AuthenticationSave
          yield BrandFilterLoading(
            isLoading: true,
          );
          yield BrandFilterSuccess(brandListData: filterList.reversed.toList());
        } catch (error) {
          ///Notify loading to UI
          yield BrandFilterFail(msg: "Error Occured.");
        }
      } else {
        ///Notify loading to UI
        yield MyTaskLoading(isLoading: true);
        yield ServiceRequestFail(msg: "Error Occured.");
      }
    }

    if (event is CategoryFilter) {
      ///Notify loading to UI
      yield CategoryFilterLoading(
        isLoading: false,
      );

      ///Fetch API via repository
      final FilterRepo result = await userRepository!
          .fetchFilterCategoryList();
      print(result);

      ///Case API fail but not have token
      if (result.success == true) {
        ///Home API success
        final Iterable refactorFilterCategoryList = result.data! ?? [];
        final filterCategoryList = refactorFilterCategoryList.map((item) {
          return FilterModule.fromJson(item);
        }).toList();
        print('Service Request List: $filterCategoryList');
        try {
          ///Begin start AuthBloc Event AuthenticationSave
          yield CategoryFilterLoading(
            isLoading: true,
          );
          yield CategoryFilterSuccess(categoryListData: filterCategoryList);
        } catch (error) {
          ///Notify loading to UI
          yield CategoryFilterFail(msg: "Error Occured.");
        }
      } else {
        ///Notify loading to UI
        yield MyTaskLoading(isLoading: true);
        yield ServiceRequestFail(msg: "Error Occured.");
      }
    }
=========
>>>>>>>>> Temporary merge branch 2

    //Event for Task Hand Over Machine Maintaince

    if (event is OnTaskHandOver) {
      ///Notify loading to UI
      yield TaskHandOverLoading(
        isLoading: false,
      );

      ///Fetch API via repository
      final MachineMaintanceTaskHandOverRepo result = await userRepository!
          .fetchTaskHandOverList(
        offSet: event.offSet,
        subCatId: event.subCatId,
      );
      print(result);

      ///Case API fail but not have token
      if (result.success == true) {
        ///Home API success
        final Iterable refactorTaskHandOverList = result.data! ?? [];
        final TaskHandOverList = refactorTaskHandOverList.map((item) {
          return MachineMaintanceTaskHandOverModel.fromJson(item);
        }).toList();
        print('Task Hand Over List: $TaskHandOverList');
        try {
          ///Begin start AuthBloc Event AuthenticationSave
          yield TaskHandOverLoading(
            isLoading: true,
          );
          yield TaskHandOverSuccess(serviceListData:TaskHandOverList, message:"Task Hand Over Successfully");
        } catch (error) {
          ///Notify loading to UI
          yield TaskHandOverFail(msg:"Task Hand Over Fail");
        }
      } else {
        ///Notify loading to UI
        yield TaskHandOverLoading(isLoading: false);
        yield TaskHandOverFail(msg:"Task Hand Over Fail");
      }
    }

    //Event for Task Hand Over Job Work Enquiry

    if (event is OnJobWorkEnquiryTaskHandOver) {
      ///Notify loading to UI
      yield JobWorkEnquiryTaskHandOverLoading(
        isLoading: false,
      );

      ///Fetch API via repository
      final JobWorkEnquiryTaskHandOverRepo result = await userRepository!
          .fetchJobWorkEnquiryTaskHandOverList(
        offSet: event.offSet,
        userID: event.catId,
      );
      print(result);

      ///Case API fail but not have token
      if (result.success == true) {
        ///Home API success
        final Iterable refactorTaskHandOverList = result.data! ?? [];
        final TaskHandOverList = refactorTaskHandOverList.map((item) {
          return JobWorkEnquiryTaskHandOverModel.fromJson(item);
        }).toList();
        print('Task Hand Over List: $TaskHandOverList');
        try {
          ///Begin start AuthBloc Event AuthenticationSave
          yield JobWorkEnquiryTaskHandOverLoading(
            isLoading: true,
          );
          yield JobWorkEnquiryTaskHandOverSuccess(serviceListJWEData:TaskHandOverList, message:"Task Hand Over Successfully");
        } catch (error) {
          ///Notify loading to UI
          yield JobWorkEnquiryTaskHandOverFail(msg:"Task Hand Over Fail");
        }
      } else {
        ///Notify loading to UI
        yield JobWorkEnquiryTaskHandOverLoading(isLoading: false);
        yield JobWorkEnquiryTaskHandOverFail(msg:"Task Hand Over Fail");
      }
    }


    //Event for Transport Task Hand Over
    if (event is OnTransportTaskHandOver) {
      ///Notify loading to UI
      yield TransportTaskHandOverLoading(
        isLoading: false,
      );

      ///Fetch API via repository
      final TransportTaskHandOverRepo result = await userRepository!
          .fetchTransportTaskHandOverList(
        offSet: event.offSet,
        vehicleType: event.vehicleType,
      );
      print(result);

      ///Case API fail but not have token
      if (result.success == true) {
        ///Home API success
        final Iterable refactorTaskHandOverList = result.data! ?? [];
        final TransportTaskHandOverList = refactorTaskHandOverList.map((item) {
          return TransportTaskHandOverModel.fromJson(item);
        }).toList();
        print('Task Hand Over List: $TransportTaskHandOverList');
        try {
          ///Begin start AuthBloc Event AuthenticationSave
          yield TransportTaskHandOverLoading(
            isLoading: true,
          );
          yield TransportTaskHandOverSuccess(serviceListTransportData:TransportTaskHandOverList, message:"Task Hand Over Successfully");
        } catch (error) {
          ///Notify loading to UI
          yield TransportTaskHandOverFail(msg:"Task Hand Over Fail");
        }
      } else {
        ///Notify loading to UI
        yield TransportTaskHandOverLoading(isLoading: false);
        yield TransportTaskHandOverFail(msg:"Task Hand Over Fail");
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
        offset:event.offset,
        timePeriod: event.timePeriod,
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
          machineEnquiryId: event.machineEnquiryId,
          jobWorkEnquiryId: event.jobWorkEnquiryId,
          transportEnquiryId: event.transportEnquiryId
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



    //Event for Transpotation Service Request Detail
    if (event is OnServiceRequestTranspotationDetail) {
      ///Notify loading to UI
      yield ServiceRequestTranspotationDetailLoading(isLoading: false);

      ///Fetch API via repository
      final TranspotationServiceRequestDetailRepo result = await userRepository!
          .fetchServiceRequestTransportationDetail(
          userID: event.userID,
          machineEnquiryId: event.machineEnquiryId,
          jobWorkEnquiryId: event.jobWorkEnquiryId,
          transportEnquiryId: event.transportEnquiryId
      );
      print(result);

      ///Case API fail but not have token
      if (result.success == true) {
        ///Home API success
        final Iterable refactorServiceRequestDetail = result.transportDetails! ?? [];
        final serviceRequestDetail = refactorServiceRequestDetail.map((item) {
          return TransportDetailsModel.fromJson(item);
        }).toList();
        // MachineServiceDetailsModel data = MachineServiceDetailsModel();
        // data = refactorServiceRequestList as MachineServiceDetailsModel;
        print('Service Request Data: $serviceRequestDetail');
        try {
          ///Begin start AuthBloc Event AuthenticationSave
          yield ServiceRequestTranspotationDetailLoading(
            isLoading: true,
          );
          yield ServiceRequestTranspotationDetailSuccess(transportServiceDetail: serviceRequestDetail, message: result.msg!);
        } catch (error) {
          ///Notify loading to UI
          yield ServiceRequestTranspotationDetailFail(msg: result.msg!);
        }
      } else {
        ///Notify loading to UI
        yield ServiceRequestTranspotationDetailFail(msg: result.msg!);
      }
    }

    //Event for Job Work Enquiry Service Request Detail
    if (event is OnServiceRequestJobWorkEnquiryDetail) {
      ///Notify loading to UI
      yield ServiceRequestJobWorkEnquryDetailLoading(isLoading: false);

      ///Fetch API via repository
      final ServiceRequestDetailRepo result = await userRepository!
          .fetchServiceRequestJobWorkEnquiryDetail(
          userID: event.userID,
          machineEnquiryId: event.machineEnquiryId,
          jobWorkEnquiryId: event.jobWorkEnquiryId,
          transportEnquiryId: event.transportEnquiryId
      );
      print(result);

      ///Case API fail but not have token
      if (result.success == true) {
        ///Home API success
        final Iterable refactorServiceRequestDetail = result.enquiryDetails! ?? [];
        final serviceRequestDetail = refactorServiceRequestDetail.map((item) {
          return JobWorkEnquiryDetailsModel.fromJson(item);
        }).toList();
        // MachineServiceDetailsModel data = MachineServiceDetailsModel();
        // data = refactorServiceRequestList as MachineServiceDetailsModel;
        print('Service Request Data: $serviceRequestDetail');
        try {
          ///Begin start AuthBloc Event AuthenticationSave
          yield ServiceRequestJobWorkEnquryDetailLoading(
            isLoading: true,
          );
          yield ServiceRequestJobWorkEnquryDetailSuccess(jobWorkEnquryServiceDetail: serviceRequestDetail, message: result.msg!);
        } catch (error) {
          ///Notify loading to UI
          yield ServiceRequestJobWorkEnquryDetailFail(msg: result.msg!);
        }
      } else {
        ///Notify loading to UI
        yield ServiceRequestJobWorkEnquryDetailFail(msg: result.msg!);
      }
    }

    //Event for Job Work Enquiry My Task Detail
    if (event is OnMyTaskJobWorkEnquiryDetail) {
      ///Notify loading to UI
      yield MyTaskJobWorkEnquiryDetailLoading(isLoading: false);

      ///Fetch API via repository
      final JobWorkEnquiryMyTaskDetailRepo result = await userRepository!
          .fetchMyTaskJobWorkEnquiryDetail(
          userID: event.userID,
          machineEnquiryId: event.machineEnquiryId,
          jobWorkEnquiryId: event.jobWorkEnquiryId,
          transportEnquiryId: event.transportEnquiryId
      );
      print(result);

      ///Case API fail but not have token
      if (result.success == true) {
        ///Home API success
        final Iterable refactorServiceRequestDetail = result.enquiryDetails! ?? [];
        final myTaskDetail = refactorServiceRequestDetail.map((item) {
          return MyTaskEnquiryDetails.fromJson(item);
        }).toList();
        // MachineServiceDetailsModel data = MachineServiceDetailsModel();
        // data = refactorServiceRequestList as MachineServiceDetailsModel;
        print('My Task Data: $myTaskDetail');
        try {
          ///Begin start AuthBloc Event AuthenticationSave
          yield MyTaskJobWorkEnquiryDetailLoading(
            isLoading: true,
          );
          yield MyTaskJobWorkEnquiryDetailSuccess(MyTaskDetail: myTaskDetail, message: result.msg!);
        } catch (error) {
          ///Notify loading to UI
          yield MyTaskJobWorkEnquiryDetailFail(msg: result.msg!);
        }
      } else {
        ///Notify loading to UI
        yield MyTaskJobWorkEnquiryDetailFail(msg: result.msg!);
      }
    }

    //Event for Transpotation My Task Detail
    if (event is OnMyTaskTranspotationDetail) {
      ///Notify loading to UI
      yield MyTaskTranspotationDetailLoading(isLoading: false);

      ///Fetch API via repository
      final MyTaskTransportDetailRepo result = await userRepository!
          .fetchMyTaskTransportationDetail(
          userID: event.userID,
          machineEnquiryId: event.machineEnquiryId,
          jobWorkEnquiryId: event.jobWorkEnquiryId,
          transportEnquiryId: event.transportEnquiryId
      );
      print(result);

      ///Case API fail but not have token
      if (result.success == true) {
        ///Home API success
        final Iterable refactorServiceRequestDetail = result.transportDetails! ?? [];
        final myTaskDetail = refactorServiceRequestDetail.map((item) {
          return TransportMyTaskDetailsModel.fromJson(item);
        }).toList();
        // MachineServiceDetailsModel data = MachineServiceDetailsModel();
        // data = refactorServiceRequestList as MachineServiceDetailsModel;
        print('My Task Data: $myTaskDetail');
        try {
          ///Begin start AuthBloc Event AuthenticationSave
          yield MyTaskTranspotationDetailLoading(
            isLoading: true,
          );
          yield MyTaskTranspotationDetailSuccess(transportMyTaskDetail: myTaskDetail, message: result.msg!);
        } catch (error) {
          ///Notify loading to UI
          yield MyTaskTranspotationDetailFail(msg: result.msg!);
        }
      } else {
        ///Notify loading to UI
        yield MyTaskTranspotationDetailFail(msg: result.msg!);
      }
    }

    ///Transport Quotation Reply Detail
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

    ///Transport Update Track Process
    if (event is TransportUpdateTrackProcess) {
      ///Notify loading to UI
      yield TransportUpdateProcessLoading(isLoading: false);

      ///Fetch API via repository
      // final CartRepo result = await userRepository!
      //     .transportUpdateTrackProcess(
      //     serviceUserId: event.serviceUserID,
      //     transportEnqId: event.transportEnquiryId,
      //     reachAtPic: event.reachAtPick,
      //     loadingComplete: event.loadComplete,
      //     onTheWay: event.onWayToDrop,
      //     reachAtDrop: event.reachOnDrop,
      //     invoiceImage: event.invoiceImage,
      // );
      // print(result);



      Map<String, String> params = {
        "service_user_id":event.serviceUserID,
        "transport_enquiry_id":event.transportEnquiryId,
        'reached_at_pickup_location':event.reachAtPick,
        'loading_completed':event.loadComplete,
        'on_the_way_to_drop_location':event.onWayToDrop,
        'reaches_on_drop_location':event.reachOnDrop,
      };

      http.MultipartRequest _request = http.MultipartRequest('POST', Uri.parse('http://mone.ezii.live/service_engineer/transport_track_progress'));
      // ..fields.addAll(params);
      if(event.invoiceImage!="null") {
        var userProfileImgFile = await http.MultipartFile.fromPath(
            'invoice_img', event.invoiceImage.toString());
        _request.files.add(userProfileImgFile);
      }

      _request = jsonToFormData(_request, params);
      var streamResponse = await _request.send();
      var response = await http.Response.fromStream(streamResponse);
      final responseJson = json.decode(response.body);
      print(responseJson);
      CartRepo result =  CartRepo.fromJson(responseJson);
      print(result.msg);

      ///Case API fail but not have token
      if (result.success == true) {

        try {
          ///Begin start AuthBloc Event AuthenticationSave
          yield TransportUpdateProcessLoading(
            isLoading: true,
          );
          yield TransportUpdateProcessSuccess( message: result.msg.toString());
        } catch (error) {
          ///Notify loading to UI
          yield TransportUpdateProcessFail(msg: result.msg);
        }
      } else {
        ///Notify loading to UI
        yield TransportUpdateProcessFail(msg: result.msg);
      }
    }

    ///Transport Get Track Process
    if (event is TransporGetTrackProcess) {
      ///Notify loading to UI
      yield TransportGetProcessLoading(isLoading: false);

      ///Fetch API via repository
      final CartRepo result = await userRepository!
          .transportGetTrackProcess(
        serviceUserId: event.serviceUserID,
        transportEnqId: event.transportEnquiryId,
      );
      print(result);

      ///Case API fail but not have token
      if (result.success == true) {

        final Iterable refactorTrackData = result.data! ?? [];
        final trackData = refactorTrackData.map((item) {
          return TrackDataModel.fromJson(item);
        }).toList();
        print('Quotation Reply List: $trackData');

        try {
          ///Begin start AuthBloc Event AuthenticationSave
          yield TransportGetProcessLoading(
            isLoading: true,
          );
          yield TransportGetProcessSuccess(trackData: trackData,message: result.msg.toString());
        } catch (error) {
          ///Notify loading to UI
          yield TransportGetProcessFail(msg: result.msg);
        }
      } else {
        ///Notify loading to UI
        yield TransportGetProcessFail(msg: result.msg);
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
          offset: event.offSet,
          brandId: event.brandId,
          priceId: event.priceId,
          catId: event.catId
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

    //My Task Track Process Transport
    if (event is TrackProcessTransportList) {
      ///Notify loading to UI
      yield TrackProcssListTransportLoading(isLoading: false);

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
        print('Track Process Data: $trackProgressList');

        try {
          ///Begin start AuthBloc Event AuthenticationSave
          yield TrackProcssListTransportLoading(
            isLoading: true,
          );
          yield TrackProcssListTransportSuccess(trackProgressList: trackProgressList, message: result.msg!);
        } catch (error) {
          ///Notify loading to UI
          yield TrackProcssListTransportFail(msg: result.msg);
        }
      } else {
        ///Notify loading to UI
        yield TrackProcssListTransportFail(msg: result.msg);
      }
    }

    //My Task Job Work Enquiry Track Process
    if (event is OnTrackProcessList) {
      ///Notify loading to UI
      yield TrackProcssJWEListLoading(isLoading: false);

      ///Fetch API via repository
      final TrackProgressListJobWorkRepo result = await userRepository!
          .fetchTrackProgressJWEList(
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
          return TrackProcessJobWorkEnquiryModel.fromJson(item);
        }).toList();
        // MachineServiceDetailsModel data = MachineServiceDetailsModel();
        // data = refactorServiceRequestList as MachineServiceDetailsModel;
        print('Track Process Data: $trackProgressList');

        try {
          ///Begin start AuthBloc Event AuthenticationSave
          yield TrackProcssJWEListLoading(
            isLoading: true,
          );
          yield TrackProcssJWEListSuccess(trackProgressList: trackProgressList, message: result.msg!);
        } catch (error) {
          ///Notify loading to UI
          yield TrackProcssJWEListFail(msg: result.msg);
        }
      } else {
        ///Notify loading to UI
        yield TrackProcssJWEListFail(msg: result.msg);
      }
    }

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

    //Create Task Transport
    if (event is CreateTransportTask) {
      ///Notify loading to UI
      yield CreateTaskTransportLoading(isLoading: false);

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
          yield CreateTaskTransportLoading(
            isLoading: true,
          );
          yield CreateTaskTransportSuccess( message: result.msg!);
        } catch (error) {
          ///Notify loading to UI
          yield CreateTaskTransportFail(msg: result.msg);
        }
      } else {
        ///Notify loading to UI
        yield CreateTaskTransportFail(msg: result.msg);
      }
    }
    //Job Work Enquiry Create Task
    if (event is OnCreateTask) {
      ///Notify loading to UI
      yield CreateTaskJWELoading(isLoading: false);

      ///Fetch API via repository
      final CreateTaskJWERepo result = await userRepository!
          .createTaskJWE(
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
          yield CreateTaskJWELoading(
            isLoading: true,
          );
          yield CreateTaskJWESuccess( message: result.msg!);
        } catch (error) {
          ///Notify loading to UI
          yield CreateTaskJWEFail(msg: result.msg);
        }
      } else {
        ///Notify loading to UI
        yield CreateTaskJWEFail(msg: result.msg);
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

    //Mark Task Complete JWE
    if (event is TaskCompleteJWE) {
      ///Notify loading to UI
      yield TaskCompleteJWELoading(isLoading: false);

      ///Fetch API via repository
      final CreateTaskJWERepo result = await userRepository!
          .completeTaskJWE(
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
          yield TaskCompleteJWELoading(
            isLoading: true,
          );
          yield TaskCompleteJWESuccess( message: result.msg!);
        } catch (error) {
          ///Notify loading to UI
          yield TaskCompleteJWEFail(msg: result.msg);
        }
      } else {
        ///Notify loading to UI
        yield TaskCompleteJWEFail(msg: result.msg);
      }
    }

    //Send Quotation for Machine Maintainance
    if (event is SendQuotation) {
      ///Notify loading to UI
      yield SendQuotationLoading(isLoading: false);

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
        "total_amount": event.totalAmount,
      };

      http.MultipartRequest _request = http.MultipartRequest('POST', Uri.parse('http://mone.ezii.live/service_engineer/machine_maintainence_quatation'));
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
        yield SendQuotationSuccess(message: res.msg.toString());

      } else {
        ///Notify loading to UI
        yield SendQuotationFail(msg: res.msg.toString());
        print(response.body);
      }
    }


    // *******  Job Work Enquiry ******* //

    //Event for Job Work Enquiry Service Request
    if (event is OnServiceRequestJWEList) {
      ///Notify loading to UI
      yield ServiceRequestJWELoading(
        isLoading: false,
      );

      ///Fetch API via repository
      final JobWorkEnquiryServiceRequestRepo result = await userRepository!
          .fetchServiceRequestJobWorkEnquiryList(
        offSet: event.offSet,
        timeId: event.timePeriod
      );
      print(result);

      ///Case API fail but not have token
      if (result.success == true) {
        ///Home API success
        final Iterable refactorServiceRequestJobWorkEnquiryList = result.data! ?? [];
        final serviceRequestJobWorkEnquiryList = refactorServiceRequestJobWorkEnquiryList.map((item) {
          return JobWorkEnquiryServiceRequestModel.fromJson(item);
        }).toList();
        print('Service Request JobWorkEnquiry List: $ServiceRequestJWESuccess');
        try {
          ///Begin start AuthBloc Event AuthenticationSave
          yield ServiceRequestJWELoading(
            isLoading: true,
          );
          yield ServiceRequestJWESuccess(serviceListData: serviceRequestJobWorkEnquiryList, message: result.msg!);
        } catch (error) {
          ///Notify loading to UI
          yield ServiceRequestJWEFail(msg: result.msg!);
        }
      } else {
        ///Notify loading to UI
        yield ServiceRequestJWELoading(isLoading: false);
        yield ServiceRequestJWEFail(msg: result.msg!);
      }
    }

    //Event for Job Work Enquiry  My Task List
    if (event is OnMyTaskJWEList) {
      ///Notify loading to UI
      yield MyTaskJWELoading(isLoading: false);

      ///Fetch API via repository
      final JobWorkEnquiryMyTaskRepo response = await userRepository!
          .fetchJobWorkEnquiryMyTaskList(
          userId: event.userid,
          offset:event.offset,
          timeId: event.timeId
      );
      print(response);

      if(response.success == true){
        final Iterable refactorMyTaskJWE = response.data ?? [];
        final listJWEMyTask = refactorMyTaskJWE.map((item) {
          return  JobWorkEnquiryMyTaskModel.fromJson(item);
        }).toList();

        print("Task List: $listJWEMyTask");

        try{
          yield MyTaskJWELoading(isLoading: true);
          yield MyTaskJWEListSuccess(MyTaskJWEList: listJWEMyTask);
        }catch(error){
          yield MyTaskJWELoading(isLoading: false);
          yield MyTaskJWEListLoadFail(msg: response.msg);
        }
      }
      else {
        ///Notify loading to UI
        yield MyTaskLoading(isLoading: false);
        yield MyTaskListLoadFail(msg: response.msg);
      }
    }

    //Event for Service Request Transpotation
    if (event is OnServiceRequestTranspotation) {
      ///Notify loading to UI
      yield ServiceRequestTranspotationLoading(
        isLoading: false,
      );

      ///Fetch API via repository
      final ServiceRequestTranspotationRepo result = await userRepository!
          .fetchServiceRequestTranspotationList(
        offSet: event.offSet,
        timeId: event.timeId
      );
      print(result);

      ///Case API fail but not have token
      if (result.success == true) {
        ///Home API success
        final Iterable refactorServiceRequestList = result.data! ?? [];
        final serviceRequestList = refactorServiceRequestList.map((item) {
          return ServiceRequestTranspotationModel.fromJson(item);
        }).toList();
        print('Service Request List: $serviceRequestList');
        try {
          ///Begin start AuthBloc Event AuthenticationSave
          yield ServiceRequestTranspotationLoading(
            isLoading: true,
          );
          yield ServiceRequestTranspotationSuccess(serviceListData: serviceRequestList, message: result.msg!);
        } catch (error) {
          ///Notify loading to UI
          yield ServiceRequestTranspotationFail(msg: result.msg!);
        }
      } else {
        ///Notify loading to UI
        yield ServiceRequestTranspotationLoading(isLoading: false);
        yield ServiceRequestTranspotationFail(msg: result.msg!);
      }
    }

    //Event for My Task Transpotation
    if (event is OnMyTaskTranspotationList) {
      ///Notify loading to UI
      yield MyTaskTranspotationLoading(isLoading: false);

      ///Fetch API via repository
      final MyTaskTransportationRepo response = await userRepository!
          .fetchTranspotationMyTaskList(
          userId: event.userid,
          offset:event.offset,
          timeId: event.timeId,
      );
      print(response);

      if(response.success == true){
        final Iterable refactorMyTask = response.data ?? [];
        final listMyTask = refactorMyTask.map((item) {
          return MyTaskTransportationModel.fromJson(item);
        }).toList();

        print("Task List: $listMyTask");

        try{
          yield MyTaskTranspotationLoading(isLoading: true);
          yield MyTaskTranspotationListSuccess(MyTaskList: listMyTask);
        }catch(error){
          yield MyTaskTranspotationLoading(isLoading: false);
          yield MyTaskTranspotationListLoadFail(msg: response.msg);
        }
      }
      else {
        ///Notify loading to UI
        yield MyTaskTranspotationLoading(isLoading: false);
        yield MyTaskTranspotationListLoadFail(msg: response.msg);
      }
    }

    //Send Quotation for Transpotation
    if (event is TranspotationSendQuotation) {
      ///Notify loading to UI
      yield TranspotationSendQuotationLoading(isLoading: false);

      Map<String, String> params = {
        "vehicle_number": event.vehicleNumber,
        "vehicle_name":event.vehicleName,
        "vehicle_type":event.vehicleType,
        "gst":event.gst,
        "service_charge":event.serviceCharges == "" ? '0' : event.serviceCharges,
        "handling_charge":event.handlingCharges == "" ? '0' : event.handlingCharges,
        "commission": event.commision == "" ? '0' : event.commision,
        "gst_no":event.gst_no,
        "transport_enquiry_date": event.transport_enquiry_date,
        "transport_enquiry_id": event.transport_enquiry_id.toString(),
        "service_user_id": event.service_user_id,
        "total_amount": event.total_amount,
      };

      http.MultipartRequest _request = http.MultipartRequest('POST', Uri.parse('http://mone.ezii.live/service_engineer/transport_quatation'));
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
        yield TranspotationSendQuotationSuccess(message: res.msg.toString());

      } else {
        ///Notify loading to UI
        yield TranspotationSendQuotationFail(msg: res.msg.toString());
        print(response.body);
      }
    }

   // Event for Job Work Enquiry send quotation
    if (event is JobWorkSendQuotation) {
      ///Notify loading to UI
      yield JobWorkSendQuotationLoading(isLoading: false);

      var itemList = [];

      for(int j = 0; j < event.itemList.length; j++){
        var innerObj ={};
        double amount = double.parse(event.itemList[j].qty
            .toString()) * int.parse(event.itemRateController[j].text);

        innerObj["item_name"] = event.itemList[j].itemName;
        innerObj["item_qty"] = event.itemList[j].qty;
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
        yield JobWorkSendQuotationSuccess(message: res.msg.toString());

      } else {
        ///Notify loading to UI
        yield JobWorkSendQuotationFail(msg: res.msg.toString());
        print(response.body);
      }
    }
    ///Event for Job Work Enquiry send quotation
    if (event is JobWorkSendQuotation) {
      ///Notify loading to UI
      yield JobWorkSendQuotationLoading(isLoading: false);

      var itemList = [];

      for(int j = 0; j < event.itemList.length; j++){
        var innerObj ={};
        double amount = double.parse(event.itemList[j].qty
            .toString()) * int.parse(event.itemRateController[j].text);

        innerObj["item_name"] = event.itemList[j].itemName;
        innerObj["item_qty"] = event.itemList[j].qty;
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
        "total_amount": event.totalAmount,
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
        yield JobWorkSendQuotationSuccess(message: res.msg.toString());

      } else {
        ///Notify loading to UI
        yield JobWorkSendQuotationFail(msg: res.msg.toString());
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