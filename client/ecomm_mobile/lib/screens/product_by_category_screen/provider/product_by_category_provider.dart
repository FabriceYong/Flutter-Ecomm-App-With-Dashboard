import 'package:ecomm_mobile/core/data/data_provider.dart';
import 'package:ecomm_mobile/models/brand.dart';
import 'package:ecomm_mobile/models/category.dart';
import 'package:ecomm_mobile/models/product.dart';
import 'package:ecomm_mobile/models/sub_category.dart';
import 'package:flutter/material.dart';

class ProductByCategoryProvider extends ChangeNotifier{
  ProductByCategoryProvider(this._dataProvider);
  final DataProvider _dataProvider;
  Category? mySelectedCategory;
  SubCategory? mySelectedSubCategory;
  List<SubCategory> subCategories = [];
  List<Brand> brands = [];
  List<Brand> selectedBrands = [];
  List<Product> filteredProducts = [];

  
  //TODO: should complete filterInitialProductAndSubCategory

  //TODO: should complete filterProductBySubCategory

  //TODO: should complete filterProductByBrand


  //TODO: should complete sortProducts
  void updateUI(){
    notifyListeners();
  }
}