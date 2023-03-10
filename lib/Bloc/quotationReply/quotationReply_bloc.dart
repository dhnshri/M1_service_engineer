import 'dart:async';


import 'package:bloc/bloc.dart';
import 'package:service_engineer/Model/product_repo.dart';
import 'package:service_engineer/Model/service_request_detail_repo.dart';
import 'package:service_engineer/Model/service_request_repo.dart';
import 'package:service_engineer/Repository/UserRepository.dart';

import '../../Model/JobWorkEnquiry/my_task_model.dart';
import '../../Model/JobWorkEnquiry/quotation_reply.dart';
import '../../Model/JobWorkEnquiry/service_request_model.dart';
import '../../Model/MachineMaintance/myTaskModel.dart';
import '../../Model/MachineMaintance/quotationReply.dart';
import '../../Model/Transpotation/quotationReplyModel.dart';
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
  }


}
