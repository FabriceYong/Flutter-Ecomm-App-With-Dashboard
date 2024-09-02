import 'dart:developer';

import 'package:ecomm_dashboard/models/api_response.dart';
import 'package:ecomm_dashboard/utility/snack_bar_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/data/data_provider.dart';
import '../../../models/category.dart';
import '../../../models/sub_category.dart';
import '../../../services/http_services.dart';

class SubCategoryProvider extends ChangeNotifier {
  HttpService service = HttpService();
  final DataProvider _dataProvider;

  final GlobalKey<FormState> addSubCategoryFormKey = GlobalKey<FormState>();
  TextEditingController subCategoryNameCtrl = TextEditingController();
  Category? selectedCategory;
  SubCategory? subCategoryForUpdate;

  SubCategoryProvider(this._dataProvider);

  // should complete addSubCategory
  addSubCategory() async {
    try {
      Map<String, dynamic> subCategory = {
        'name': subCategoryNameCtrl.text,
        'categoryId': selectedCategory?.sId
      };
      final Response response = await service.addItem(
          endpointUrl: 'subCategories', itemData: subCategory);
      if (response.isOk) {
        ApiResponse<List<SubCategory>> apiResponse =
            ApiResponse<List<SubCategory>>.fromJson(response.body, null);
        if (apiResponse.success == true) {
          clearFields();
          _dataProvider.getAllSubCategories();
          SnackBarHelper.showSuccessSnackBar(apiResponse.message);
          log('Sub Category added successfully');
        } else {
          SnackBarHelper.showErrorSnackBar(
              'Failed to add Sub Category: ${apiResponse.message}');
        }
      } else {
        SnackBarHelper.showErrorSnackBar(
            'Error: ${response.body?['message'] ?? response.statusText}');
      }
    } catch (e) {
      log(e.toString());
      SnackBarHelper.showErrorSnackBar(e.toString());
      rethrow;
    }
  }

  // should complete updateSubCategory
  updateSubCategory() async {
    try {
      Map<String, dynamic> subCategories = {
        'name': subCategoryNameCtrl.text,
        'categoryId': selectedCategory?.sId
      };
      final Response response = await service.updateItem(
          endpointUrl: 'subCategories',
          itemId: subCategoryForUpdate?.sId ?? '',
          itemData: subCategories);
      if (response.isOk) {
        ApiResponse<List<SubCategory>> apiResponse =
            ApiResponse<List<SubCategory>>.fromJson(response.body, null);
        if (apiResponse.success == true) {
          _dataProvider.getAllSubCategories();
          clearFields();
          SnackBarHelper.showSuccessSnackBar(apiResponse.message);
          log('Sub Category updated successfully');
        } else {
          SnackBarHelper.showErrorSnackBar(
              'Failed to update Sub Category: ${apiResponse.message}');
        }
      } else {
        SnackBarHelper.showErrorSnackBar(
            'Error : ${response.body?['messge'] ?? response.statusText}');
      }
    } catch (e) {
      log(e.toString());
      SnackBarHelper.showErrorSnackBar(e.toString());
      rethrow;
    }
  }

  // should complete submitSubCategory
  submitSubCategory() {
    if (subCategoryForUpdate != null) {
      updateSubCategory();
    } else {
      addSubCategory();
    }
  }

  // should complete deleteSubCategory
  deleteSubCategory(SubCategory subCategory) async {
    try {
      final response = await service.deleteItem(
          endpointUrl: 'subCategories', itemId: subCategory.sId!);

      if (response.isOk) {
        ApiResponse<List<SubCategory>> apiResponse =
            ApiResponse<List<SubCategory>>.fromJson(response.body, null);
        if (apiResponse.success == true) {
          _dataProvider.getAllSubCategories();
          SnackBarHelper.showSuccessSnackBar(apiResponse.message);
          log('Sub Category deleted successfully');
        }
      } else {
        SnackBarHelper.showErrorSnackBar(
            'Error ${response.body?['message'] ?? response.statusText}');
      }
    } catch (e) {
      print(e);
      SnackBarHelper.showErrorSnackBar(e.toString());
      rethrow;
    }
  }

  setDataForUpdateSubCategory(SubCategory? subCategory) {
    if (subCategory != null) {
      subCategoryForUpdate = subCategory;
      subCategoryNameCtrl.text = subCategory.name ?? '';
      selectedCategory = _dataProvider.categories.firstWhereOrNull(
          (element) => element.sId == subCategory.categoryId?.sId);
    } else {
      clearFields();
    }
  }

  clearFields() {
    subCategoryNameCtrl.clear();
    selectedCategory = null;
    subCategoryForUpdate = null;
  }

  updateUi() {
    notifyListeners();
  }
}
