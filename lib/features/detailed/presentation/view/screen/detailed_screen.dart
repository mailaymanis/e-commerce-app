import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../home/data/model/products_model.dart';
import '../../../../layout/presentation/view_model/cubit/layout_cubit.dart';

class DetailedScreen extends StatefulWidget {
  const DetailedScreen({super.key, required this.products});
  final ProductsModel products;
  @override
  State<DetailedScreen> createState() => _DetailedScreenState();
}

class _DetailedScreenState extends State<DetailedScreen> {
  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<LayoutCubit>(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              crossAxisAlignment:CrossAxisAlignment.start,
              mainAxisAlignment:MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: Container(
                        color: Colors.grey.withValues(alpha: 0.2),
                        child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(Icons.arrow_back_ios_rounded)),
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: Container(
                        color: Colors.grey.withValues(alpha: 0.2),
                        child: IconButton(
                          onPressed: (){
                            setState(() {
                              cubit.addOrRemoveFromFavourites(productID:widget.products.id.toString());
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(
                                SnackBar(
                                  content:cubit.favouritesID.contains(widget.products.id.toString()) ?const Text(
                                    "Product deleted from favourites",
                                    style: TextStyle(fontSize: 20),
                                  ) : Text( "Product add to favourites",
                                    style: TextStyle(fontSize: 20),),
                                  backgroundColor:cubit.favouritesID.contains(widget.products.id.toString()) ? Colors.red : Colors.green,
                                  shape: OutlineInputBorder(
                                      borderRadius:
                                      BorderRadius.circular(5)),
                                ),
                              );
                            });
                          },
                          icon:Icon(Icons.favorite ,
                            color:cubit.favouritesID.contains(widget.products.id.toString()) ? Colors.red : Colors.white ,
                          ),),
                      ),
                    ),
                  ],
                ),
                Container(
                  width: MediaQuery.sizeOf(context).width,
                  height: 280,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(widget.products.image!),
                          filterQuality: FilterQuality.high,
                          fit:BoxFit.fill
                      )),
                ),
                const SizedBox(height: 10,),
                const Text("Name : " , style: TextStyle(
                  color:Colors.blue,
                  fontSize: 30,
                ),),
                Text(widget.products.name! , style:const TextStyle(
                  fontWeight:FontWeight.bold,
                  fontSize: 25,
                ),),
                const SizedBox(height: 10,),
                const Text("Price : " , style: TextStyle(
                  color:Colors.blue,
                  fontSize: 30,
                ),),
                Text("${widget.products.price.toString()}\$" , style:const TextStyle(
                  color:Colors.grey,
                  fontWeight:FontWeight.bold,
                  fontSize: 25,
                ),),
                const SizedBox(height: 10,),
                const Text("description : " , style: TextStyle(
                  color:Colors.blue,
                  fontSize: 30,
                ),),
                Text(widget.products.description!.trim() , style:const TextStyle(
                  fontWeight:FontWeight.bold,
                  fontSize: 15,
                ),),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
