import 'package:ecomm_mobile/models/product.dart';
import 'package:ecomm_mobile/screens/product_details_screen/components/product_rating_sections.dart';
import 'package:ecomm_mobile/screens/product_details_screen/provider/provider.dart';
import 'package:ecomm_mobile/widget/carousel_slider.dart';
import 'package:ecomm_mobile/widget/horizontal_list.dart';
import 'package:ecomm_mobile/widget/page_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key, required this.product});
  final Product product;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: SingleChildScrollView(
          child: PageWrapper(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //? Product image section
                Container(
                  height: size.height * .42,
                  width: size.width,
                  decoration: const BoxDecoration(
                      color: Color(0xFFE5E6E8),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(200),
                        bottomRight: Radius.circular(200),
                      )),
                  child: CarouselSlider(items: product.images ?? []),
                ),
                const Gap(20),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //? Product name;
                      Text(
                        '${product.name}',
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                      const Gap(10.0),
                      //? product rating section
                      const ProductRatingSections(),
                      const Gap(10.0),
                      Row(
                        children: [
                          Text(
                            product.offerPrice != null
                                ? '\$${product.offerPrice}'
                                : '\$${product.price}',
                            style: Theme.of(context).textTheme.displayLarge,
                          ),
                          const Gap(3),
                          Visibility(
                            visible: product.offerPrice != product.price,
                            child: Text(
                              '\$${product.price}',
                              style: const TextStyle(
                                decoration: TextDecoration.lineThrough,
                                color: Colors.grey,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          const Spacer(),
                          Text(
                            product.quantity != 0
                                ? 'Avialable stock: ${product.quantity}'
                                : 'Not available',
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        ],
                      ),
                      const Gap(30),
                      product.proVariantId!.isNotEmpty
                          ? Text(
                              'Available ${product.proVariantTypeId?.type}',
                              style: const TextStyle(
                                color: Colors.red,
                                fontSize: 16,
                              ),
                            )
                          : const SizedBox(),
                      Consumer<ProductDetailsProvider>(
                        builder: (context, proDetailsProvider, child) {
                          return HorizontalList(
                            items: product.proVariantId ?? [],
                            itemToString: (value) => value!,
                            selected: proDetailsProvider.selectedVariant,
                            onSelect: (value) {
                              proDetailsProvider.selectedVariant = value;
                              proDetailsProvider.updateUI();
                            },
                          );
                        },
                      ),
                      Text(
                        'About',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const Gap(10.0),
                      Text('${product.description}'),
                      const Gap(40),
                      //? add to cart button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: product.quantity != 0
                              ? () {
                                  //TODO: should complete call addToCart
                                }
                              : null,
                          child: const Text(
                            'Add to cart',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
