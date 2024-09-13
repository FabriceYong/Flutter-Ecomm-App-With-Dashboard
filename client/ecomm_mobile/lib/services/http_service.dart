import 'dart:convert';

import 'package:ecomm_mobile/utility/constants.dart';
import 'package:get/get.dart';

class HttpService {
  final String baseUrl = MAIN_URL;

  Future<Response> getItems({required String endPoint}) async {
    try {
      return await GetConnect().get('$baseUrl/$endPoint');
    } catch (e) {
      return Response(
          body: json.encode({'message': e.toString()}), statusCode: 500);
    }
  }

  Future<Response> addItem({required String endPoint, dynamic itemData}) async {
    try {
      final response = await GetConnect().post('$baseUrl/$endPoint', itemData);
      print(response.body);
      return response;
    } catch (e) {
      return Response(
          body: json.encode({'message': e.toString()}), statusCode: 500);
    }
  }

  Future<Response> updateItem(
      {required String endPoint,
      required String itemId,
      dynamic itemData}) async {
    try {
      final response =
          await GetConnect().put('$baseUrl/$endPoint/$itemId', itemData);
      print(response.body);
      return response;
    } catch (e) {
      return Response(
          body: json.encode({'message': e.toString()}), statusCode: 500);
    }
  }

  Future<Response> deleteItem(
      {required String endPoint, required String itemId}) async {
    try {
      final Response response =
          await GetConnect().delete('$baseUrl/$endPoint/$itemId');
      print(response.body);
      return response;
    } catch (e) {
      return Response(
          body: json.encode({'message': e.toString()}), statusCode: 500);
    }
  }
}
