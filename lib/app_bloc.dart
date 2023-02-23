

import 'package:flutter_bloc/flutter_bloc.dart';

import 'Bloc/authentication/authentication_bloc.dart';
import 'Bloc/login/login_bloc.dart';
import 'Bloc/theme/theme_bloc.dart';
import 'Repository/UserRepository.dart';


class AppBloc {
  static final userRepository = UserRepository();
  static final themeBloc = ThemeBloc();

 static final authBloc = AuthBloc(userRepository: userRepository);
  static final loginBloc = LoginBloc(userRepository: userRepository);
  // static final profileBloc = ProfileBloc(profileRepo: userRepository);
  // static final contactUsBloc = ContactUsBloc(contactUsRepo: userRepository);
  // static final changePassBloc = ChangePassBloc(changePassRepo: userRepository);
  // static final categoryBloc = CategoryBloc(categoryRepo: userRepository);
  // static final homeBloc = HomeBloc(homeRepo: userRepository);
  // static final addressBloc = AddressBloc(addressRepo: userRepository);
  // static final myOrderBloc = MyOrdersBloc(ordersRepo: userRepository);
  // static final cartBloc = CartBloc(cartRepo: userRepository);




  static final List<BlocProvider> providers = [
    // BlocProvider<ApplicationBloc>(
    //   create: (context) => applicationBloc,
    // ),
    // BlocProvider<LanguageBloc>(
    //   create: (context) => languageBloc,
    // ),
    BlocProvider<ThemeBloc>(
      create: (context) => themeBloc,
    ),
    BlocProvider<AuthBloc>(
      create: (context) => authBloc,
    ),
    BlocProvider<LoginBloc>(
      create: (context) => loginBloc,
    ),
    // BlocProvider<ProfileBloc>(
    //   create: (context) => profileBloc,
    // ),
    // BlocProvider<ContactUsBloc>(
    //   create: (context) => contactUsBloc,
    // ),
    // BlocProvider<ChangePassBloc>(
    //   create: (context) => changePassBloc,
    // ),
    // BlocProvider<CategoryBloc>(
    //   create: (context) => categoryBloc,
    // ),
    // BlocProvider<HomeBloc>(
    //   create: (context) => homeBloc,
    // ),
    // BlocProvider<AddressBloc>(
    //   create: (context) => addressBloc,
    // ),
    // BlocProvider<MyOrdersBloc>(
    //   create: (context) => myOrderBloc,
    // ),
    // BlocProvider<CartBloc>(
    //   create: (context) => cartBloc,
    // ),
  ];

  static void dispose() {
    // applicationBloc.close();
    // languageBloc.close();
    themeBloc.close();
    authBloc.close();
    loginBloc.close();
    // profileBloc.close();
    // contactUsBloc.close();
    // categoryBloc.close();
    // changePassBloc.close();
    // homeBloc.close();
    // addressBloc.close();
    // myOrderBloc.close();
    // cartBloc.close();
  }

  ///Singleton factory
  static final AppBloc _instance = AppBloc._internal();

  factory AppBloc() {
    return _instance;
  }

  AppBloc._internal();
}
