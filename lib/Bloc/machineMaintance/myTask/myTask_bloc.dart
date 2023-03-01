import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';

import 'package:http/http.dart' as http;

import '../../../Model/MachineMaintance/myTaskModel.dart';
import '../../../Repository/UserRepository.dart';
import 'myTask_event.dart';
import 'myTask_state.dart';


class MyTaskBloc extends Bloc<MyTaskEvent, MyTaskState> {
  MyTaskBloc({this.userRepository})
      : super(InitialMyTaskListState());
  final UserRepository? userRepository;


  @override
  Stream<MyTaskState> mapEventToState(event) async* {


    ///Event for login
    if (event is OnLoadingMyTaskList) {
      ///Notify loading to UI
      yield MyTaskLoading();

      ///Fetch API via repository
      final MyTaskRepo response = await userRepository!
          .fetchMachineMaintainceMyTaskList(
          userId: event.userid,
          offset:event.offset
      );

      final Iterable refactorMyTask = response.data ?? [];
      final listMyTask = refactorMyTask.map((item) {
        return MyTaskModel.fromJson(item);
      }).toList();

      yield MyTaskListSuccess(
          MyTaskList: listMyTask);
    }


  }

}

