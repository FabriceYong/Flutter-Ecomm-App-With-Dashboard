import 'package:ecomm_mobile/screens/product_cart_screen/provider/cart_provider.dart';
import 'package:ecomm_mobile/utility/extensions.dart';
import 'package:ecomm_mobile/widget/apply_coupon_button.dart';
import 'package:ecomm_mobile/widget/complete_order_button.dart';
import 'package:ecomm_mobile/widget/custom_dropdown.dart';
import 'package:ecomm_mobile/widget/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

void showCustomBottomSheet(BuildContext context) {
  context.cartProvider.clearCouponDiscount();
  context.cartProvider.retrieveSavedAddress();
  showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: context.cartProvider.buyNowFormKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Toggle Address Fields
                  ListTile(
                    title: const Text('Enter Address'),
                    trailing: IconButton(
                      onPressed: () {
                        context.cartProvider.isExpanded =
                            !context.cartProvider.isExpanded;
                        (context as Element).markNeedsBuild();
                      },
                      icon: Icon(
                        context.cartProvider.isExpanded
                            ? Icons.arrow_drop_up
                            : Icons.arrow_drop_down,
                      ),
                    ),
                  ),

                  Consumer<CartProvider>(
                    builder: (context, cartProvider, child) {
                      return Visibility(
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(.2),
                                  spreadRadius: 2,
                                  blurRadius: 4,
                                  offset: const Offset(0, 3),
                                ),
                              ]),
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.only(bottom: 10),
                          child: Column(
                            children: [
                              CustomTextField(
                                height: 65,
                                inputType: TextInputType.number,
                                labelText: 'Phone',
                                controller:
                                    context.cartProvider.phoneController,
                                onSave: (value) {},
                                validator: (value) => value!.isEmpty
                                    ? 'Please enter a phone number'
                                    : null,
                              ),
                              CustomTextField(
                                height: 65,
                                labelText: 'Street',
                                onSave: (value) {},
                                controller:
                                    context.cartProvider.streetController,
                                validator: (value) => value!.isEmpty
                                    ? 'Please enter a street'
                                    : null,
                              ),
                              CustomTextField(
                                height: 65,
                                labelText: 'City',
                                onSave: (value) {},
                                controller: context.cartProvider.cityController,
                                validator: (value) => value!.isEmpty
                                    ? 'Please enter a city'
                                    : null,
                              ),
                              CustomTextField(
                                height: 65,
                                labelText: 'State',
                                onSave: (value) {},
                                controller:
                                    context.cartProvider.stateController,
                                validator: (value) => value!.isEmpty
                                    ? 'Please enter a state'
                                    : null,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: CustomTextField(
                                      height: 65,
                                      labelText: 'Postal Code',
                                      onSave: (value) {},
                                      inputType: TextInputType.number,
                                      controller: context
                                          .cartProvider.postalCodeController,
                                      validator: (value) => value!.isEmpty
                                          ? 'Please enter a code'
                                          : null,
                                    ),
                                  ),
                                  const Gap(10),
                                  Expanded(
                                    child: CustomTextField(
                                      height: 65,
                                      labelText: 'Country',
                                      onSave: (value) {},
                                      controller: context
                                          .cartProvider.countryController,
                                      validator: (value) => value!.isEmpty
                                          ? 'Please enter a country'
                                          : null,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  Consumer<CartProvider>(
                    builder: (context, cartProvider, child) {
                      return CustomDropdown(
                        bgColor: Colors.white,
                        hintText: cartProvider.selectedPaymentOption,
                        items: const ['cod', 'prepaid'],
                        onChanged: (value) {
                          cartProvider.selectedPaymentOption =
                              value ?? 'prepaid';
                          cartProvider.updateUI();
                        },
                        displayItem: (value) => value,
                      );
                    },
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextField(
                          height: 60,
                          labelText: 'Enter Coupon code',
                          onSave: (value) {},
                          controller: context.cartProvider.couponController,
                        ),
                      ),
                      ApplyCouponButton(
                        onPressed: () {
                          // TODO: should complete call checkCoupon
                        },
                      ),
                    ],
                  ),

                  //? Text for Total Amount, Total Offer Applied and Grand Total
                  Container(
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.only(bottom: 5, left: 6),
                    child: Consumer<CartProvider>(
                      builder: (context, cartProvider, child) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Total Amount : \$${100}', // TODO: should complete CartSubTotal
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              'Total Offer Applied : \$${cartProvider.couponCodeDiscount}',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            const Text(
                              'Grand Total: \$${100}', //TODO: should complete GrandTotal
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                              ),
                            )
                          ],
                        );
                      },
                    ),
                  ),
                  const Divider(),
                  Consumer<CartProvider>(
                    builder: (context, cartProvider, child) {
                      return CompleteOrderButton(
                        labelText:
                            'Complete Order \$${100}', //TODO: should complete GrandTotal
                        onPressed: () {
                          if (!cartProvider.isExpanded) {
                            cartProvider.isExpanded = true;
                            cartProvider.updateUI();
                            return;
                          }
                          // Check if the form is valid
                          if (context.cartProvider.buyNowFormKey.currentState!
                              .validate()) {
                            context.cartProvider.buyNowFormKey.currentState!
                                .save();
                            // TODO: should complete call submitOrder
                          }
                        },
                      );
                    },
                  )
                ],
              ),
            ),
          ),
        );
      },
      isScrollControlled: true);
}
