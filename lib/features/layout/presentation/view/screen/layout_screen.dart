import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
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
    return BlocConsumer<LayoutCubit, LayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          bottomNavigationBar: SingleChildScrollView(
            scrollDirection:Axis.horizontal,
            child: SalomonBottomBar(
              currentIndex: cubit.bottomNavIndex,
              onTap: (index) {
                cubit.changeBottomNav(index: index);
              },
              selectedItemColor: Colors.orangeAccent,
              unselectedItemColor: Colors.grey,
              backgroundColor: Colors.black54,
              items: [
                SalomonBottomBarItem(icon: Icon(Icons.home), title: Text("Home") , selectedColor:Colors.purple),
                SalomonBottomBarItem(
                    icon: Icon(Icons.category), title: Text("Categories") , selectedColor:Colors.orange),
                SalomonBottomBarItem(
                    icon: Icon(Icons.favorite_outlined),
                    title: Text("Favourites") , selectedColor:Colors.pink),
                SalomonBottomBarItem(
                    icon: Icon(Icons.shopping_cart), title: Text("Cart") , selectedColor:Colors.green),
                SalomonBottomBarItem(
                    icon: Icon(Icons.person), title: Text("Profile") , selectedColor:Colors.blue),
              ],
            ),
          ),
          body: cubit.layoutScreens[cubit.bottomNavIndex],
        );
      },
    );
  }
}
