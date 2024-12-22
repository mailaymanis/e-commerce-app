import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/features/cart/presentation/view/screen/cart_screen.dart';
import 'package:shop_app/features/category/presentation/view/screen/categories_screen.dart';
import 'package:shop_app/features/favourite/presentation/view/screen/favourite_screen.dart';
import 'package:shop_app/features/home/presentation/view/screen/home_screen.dart';
import 'package:shop_app/features/layout/presentation/view_model/cubit/layout_states.dart';
import 'package:shop_app/features/profile/presentation/view/user_profile_screen.dart';

class LayoutCubit extends Cubit<LayoutStates> {
  LayoutCubit() : super(LayoutInitializationState());
  int bottomNavIndex = 0;
  List<Widget> layoutScreens = [
    HomeScreen(),
    CategoryScreen(),
    FavouriteScreen(),
    CartScreen(),
    ProfileScreen(),
  ];
//bottom nav method logic
  void changeBottomNav({required int index}){
    bottomNavIndex = index;
    emit(BottomNavSuccessState());
  }
}
