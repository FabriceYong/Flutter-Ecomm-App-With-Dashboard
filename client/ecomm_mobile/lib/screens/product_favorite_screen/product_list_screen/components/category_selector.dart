import 'package:ecomm_mobile/models/category.dart';
import 'package:ecomm_mobile/screens/product_by_category_screen/product_by_category_screen.dart';
import 'package:ecomm_mobile/utility/animation/open_container_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CategorySelector extends StatelessWidget {
  const CategorySelector({super.key, required this.categories});
  final List<Category> categories;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final Category category = categories[index];
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
            child: OpenContainerWrapper(
              nextScreen: ProductByCategoryScreen(
                selectedCategory: categories[index],
              ),
              child: Container(
                height: 80,
                width: 80,
                margin: const EdgeInsets.symmetric(
                  horizontal: 8,
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: category.isSelected
                      ? const Color(0xFFf16b26)
                      : const Color(0xFFE5E6E8),
                  borderRadius: BorderRadius.circular(10),
                ),
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Image.network(
                        category.image ?? '',
                        width: 90,
                        height: 90,
                        fit: BoxFit.contain,
                        errorBuilder:
                            (BuildContext context, error, stackTrace) {
                          return const Icon(
                            Icons.error,
                            color: Colors.grey,
                          );
                        },
                      ),
                    ),
                    const Gap(4),
                    Text(
                      category.name ?? '',
                      style: TextStyle(
                        color:
                            category.isSelected ? Colors.white : Colors.black,
                        fontSize: 12,
                      ),
                      overflow: TextOverflow.ellipsis,
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
