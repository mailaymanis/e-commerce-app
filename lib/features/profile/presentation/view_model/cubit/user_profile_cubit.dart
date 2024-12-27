// ignore_for_file: avoid_print
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/core/utils/helper/app_api.dart';
import 'package:shop_app/core/utils/helper/app_constants.dart';
import 'package:shop_app/features/profile/data/model/user_model.dart';
import 'package:shop_app/features/profile/presentation/view_model/cubit/user_profile_states.dart';
import 'package:http/http.dart' as http;

class UserProfileCubit extends Cubit<UserProfileStates> {
  UserProfileCubit() : super(UserProfileInitializationState());

//userProfile method logic
//create instance from User Model
  UserModel? userModel;
  Future<void> getUserProfileData() async {
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

//update profile method logic
void updateProfile({required String name , required String email , required String phone}) async{
    emit(UpdateProfileLoadingState());
    http.Response response = await http.put(
      Uri.parse(AppApis.updateProfileApi),
      body:{
        'name' : name,
        'email' : email,
        'phone' : phone,
      },
      headers:{
        'lang' : 'en',
        'Authorization' : token!,
      },
    );
    try
    {
      if (response.statusCode == 200)
      {
        var jsonDecoded = jsonDecode(response.body);
        if (jsonDecoded['status'] == true)
        {
          await getUserProfileData();
          emit(UpdateProfileSuccessState());
        }
        else
        {
          emit(UpdateProfileFailedState(errorMessage: jsonDecoded['message']),);
        }
      }
    }
    catch(e)
    {
      print(e.toString());
    }
}
}

class ThemeCubit extends Cubit<ThemeData>{
  ThemeCubit() : super(ThemeData.light()){
    _getThemeFromPrefs();
  }

Future<void> _saveThemeFromPrefs({required Brightness brightness}) async{
  final themeIndex = brightness == Brightness.light ? 0 : 1;
  final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  await sharedPreferences.setInt('theme', themeIndex);
}

  Future<void> _getThemeFromPrefs() async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final savedThemeIndex = sharedPreferences.getInt('theme') ?? 0;
    final savedTheme = savedThemeIndex == 0 ? ThemeData.light() : ThemeData.dark();
    emit(savedTheme);
  }

  void toggleTheme() {
    emit(state.brightness == Brightness.light ? ThemeData.dark() : ThemeData.light());
    _saveThemeFromPrefs(brightness: state.brightness);
  }
}
