import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/features/layout/presentation/view_model/cubit/layout_cubit.dart';
class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});
  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<LayoutCubit>(context).categories;
    return  Scaffold(
      body:SafeArea(
        child:Padding(
          padding:EdgeInsets.symmetric(vertical:10 , horizontal:20),
          child:GridView.builder(
              gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount:2,
                crossAxisSpacing:15,
                mainAxisSpacing:15,
                childAspectRatio:0.8,
              ),
              itemCount:cubit.length,
              itemBuilder:(context , index){
                return Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      Expanded(child:Image.network(cubit[index].image!)),
                      const SizedBox(height: 10,),
                      Text(cubit[index].name! , style:const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),),
                    ],
                  ),
                );
              }
          ),
        ),
      ),
    );
  }
}
