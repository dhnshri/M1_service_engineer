import 'dart:async';
import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Model/address_model.dart';
import '../../Model/cart_model.dart';
import '../../Model/customer_login.dart';
import '../../Utils/application.dart';
import '../../app_bloc.dart';
import 'authentication_event.dart';
import 'authentication_state.dart';



class AuthBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthBloc({this.userRepository}) : super(InitialAuthenticationState());
  dynamic userRepository;

  @override
  Stream<AuthenticationState> mapEventToState(event) async* {
    if (event is OnAuthCheck) {
      ///Notify state AuthenticationBeginCheck
      yield AuthenticationBeginCheck();
      final hasUser = userRepository.getUser();
      final hasAddress = userRepository.getAddress();
      final hasCart = userRepository.getCart();

      if (hasUser!=null && hasAddress != null && hasCart != null) {
        ///Getting data from Storage
        final customerModel = CustomerLogin.fromJson(jsonDecode(hasUser));
        final addressModel = AddressModel.fromJson(jsonDecode(hasAddress));
        final cartRepo = CartListRepo.fromJson(jsonDecode(hasCart));

        ///Set token network
        // httpManager.getOption.headers["Authorization"] = "Bearer " + user.token;
        // httpManager.postOption.headers["Authorization"] =
        //     "Bearer " + user.token;

        ///Valid token server
        // final ResultApiModel result = await userRepository.validateToken(); //commented on 17/12/2020

        ///Fetch api success
        if (customerModel.userId!=null && addressModel.id!= null
            && cartRepo.cartQuantity != null
        ) {
          ///Set user
          Application.customerLogin = customerModel;
          Application.address = addressModel;
          Application.cart = cartRepo;
          yield AuthenticationSuccess();

        } else {
          ///Fetch api fail
          ///Delete user when can't verify token
          await userRepository!.deleteUser();

          ///Notify loading to UI
          yield AuthenticationFail();
        }
      }
      //updated on 10/02/2021
      else {
        ///Notify loading to UI
        ///
        yield AuthenticationFail();
      }

    }

    if (event is OnSaveUser) {
      ///Save to Storage user via repository
      final savePreferences = await userRepository!.saveUser(event.user);

      ///Check result save user
      if (savePreferences) {
        ///Set token network
        // httpManager.getOption.headers["Authorization"] =
        //     "Bearer " + event.user.token;
        // httpManager.postOption.headers["Authorization"] =
        //     "Bearer " + event.user.token;

        ///Set user
        Application.customerLogin= event.user;
        // UtilPreferences.setString(Preferences.user, Application.user.toString());

        ///Notify loading to UI
        if(Application.customerLogin!.userId!=null) {
          yield AuthenticationSuccess();
        }else{
          yield AuthenticationFail();
        }


      } else {
        final String message = "Cannot save user data to storage phone";
        throw Exception(message);
      }
    }


    ///Save address
    if (event is OnSaveAddress) {
      ///Save to Storage user via repository
      final savePreferences = await userRepository!.saveAddress(event.address);

      ///Check result save user
      if (savePreferences) {

        ///Set address
        Application.address= event.address;
        // UtilPreferences.setString(Preferences.user, Application.user.toString());

        ///Notify loading to UI
        if(Application.address!.id!=null) {
          yield AuthenticationSuccess();
        }else{
          yield AuthenticationFail();
        }


      } else {
        final String message = "Cannot save user data to storage phone";
        throw Exception(message);
      }
    }

    if (event is OnSaveCart) {
      ///Save to Storage user via repository
      final savePreferences = await userRepository!.saveCart(event.cart);

      ///Check result save user
      if (savePreferences) {

        ///Set address
        Application.cart= event.cart;
        // UtilPreferences.setString(Preferences.user, Application.user.toString());

        ///Notify loading to UI
        if(Application.cart!.cartQuantity != null) {
          yield AuthenticationSuccess();
        }else{
          yield AuthenticationFail();
        }


      } else {
        final String message = "Cannot save user data to storage phone";
        throw Exception(message);
      }
    }



    if (event is OnClear) {
      ///Delete user
      final deletePreferences = await userRepository!.deleteUser();

      ///Clear user Storage user via repos itory
      Application.customerLogin = null;

      ///Check result delete user
      if (deletePreferences) {
        yield AuthenticationFail();
      } else {
        final String message = "Cannot delete user data to storage phone";
        throw Exception(message);
      }
    }

  }
}
