import 'package:ecomm_mobile/screens/product_cart_screen/provider/cart_provider.dart';
import 'package:ecomm_mobile/screens/product_cart_screen/components/buy_now_bottom_sheet.dart';
import 'package:ecomm_mobile/screens/product_cart_screen/components/cart_list_section.dart';
import 'package:ecomm_mobile/screens/product_cart_screen/components/empty_cart.dart';
import 'package:ecomm_mobile/utility/animation/animated_switcher_wrapper.dart';
import 'package:ecomm_mobile/utility/app_color.dart';
import 'package:ecomm_mobile/utility/extensions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () {
      // TODO: should complete call getCartItems
    });
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Cart',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColor.darkOrange,
          ),
        ),
      ),
      body: Consumer<CartProvider>(builder: (context, cartProvider, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            cartProvider.myCartItems.isEmpty
                ? const EmptyCart()
                : Consumer<CartProvider>(
                    builder: (context, cartProvider, child) {
                      return CartListSection(
                        cartProducts: cartProvider.myCartItems,
                      );
                    },
                  ),

            //? Total price section
            Container(
              margin: const EdgeInsets.only(bottom: 15),
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w400),
                  ),
                  AnimatedSwitcherWrapper(
                    child: Text(
                      '\$${100}', // TODO: should complete amount to CartSubTotal
                      // key: Valuekey<double>(cartProvider.getCartSubTotal())
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFFEC6813),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            //? Buy now Button
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 30,
                  right: 30,
                  bottom: 20,
                ),
                child: ElevatedButton(
                  onPressed: context.cartProvider.myCartItems.isEmpty
                      ? null
                      : () {
                          showCustomBottomSheet(context);
                        },
                  child: const Text(
                    'By Now',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
