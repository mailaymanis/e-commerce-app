// ignore_for_file: avoid_print
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:shop_app/core/utils/helper/app_api.dart';
import 'package:shop_app/core/utils/helper/app_constants.dart';
import 'package:shop_app/features/profile/data/model/user_model.dart';
import 'package:shop_app/features/profile/presentation/view_model/cubit/user_profile_states.dart';
import 'package:http/http.dart' as http;

class UserProfileCubit extends Cubit<UserProfileStates> {
  UserProfileCubit() : super(UserProfileInitializationState());

//create instance from User Model
  UserModel? userModel;
//userProfile method logic
  void getUserProfileData() async {
    http.Response response = await http.get(
      Uri.parse(AppApis.userProfileApi),
      headers: {
        'lang': 'en',
        'Authorization': token!,
      },
    );

    try
    {
      if (response.statusCode == 200)
      {
        var jsonDecoded = jsonDecode(response.body);
        if (jsonDecoded['status'] == true)
        {
          userModel = UserModel.fromJson(data: jsonDecoded['data']);
          emit(UserProfileSuccessState());
          debugPrint("user data is : $jsonDecoded");
        }
        else
        {
          emit(
            UserProfileFailedState(message: jsonDecoded['message']),
          );
        }
      }
    }
    catch (e)
    {
      print(e.toString());
    }
  }
}
