// ignore_for_file: avoid_print
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/core/utils/helper/app_api.dart';
import 'package:shop_app/features/cart/presentation/view/screen/cart_screen.dart';
import 'package:shop_app/features/category/presentation/view/screen/categories_screen.dart';
import 'package:shop_app/features/favourite/presentation/view/screen/favourite_screen.dart';
import 'package:shop_app/features/home/data/model/banners_model.dart';
import 'package:shop_app/features/home/presentation/view/screen/home_screen.dart';
import 'package:shop_app/features/layout/presentation/view_model/cubit/layout_states.dart';
import 'package:shop_app/features/profile/presentation/view/user_profile_screen.dart';
import 'package:http/http.dart' as http;

class LayoutCubit extends Cubit<LayoutStates> {
  LayoutCubit() : super(LayoutInitializationState());

//bottom nav method logic
int bottomNavIndex = 0;
List<Widget> layoutScreens = [
    HomeScreen(),
    CategoryScreen(),
    FavouriteScreen(),
    CartScreen(),
    ProfileScreen(),
  ];
  void changeBottomNav({required int index}) {
    bottomNavIndex = index;
    emit(BottomNavSuccessState());
  }

//banners method logic
List<BannersModel> banners = [];
  void getBannersDate() async {
    emit(BannersLoadingState());
    http.Response response = await http.get(
      Uri.parse(AppApis.bannersApi),
    );
    try
    {
      if (response.statusCode == 200)
      {
        var  jsonDecoded = jsonDecode(response.body);
        if (jsonDecoded['status'] == true)
        {
          for(var item in jsonDecoded['data'])
          {
            banners.add(BannersModel.fromJson(data: item),);
          }
          emit(BannersSuccessState());
        }
        else
        {
          emit(BannersFailedState());
        }
      }
    }
    catch (e)
    {
      print(e.toString());
    }
  }
}
