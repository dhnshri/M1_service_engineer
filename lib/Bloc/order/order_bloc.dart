import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:service_engineer/Bloc/order/order_event.dart';
import 'package:service_engineer/Bloc/order/order_state.dart';
import 'package:service_engineer/Model/dashboard_cound_repo.dart';
import 'package:service_engineer/Model/order_list_repo.dart';
import 'package:service_engineer/Model/order_repo.dart';
import 'package:service_engineer/Model/product_repo.dart';
import 'package:service_engineer/Model/quotation_reply_detail_repo.dart';
import 'package:service_engineer/Model/service_request_detail_repo.dart';
import 'package:service_engineer/Repository/UserRepository.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc({this.userRepository}) : super(InitialOrderState());
  final UserRepository? userRepository;


  @override
  Stream<OrderState> mapEventToState(event) async* {


    ///Machine Order List
    if (event is GetOrderList) {
      ///Notify loading to UI
      yield OrderListLoading(
        isLoading: false,
      );

      ///Fetch API via repository
      final OrderListRepo result = await userRepository!.fetchOrderList(
          serviceUserId: event.serviceUserId
      );

      print(result);

      ///Case API fail but not have token
      if (result.success == true) {
        final Iterable refactorOrderList = result.data! ?? [];
        final orderList = refactorOrderList.map((item) {
          return OrderList.fromJson(item);
        }).toList();
        print('Order List: $orderList');

        try {

          yield OrderListLoading(
            isLoading: true,
          );
          yield OrderListSuccess(orderList: orderList);
        } catch (error) {
          ///Notify loading to UI
          yield OrderListLoading(isLoading: false,);
          yield OrderListFail(msg: result.msg);
        }
      } else {
        ///Notify loading to UI
        yield OrderListLoading(isLoading: false,);
        yield OrderListFail(msg: result.msg);
      }
    }

    ///Machine Order Detail
    if (event is GetOrderDetail) {
      ///Notify loading to UI
      yield OrderDetailLoading(
        isLoading: false,
      );

      ///Fetch API via repository
      final OrderRepo result = await userRepository!.fetchOrderDetail(
          serviceUserId: event.serviceUserId,
          machineEnquiryId: event.machineEnquiryId,
      );

      print(result);

      ///Case API fail but not have token
      if (result.success == true) {

        final Iterable refactorOrderDetail = result.data! ?? [];
        final orderDetail = refactorOrderDetail.map((item) {
          return OrderModel.fromJson(item);
        }).toList();
        print('Order Detail List: $orderDetail');


        try {

          yield OrderDetailLoading(
            isLoading: true,
          );
          yield OrderDetailSuccess(orderDetailList: orderDetail);
        } catch (error) {
          ///Notify loading to UI
          yield OrderDetailLoading(isLoading: false,);
          yield OrderDetailFail(msg: result.msg);
        }
      } else {
        ///Notify loading to UI
        yield OrderDetailLoading(isLoading: false,);
        yield OrderDetailFail(msg: result.msg);
      }
    }

    ///Machine Maintainance Quotation reply detail
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

    /// Product List
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

    ///Product Enquiry Detail
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
          yield ServiceRequestDetailLoading(
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

    /// Cancel Order
    if (event is CancelOrder) {
      ///Notify loading to UI
      yield CancelOrderLoading(
        isLoading: false,
      );

      ///Fetch API via repository
      final OrderListRepo result = await userRepository!.cancelOrder(
          serviceUserId: event.serviceUserId,
          machineEnqId: event.machineEnquiryId,
      );

      print(result);

      ///Case API fail but not have token
      if (result.success == true) {

        try {

          yield CancelOrderLoading(
            isLoading: true,
          );
          yield CancelOrderSuccess(msg: result.msg);
        } catch (error) {
          ///Notify loading to UI
          yield CancelOrderLoading(isLoading: false,);
          yield CancelOrderFail(msg: result.msg);
        }
      } else {
        ///Notify loading to UI
        yield CancelOrderLoading(isLoading: false,);
        yield CancelOrderFail(msg: result.msg);
      }
    }

  }

// yield LogoutSuccess();
}
