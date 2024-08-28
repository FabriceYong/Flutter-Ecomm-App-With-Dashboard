import 'dart:developer';

import 'package:ecomm_dashboard/models/api_response.dart';
import 'package:ecomm_dashboard/utility/snack_bar_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../core/data/data_provider.dart';
import '../../../models/brand.dart';
import '../../../models/sub_category.dart';
import '../../../services/http_services.dart';

class BrandProvider extends ChangeNotifier {
  HttpService service = HttpService();
  final DataProvider _dataProvider;

  final addBrandFormKey = GlobalKey<FormState>();
  TextEditingController brandNameCtrl = TextEditingController();
  SubCategory? selectedSubCategory;
  Brand? brandForUpdate;

  BrandProvider(this._dataProvider);

  // should complete addBrand
  addBrand() async {
    try {
      final Map<String, dynamic> formMapData = {
        'name': brandNameCtrl.text,
        'subcategoryId': selectedSubCategory?.sId,
      };
      final response =
          await service.addItem(endpointUrl: 'brands', itemData: formMapData);
      if (response.body == null) {
        print(response.body?['message']);
        SnackBarHelper.showErrorSnackBar(
            'Failed to add Brand: ${response.body?['message'] ?? 'Unknown error occurred'}');
        return;
      }
      if (response.isOk) {
        ApiResponse<List<Brand>> apiResponse =
            ApiResponse<List<Brand>>.fromJson(response.body, null);
        if (apiResponse.success == true) {
          clearFields();
          _dataProvider.getAllBrands();
          log('Brand added successfully');
          SnackBarHelper.showSuccessSnackBar(apiResponse.message);
        } else {
          SnackBarHelper.showErrorSnackBar(
              'Failed to add brand: ${apiResponse.message}');
        }
      } else {
        SnackBarHelper.showErrorSnackBar(
            'Error: ${response.body?['message'] ?? response.statusText}');
      }
    } catch (e) {
      log(e.toString());
      rethrow;
      // SnackBarHelper.showErrorSnackBar(e.toString());
    }
  }

  // should complete updateBrand
  updateBrand() async {
    try {
      final Map<String, dynamic> formMapData = {
        'name': brandNameCtrl.text,
        'subcategoryId': selectedSubCategory?.sId,
      };
      final Response response = await service.updateItem(
          endpointUrl: 'brands',
          itemId: brandForUpdate?.sId ?? '',
          itemData: formMapData);
      if (response.body == null) {
        print(response.body?['message']);
        SnackBarHelper.showErrorSnackBar(
            'Failed to update Brand: ${response.body?['message'] ?? 'Unknown error occurred'}');
        return;
      }
      if (response.isOk) {
        ApiResponse<List<Brand>> apiResponse =
            ApiResponse<List<Brand>>.fromJson(response.body, null);
        _dataProvider.getAllBrands();
        if (apiResponse.success == true) {
          clearFields();
          log('Brand updated successfully');
          SnackBarHelper.showSuccessSnackBar(apiResponse.message);
        } else {
          SnackBarHelper.showErrorSnackBar(apiResponse.message);
        }
      } else {
        SnackBarHelper.showErrorSnackBar(
            response.body?['message'] ?? response.statusText);
      }
    } catch (e) {
      log(e.toString());
      rethrow;
      // SnackBarHelper.showErrorSnackBar(e.toString());
    }
  }

  //should complete submitBrand
  submitBrand() {
    if (brandForUpdate == null) {
      addBrand();
    } else {
      updateBrand();
    }
  }

  // should complete deleteBrand
  deleteBrand(Brand brand) async {
    try {
      final Response response =
          await service.deleteItem(endpointUrl: 'brands', itemId: brand.sId!);
      if (response.body == null) {
        print(response.body?['message']);
        SnackBarHelper.showErrorSnackBar(
            'Failed to update Brand: ${response.body?['message'] ?? 'Unknown error occurred'}');
        return;
      }
      if (response.isOk) {
        ApiResponse<List<Brand>> apiResponse =
            ApiResponse<List<Brand>>.fromJson(response.body, null);
        if (apiResponse.success == true) {
          _dataProvider.getAllBrands();
          log('Brand deleted successfully');
          SnackBarHelper.showSuccessSnackBar(apiResponse.message);
        }
      } else {
        SnackBarHelper.showErrorSnackBar(
            'Error: ${response.body?['message'] ?? response.statusText}');
      }
    } catch (e) {
      log(e.toString());
      // SnackBarHelper.showErrorSnackBar(e.toString());
      rethrow;
    }
  }

  //? set data for update on editing
  setDataForUpdateBrand(Brand? brand) {
    if (brand != null) {
      brandForUpdate = brand;
      brandNameCtrl.text = brand.name ?? '';
      selectedSubCategory = _dataProvider.subCategories.firstWhereOrNull(
          (element) => element.sId == brand.subcategoryId?.sId);
    } else {
      clearFields();
    }
  }

  //? to clear text field and images after adding or update brand
  clearFields() {
    brandNameCtrl.clear();
    selectedSubCategory = null;
    brandForUpdate = null;
  }

  updateUI() {
    notifyListeners();
  }
}
