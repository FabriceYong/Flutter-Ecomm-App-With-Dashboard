import 'package:ecomm_mobile/models/product.dart';
import 'package:ecomm_mobile/screens/product_favorite_screen/provider/favorite_provider.dart';
import 'package:ecomm_mobile/utility/extensions.dart';
import 'package:ecomm_mobile/utility/utility_extension.dart';
import 'package:ecomm_mobile/widget/custom_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class ProductGridTile extends StatelessWidget {
  const ProductGridTile(
      {super.key,
      required this.product,
      required this.index,
      required this.isPriceOff});
  final Product product;
  final int index;
  final bool isPriceOff;

  @override
  Widget build(BuildContext context) {
    double discountPercentage = context.dataProvider
        .calculateDiscountPercentage(
            product.price ?? 0, product.offerPrice ?? 00);
    return GridTile(
      header: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Visibility(
              visible: discountPercentage != 0,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  color: Colors.white,
                ),
                width: 80,
                height: 30,
                alignment: Alignment.center,
                child: Text(
                  'OFF ${discountPercentage.toInt()}%',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            Consumer<FavoriteProvider>(
              builder: (context, favoriteProvider, child) {
                return IconButton(
                  icon: const Icon(
                    Iconsax.heart,
                    //TODO: should complete make color dynamic
                    color: Color(0xFFA6A3A0),
                  ),
                  onPressed: () {
                    // TODO: should complete make call updateToFavoriteList
                  },
                );
              },
            )
          ],
        ),
      ),
      footer: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          padding: const EdgeInsets.all(10.0),
          height: 70,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(15.0),
              bottomRight: Radius.circular(15.0),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FittedBox(
                child: Text(
                  product.name ?? '',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                  ),
                ),
              ),
              const Gap(5),
              Row(
                children: [
                  Flexible(
                    child: Text(
                      product.offerPrice != 0
                          ? '\$${product.offerPrice}'
                          : '\$${product.price}',
                      style: Theme.of(context).textTheme.headlineMedium,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const Gap(3),
                  if (product.offerPrice != null &&
                      product.offerPrice != product.price)
                    Flexible(
                      child: Text(
                        '\$${product.price}',
                        style: const TextStyle(
                          decoration: TextDecoration.lineThrough,
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                ],
              )
            ],
          ),
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: const Color(0xFFE5E6E8),
          borderRadius: BorderRadius.circular(20),
        ),
        child: CustomNetworkImage(
          imageUrl: product.images!.isNotEmpty
              ? product.images?.safeElementAt(0)?.url ?? ''
              : '',
          fit: BoxFit.scaleDown,
          scale: 3.0,
        ),
      ),
    );
  }
}
