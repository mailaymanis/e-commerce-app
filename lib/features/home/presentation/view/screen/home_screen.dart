import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/features/home/presentation/view/widgets/custom_smooth_indecator.dart';
import 'package:shop_app/features/home/presentation/view/widgets/custom_text_form_field.dart';
import 'package:shop_app/features/home/presentation/view/widgets/product_item.dart';
import 'package:shop_app/features/layout/presentation/view_model/cubit/layout_cubit.dart';
import 'package:shop_app/features/layout/presentation/view_model/cubit/layout_states.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = true;
  setTimeOut(){
    Future.delayed(Duration(seconds:3),(){
      setState(() {
        isLoading = false;
      });
    });
  }
  @override
  void initState() {
    super.initState();
    setTimeOut();
  }
  PageController pageController = PageController();
  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<LayoutCubit>(context);
    return BlocConsumer<LayoutCubit , LayoutStates>(
      listener:(context , state){},
      builder:(context , state){
        return Skeletonizer(
          enabled:isLoading,
          effect:ShimmerEffect(
            duration:Duration(seconds:3),
            baseColor:Colors.grey.shade300,
            highlightColor:Colors.amber,
          ),
          child: Scaffold(
              body:SafeArea(
                child:Padding(
                  padding: EdgeInsets.symmetric(vertical:20 , horizontal:20),
                    child:ListView(
                    children: [
                      CustomTextFormField(
                        onChanged:(input){
                          cubit.searchForProducts(input: input);
                        },
                      ),
                      SizedBox(height: 20,),
                      SizedBox(
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
                      ),
                      SizedBox(height: 10,),
                      CustomSmoothIndecator(controller: pageController, cubit: cubit),
                      SizedBox(height:20,),
                      Row(
                        mainAxisAlignment:MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Categories" , style: TextStyle(
                            fontSize: 25,
                            fontWeight:FontWeight.bold,
                          ),),
                          Text("See all" ,style: TextStyle(
                            fontSize: 18,
                            fontWeight:FontWeight.bold,
                            color:Colors.grey,
                          ),),
                        ],
                      ),
                      SizedBox(height:20,),
                     SizedBox(
                        width:MediaQuery.sizeOf(context).width,
                        height:120,
                        child:ListView.separated(
                          scrollDirection:Axis.horizontal,
                          separatorBuilder:(context , index){
                            return SizedBox(width: 10,);
                          },
                          itemCount:cubit.categories.length,
                          itemBuilder:(context , index){
                            return Column(
                              spacing: 5,
                              children: [
                                CircleAvatar(
                                  backgroundImage:NetworkImage(cubit.categories[index].image!),
                                  radius:40,
                                ),
                                Text(cubit.categories[index].name!),
                              ],
                            );
                          },
                        ),
                      ),
                      SizedBox(height:20,),
                      Row(
                        mainAxisAlignment:MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Products" , style: TextStyle(
                            fontSize: 25,
                            fontWeight:FontWeight.bold,
                          ),),
                          Text("See all" ,style: TextStyle(
                            fontSize: 18,
                            fontWeight:FontWeight.bold,
                            color:Colors.grey,
                          ),),
                        ],
                      ),
                       GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 15,
                            mainAxisSpacing: 15,
                            childAspectRatio: 0.8,
                          ),
                          itemCount:cubit.searchItems.isNotEmpty ? cubit.searchItems.length : cubit.products.length,
                          itemBuilder: (context, index) {
                            return ProductItem(
                                model:cubit.searchItems.isNotEmpty ? cubit.searchItems[index] : cubit.products[index],
                                cubit: cubit
                            );
                          }),
                    ],
                  ),
                ),
              )
          ),
        );
      },
    );
  }
}
