import 'package:flutter/material.dart';

class LayoutScreen extends StatefulWidget {
  const LayoutScreen({super.key});
  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}
class _LayoutScreenState extends State<LayoutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar:BottomNavigationBar(
        currentIndex:0,
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
    );
  }
}
