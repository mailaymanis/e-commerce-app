import 'package:flutter/material.dart';
import 'package:shop_app/features/detailed/presentation/view/screen/detailed_screen.dart';
import '../../../../layout/presentation/view_model/cubit/layout_cubit.dart';
import '../../../data/model/products_model.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({super.key, required this.model, required this.cubit});
  final ProductsModel model;
  final LayoutCubit cubit;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DetailedScreen(products: model)),
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 2, horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.grey.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          spacing: 2,
          children: [
            IconButton(
              onPressed: () {
                cubit.addOrRemoveFromCart(productID: model.id.toString());
              },
              icon: Icon(
                Icons.shopping_cart,
                color: cubit.cartID.contains(model.id.toString())
                    ? Colors.red
                    : Colors.white,
              ),
            ),
            Expanded(
              child: Image.network(
                model.image!,
                filterQuality: FilterQuality.high,
                fit: BoxFit.fill,
              ),
            ),
            Text(
              model.name!,
              style: TextStyle(
                overflow: TextOverflow.ellipsis,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Row(
                    spacing: 5,
                    children: [
                      Text(
                        "${model.price.toString()}\$",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "${model.oldPrice.toString()}\$",
                        style: TextStyle(
                          decoration: TextDecoration.lineThrough,
                        ),
                      )
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {
                    cubit.addOrRemoveFromFavourites(
                        productID: model.id.toString());
                  },
                  icon: Icon(
                    Icons.favorite,
                    color: cubit.favouritesID.contains(model.id.toString())
                        ? Colors.red
                        : Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
