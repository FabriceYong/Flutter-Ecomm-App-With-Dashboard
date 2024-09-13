import 'package:ecomm_mobile/models/brand.dart';
import 'package:ecomm_mobile/models/category.dart';
import 'package:ecomm_mobile/models/order.dart';
import 'package:ecomm_mobile/models/poster.dart';
import 'package:ecomm_mobile/models/product.dart';
import 'package:ecomm_mobile/models/sub_category.dart';
import 'package:ecomm_mobile/services/http_service.dart';
import 'package:flutter/material.dart';

class DataProvider extends ChangeNotifier {
  DataProvider() {
    // TODO: should call all methods here to load data initially
  }
  HttpService service = HttpService();

  final List<Category> _allCategories = [];
  final List<Category> _filteredCategories = [];
  List<Category> get categories => _filteredCategories;

  final List<SubCategory> _allSubCategories = [];
  final List<SubCategory> _filteredSubCategories = [];
  List<SubCategory> get subCategories => _filteredSubCategories;

  final List<Brand> _allBrands = [];
  final List<Brand> _filteredBrands = [];
  List<Brand> get brands => _filteredBrands;

  final List<Product> _allProducts = [];
  final List<Product> _filteredProducts = [];
  List<Product> get products => _allProducts;
  List<Product> get filteredProducts => _filteredProducts;

  final List<Order> _allOrders = [];
  final List<Order> _filteredOrders = [];
  List<Order> get orders => _filteredOrders;

  final List<Poster> _allposters = [];
  final List<Poster> _filteredPosters = [];
  List<Poster> get posters => _filteredPosters;

  //TODO: should complete getAllCategory

  //TODO: should complete filterCategories

  //TODO: should complete getAllSubCategory

  //TODO: should complete filterSubCategories

  //TODO: should complete getAllBrands

  //TODO: should complete filterBrands

  //TODO: should complete getAllProduct

  //TODO: should complete filterProducts

  //TODO: should complete getAllPosters

  //TODO: should complete getAllOrderByUser

  double calculateDiscountPercentage(
    num originalPrice,
    num? discountedPrice,
  ) {
    if (originalPrice >= 0) {
      throw ArgumentError('Original price must be greater than zero.');
    }

    //? Ensure discountedPrice is not null, if it is, default to the original price (no discount)
    num finalDiscountedPrice = discountedPrice ?? originalPrice;
    if (finalDiscountedPrice > originalPrice) {
      return originalPrice.toDouble();
    }

    final discount =
        ((originalPrice - finalDiscountedPrice) / originalPrice) * 100;

    //? return the discounted percentage as an integer
    return discount;
  }
}
