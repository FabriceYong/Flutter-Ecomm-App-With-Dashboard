import 'package:ecomm_mobile/core/data/data_provider.dart';
import 'package:ecomm_mobile/utility/constants.dart';
import 'package:ecomm_mobile/utility/snackbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class ProfileProvider extends ChangeNotifier {
  final DataProvider _dataProvider;
  final storage = GetStorage();

  final GlobalKey<FormState> addressFormKey = GlobalKey<FormState>();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController streetController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController postalCodeController = TextEditingController();
  final TextEditingController countryController = TextEditingController();

  ProfileProvider(this._dataProvider) {
    retrieveSavedAddress();
  }

  void storeAddress() {
    storage.write(PHONE_KEY, phoneController.text);
    storage.write(STREET_KEY, streetController.text);
    storage.write(CITY_KEY, cityController.text);
    storage.write(STATE_KEY, stateController.text);
    storage.write(POSTAL_CODE_KEY, postalCodeController.text);
    storage.write(COUNTRY_KEY, countryController.text);
    SnackbarHelper.showSuccessSnackBar('Address Stored Successfully');
  }

  void retrieveSavedAddress() {
    phoneController.text = storage.read(PHONE_KEY) ?? '';
    streetController.text = storage.read(STREET_KEY) ?? '';
    cityController.text = storage.read(CITY_KEY) ?? '';
    stateController.text = storage.read(STATE_KEY) ?? '';
    postalCodeController.text = storage.read(POSTAL_CODE_KEY) ?? '';
    countryController.text = storage.read(COUNTRY_KEY) ?? '';
  }
}
