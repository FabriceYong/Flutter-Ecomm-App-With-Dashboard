import 'package:ecomm_mobile/models/product.dart';
import 'package:ecomm_mobile/screens/product_details_screen/product_details_screen.dart';
import 'package:ecomm_mobile/utility/animation/open_container_wrapper.dart';
import 'package:ecomm_mobile/widget/product_grid_tile.dart';
import 'package:flutter/material.dart';

class ProductGridView extends StatelessWidget {
  const ProductGridView({super.key, required this.products});
  final List<Product> products;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: GridView.builder(
        itemCount: products.length,
        shrinkWrap: true,
        physics: const ScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 10 / 16,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
        ),
        itemBuilder: (context, index) {
          Product product = products[index];
          return OpenContainerWrapper(
            nextScreen: ProductDetailsScreen(product: product),
            child: ProductGridTile(
              product: product,
              index: index,
              isPriceOff: product.offerPrice != 0,
            ),
          );
        },
      ),
    );
  }
}
