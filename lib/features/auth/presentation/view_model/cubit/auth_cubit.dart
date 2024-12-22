// ignore_for_file: avoid_print
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:shop_app/core/utils/helper/app_api.dart';
import 'package:shop_app/features/auth/data/shared/save_user_token.dart';
import 'package:shop_app/features/auth/presentation/view_model/cubit/auth_states.dart';
import 'package:http/http.dart' as http;

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit() : super(AuthInitializationState());

//register method logic
void register({required String name, required String email, required String phone, required String password}) async {
    emit(RegisterLoadingState());

    http.Response response = await http.post(
      Uri.parse(AppApis.registerApi),
      body: {
        'name': name,
        'email': email,
        'phone' : phone,
        'password' : password,
      },
      headers:{
        'lang' : 'en',
      },
    );

    try
    {
      if(response.statusCode == 200)
      {
         var jsonDecoded = jsonDecode(response.body);
         if(jsonDecoded['status'] == true)
         {
            emit(RegisterSuccessState());
            debugPrint("user register successfully and his data is : $jsonDecoded");
         }
         else
         {
           emit(RegisterFailedState(message: jsonDecoded['message']),);
           debugPrint("user register failed and his data is : $jsonDecoded");
         }
      }
    }
    catch(e)
    {
      print(e.toString());
    }
  }

//login method logic
void login({required String email , required String password}) async{
  emit(LoginLoadingState());
  http.Response response = await http.post(
    Uri.parse(AppApis.loginApi),
    body:{
      'email' : email,
      'password' : password,
    },
    headers:{
      'lang' : 'en',
    },
  );

  try
  {
    if(response.statusCode == 200)
    {
      var jsonDecoded = jsonDecode(response.body);
      if(jsonDecoded['status'] == true)
      {
        await CacheSecureStorage.setUserToken(key: 'token', value: jsonDecoded['data']['token']);
        emit(LoginSuccessState());
        debugPrint("user login successfully and his data is : $jsonDecoded");
      }
      else
      {
        emit(LoginFailedState(message: jsonDecoded['message']),);
        debugPrint("user login failed and his data is : $jsonDecoded");
      }
    }
  }
  catch(e)
  {
    print(e.toString());
  }
}
}
