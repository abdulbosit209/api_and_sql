import 'dart:convert';
import 'dart:core';
import 'package:http/http.dart' as https;
import 'package:http/http.dart';
import 'package:third_exam/data/models/category_item.dart';
import 'package:third_exam/data/models/product_item.dart';

class ApiProvider {
  // ------------------------- Get All Categories -----------------------------

  //TODO 4 barcha Categoryalarni  serverdan olib keluvchi so'rov yozilsin!

  Future<List<CategoryItem>> getCategorysList() async {
    try {
      Response response =
      await https.get(Uri.parse("https://third-exam.free.mockoapp.net/categories"));
      if (response.statusCode == 200) {
        List<CategoryItem> categoryItems = (jsonDecode(response.body) as List?)
            ?.map((item) => CategoryItem.fromJson(item))
            .toList() ??
            [];
        return categoryItems;
      } else {
        throw Exception();
      }
    } catch (e) {
      print(e.toString());
      throw Exception(e);
    }
  }

// ------------------------- Get Single Category Products -----------------------------

//TODO 5 Yagona kategoriyaga tegishli mahsulotlar ro'yxati serverdan olib kelinsin!

  Future<List<ProductItem>> getProductsList({required int id }) async {
    try {
      Response response =
      await https.get(Uri.parse("https://third-exam.free.mockoapp.net/categories/$id"));
      if (response.statusCode == 200) {
        List<ProductItem> productItems = (jsonDecode(response.body) as List?)
            ?.map((item) => ProductItem.fromJson(item))
            .toList() ??
            [];
        return productItems;
      } else {
        throw Exception();
      }
    } catch (e) {
      print(e.toString());
      throw Exception(e);
    }
  }

  Future<List<ProductItem>> getAllProductItems() async {
    try {
      Response response =
      await https.get(Uri.parse("https://third-exam.free.mockoapp.net/products"));
      if (response.statusCode == 200) {
        List<ProductItem> productsItems = (jsonDecode(response.body) as List?)
            ?.map((item) => ProductItem.fromJson(item))
            .toList() ??
            [];
        return productsItems;
      } else {
        throw Exception();
      }
    } catch (e) {
      print(e.toString());
      throw Exception(e);
    }
  }


}
