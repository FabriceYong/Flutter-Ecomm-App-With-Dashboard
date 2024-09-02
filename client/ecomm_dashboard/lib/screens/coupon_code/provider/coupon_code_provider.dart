import 'dart:developer';

import 'package:ecomm_dashboard/models/api_response.dart';
import 'package:ecomm_dashboard/utility/snack_bar_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../core/data/data_provider.dart';
import '../../../models/category.dart';
import '../../../models/coupon.dart';
import '../../../models/product.dart';
import '../../../models/sub_category.dart';
import '../../../services/http_services.dart';

class CouponCodeProvider extends ChangeNotifier {
  HttpService service = HttpService();
  final DataProvider _dataProvider;
  Coupon? couponForUpdate;

  final addCouponFormKey = GlobalKey<FormState>();
  TextEditingController couponCodeCtrl = TextEditingController();
  TextEditingController discountAmountCtrl = TextEditingController();
  TextEditingController minimumPurchaseAmountCtrl = TextEditingController();
  TextEditingController endDateCtrl = TextEditingController();
  String selectedDiscountType = 'fixed';
  String selectedCouponStatus = 'active';
  Category? selectedCategory;
  SubCategory? selectedSubCategory;
  Product? selectedProduct;

  CouponCodeProvider(this._dataProvider);

  //should complete addCoupon
  Future<void> addCoupon() async {
    try {
      if (endDateCtrl.text.isEmpty) {
        SnackBarHelper.showErrorSnackBar('Please select end date');
        return;
      }
      Map<String, dynamic> coupon = {
        'couponCode': couponCodeCtrl.text,
        'discountType': selectedDiscountType,
        'discountAmount': discountAmountCtrl.text,
        'minimumPurchaseAmount': minimumPurchaseAmountCtrl.text,
        'endDate': endDateCtrl.text,
        'status': selectedCouponStatus,
        'applicableCategory': selectedCategory?.sId,
        'applicableSubCategory': selectedSubCategory?.sId,
        'applicableProduct': selectedProduct?.sId,
      };
      final Response response =
          await service.addItem(endpointUrl: 'coupons', itemData: coupon);
      if (response.isOk) {
        ApiResponse<List<Coupon>> apiResponse =
            ApiResponse<List<Coupon>>.fromJson(response.body, null);
        if (apiResponse.success == true) {
          _dataProvider.getAllCoupons();
          clearFields();
          SnackBarHelper.showSuccessSnackBar(apiResponse.message);
          log('Coupon has been created successfully');
        } else {
          SnackBarHelper.showErrorSnackBar('Failed to add coupon');
        }
      } else {
        SnackBarHelper.showErrorSnackBar(
            'Error: ${response.body?['message'] ?? response.statusText}');
      }
    } catch (e) {
      print(e);
      SnackBarHelper.showErrorSnackBar(e.toString());
      rethrow;
    }
  }

  // should complete updateCoupon
  Future<void> updateCoupon() async {
    try {
      if (endDateCtrl.text.isEmpty) {
        SnackBarHelper.showErrorSnackBar('Please select end date');
        return;
      }
      Map<String, dynamic> coupon = {
        'couponCode': couponCodeCtrl.text,
        'discountType': selectedDiscountType,
        'discountAmount': discountAmountCtrl.text,
        'minimumPurchaseAmount': minimumPurchaseAmountCtrl.text,
        'endDate': endDateCtrl.text,
        'status': selectedCouponStatus,
        'applicableCategory': selectedCategory?.sId,
        'applicableSubCategory': selectedSubCategory?.sId,
        'applicableProduct': selectedProduct?.sId,
      };
      final Response response = await service.updateItem(
          endpointUrl: 'coupons',
          itemId: couponForUpdate?.sId ?? '',
          itemData: coupon);
      if (response.isOk) {
        ApiResponse<List<Coupon>> apiResponse =
            ApiResponse<List<Coupon>>.fromJson(response.body, null);
        if (apiResponse.success == true) {
          _dataProvider.getAllCoupons();
          clearFields();
          SnackBarHelper.showSuccessSnackBar(apiResponse.message);
          log('Coupon updated successfully');
        } else {
          SnackBarHelper.showErrorSnackBar('Failed to update coupon');
        }
      } else {
        SnackBarHelper.showErrorSnackBar(
            'Error: ${response.body?['message'] ?? response.statusText}');
      }
    } catch (e) {
      print(e);
      SnackBarHelper.showErrorSnackBar(e.toString());
      rethrow;
    }
  }

  // should complete submitCoupon
  void submitCoupon() {
    if (couponForUpdate != null) {
      updateCoupon();
    } else {
      addCoupon();
    }
  }

  // should complete deleteCoupon
  Future<void> deleteCoupon(Coupon coupon) async {
    try {
      final Response response = await service.deleteItem(
          endpointUrl: 'coupons', itemId: coupon.sId ?? '');
      if (response.isOk) {
        ApiResponse<List<Coupon>> apiResponse =
            ApiResponse<List<Coupon>>.fromJson(response.body, null);
        if (apiResponse.success == true) {
          _dataProvider.getAllCoupons();
          SnackBarHelper.showSuccessSnackBar(apiResponse.message);
          log('Coupon deleted successfully');
        } else {
          SnackBarHelper.showErrorSnackBar('Failed to delete coupon');
        }
      } else {
        SnackBarHelper.showErrorSnackBar(
            'Error: ${response.body?['message'] ?? response.statusText}');
      }
    } catch (e) {
      print(e);
      SnackBarHelper.showErrorSnackBar(e.toString());
      rethrow;
    }
  }

  //? set data for update on editing
  setDataForUpdateCoupon(Coupon? coupon) {
    if (coupon != null) {
      couponForUpdate = coupon;
      couponCodeCtrl.text = coupon.couponCode ?? '';
      selectedDiscountType = coupon.discountType ?? 'fixed';
      discountAmountCtrl.text = '${coupon.discountAmount}';
      minimumPurchaseAmountCtrl.text = '${coupon.minimumPurchaseAmount}';
      endDateCtrl.text = '${coupon.endDate}';
      selectedCouponStatus = coupon.status ?? 'active';
      selectedCategory = _dataProvider.categories.firstWhereOrNull(
          (element) => element.sId == coupon.applicableCategory?.sId);
      selectedSubCategory = _dataProvider.subCategories.firstWhereOrNull(
          (element) => element.sId == coupon.applicableSubCategory?.sId);
      selectedProduct = _dataProvider.products.firstWhereOrNull(
          (element) => element.sId == coupon.applicableProduct?.sId);
    } else {
      clearFields();
    }
  }

  //? to clear text field and images after adding or update coupon
  clearFields() {
    couponForUpdate = null;
    selectedCategory = null;
    selectedSubCategory = null;
    selectedProduct = null;

    couponCodeCtrl.text = '';
    discountAmountCtrl.text = '';
    minimumPurchaseAmountCtrl.text = '';
    endDateCtrl.text = '';
  }

  updateUi() {
    notifyListeners();
  }
}
