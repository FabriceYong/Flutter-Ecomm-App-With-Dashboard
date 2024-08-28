import 'dart:developer';
import 'dart:io';

import 'package:ecomm_dashboard/models/api_response.dart';
import 'package:ecomm_dashboard/utility/snack_bar_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' hide Category;
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/data/data_provider.dart';
import '../../../models/poster.dart';
import '../../../services/http_services.dart';

class PosterProvider extends ChangeNotifier {
  HttpService service = HttpService();
  final DataProvider _dataProvider;
  final addPosterFormKey = GlobalKey<FormState>();
  TextEditingController posterNameCtrl = TextEditingController();
  Poster? posterForUpdate;

  File? selectedImage;
  XFile? imgXFile;

  PosterProvider(this._dataProvider);

  // should complete addPoster
  addPoster() async {
    try {
      if (selectedImage == null) {
        SnackBarHelper.showErrorSnackBar('Please select an image');
        return;
      }
      final Map<String, dynamic> formMapData = {
        'posterName': posterNameCtrl.text,
        'posterImage': 'no_url'
      };
      final FormData formData =
          await createFormData(imgXFile: imgXFile, formData: formMapData);
      final Response response =
          await service.addItem(endpointUrl: 'posters', itemData: formData);
      if (response.isOk) {
        ApiResponse apiResponse = ApiResponse.fromJson(response.body, null);
        if (apiResponse.success) {
          _dataProvider.getAllPosters;
          clearFields();
          SnackBarHelper.showSuccessSnackBar(apiResponse.message);
          log('Poster added successfully');
        } else {
          SnackBarHelper.showErrorSnackBar(
              'Failed to add poster, please try again');
        }
      } else {
        SnackBarHelper.showErrorSnackBar(
            response.body?['message'] ?? response.statusText);
      }
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  // should complete updatePoster
  updatePoster() async {
    try {
      if (selectedImage == null) {
        SnackBarHelper.showErrorSnackBar('Please select an image');
        return;
      }
      final Map<String, dynamic> formMapData = {
        'posterName': posterNameCtrl.text,
        'posterImage': 'no_url'
      };
      final FormData formData =
          await createFormData(imgXFile: imgXFile, formData: formMapData);
      final Response response = await service.updateItem(
          endpointUrl: 'posters',
          itemId: posterForUpdate?.sId ?? '',
          itemData: formData);
      if (response.isOk) {
        ApiResponse apiResponse = ApiResponse.fromJson(response.body, null);
        if (apiResponse.success) {
          _dataProvider.getAllPosters;
          clearFields();
          SnackBarHelper.showSuccessSnackBar(apiResponse.message);
          log('Poster updated successfully');
        } else {
          SnackBarHelper.showErrorSnackBar('Failed to update poster');
        }
      } else {
        SnackBarHelper.showErrorSnackBar(
            response.body?['message'] ?? response.statusText);
      }
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  // should complete submitPoster
  submitPoster() {
    if (posterForUpdate != null) {
      updatePoster();
    } else {
      addPoster();
    }
  }

  void pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      selectedImage = File(image.path);
      imgXFile = image;
      notifyListeners();
    }
  }

  // should complete deletePoster
  deletePoster(Poster poster) async {
    try {
      final Response response = await service.deleteItem(
          endpointUrl: 'posters', itemId: poster.sId ?? '');
      if (response.isOk) {
        ApiResponse apiResponse = ApiResponse.fromJson(response.body, null);
        if (apiResponse.success) {
          _dataProvider.getAllPosters;
          SnackBarHelper.showSuccessSnackBar(apiResponse.message);
          log('Poster deleted successfully');
        } else {
          SnackBarHelper.showErrorSnackBar('Failed to delete poster');
        }
      } else {
        SnackBarHelper.showErrorSnackBar(
            response.body?['message'] ?? response.statusText);
      }
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  setDataForUpdatePoster(Poster? poster) {
    if (poster != null) {
      clearFields();
      posterForUpdate = poster;
      posterNameCtrl.text = poster.posterName ?? '';
    } else {
      clearFields();
    }
  }

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

  clearFields() {
    posterNameCtrl.clear();
    selectedImage = null;
    imgXFile = null;
    posterForUpdate = null;
  }
}
