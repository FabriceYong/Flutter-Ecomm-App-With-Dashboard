import 'package:ecomm_mobile/core/data/data_provider.dart';
import 'package:ecomm_mobile/models/product.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class FavoriteProvider extends ChangeNotifier {
  FavoriteProvider(this._dataProvider);
  final DataProvider _dataProvider;
  final storage = GetStorage();
  List<Product> favoriteProducts = [];

  //TODO: should complete updateToFavoriteList

  //TODO: should complete checkIsItemFavorite

  //TODO: should complete loadFavoriteItems

  //TODO: should complete clearFavoriteList
}
