import 'package:ecomm_mobile/core/data/data_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cart/flutter_cart.dart';

class ProductDetailsProvider extends ChangeNotifier {
  final DataProvider _dataProvider;
  String? selectedVariant;
  var flutterCart = FlutterCart();

  ProductDetailsProvider(this._dataProvider);

  // TODO: should complete addTask
  void updateUI() {
    notifyListeners();
  }
}
