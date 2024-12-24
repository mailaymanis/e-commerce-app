// ignore_for_file: avoid_print
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/core/utils/helper/app_api.dart';
import 'package:shop_app/core/utils/helper/app_constants.dart';
import 'package:shop_app/features/cart/presentation/view/screen/cart_screen.dart';
import 'package:shop_app/features/category/data/model/category_model.dart';
import 'package:shop_app/features/category/presentation/view/screen/categories_screen.dart';
import 'package:shop_app/features/favourite/presentation/view/screen/favourite_screen.dart';
import 'package:shop_app/features/home/data/model/banners_model.dart';
import 'package:shop_app/features/home/data/model/products_model.dart';
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
    try {
      if (response.statusCode == 200) {
        var jsonDecoded = jsonDecode(response.body);
        if (jsonDecoded['status'] == true) {
          for (var item in jsonDecoded['data']) {
            banners.add(
              BannersModel.fromJson(data: item),
            );
          }
          emit(BannersSuccessState());
        } else {
          emit(BannersFailedState());
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }

//categories method logic
  List<CategoryModel> categories = [];
  void getCategoriesData() async {
    emit(CategoryLoadingState());
    http.Response response = await http.get(
      Uri.parse(AppApis.categoriesApi),
    );
    try {
      if (response.statusCode == 200) {
        var jsonDecoded = jsonDecode(response.body);
        if (jsonDecoded['status'] == true) {
          for (var item in jsonDecoded['data']['data']) {
            categories.add(
              CategoryModel.fromJson(data: item),
            );
          }
          emit(CategorySuccessState());
        } else {
          emit(CategoryFailedState());
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }

//products method logic
  List<ProductsModel> products = [];
  void getProductsDate() async {
    emit(ProductsLoadingState());
    http.Response response = await http.get(
      Uri.parse(AppApis.productsApi),
      headers: {
        'lang': 'en',
        'Authorization': token!,
      },
    );
    try {
      if (response.statusCode == 200) {
        var jsonDecoded = jsonDecode(response.body);
        if (jsonDecoded['status'] == true) {
          for (var item in jsonDecoded['data']['products']) {
            products.add(
              ProductsModel.fromJson(data: item),
            );
          }
          emit(ProductsSuccessState());
          debugPrint("products data is : $jsonDecoded");
        } else {
          emit(ProductsFailedState());
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }

//search for products method logic
  List<ProductsModel> searchItems = [];
  void searchForProducts({required String input}) {
    searchItems = products
        .where((element) =>
            element.name!.toLowerCase().contains(input.toLowerCase()))
        .toList();
    emit(SearchForProductsSuccessState());
  }

  List<ProductsModel> favourites = [];
  void getFavouritesData() async{
    emit(FavouritesLoadingState());
    http.Response response = await http.get(
      Uri.parse(AppApis.favouritesApi),
      headers: {
        'lang' : 'en',
        'Authorization' : token!,
      },
    );
    try
    {
      if(response.statusCode == 200)
      {
        var jsonDecoded = jsonDecode(response.body);
        if(jsonDecoded['status'] == true)
        {
          for(var item in jsonDecoded['data']['data'])
          {
            favourites.add(ProductsModel.fromJson(data:item['product']),);
          }
          debugPrint("number of favourite items is : ${favourites.length}");
          emit(FavouritesSuccessState());
        }
        else
        {
          emit(FavouritesFailedState());
        }
      }
    }
    catch(e)
    {
      print(e.toString());
    }
  }
}
