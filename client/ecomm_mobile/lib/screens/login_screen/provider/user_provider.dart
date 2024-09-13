import 'package:ecomm_mobile/core/data/data_provider.dart';
import 'package:ecomm_mobile/models/user.dart';
import 'package:ecomm_mobile/screens/login_screen/login_screen.dart';
import 'package:ecomm_mobile/services/http_service.dart';
import 'package:ecomm_mobile/utility/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class UserProvider extends ChangeNotifier {
  HttpService service = HttpService();
  final DataProvider _dataProvider;
  final storage = GetStorage();

  UserProvider(this._dataProvider);

  // TODO: should complete login;

  // TODO: should complete register;

  Future<void> saveLoginInfo(User? loginUser) async {
    await storage.write(USER_INFO_BOX, loginUser?.toJson());
    Map<String, dynamic>? userJson = storage.read(USER_INFO_BOX);
  }

  User? getLoginUser() {
    Map<String, dynamic>? userJson = storage.read(USER_INFO_BOX);
    User? userLogged = User.fromJson(userJson ?? {});
    return userLogged;
  }

  logOutUser() {
    storage.remove(USER_INFO_BOX);
    Get.offAll(const LoginScreen());
  }
}
