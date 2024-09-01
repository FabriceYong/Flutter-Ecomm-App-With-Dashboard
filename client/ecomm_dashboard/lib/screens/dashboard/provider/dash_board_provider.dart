import 'dart:developer';
import 'dart:io';

import 'package:ecomm_dashboard/models/api_response.dart';
import 'package:ecomm_dashboard/utility/snack_bar_helper.dart';
import 'package:flutter/foundation.dart' hide Category;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/data/data_provider.dart';
import '../../../models/brand.dart';
import '../../../models/category.dart';
import '../../../models/product.dart';
import '../../../models/sub_category.dart';
import '../../../models/variant_type.dart';
import '../../../services/http_services.dart';

class DashBoardProvider extends ChangeNotifier {
  HttpService service = HttpService();
  final DataProvider _dataProvider;
  final addProductFormKey = GlobalKey<FormState>();

  //?text editing controllers in dashBoard screen
  TextEditingController productNameCtrl = TextEditingController();
  TextEditingController productDescCtrl = TextEditingController();
  TextEditingController productQntCtrl = TextEditingController();
  TextEditingController productPriceCtrl = TextEditingController();
  TextEditingController productOffPriceCtrl = TextEditingController();

  //? dropdown value
  Category? selectedCategory;
  SubCategory? selectedSubCategory;
  Brand? selectedBrand;
  VariantType? selectedVariantType;
  List<String> selectedVariants = [];

  Product? productForUpdate;
  File? selectedMainImage,
      selectedSecondImage,
      selectedThirdImage,
      selectedFourthImage,
      selectedFifthImage;
  XFile? mainImgXFile,
      secondImgXFile,
      thirdImgXFile,
      fourthImgXFile,
      fifthImgXFile;

  //? to filter the data depends on the parent dropdown value
  List<SubCategory> subCategoriesByCategory = [];
  List<Brand> brandsBySubCategory = [];
  List<String> variantsByVariantType = [];

  DashBoardProvider(this._dataProvider);

  // should complete addProduct
  Future<void> addProduct() async {
    try {
      if (selectedMainImage == null) {
        SnackBarHelper.showErrorSnackBar('Please choose an image!');
        return;
      }
      final Map<String, dynamic> formMapData = {
        'name': productNameCtrl.text,
        'description': productDescCtrl.text,
        'quantity': productQntCtrl.text,
        'price': productPriceCtrl.text,
        'offerPrice': productOffPriceCtrl.text.isEmpty
            ? productPriceCtrl.text
            : productOffPriceCtrl.text,
        'proCategoryId': selectedCategory?.sId ?? '',
        'proSubCategoryId': selectedSubCategory?.sId ?? '',
        'proBrandId': selectedBrand?.sId ?? '',
        'proVariantTypeId': selectedVariantType?.sId ?? '',
        'proVariantId': selectedVariants,
      };
      final List<Map<String, XFile?>> imgXFiles = [
        {'image1': mainImgXFile},
        {'image2': secondImgXFile},
        {'image3': thirdImgXFile},
        {'image4': fourthImgXFile},
        {'image5': fifthImgXFile},
      ];
      final FormData form = await createFormDataForMultipleImage(
          imgXFiles: imgXFiles, formData: formMapData);
      final Response response =
          await service.addItem(endpointUrl: 'products', itemData: form);
      if (response.isOk) {
        ApiResponse apiResponse = ApiResponse.fromJson(response.body, null);
        if (apiResponse.success) {
          clearFields();
          _dataProvider.getAllProducts();
          SnackBarHelper.showSuccessSnackBar(apiResponse.message);
          log('Product created successfully');
        } else {
          SnackBarHelper.showErrorSnackBar(
              'Failed to add product: ${apiResponse.message}');
        }
      } else {
        SnackBarHelper.showErrorSnackBar(
            'Error: ${response.body?['message'] ?? response.statusText}');
      }
    } catch (e) {
      print(e);
      SnackBarHelper.showErrorSnackBar('An unknown error occurred: $e');
      rethrow;
    }
  }

  // should complete updateProduct
  Future<void> updateProduct() async {
    try {
      if (mainImgXFile == null) {
        SnackBarHelper.showErrorSnackBar('Please choose an image');
        return;
      }
      final Map<String, dynamic> formMapData = {
        'name': productNameCtrl.text,
        'description': productDescCtrl.text,
        'quantity': productQntCtrl.text,
        'price': productPriceCtrl.text,
        'offerPrice': productOffPriceCtrl.text.isEmpty
            ? productPriceCtrl.text
            : productOffPriceCtrl.text,
        'proCategoryId': selectedCategory?.sId ?? '',
        'proSubCategoryId': selectedSubCategory?.sId ?? '',
        'proBrandId': selectedBrand?.sId ?? '',
        'proVariantTypeId': selectedVariantType?.sId ?? '',
        'proVariantId': selectedVariants,
      };
      final List<Map<String, XFile?>> imgXFiles = [
        {'image1': mainImgXFile},
        {'image2': secondImgXFile},
        {'image3': thirdImgXFile},
        {'image4': fourthImgXFile},
        {'image5': fifthImgXFile},
      ];
      final FormData formData = await createFormDataForMultipleImage(
          imgXFiles: imgXFiles, formData: formMapData);
      if (productForUpdate != null) {
        final Response response = await service.updateItem(
            endpointUrl: 'products',
            itemId: '${productForUpdate?.sId}',
            itemData: formData);
        if (response.isOk) {
          ApiResponse apiResponse = ApiResponse.fromJson(response.body, null);
          if (apiResponse.success) {
            clearFields();
            _dataProvider.getAllProducts();
            SnackBarHelper.showSuccessSnackBar(apiResponse.message);
            log('Product updated successfully');
          } else {
            SnackBarHelper.showErrorSnackBar('Failed to update product');
          }
        } else {
          SnackBarHelper.showErrorSnackBar(
              response.body?['message'] ?? response.statusText);
        }
      } else {
        print('Cannot update product');
      }
    } catch (e) {
      print(e);
      SnackBarHelper.showErrorSnackBar('An unknown error occurred: $e');
      rethrow;
    }
  }

  // should complete submitProduct
  void submitProduct() {
    if (productForUpdate != null) {
      updateProduct();
    } else {
      addProduct();
    }
  }

  // should complete deleteProduct
  Future<void> deleteProduct(Product product) async {
    try {
      final Response response = await service.deleteItem(
          endpointUrl: 'products', itemId: product.sId ?? '');
      if (response.isOk) {
        ApiResponse apiResponse = ApiResponse.fromJson(response.body, null);
        if (apiResponse.success) {
          _dataProvider.getAllProducts();
          SnackBarHelper.showSuccessSnackBar(apiResponse.message);
          log('Product deleted successfully');
        } else {
          SnackBarHelper.showErrorSnackBar('Failed to delete product');
        }
      } else {
        SnackBarHelper.showErrorSnackBar(
            response.body?['message'] ?? response.statusText);
      }
    } catch (e) {
      print(e);
      SnackBarHelper.showErrorSnackBar('An unknown error occurred: $e');
      rethrow;
    }
  }

  void pickImage({required int imageCardNumber}) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      if (imageCardNumber == 1) {
        selectedMainImage = File(image.path);
        mainImgXFile = image;
      } else if (imageCardNumber == 2) {
        selectedSecondImage = File(image.path);
        secondImgXFile = image;
      } else if (imageCardNumber == 3) {
        selectedThirdImage = File(image.path);
        thirdImgXFile = image;
      } else if (imageCardNumber == 4) {
        selectedFourthImage = File(image.path);
        fourthImgXFile = image;
      } else if (imageCardNumber == 5) {
        selectedFifthImage = File(image.path);
        fifthImgXFile = image;
      }
      notifyListeners();
    }
  }

  Future<FormData> createFormDataForMultipleImage({
    required List<Map<String, XFile?>>? imgXFiles,
    required Map<String, dynamic> formData,
  }) async {
    // Loop over the provided image files and add them to the form data
    if (imgXFiles != null) {
      for (int i = 0; i < imgXFiles.length; i++) {
        XFile? imgXFile = imgXFiles[i]['image${i + 1}'];
        if (imgXFile != null) {
          // Check if it's running on the web
          if (kIsWeb) {
            String fileName = imgXFile.name;
            Uint8List byteImg = await imgXFile.readAsBytes();
            formData['image${i + 1}'] =
                MultipartFile(byteImg, filename: fileName);
          } else {
            String filePath = imgXFile.path;
            String fileName = filePath.split('/').last;
            formData['image${i + 1}'] =
                MultipartFile(filePath, filename: fileName);
          }
        }
      }
    }

    // Create and return the FormData object
    final FormData form = FormData(formData);
    return form;
  }

  // should complete filterSubcategory
  filterSubCategory(Category category) {
    selectedSubCategory = null;
    selectedBrand = null;
    selectedCategory = category;
    subCategoriesByCategory.clear();
    final newList = _dataProvider.subCategories
        .where((subCategory) => subCategory.categoryId?.sId == category.sId)
        .toList();
    subCategoriesByCategory = newList;
    notifyListeners();
  }

  // should complete filterBrand
  filterBrand(SubCategory subCategory) {
    selectedBrand = null;
    selectedSubCategory = subCategory;
    brandsBySubCategory.clear();
    final newList = _dataProvider.brands
        .where((brand) => brand.subcategoryId?.sId == subCategory.sId)
        .toList();
    brandsBySubCategory = newList;
    notifyListeners();
  }

  // should complete filterVariant
  filterVariant(VariantType variantType) {
    selectedVariants = [];
    selectedVariantType = variantType;
    variantsByVariantType.clear();
    final newList = _dataProvider.variants
        .where((variant) => variant.variantTypeId?.sId == variantType.sId);
    final List<String> variantNames =
        newList.map((variant) => variant.name ?? '').toList();
    variantsByVariantType = variantNames;
    notifyListeners();
  }

  setDataForUpdateProduct(Product? product) {
    if (product != null) {
      productForUpdate = product;

      productNameCtrl.text = product.name ?? '';
      productDescCtrl.text = product.description ?? '';
      productPriceCtrl.text = product.price.toString();
      productOffPriceCtrl.text = '${product.offerPrice}';
      productQntCtrl.text = '${product.quantity}';

      selectedCategory = _dataProvider.categories.firstWhereOrNull(
          (element) => element.sId == product.proCategoryId?.sId);

      final newListCategory = _dataProvider.subCategories
          .where((subcategory) =>
              subcategory.categoryId?.sId == product.proCategoryId?.sId)
          .toList();
      subCategoriesByCategory = newListCategory;
      selectedSubCategory = _dataProvider.subCategories.firstWhereOrNull(
          (element) => element.sId == product.proSubCategoryId?.sId);

      final newListBrand = _dataProvider.brands
          .where((brand) =>
              brand.subcategoryId?.sId == product.proSubCategoryId?.sId)
          .toList();
      brandsBySubCategory = newListBrand;
      selectedBrand = _dataProvider.brands.firstWhereOrNull(
          (element) => element.sId == product.proBrandId?.sId);

      selectedVariantType = _dataProvider.variantTypes.firstWhereOrNull(
          (element) => element.sId == product.proVariantTypeId?.sId);

      final newListVariant = _dataProvider.variants
          .where((variant) =>
              variant.variantTypeId?.sId == product.proVariantTypeId?.sId)
          .toList();
      final List<String> variantNames =
          newListVariant.map((variant) => variant.name ?? '').toList();
      variantsByVariantType = variantNames;
      selectedVariants = product.proVariantId ?? [];
    } else {
      clearFields();
    }
  }

  clearFields() {
    productNameCtrl.clear();
    productDescCtrl.clear();
    productPriceCtrl.clear();
    productOffPriceCtrl.clear();
    productQntCtrl.clear();

    selectedMainImage = null;
    selectedSecondImage = null;
    selectedThirdImage = null;
    selectedFourthImage = null;
    selectedFifthImage = null;

    mainImgXFile = null;
    secondImgXFile = null;
    thirdImgXFile = null;
    fourthImgXFile = null;
    fifthImgXFile = null;

    selectedCategory = null;
    selectedSubCategory = null;
    selectedBrand = null;
    selectedVariantType = null;
    selectedVariants = [];

    productForUpdate = null;

    subCategoriesByCategory = [];
    brandsBySubCategory = [];
    variantsByVariantType = [];
  }

  updateUI() {
    notifyListeners();
  }
}
