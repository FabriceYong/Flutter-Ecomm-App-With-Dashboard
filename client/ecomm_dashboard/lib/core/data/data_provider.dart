import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' hide Category;
import 'package:get/get.dart';

import '../../../models/category.dart';
import '../../models/api_response.dart';
import '../../models/brand.dart';
import '../../models/coupon.dart';
import '../../models/my_notification.dart';
import '../../models/order.dart';
import '../../models/poster.dart';
import '../../models/product.dart';
import '../../models/sub_category.dart';
import '../../models/variant.dart';
import '../../models/variant_type.dart';
import '../../services/http_services.dart';
import '../../utility/snack_bar_helper.dart';

class DataProvider extends ChangeNotifier {
  DataProvider() {
    getAllCategories();
    getAllSubCategories();
    getAllBrands();
    getAllVariants();
    getAllVarianTypes();
  }
  // HTTP Service
  HttpService service = HttpService();

  List<Category> _allCategories = [];
  List<Category> _filteredCategories = [];
  List<Category> get categories => _filteredCategories;

  List<SubCategory> _allSubCategories = [];
  List<SubCategory> _filteredSubCategories = [];
  List<SubCategory> get subCategories => _filteredSubCategories;

  List<Brand> _allBrands = [];
  List<Brand> _filteredBrands = [];
  List<Brand> get brands => _filteredBrands;

  List<VariantType> _allVariantTypes = [];
  List<VariantType> _filteredVariantTypes = [];
  List<VariantType> get variantTypes => _filteredVariantTypes;

  List<Variant> _allVariants = [];
  List<Variant> _filteredVariants = [];
  List<Variant> get variants => _filteredVariants;

  final List<Product> _allProducts = [];
  final List<Product> _filteredProducts = [];
  List<Product> get products => _filteredProducts;

  final List<Coupon> _allCoupons = [];
  final List<Coupon> _filteredCoupons = [];
  List<Coupon> get coupons => _filteredCoupons;

  List<Poster> _allPosters = [];
  List<Poster> _filteredPosters = [];
  List<Poster> get posters => _filteredPosters;

  final List<Order> _allOrders = [];
  final List<Order> _filteredOrders = [];
  List<Order> get orders => _filteredOrders;

  final List<MyNotification> _allNotifications = [];
  final List<MyNotification> _filteredNotifications = [];
  List<MyNotification> get notifications => _filteredNotifications;

  //Get all Categories
  Future<List<Category>> getAllCategories({bool showSnack = false}) async {
    try {
      Response response = await service.getItems(endpointUrl: 'categories');
      if (response.isOk) {
        ApiResponse<List<Category>> apiResponse =
            ApiResponse<List<Category>>.fromJson(
                response.body,
                (json) => (json as List)
                    .map((item) => Category.fromJson(item))
                    .toList());
        if (apiResponse.success) {
          _allCategories = apiResponse.data ?? [];
          _filteredCategories = List.from(_allCategories);
          notifyListeners();
          if (showSnack) {
            SnackBarHelper.showSuccessSnackBar(apiResponse.message);
          }
        }
      } else {
        if (showSnack) {
          SnackBarHelper.showErrorSnackBar(
              response.body?['messsage'] ?? response.statusText);
        }
      }
    } catch (e) {
      if (showSnack) SnackBarHelper.showErrorSnackBar(e.toString());
      rethrow;
    }
    return _filteredCategories;
  }

  // should complete filterCategories
  void filterCategories(String query) {
    if (query.isEmpty) {
      _filteredCategories = List.from(_allCategories);
    } else {
      final lowerQuery = query.toLowerCase();
      _filteredCategories = _allCategories.where((category) {
        return (category.name ?? '').toLowerCase().contains(lowerQuery);
      }).toList();
    }
    notifyListeners();
  }

  //should complete getAllSubCategory
  Future<List<SubCategory>> getAllSubCategories(
      {bool showSnack = false}) async {
    try {
      Response response = await service.getItems(endpointUrl: 'subCategories');
      if (response.isOk) {
        ApiResponse<List<SubCategory>> apiResponse =
            ApiResponse<List<SubCategory>>.fromJson(
                response.body,
                (json) => (json as List)
                    .map((item) => SubCategory.fromJson(item))
                    .toList());
        if (apiResponse.success) {
          _allSubCategories = apiResponse.data ?? [];
          _filteredSubCategories = apiResponse.data ?? [];
          notifyListeners();
          if (showSnack) {
            SnackBarHelper.showSuccessSnackBar(apiResponse.message);
          }
        } else {
          if (showSnack) {
            SnackBarHelper.showErrorSnackBar('Failed to fetch sub categories');
          }
        }
      } else {
        if (showSnack) {
          SnackBarHelper.showErrorSnackBar(
              response.body?['message'] ?? response.statusText);
        }
      }
    } catch (e) {
      if (showSnack) SnackBarHelper.showErrorSnackBar(e.toString());
      rethrow;
    }
    return _filteredSubCategories;
  }

  // should complete filterSubCategories
  void filterSubCategories(String query) {
    if (query.isEmpty) {
      _filteredSubCategories = List.from(_allSubCategories);
    } else {
      final lowQuery = query.toLowerCase();
      _filteredSubCategories = _allSubCategories.where((subCategory) {
        return (subCategory.name ?? '').toLowerCase().contains(lowQuery);
      }).toList();
    }
    notifyListeners();
  }

  // should complete getAllBrands
  Future<List<Brand>> getAllBrands({bool showSnack = false}) async {
    try {
      final Response response = await service.getItems(endpointUrl: 'brands');
      if (response.isOk) {
        ApiResponse<List<Brand>> apiResponse =
            ApiResponse<List<Brand>>.fromJson(
                response.body,
                (json) => (json as List)
                    .map((item) => Brand.fromJson(item))
                    .toList());
        if (apiResponse.success == true) {
          _filteredBrands = apiResponse.data ?? [];
          _allBrands = apiResponse.data ?? [];
          notifyListeners();
          if (showSnack) {
            SnackBarHelper.showSuccessSnackBar(apiResponse.message);
          }
        } else {
          if (showSnack) {
            SnackBarHelper.showErrorSnackBar('Failed to fetch brands');
          }
        }
      } else {
        if (showSnack) {
          SnackBarHelper.showErrorSnackBar(
              response.body?['message'] ?? response.statusText);
        }
      }
    } catch (e) {
      if (showSnack) SnackBarHelper.showErrorSnackBar(e.toString());
      print(e);
    }
    return _filteredBrands;
  }

  // should complete filterBrands
  void filterBrands(String query) {
    if (query.isEmpty) {
      _filteredBrands = List.from(_allBrands);
    } else {
      final lowerQuery = query.toLowerCase();
      _filteredBrands = _allBrands
          .where(
              (brand) => (brand.name ?? '').toLowerCase().contains(lowerQuery))
          .toList();
    }
    notifyListeners();
  }

  // should complete getAllVariantType
  Future<List<VariantType>> getAllVarianTypes({bool showSnack = false}) async {
    try {
      final Response response =
          await service.getItems(endpointUrl: 'variantTypes');
      if (response.isOk) {
        ApiResponse<List<VariantType>> apiResponse =
            ApiResponse<List<VariantType>>.fromJson(
                response.body,
                (json) => (json as List)
                    .map((item) => VariantType.fromJson(item))
                    .toList());
        if (apiResponse.success == true) {
          _allVariantTypes = apiResponse.data ?? [];
          _filteredVariantTypes = apiResponse.data ?? [];
          notifyListeners();
          if (showSnack) {
            SnackBarHelper.showSuccessSnackBar(apiResponse.message);
          }
        } else {
          if (showSnack) {
            SnackBarHelper.showErrorSnackBar('Failed to fetch variant types');
          }
        }
      } else {
        if (showSnack) {
          SnackBarHelper.showErrorSnackBar(
              response.body?['message'] ?? response.statusText);
        }
      }
    } catch (e) {
      if (showSnack) SnackBarHelper.showErrorSnackBar(e.toString());
      rethrow;
    }
    return _allVariantTypes;
  }

  // should complete filterVariantTypes
  void filterVariantTypes(String query) {
    if (query.isEmpty) {
      _filteredVariantTypes = List.from(_allVariantTypes);
    } else {
      _filteredVariantTypes = _allVariantTypes
          .where((variantType) => (variantType.name ?? '')
              .toLowerCase()
              .contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }

  // should complete getAllVariant
  Future<List<Variant>> getAllVariants({bool showSnack = false}) async {
    try {
      final Response response = await service.getItems(endpointUrl: 'variants');
      if (response.isOk) {
        ApiResponse<List<Variant>> apiResponse =
            ApiResponse<List<Variant>>.fromJson(
                response.body,
                (json) => (json as List)
                    .map((variant) => Variant.fromJson(variant))
                    .toList());
        if (apiResponse.success == true) {
          _allVariants = apiResponse.data ?? [];
          _filteredVariants = apiResponse.data ?? [];
          notifyListeners();
          if (showSnack) SnackBarHelper.showErrorSnackBar(apiResponse.message);
        } else {
          if (showSnack) {
            SnackBarHelper.showErrorSnackBar('Failed to fetch variants');
          }
        }
      } else {
        if (showSnack) {
          SnackBarHelper.showErrorSnackBar(
              response.body?['message'] ?? response.statusText);
        }
      }
    } catch (e) {
      if (showSnack) SnackBarHelper.showErrorSnackBar(e.toString());
      rethrow;
    }
    return _allVariants;
  }

  // should complete filterVariants
  void filterVariants(String query) {
    if (query.isEmpty) {
      _filteredVariants = List.from(_allVariants);
    } else {
      _filteredVariants = _allVariants
          .where((variant) =>
              (variant.name ?? '').toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
  }

  // should complete getAllPosters
  Future<List<Poster>> getAllPosters({bool showSnack = false}) async {
    try {
      final Response response = await service.getItems(endpointUrl: 'posters');
      if (response.isOk) {
        ApiResponse<List<Poster>> apiResponse =
            ApiResponse<List<Poster>>.fromJson(
                response.body,
                (json) => (json as List)
                    .map((poster) => Poster.fromJson(poster))
                    .toList());
        if (apiResponse.success == true) {
          _allPosters = apiResponse.data ?? [];
          _filteredPosters = apiResponse.data ?? [];
          notifyListeners();
          if (showSnack) {
            SnackBarHelper.showSuccessSnackBar(apiResponse.message);
          }
        } else {
          if (showSnack) {
            SnackBarHelper.showErrorSnackBar('Failed to fetch posters');
          }
        }
      } else {
        if (showSnack) {
          SnackBarHelper.showErrorSnackBar(
              response.body?['message'] ?? response.statusText);
        }
      }
    } catch (e) {
      if (showSnack) SnackBarHelper.showErrorSnackBar(e.toString());
      rethrow;
    }
    return _allPosters;
  }

  // should complete call filterPosters
  void filterPosters(String query) {
    if (query.isEmpty) {
      _filteredPosters = List.from(_allPosters);
    } else {
      _filteredPosters = _allPosters
          .where((poster) => (poster.posterName ?? '')
              .toLowerCase()
              .contains(query.toLowerCase()))
          .toList();
    }
  }

  //TODO: should complete getAllProducts

  //TODO: should complete filterProducts

  //TODO: should complete getAllCoupons

  //TODO: should complete filterCoupons

  //TODO: should complete getAllPosters

  //TODO: should complete filterPosters

  //TODO: should complete getAllNotifications

  //TODO: should complete filterNotifications

  //TODO: should complete getAllOrders

  //TODO: should complete filterOrders

  //TODO: should complete calculateOrdersWithStatus

  //TODO: should complete filterProductsByQuantity

  //TODO: should complete calculateProductWithQuantity
}