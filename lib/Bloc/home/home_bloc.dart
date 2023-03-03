import 'dart:async';


import 'package:bloc/bloc.dart';
import 'package:service_engineer/Model/product_repo.dart';
import 'package:service_engineer/Model/service_request_detail_repo.dart';
import 'package:service_engineer/Model/service_request_repo.dart';
import 'package:service_engineer/Repository/UserRepository.dart';

import '../../Model/JobWorkEnquiry/my_task_model.dart';
import '../../Model/JobWorkEnquiry/service_request_model.dart';
import '../../Model/MachineMaintance/myTaskModel.dart';
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
          offset:event.offset
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

  }


}
