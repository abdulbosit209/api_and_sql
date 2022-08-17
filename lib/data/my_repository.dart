import 'package:third_exam/data/api/api_provider.dart';
import 'package:third_exam/data/local_data/db/local_database.dart';
import 'package:third_exam/data/models/product_item.dart';

import 'local_data/db/cached_category.dart';
import 'local_data/db/cached_product.dart';
import 'models/category_item.dart';

class MyRepository {
  MyRepository({
    required this.apiProvider,
  });

  final ApiProvider apiProvider;





//  -----------------------------------Products------------------------------------------

  Future<List<ProductItem>> getAllProducts({required int id}) => apiProvider.getProductsList(id: id);
  Future<List<CategoryItem>> getAllCategory() => apiProvider.getCategorysList();
  Future<List<ProductItem>> getAllProductItems() => apiProvider.getAllProductItems();




   Future<CachedProduct> insertCachedProduct({required CachedProduct cachedProduct}) async {
    return await LocalDatabase.insertCachedUser(cachedProduct);
  }

   Future<int> deleteCachedProduct({required int id}) async {
    return await LocalDatabase.deleteCachedUserById(id);
  }

   Future deleteAllCachedProduct() async {
    return await LocalDatabase.deleteAllCachedUsers();
  }

   Future<List<CachedProduct>> getAllCachedProducts() async {
    return await LocalDatabase.getAllCachedProducts();
  }

  Future<int> updateCachedProduct(CachedProduct cachedProduct) async {
    return await LocalDatabase.updateCachedProduct(cachedProduct);
  }

  //-----------------------------------cachedProductFavorite----------------------------------------

  Future<List<CachedFavouriteProduct>> getAllCachedProductsFavorite()async {
     return await LocalDatabase.getAllCachedProductsFavorite();
  }

  Future<int> deleteCachedProductsFavoriteById({required int id})async {
    return await LocalDatabase.deleteCachedProductsFavoriteById(id);
  }

  Future<CachedFavouriteProduct> insertCachedProductFavorite({required CachedFavouriteProduct cachedProductsFavorite})async {
    return await LocalDatabase.insertCachedProductFavorite(cachedProductsFavorite);
  }

  Future deleteAllCachedProductFavorite()async {
    return await LocalDatabase.deleteAllCachedProductFavorite();
  }

}

