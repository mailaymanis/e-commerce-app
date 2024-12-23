import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/features/home/presentation/view/widgets/custom_smooth_indecator.dart';
import 'package:shop_app/features/home/presentation/view/widgets/custom_text_form_field.dart';
import 'package:shop_app/features/layout/presentation/view_model/cubit/layout_cubit.dart';
import 'package:shop_app/features/layout/presentation/view_model/cubit/layout_states.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PageController pageController = PageController();
  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<LayoutCubit>(context);
    return BlocConsumer<LayoutCubit , LayoutStates>(
      listener:(context , state){},
      builder:(context , state){
        return Scaffold(
            body:SafeArea(
              child:Padding(
                padding: EdgeInsets.symmetric(vertical:20 , horizontal:20),
                child:ListView(
                  children: [
                    CustomTextFormField(),
                    SizedBox(height: 20,),
                    cubit.banners.isNotEmpty ? SizedBox(
                       height:150,
                       child:PageView.builder(
                         controller:pageController,
                         itemCount:cubit.banners.length,
                         itemBuilder:(context , index){
                           return Container(
                             margin: const EdgeInsets.only(left: 15),
                             decoration: BoxDecoration(
                               borderRadius: BorderRadius.circular(10),
                               image: DecorationImage(
                                   image: NetworkImage(
                                       cubit.banners[index].image!),
                                   filterQuality: FilterQuality.high,
                                   fit: BoxFit.fill,
                               ),
                             ),
                           );
                         },
                       ),
                     ) : Center(child:CircularProgressIndicator(),),
                     SizedBox(height: 10,),
                    CustomSmoothIndecator(controller: pageController, cubit: cubit),
                  ],
                ),
              ),
            )
        );
      },
    );
  }
}
