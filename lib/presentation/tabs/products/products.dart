import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:third_exam/data/models/product_item.dart';
import 'package:third_exam/presentation/tabs/products/widgets/all_product_items.dart';
import 'package:third_exam/utils/utility_functions.dart';

import '../../../data/local_data/db/cached_product.dart';
import '../../../data/my_repository.dart';

class Products extends StatefulWidget {
  const Products({Key? key, required this.myRepository}) : super(key: key);

  final MyRepository myRepository;

  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  List<CachedFavouriteProduct> favourites = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hamma mahsulotlar"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return AllProductItems(repository: widget.myRepository);
                }));
              },
              icon: const Icon(Icons.favorite_sharp))
        ],
      ),
      body: FutureBuilder(
        future: Future.wait(
            [widget.myRepository.getAllProductItems(), widget.myRepository
                .getAllCachedProductsFavorite()
            ]),
        builder:
            (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            favourites = snapshot.data[1]! as List<CachedFavouriteProduct>;
            var items = snapshot.data[0]! as List<ProductItem>;
            return GridView.count(
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              crossAxisCount: 2,
              children: List.generate(
                  items.length,
                      (index) =>
                      Container(
                        height: 250,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                blurRadius: 5,
                                spreadRadius: 5,
                                offset: const Offset(1, 3),
                              )
                            ]),
                        child: Stack(
                          children: [
                            Positioned(
                              right: 0,
                              left: 0,
                              child: Column(
                                children: [
                                  Image.network(
                                    items[index].imageUrl,
                                    height: 150,
                                    width: 150,
                                  ),
                                  const SizedBox(height: 15),
                                  Text(
                                    "USD \$ ${items[index].price}",
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(fontSize: 25),
                                  )
                                ],
                              ),
                            ),
                            Positioned(
                                right: 0,
                                top: 10,
                                child: IconButton(
                                  onPressed: () async{
                                    ProductItem item = items[index];
                                    //Ana boldi
                                    //Tushundizmi logikaga
                                    // boldi ustoz tushindim rahmat
                                    //boshqa sceenlarda ham shunaqa logika

                                    if (favourites.map((e) => e.productId).toList().contains(item.id)) {
                                      widget.myRepository.deleteCachedProductsFavoriteById(
                                        id: favourites.where((e) => e.productId == item.id).toList()[0].id!,
                                      );
                                      setState(() {});
                                    } else {
                                      widget.myRepository.insertCachedProductFavorite(
                                        cachedProductsFavorite: CachedFavouriteProduct(
                                          imageUrl: item.imageUrl,
                                          price: item.price,
                                          name: item.name,
                                          productId: item.id,),
                                      );
                                      UtilityFunctions.getMyToast(
                                        message: "Added to favourites!",
                                      );
                                      setState(() {});
                                    }
                                  },
                                  icon: favourites
                                      .map((e) => e.productId)
                                      .toList()
                                      .contains(items[index].id)
                                      ? const Icon(Icons.favorite,
                                      size: 35, color: Colors.red)
                                      : const Icon(Icons.favorite_outline,
                                      size: 35, color: Colors.red),
                                )),
                          ],
                        ),
                      )),
            );
          } else if (snapshot.hasError) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
  //Bu yerda cached favouritelarni productId lar hammasi yig'ib olinib keyin siz bergan produk id si contains orqali ular ichidan qidirilvotti
  // rahamt ustoz endi ishladi shuni funksiya yozmasdan qisayam bo'ladimi
  //haa boladi
  //qarab turing

  Future<void> addToFavourites(ProductItem item) async {
    if (favourites.map((e) => e.productId).toList().contains(item.id)) {
      widget.myRepository.deleteCachedProductsFavoriteById(
        id: favourites.where((e) => e.productId == item.id).toList()[0].id!,
      );
      setState(() {});
    } else {
      widget.myRepository.insertCachedProductFavorite(
        cachedProductsFavorite: CachedFavouriteProduct(
          imageUrl: item.imageUrl,
          price: item.price,
          name: item.name,
          productId: item.id,),
      );
      UtilityFunctions.getMyToast(
        message: "Added to favourites!",
      );
      setState(() {});
    }
  }
}

//Qarang hozi eski appni o'chirasiz keyin yangil qilib ishlatib ko'rasiz
// bo'madi ustoz
//run qilmadizu
