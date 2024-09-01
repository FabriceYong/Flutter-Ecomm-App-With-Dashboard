import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/brand.dart';
import '../../../models/category.dart';
import '../../../models/product.dart';
import '../../../models/sub_category.dart';
import '../../../models/variant_type.dart';
import '../../../utility/constants.dart';
import '../../../utility/extensions.dart';
import '../../../widgets/custom_dropdown.dart';
import '../../../widgets/custom_text_field.dart';
import '../../../widgets/multi_select_drop_down.dart';
import '../../../widgets/product_image_card.dart';
import '../provider/dash_board_provider.dart';

class ProductSubmitForm extends StatelessWidget {
  final Product? product;

  const ProductSubmitForm({super.key, this.product});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    context.dashBoardProvider.setDataForUpdateProduct(product);
    return SingleChildScrollView(
      child: Form(
        key: context.dashBoardProvider.addProductFormKey,
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
              const SizedBox(height: defaultPadding),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Consumer<DashBoardProvider>(
                    builder: (context, dashProvider, child) {
                      return ProductImageCard(
                        labelText: 'Main Image',
                        imageFile: dashProvider.selectedMainImage,
                        imageUrlForUpdateImage:
                            product?.images.safeElementAt(0)?.url,
                        onTap: () {
                          dashProvider.pickImage(imageCardNumber: 1);
                        },
                        onRemoveImage: () {
                          dashProvider.selectedMainImage = null;
                          dashProvider.updateUI();
                        },
                      );
                    },
                  ),
                  Consumer<DashBoardProvider>(
                    builder: (context, dashProvider, child) {
                      return ProductImageCard(
                        labelText: 'Second image',
                        imageFile: dashProvider.selectedSecondImage,
                        imageUrlForUpdateImage:
                            product?.images.safeElementAt(1)?.url,
                        onTap: () {
                          dashProvider.pickImage(imageCardNumber: 2);
                        },
                        onRemoveImage: () {
                          dashProvider.selectedSecondImage = null;
                          dashProvider.updateUI();
                        },
                      );
                    },
                  ),
                  Consumer<DashBoardProvider>(
                    builder: (context, dashProvider, child) {
                      return ProductImageCard(
                        labelText: 'Third image',
                        imageFile: dashProvider.selectedThirdImage,
                        imageUrlForUpdateImage:
                            product?.images.safeElementAt(2)?.url,
                        onTap: () {
                          dashProvider.pickImage(imageCardNumber: 3);
                        },
                        onRemoveImage: () {
                          dashProvider.selectedThirdImage = null;
                          dashProvider.updateUI();
                        },
                      );
                    },
                  ),
                  Consumer<DashBoardProvider>(
                    builder: (context, dashProvider, child) {
                      return ProductImageCard(
                        labelText: 'Fourth image',
                        imageFile: dashProvider.selectedFourthImage,
                        imageUrlForUpdateImage:
                            product?.images.safeElementAt(3)?.url,
                        onTap: () {
                          dashProvider.pickImage(imageCardNumber: 4);
                        },
                        onRemoveImage: () {
                          dashProvider.selectedFourthImage = null;
                          dashProvider.updateUI();
                        },
                      );
                    },
                  ),
                  Consumer<DashBoardProvider>(
                    builder: (context, dashProvider, child) {
                      return ProductImageCard(
                        labelText: 'Fifth image',
                        imageFile: dashProvider.selectedFifthImage,
                        imageUrlForUpdateImage:
                            product?.images.safeElementAt(4)?.url,
                        onTap: () {
                          dashProvider.pickImage(imageCardNumber: 5);
                        },
                        onRemoveImage: () {
                          dashProvider.selectedFifthImage = null;
                          dashProvider.updateUI();
                        },
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: defaultPadding),
              CustomTextField(
                controller: context.dashBoardProvider.productNameCtrl,
                labelText: 'Product Name',
                onSave: (val) {},
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: defaultPadding),
              CustomTextField(
                controller: context.dashBoardProvider.productDescCtrl,
                labelText: 'Product Description',
                lineNumber: 3,
                onSave: (val) {},
              ),
              const SizedBox(height: defaultPadding),
              Row(
                children: [
                  Expanded(child: Consumer<DashBoardProvider>(
                    builder: (context, dashProvider, child) {
                      return CustomDropdown(
                        key: ValueKey(dashProvider.selectedCategory?.sId),
                        initialValue: dashProvider.selectedCategory,
                        hintText: dashProvider.selectedCategory?.name ??
                            'Select category',
                        items: context.dataProvider.categories,
                        displayItem: (Category? category) =>
                            category?.name ?? '',
                        onChanged: (newValue) {
                          if (newValue != null) {
                            // should complete call  filterSubcategory
                            context.dashBoardProvider
                                .filterSubCategory(newValue);
                          }
                        },
                        validator: (value) {
                          if (value == null) {
                            return 'Please select a category';
                          }
                          return null;
                        },
                      );
                    },
                  )),
                  Expanded(child: Consumer<DashBoardProvider>(
                    builder: (context, dashProvider, child) {
                      return CustomDropdown(
                        key: ValueKey(dashProvider.selectedSubCategory?.sId),
                        hintText: dashProvider.selectedSubCategory?.name ??
                            'Sub category',
                        items: dashProvider.subCategoriesByCategory,
                        initialValue: dashProvider.selectedSubCategory,
                        displayItem: (SubCategory? subCategory) =>
                            subCategory?.name ?? '',
                        onChanged: (newValue) {
                          if (newValue != null) {
                            // should complete call filterBrand
                            context.dashBoardProvider.filterBrand(newValue);
                          }
                        },
                        validator: (value) {
                          if (value == null) {
                            return 'Please select sub category';
                          }
                          return null;
                        },
                      );
                    },
                  )),
                  Expanded(
                    child: Consumer<DashBoardProvider>(
                      builder: (context, dashProvider, child) {
                        return CustomDropdown(
                            key: ValueKey(dashProvider.selectedBrand?.sId),
                            initialValue: dashProvider.selectedBrand,
                            items: dashProvider.brandsBySubCategory,
                            hintText: dashProvider.selectedBrand?.name ??
                                'Select Brand',
                            displayItem: (Brand? brand) => brand?.name ?? '',
                            onChanged: (newValue) {
                              if (newValue != null) {
                                dashProvider.selectedBrand = newValue;
                                dashProvider.updateUI();
                              }
                            },
                            validator: (value) {
                              if (value == null) {
                                return 'Please select a brand';
                              }
                              return null;
                            });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: defaultPadding),
              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      controller: context.dashBoardProvider.productPriceCtrl,
                      labelText: 'Price',
                      inputType: TextInputType.number,
                      onSave: (val) {},
                      validator: (value) {
                        if (value == null) {
                          return 'Please enter price';
                        }
                        return null;
                      },
                    ),
                  ),
                  Expanded(
                    child: CustomTextField(
                      controller: context.dashBoardProvider.productOffPriceCtrl,
                      labelText: 'Offer price',
                      inputType: TextInputType.number,
                      onSave: (val) {},
                    ),
                  ),
                  Expanded(
                    child: CustomTextField(
                      controller: context.dashBoardProvider.productQntCtrl,
                      labelText: 'Quantity',
                      inputType: TextInputType.number,
                      onSave: (val) {},
                      validator: (value) {
                        if (value == null) {
                          return 'Please enter quantity';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(width: defaultPadding),
              Row(
                children: [
                  Expanded(
                    child: Consumer<DashBoardProvider>(
                      builder: (context, dashProvider, child) {
                        return CustomDropdown(
                          key: ValueKey(dashProvider.selectedVariantType?.sId),
                          initialValue: dashProvider.selectedVariantType,
                          items: context.dataProvider.variantTypes,
                          displayItem: (VariantType? variantType) =>
                              variantType?.name ?? '',
                          onChanged: (newValue) {
                            if (newValue != null) {
                              // should complete call filterVariant
                              context.dashBoardProvider.filterVariant(newValue);
                            }
                          },
                          hintText: 'Select Variant type',
                        );
                      },
                    ),
                  ),
                  Expanded(
                    child: Consumer<DashBoardProvider>(
                      builder: (context, dashProvider, child) {
                        final filteredSelectedItems = dashProvider
                            .selectedVariants
                            .where((item) => dashProvider.variantsByVariantType
                                .contains(item))
                            .toList();
                        return MultiSelectDropDown(
                          items: dashProvider.variantsByVariantType,
                          onSelectionChanged: (newValue) {
                            dashProvider.selectedVariants = newValue;
                            dashProvider.updateUI();
                          },
                          displayItem: (String item) => item,
                          selectedItems: filteredSelectedItems,
                        );
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: defaultPadding),
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
                          .dashBoardProvider.addProductFormKey.currentState!
                          .validate()) {
                        context
                            .dashBoardProvider.addProductFormKey.currentState!
                            .save();
                        // should complete call submitProduct
                        context.dashBoardProvider.submitProduct();
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
void showAddProductForm(BuildContext context, Product? product) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: bgColor,
        title: Center(
            child: Text('Add Product'.toUpperCase(),
                style: const TextStyle(color: primaryColor))),
        content: ProductSubmitForm(product: product),
      );
    },
  );
}

extension SafeList<T> on List<T>? {
  T? safeElementAt(int index) {
    // Check if the list is null or if the index is out of range
    if (this == null || index < 0 || index >= this!.length) {
      return null;
    }
    return this![index];
  }
}
