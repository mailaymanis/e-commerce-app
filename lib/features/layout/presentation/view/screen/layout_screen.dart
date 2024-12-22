import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/features/layout/presentation/view_model/cubit/layout_cubit.dart';
import 'package:shop_app/features/layout/presentation/view_model/cubit/layout_states.dart';

class LayoutScreen extends StatefulWidget {
  const LayoutScreen({super.key});
  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}
class _LayoutScreenState extends State<LayoutScreen> {
  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<LayoutCubit>(context);
    return BlocConsumer<LayoutCubit , LayoutStates>(
      listener:(context , state){},
      builder:(context , state){
        return Scaffold(
          bottomNavigationBar:BottomNavigationBar(
            currentIndex:cubit.bottomNavIndex,
            onTap:(index){
              cubit.changeBottomNav(index: index);
            },
            selectedItemColor:Colors.orangeAccent,
            unselectedItemColor:Colors.grey,
            selectedIconTheme:const IconThemeData(size: 30,),
            type:BottomNavigationBarType.fixed,
            backgroundColor:Colors.black54,
            items:[
              BottomNavigationBarItem(icon:Icon(Icons.home) , label: "Home"),
              BottomNavigationBarItem(icon:Icon(Icons.category) , label: "Categories"),
              BottomNavigationBarItem(icon:Icon(Icons.favorite_outlined) , label: "Favourites"),
              BottomNavigationBarItem(icon:Icon(Icons.shopping_cart) , label: "Cart"),
              BottomNavigationBarItem(icon:Icon(Icons.person) , label: "Profile"),
            ],
          ),
          body:cubit.layoutScreens[cubit.bottomNavIndex],
        );
      },
    );
  }
}
