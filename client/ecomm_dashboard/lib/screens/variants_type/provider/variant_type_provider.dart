import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../core/data/data_provider.dart';
import '../../../models/api_response.dart';
import '../../../models/variant_type.dart';
import '../../../services/http_services.dart';
import '../../../utility/snack_bar_helper.dart';

class VariantsTypeProvider extends ChangeNotifier {
  HttpService service = HttpService();
  final DataProvider _dataProvider;

  final addVariantsTypeFormKey = GlobalKey<FormState>();
  TextEditingController variantNameCtrl = TextEditingController();
  TextEditingController variantTypeCtrl = TextEditingController();

  VariantType? variantTypeForUpdate;

  VariantsTypeProvider(this._dataProvider);

  // should complete addVariantType
  addVariantType() async {
    try {
      final Response response =
          await service.addItem(endpointUrl: 'variantTypes', itemData: {
        'name': variantNameCtrl.text,
        'type': variantTypeCtrl.text,
      });
      if (response.isOk) {
        ApiResponse apiResponse = ApiResponse.fromJson(response.body, null);
        if (apiResponse.success == true) {
          _dataProvider.getAllVarianTypes();
          clearFields();
          SnackBarHelper.showSuccessSnackBar(apiResponse.message);
        } else {
          SnackBarHelper.showErrorSnackBar('Failed to add Variant Type');
        }
      } else {
        SnackBarHelper.showErrorSnackBar(
            'Error: ${response.body?['message'] ?? response.statusText}');
      }
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  // should complete updateVariantType
  updateVariantType() async {
    try {
      final Map<String, String> formMapData = {
        'name': variantNameCtrl.text,
        'type': variantTypeCtrl.text,
      };
      final Response response = await service.updateItem(
          endpointUrl: 'variantTypes',
          itemId: variantTypeForUpdate?.sId ?? '',
          itemData: formMapData);
      if (response.isOk) {
        ApiResponse apiResponse = ApiResponse.fromJson(response.body, null);
        if (apiResponse.success == true) {
          _dataProvider.getAllVarianTypes();
          clearFields();
          SnackBarHelper.showSuccessSnackBar(apiResponse.message);
        } else {
          SnackBarHelper.showErrorSnackBar('Failed to update Variant Type');
        }
      } else {
        SnackBarHelper.showErrorSnackBar(
            'Error: ${response.body?['message'] ?? response.statusText}');
      }
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  // should complete submitVariantType
  submitVariantType() {
    if (variantTypeForUpdate != null) {
      updateVariantType();
    } else {
      addVariantType();
    }
  }

  // should complete deleteVariantType
  deleteVariantType(VariantType variantType) async {
    try {
      final Response response = await service.deleteItem(
          endpointUrl: 'variantTypes', itemId: variantType.sId ?? '');
      if (response.isOk) {
        ApiResponse apiResponse = ApiResponse.fromJson(response.body, null);
        if (apiResponse.success == true) {
          _dataProvider.getAllVarianTypes();
          log('Variant Type successfully deleted');
          SnackBarHelper.showSuccessSnackBar(apiResponse.message);
        } else {
          SnackBarHelper.showErrorSnackBar('Error deleting Variant Type');
        }
      } else {
        SnackBarHelper.showErrorSnackBar(
            'Error: ${response.body?['message'] ?? response.statusText}');
      }
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  setDataForUpdateVariantType(VariantType? variantType) {
    if (variantType != null) {
      variantTypeForUpdate = variantType;
      variantNameCtrl.text = variantType.name ?? '';
      variantTypeCtrl.text = variantType.type ?? '';
    } else {
      clearFields();
    }
  }

  clearFields() {
    variantNameCtrl.clear();
    variantTypeCtrl.clear();
    variantTypeForUpdate = null;
  }
}
