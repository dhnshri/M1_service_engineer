

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:service_engineer/Bloc/home/home_bloc.dart';
import 'package:service_engineer/Bloc/profile/profile_bloc.dart';

import 'Bloc/authentication/authentication_bloc.dart';
import 'Bloc/login/login_bloc.dart';
import 'Bloc/theme/theme_bloc.dart';
import 'Repository/UserRepository.dart';


class AppBloc {
  static final userRepository = UserRepository();
  static final themeBloc = ThemeBloc();

 static final authBloc = AuthBloc(userRepository: userRepository);
  static final loginBloc = LoginBloc(userRepository: userRepository);
  static final homeBloc = HomeBloc(userRepository: userRepository);
  static final profileBloc = ProfileBloc(userRepository: userRepository);





  static final List<BlocProvider> providers = [
    BlocProvider<ThemeBloc>(
      create: (context) => themeBloc,
    ),
    BlocProvider<AuthBloc>(
      create: (context) => authBloc,
    ),
    BlocProvider<LoginBloc>(
      create: (context) => loginBloc,
    ),
    BlocProvider<HomeBloc>(
      create: (context) => homeBloc,
    ),
    BlocProvider<ProfileBloc>(
      create: (context) => profileBloc,
    ),


  ];

  static void dispose() {
    // applicationBloc.close();
    // languageBloc.close();
    themeBloc.close();
    authBloc.close();
    loginBloc.close();
    homeBloc.close();
    profileBloc.close();
  }

  ///Singleton factory
  static final AppBloc _instance = AppBloc._internal();

  factory AppBloc() {
    return _instance;
  }

  AppBloc._internal();
}
