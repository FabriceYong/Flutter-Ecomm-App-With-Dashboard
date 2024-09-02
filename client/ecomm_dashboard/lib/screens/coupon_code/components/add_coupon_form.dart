import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '../../../models/category.dart';
import '../../../models/coupon.dart';
import '../../../models/product.dart';
import '../../../models/sub_category.dart';
import '../../../utility/constants.dart';
import '../../../utility/extensions.dart';
import '../../../widgets/custom_date_picker.dart';
import '../../../widgets/custom_dropdown.dart';
import '../../../widgets/custom_text_field.dart';
import '../provider/coupon_code_provider.dart';

class CouponSubmitForm extends StatelessWidget {
  final Coupon? coupon;

  const CouponSubmitForm({super.key, this.coupon});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    context.couponCodeProvider.setDataForUpdateCoupon(coupon);
    return SingleChildScrollView(
      child: Form(
        key: context.couponCodeProvider.addCouponFormKey,
        child: Container(
          width: size.width * 0.7,
          padding: const EdgeInsets.all(defaultPadding),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Gap(defaultPadding),
              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      controller: context.couponCodeProvider.couponCodeCtrl,
                      labelText: 'Coupon Code',
                      onSave: (val) {},
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter coupon code';
                        }
                        return null;
                      },
                    ),
                  ),
                  Expanded(
                    child: CustomDropdown(
                      key: GlobalKey(),
                      hintText: 'Discount Type',
                      items: const ['fixed', 'percentage'],
                      initialValue:
                          context.couponCodeProvider.selectedDiscountType,
                      onChanged: (newValue) {
                        context.couponCodeProvider.selectedDiscountType =
                            newValue ?? 'fixed';
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select a discount type';
                        }
                        return null;
                      },
                      displayItem: (val) => val,
                    ),
                  ),
                ],
              ),
              const Gap(defaultPadding),
              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      controller: context.couponCodeProvider.discountAmountCtrl,
                      labelText: 'Discount Amount',
                      inputType: TextInputType.number,
                      onSave: (val) {},
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter discount amount';
                        }
                        return null;
                      },
                    ),
                  ),
                  Expanded(
                    child: CustomTextField(
                      controller:
                          context.couponCodeProvider.minimumPurchaseAmountCtrl,
                      labelText: 'Minimum Purchase Amount',
                      inputType: TextInputType.number,
                      onSave: (val) {},
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select status';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              const Gap(defaultPadding),
              Row(
                children: [
                  Expanded(
                    child: CustomDatePicker(
                      labelText: 'Select Date',
                      controller: context.couponCodeProvider.endDateCtrl,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                      onDateSelected: (DateTime date) {
                        print('Selected Date: $date');
                      },
                    ),
                  ),
                  Expanded(
                    child: CustomDropdown(
                      key: GlobalKey(),
                      hintText: 'Status',
                      initialValue:
                          context.couponCodeProvider.selectedCouponStatus,
                      items: const ['active', 'inactive'],
                      displayItem: (val) => val,
                      onChanged: (newValue) {
                        context.couponCodeProvider.selectedCouponStatus =
                            newValue ?? 'active';
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select status';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Consumer<CouponCodeProvider>(
                      builder: (context, couponProvider, child) {
                        return CustomDropdown(
                          initialValue: couponProvider.selectedCategory,
                          hintText: couponProvider.selectedCategory?.name ??
                              'Select category',
                          items: context.dataProvider.categories,
                          displayItem: (Category? category) =>
                              category?.name ?? '',
                          onChanged: (newValue) {
                            if (newValue != null) {
                              couponProvider.selectedSubCategory = null;
                              couponProvider.selectedProduct = null;
                              couponProvider.selectedCategory = newValue;
                              couponProvider.updateUi();
                            }
                          },
                        );
                      },
                    ),
                  ),
                  Expanded(
                    child: Consumer<CouponCodeProvider>(
                      builder: (context, couponProvider, child) {
                        return CustomDropdown(
                          initialValue: couponProvider.selectedSubCategory,
                          hintText: couponProvider.selectedSubCategory?.name ??
                              'Select sub category',
                          items: context.dataProvider.subCategories,
                          displayItem: (SubCategory? subCategory) =>
                              subCategory?.name ?? '',
                          onChanged: (newValue) {
                            if (newValue != null) {
                              couponProvider.selectedCategory = null;
                              couponProvider.selectedProduct = null;
                              couponProvider.selectedSubCategory = newValue;
                              couponProvider.updateUi();
                            }
                          },
                        );
                      },
                    ),
                  ),
                  Expanded(
                    child: Consumer<CouponCodeProvider>(
                      builder: (context, couponProvider, child) {
                        return CustomDropdown(
                          initialValue: couponProvider.selectedProduct,
                          hintText: couponProvider.selectedProduct?.name ??
                              'Select product',
                          items: context.dataProvider.products,
                          displayItem: (Product? product) =>
                              product?.name ?? '',
                          onChanged: (newValue) {
                            if (newValue != null) {
                              couponProvider.selectedCategory = null;
                              couponProvider.selectedSubCategory = null;
                              couponProvider.selectedProduct = newValue;
                              couponProvider.updateUi();
                            }
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
              const Gap(defaultPadding),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: secondaryColor,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the popup
                    },
                    child: const Text('Cancel'),
                  ),
                  const SizedBox(width: defaultPadding),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: primaryColor,
                    ),
                    onPressed: () {
                      // Validate and save the form
                      if (context
                          .couponCodeProvider.addCouponFormKey.currentState!
                          .validate()) {
                        context
                            .couponCodeProvider.addCouponFormKey.currentState!
                            .save();
                        // should complete call  submitCoupon
                        context.couponCodeProvider.submitCoupon();
                        Navigator.of(context).pop();
                      }
                    },
                    child: const Text('Submit'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// How to show the popup
void showAddCouponForm(BuildContext context, Coupon? coupon) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: bgColor,
        title: Center(
            child: Text('Add Coupon'.toUpperCase(),
                style: const TextStyle(color: primaryColor))),
        content: CouponSubmitForm(coupon: coupon),
      );
    },
  );
}
