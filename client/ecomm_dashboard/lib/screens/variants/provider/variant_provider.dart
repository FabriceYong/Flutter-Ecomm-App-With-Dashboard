import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../core/data/data_provider.dart';
import '../../../models/api_response.dart';
import '../../../models/variant.dart';
import '../../../models/variant_type.dart';
import '../../../services/http_services.dart';
import '../../../utility/snack_bar_helper.dart';

class VariantsProvider extends ChangeNotifier {
  HttpService service = HttpService();
  final DataProvider _dataProvider;
  final addVariantsFormKey = GlobalKey<FormState>();
  TextEditingController variantCtrl = TextEditingController();
  VariantType? selectedVariantType;
  Variant? variantForUpdate;

  VariantsProvider(this._dataProvider);

  // should complete addVariant
  addVariant() async {
    try {
      final Map<String, dynamic> formMapData = {
        'name': variantCtrl.text,
        'variantTypeId': selectedVariantType?.sId,
      };
      final Response response =
          await service.addItem(endpointUrl: 'variants', itemData: formMapData);
      if (response.body == null) {
        log('Response return a null value');
        SnackBarHelper.showErrorSnackBar(
            'Failed to fetch variants: ${response.body?['message'] ?? 'Unknown error occurred'}');
      }
      if (response.isOk) {
        ApiResponse<List<Variant>> apiResponse =
            ApiResponse<List<Variant>>.fromJson(response.body, null);
        if (apiResponse.success == true) {
          _dataProvider.getAllVariants();
          clearFields();
          SnackBarHelper.showSuccessSnackBar(apiResponse.message);
          log('Variant added successfully');
        } else {
          SnackBarHelper.showErrorSnackBar('Failed to add variant');
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

  //should complete updateVariant
  updateVariant() async {
    try {
      final Map<String, dynamic> formMapData = {
        'name': variantCtrl.text,
        'variantTypeId': selectedVariantType?.sId,
      };
      final Response response = await service.updateItem(
          endpointUrl: 'variants',
          itemId: variantForUpdate?.sId ?? '',
          itemData: formMapData);
      if (response.body == null) {
        log(response.body?['message']);
        SnackBarHelper.showErrorSnackBar(
            'Failed to fetch variants: ${response.body['message'] ?? 'Unknown error occurred'}');
      }
      if (response.isOk) {
        ApiResponse<List<Variant>> apiResponse =
            ApiResponse<List<Variant>>.fromJson(response.body, null);
        if (apiResponse.success) {
          clearFields();
          _dataProvider.getAllVariants();
          SnackBarHelper.showSuccessSnackBar(apiResponse.message);
          log('Variant updated successfully');
        } else {
          SnackBarHelper.showErrorSnackBar('Failed to update variant');
        }
      } else {
        SnackBarHelper.showErrorSnackBar(
            'Error: ${response.body['message'] ?? response.statusText}');
      }
    } catch (e) {
      print(e);
      SnackBarHelper.showErrorSnackBar(e.toString());
      rethrow;
    }
  }

  // should complete submitVariant
  submitVariant() {
    if (variantForUpdate != null) {
      updateVariant();
    } else {
      addVariant();
    }
  }

  // should complete deleteVariant
  deleteVariant(Variant variant) async {
    try {
      final Response response = await service.deleteItem(
          endpointUrl: 'variants', itemId: variant.sId ?? '');
      if (response.isOk) {
        ApiResponse<List<Variant>> apiResponse =
            ApiResponse<List<Variant>>.fromJson(response.body, null);
        if (apiResponse.success == true) {
          _dataProvider.getAllVariants();
          SnackBarHelper.showSuccessSnackBar(apiResponse.message);
          log('Variant deleted successfully');
        } else {
          SnackBarHelper.showErrorSnackBar('Failed to delete variant');
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

  setDataForUpdateVariant(Variant? variant) {
    if (variant != null) {
      variantForUpdate = variant;
      variantCtrl.text = variant.name ?? '';
      selectedVariantType = _dataProvider.variantTypes.firstWhereOrNull(
          (element) => element.sId == variant.variantTypeId?.sId);
    } else {
      clearFields();
    }
  }

  clearFields() {
    variantCtrl.clear();
    selectedVariantType = null;
    variantForUpdate = null;
  }

  void updateUI() {
    notifyListeners();
  }
}
