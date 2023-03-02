import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:service_engineer/Screen/LoginRegistration/signUpAs.dart';
import 'package:service_engineer/Screen/SplashScreen/splash_screen.dart';
import 'package:service_engineer/Screen/bottom_navbar.dart';

import 'Bloc/authentication/authentication_bloc.dart';
import 'Bloc/authentication/authentication_state.dart';
import 'Config/language.dart';
import 'Config/theme.dart';
import 'Repository/UserRepository.dart';
import 'Screen/LoginRegistration/login_screen.dart';
import 'Utils/routes.dart';
import 'Utils/translate.dart';
import 'app_bloc.dart';





class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}



class _AppState extends State<App> {
  final route = Routes();

  var locator;
  String? role='';


  @override
  void dispose() {
    AppBloc.dispose();
    super.dispose();
  }



  @override
  void initState() {
    super.initState();
    role = UserRepository().getRole();

  }


  @override
  Widget build(BuildContext context) {
    return
      MultiBlocProvider(
        providers: AppBloc.providers,
        child:
        MaterialApp(
          // navigatorKey: PushNotify.navigatorKey, // imp nvigator key is used as navigation through context didnt worked
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          // darkTheme: AppTheme.darkTheme,
          locale: AppLanguage.defaultLanguage,

          localizationsDelegates: [
            Translate.delegate,
            // EasyLocalization.of(context).delegate,

            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],

          supportedLocales: AppLanguage.supportLanguage,


          onGenerateRoute: route.generateRoute,
          home:
          //UserRepository().getPhoneNo() != null? BottomNavigation(index:0,dropValue: role,): SplashScreen()
          BlocBuilder<AuthBloc, AuthenticationState>(
            builder: (context, app) {

              if (app is AuthenticationSuccess) {
                return BottomNavigation(index: 0,dropValue: role);
              }
              if (app is AuthenticationFail) {
               return SignUpAsScreen();
              //  return BottomNavigation(index: 0,);
              }
              return SplashScreen();

            },
          ),

      )

      );

  }
}
