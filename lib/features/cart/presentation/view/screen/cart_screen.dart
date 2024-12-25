import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../layout/presentation/view_model/cubit/layout_cubit.dart';
import '../../../../layout/presentation/view_model/cubit/layout_states.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit , LayoutStates>(
      listener:(context , state){},
      builder:(context , state){
        final cubit = BlocProvider.of<LayoutCubit>(context);
        return Scaffold(
          body:SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Expanded(
                    child: ListView.builder(
                        itemCount: cubit.cart.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.only(bottom: 20),
                            clipBehavior: Clip.none,
                            width: double.infinity,
                            height: 170,
                            decoration: BoxDecoration(
                              boxShadow: const [
                                BoxShadow(
                                    color: Colors.grey,
                                    spreadRadius: 2.5,
                                    blurRadius: 2.5,
                                    blurStyle: BlurStyle.inner
                                ),
                              ],
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Stack(
                              children: [
                                Positioned(
                                  top: 25,
                                  left: 0,
                                  child: CircleAvatar(
                                    radius: 60,
                                    backgroundImage: NetworkImage(cubit.cart[index].image!),
                                  ),
                                ),
                                Positioned(
                                    top: 20,
                                    left: 130,
                                    child: Text(
                                      cubit.cart[index].name!,
                                      style:const TextStyle(
                                          color: Colors.black,
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold),
                                    )),
                                 Positioned(
                                    top: 50,
                                    left: 130,
                                    child: Text(
                                      "${cubit.cart[index].price!.toString()}\$",
                                      style:  TextStyle(
                                          color: Colors.grey,
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold),
                                    )),
                                Positioned(
                                  top: 85,
                                  left: 180,
                                  child: MaterialButton(
                                    onPressed:(){},
                                    color:Colors.orangeAccent,
                                    shape: OutlineInputBorder(
                                      borderRadius:  BorderRadius.circular(12),
                                    ),
                                    child:const Text("Check Out"),
                                  ),
                                ),
                                Positioned(
                                  top: 50,
                                  left: 270,
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        cubit.addOrRemoveFromCart(
                                            productID: cubit
                                                .cart[index].id
                                                .toString());
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: const Text(
                                              "Product deleted successfully",
                                              style: TextStyle(fontSize: 20),
                                            ),
                                            backgroundColor: Colors.red,
                                            shape: OutlineInputBorder(
                                                borderRadius:
                                                BorderRadius.circular(5)),
                                          ),
                                        );
                                      });
                                    },
                                    child: const Text(
                                      "Remove",
                                      style: TextStyle(
                                        color:Colors.red,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
