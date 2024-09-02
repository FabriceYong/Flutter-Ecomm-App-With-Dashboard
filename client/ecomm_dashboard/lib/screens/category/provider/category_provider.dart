import 'dart:developer';
import 'dart:io';

import 'package:ecomm_dashboard/models/api_response.dart';
import 'package:ecomm_dashboard/utility/snack_bar_helper.dart';
import 'package:flutter/foundation.dart' hide Category;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/data/data_provider.dart';
import '../../../models/category.dart';
import '../../../services/http_services.dart';

class CategoryProvider extends ChangeNotifier {
  HttpService service = HttpService();
  final DataProvider _dataProvider;
  final addCategoryFormKey = GlobalKey<FormState>();
  TextEditingController categoryNameCtrl = TextEditingController();
  Category? categoryForUpdate;
  bool loading = false;

  File? selectedImage;
  XFile? imgXFile;

  CategoryProvider(this._dataProvider);

// Add Category
  addCategory() async {
    try {
      if (selectedImage == null) {
        SnackBarHelper.showErrorSnackBar('Please choose an image');
        return; // stop the program eviction
      }
      final Map<String, dynamic> formDataMap = {
        'name': categoryNameCtrl.text,
        'image': 'no_data' // image path will add from server side
      };
      final FormData form =
          await createFormData(imgXFile: imgXFile, formData: formDataMap);
      final response =
          await service.addItem(endpointUrl: 'categories', itemData: form);
      if (response.isOk) {
        ApiResponse<List<Category>> apiResponse =
            ApiResponse<List<Category>>.fromJson(response.body, null);
        print(apiResponse);
        if (apiResponse.success == true) {
          _dataProvider.getAllCategories();
          clearFields();
          SnackBarHelper.showSuccessSnackBar(apiResponse.message);
          log('Category added successfully');
        } else {
          SnackBarHelper.showErrorSnackBar(
              'Failed to add category: ${apiResponse.message}');
        }
      } else {
        SnackBarHelper.showErrorSnackBar(
            'Error ${response.body ?? response.statusText}');
      }
    } catch (e) {
      log(e.toString());
      SnackBarHelper.showErrorSnackBar(e.toString());
      rethrow;
    }
  }

  // should complete updateCategory
  updateCategory() async {
    if (selectedImage == null) {
      SnackBarHelper.showErrorSnackBar('Please select an image');
      return;
    }
    try {
      final Map<String, dynamic> formDataMap = {
        'name': categoryNameCtrl.text,
        'image': categoryForUpdate?.image ?? '',
      };
      final FormData form =
          await createFormData(imgXFile: imgXFile, formData: formDataMap);
      final response = await service.updateItem(
          endpointUrl: 'categories',
          itemId: categoryForUpdate?.sId ?? '',
          itemData: form);
      if (response.isOk) {
        final ApiResponse<List<Category>> apiResponse =
            ApiResponse<List<Category>>.fromJson(response.body, null);
        if (apiResponse.success == true) {
          _dataProvider.getAllCategories();
          clearFields();
          SnackBarHelper.showSuccessSnackBar(apiResponse.message);
          log('Category updated successfully');
        } else {
          SnackBarHelper.showErrorSnackBar(
              'Failed to add category: ${apiResponse.message}');
        }
      } else {
        SnackBarHelper.showErrorSnackBar(
            'Error: ${response.body ?? response.statusText}');
      }
      log('Category updated');
    } catch (e) {
      print(e);
      SnackBarHelper.showErrorSnackBar(e.toString());
      rethrow;
    }
  }

  // should complete submitCategory

  void pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      selectedImage = File(image.path);
      imgXFile = image;
      notifyListeners();
    }
  }

  // Check if method is addCategory or updateCategory
  submitCategory() {
    if (categoryForUpdate != null) {
      updateCategory();
    } else {
      addCategory();
    }
  }

  //should complete deleteCategory
  deleteCategory(Category category) async {
    try {
      Response response = await service.deleteItem(
          endpointUrl: 'categories', itemId: category.sId ?? '');
      if (response.isOk) {
        ApiResponse<List<Category>> apiResponse =
            ApiResponse<List<Category>>.fromJson(response.body, null);
        if (apiResponse.success == true) {
          _dataProvider.getAllCategories();
          SnackBarHelper.showSuccessSnackBar('Category deleted successfully');
          log('Category deleted successfully');
        } else {
          SnackBarHelper.showErrorSnackBar('Failed to delete category');
        }
      } else {
        SnackBarHelper.showErrorSnackBar(
            'Error ${response.body?['message'] ?? response.statusText}');
      }
    } catch (e) {
      log(e.toString());
      SnackBarHelper.showErrorSnackBar(e.toString());
      rethrow;
    }
  }

  //TODO: should complete setDataForUpdateCategory

  //? to create form data for sending image with body
  Future<FormData> createFormData(
      {required XFile? imgXFile,
      required Map<String, dynamic> formData}) async {
    if (imgXFile != null) {
      MultipartFile multipartFile;
      if (kIsWeb) {
        String fileName = imgXFile.name;
        Uint8List byteImg = await imgXFile.readAsBytes();
        multipartFile = MultipartFile(byteImg, filename: fileName);
      } else {
        String fileName = imgXFile.path.split('/').last;
        multipartFile = MultipartFile(imgXFile.path, filename: fileName);
      }
      formData['img'] = multipartFile;
    }
    final FormData form = FormData(formData);
    return form;
  }

  //? set data for update on editing
  setDataForUpdateCategory(Category? category) {
    if (category != null) {
      clearFields();
      categoryForUpdate = category;
      categoryNameCtrl.text = category.name ?? '';
    } else {
      clearFields();
    }
  }

  //? to clear text field and images after adding or update category
  clearFields() {
    categoryNameCtrl.clear();
    selectedImage = null;
    imgXFile = null;
    categoryForUpdate = null;
  }
}
