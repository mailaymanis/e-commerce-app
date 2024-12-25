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

//get favourites data method logic
  List<ProductsModel> favourites = [];
  Set<String> favouritesID = {};
  Future<void> getFavouritesData() async{
    emit(FavouritesLoadingState());
    favourites.clear();
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
            favouritesID.add(item['product']['id'].toString());
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

//add or remove from favourites method logic
void addOrRemoveFromFavourites({required String productID }) async{
emit(AddOrRemoveFromFavouriteLoadingState());
http.Response response = await http.post(
  Uri.parse(AppApis.favouritesApi),
  body:{
    'product_id' : productID,
  },
  headers:{
    'lang' : 'en',
    'Authorization' : token!,
  },
);
try
{
  if(response.statusCode == 200)
  {
     var jsonDecoded = jsonDecode(response.body);
     if (jsonDecoded['status'] == true)
     {
         if(favouritesID.contains(productID)==true)
         {
           //remove products
           favouritesID.remove(productID);
         }
         else
         {
           favouritesID.add(productID);
         }
         await getFavouritesData();
         emit(AddOrRemoveFromFavouriteSuccessState());
     }
     else
     {
       emit(AddOrRemoveFromFavouriteFailedState());
     }
  }
}
catch(e)
{
  print(e.toString());
}
}

//get cart data method logic
List<ProductsModel> cart = [];
Set<String> cartID = {};
Future<void> getCartData() async{
    emit(CartLoadingState());
    cart.clear();
    http.Response response = await http.get(
      Uri.parse(AppApis.cartApi),
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
          for(var item in jsonDecoded['data']['cart_items'])
          {
            cart.add(ProductsModel.fromJson(data:item['product']),);
            cartID.add(item['product']['id'].toString());
          }
          print("number of cart items is : ${cart.length}");
          emit(CartSuccessState());
        }
        else
        {
          emit(CartFailedState());
        }
      }
    }
    catch(e)
    {
      print(e.toString());
    }
}

//add or remove from favourites method logic
void addOrRemoveFromCart({required String productID}) async{
  emit(AddOrRemoveFromCartLoadingState());
  http.Response response = await http.post(
    Uri.parse(AppApis.cartApi),
    body:{
      'product_id' : productID,
    },
    headers:{
      'lang' : 'en',
      'Authorization' : token!,
    },
  );
  try
  {
    if(response.statusCode == 200)
    {
      var jsonDecoded = jsonDecode(response.body);
      if (jsonDecoded['status'] == true)
      {
        if(cartID.contains(productID) ==true)
        {
          //remove product from cart
          cartID.remove(productID);
        }
        else
        {
          //add product to cart
          cartID.add(productID);
        }
        await getCartData();
        emit(AddOrRemoveFromCartSuccessState());
      }
      else
      {
        emit(AddOrRemoveFromCartFailedState());
      }
    }
  }
  catch(e)
  {
    print(e.toString());
  }
}
}
