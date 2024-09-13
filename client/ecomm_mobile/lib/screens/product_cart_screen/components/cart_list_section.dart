import 'package:ecomm_mobile/utility/utility_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cart/model/cart_model.dart';
import 'package:gap/gap.dart';
import 'package:iconsax/iconsax.dart';

class CartListSection extends StatelessWidget {
  const CartListSection({super.key, required this.cartProducts});
  final List<CartModel> cartProducts;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: cartProducts.mapWithIndex((index, _) {
            CartModel cartItem = cartProducts[index];
            return Container(
              width: double.infinity,
              margin: const EdgeInsets.all(15),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.grey.shade200.withOpacity(.6),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Wrap(
                spacing: 10,
                runSpacing: 10,
                crossAxisAlignment: WrapCrossAlignment.center,
                alignment: WrapAlignment.spaceEvenly,
                children: [
                  Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.primaries[index],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: Image.network(
                          cartItem.productImages!.safeElementAt(0) ?? '',
                          width: 100,
                          height: 90,
                          loadingBuilder: (BuildContext context, Widget child,
                              ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) {
                              return child;
                            }
                            return Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes !=
                                        null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                    : null,
                              ),
                            );
                          },
                          errorBuilder: (BuildContext context, Object exception,
                              StackTrace? stackTrace) {
                            return const Icon(
                              Icons.error,
                              color: Colors.red,
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        cartItem.productName,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                      ),
                      const Gap(5),
                      Text(
                        '${cartItem.quantity}',
                        style: TextStyle(
                          color: Colors.black.withOpacity(.5),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const Gap(5),
                      Text(
                        '\$${cartItem.variants.safeElementAt(0)?.price}',
                        style: const TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 23,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () {
                            // TODO: should complete call updateCart decrement
                          },
                          icon: const Icon(
                            Iconsax.minus,
                            color: Color(0xFFEC6813),
                          ),
                        ),
                        Text(
                          '${cartItem.quantity}',
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w700),
                        ),
                        IconButton(
                          splashRadius: 10.0,
                          onPressed: () {
                            //TODO: should complete updateCart increment
                          },
                          icon: const Icon(
                            Iconsax.add,
                            color: Color(0xFFEC6813),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
