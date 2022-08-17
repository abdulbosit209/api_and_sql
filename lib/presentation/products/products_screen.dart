import 'package:flutter/material.dart';
import 'package:third_exam/data/local_data/db/cached_category.dart';
import 'package:third_exam/data/local_data/db/local_database.dart';
import 'package:third_exam/data/models/category_item.dart';
import 'package:third_exam/data/models/product_item.dart';
import 'package:third_exam/data/my_repository.dart';
import 'package:third_exam/presentation/products/widgets/product_item_view.dart';
import 'package:third_exam/utils/utility_functions.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen(
      {Key? key, required this.myRepository, required this.categoryItem})
      : super(key: key);

  final MyRepository myRepository;
  final CategoryItem categoryItem;

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  List<CachedProduct> productsSql = [];

  @override
  void initState() {
    _init();
    super.initState();
  }

  Future<void> _init() async {
    productsSql = await widget.myRepository.getAllCachedProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mahsulotlar"),
      ),
      body: FutureBuilder(
        future: widget.myRepository.getAllProducts(id: widget.categoryItem.id),
        builder:
            (BuildContext context, AsyncSnapshot<List<ProductItem>> snapshot) {
          if (snapshot.hasData) {
            var productItems = snapshot.data!;
            return GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 0.6,
                children: List.generate(
                    productItems.length,
                    (index) => ProductsItemView(
                          item: productItems[index],
                          onTap: () async {
                            List<CachedProduct> cachedProducts = await widget
                                .myRepository
                                .getAllCachedProducts();
                            bool beforeSaved = false;
                            int savedId = 0;
                            int count = 0;

                            for (var value in cachedProducts) {
                              if (value.productId == productItems[index].id) {
                                beforeSaved = true;
                                savedId = value.id!;
                                count = value.count;
                              }
                            }

                            if (beforeSaved) {
                              widget.myRepository.updateCachedProduct(
                                  CachedProduct(
                                      id: savedId,
                                      imageUrl: productItems[index].imageUrl,
                                      price: productItems[index].price,
                                      count: count + 1,
                                      name: productItems[index].name,
                                      productId: productItems[index].id));
                              UtilityFunctions.getMyToast(message: "Saved");
                            } else {
                              widget.myRepository.insertCachedProduct(
                                  cachedProduct: CachedProduct(
                                      imageUrl: productItems[index].imageUrl,
                                      price: productItems[index].price,
                                      count: 1,
                                      name: productItems[index].name,
                                      productId: productItems[index].id));

                              UtilityFunctions.getMyToast(message: "Saved");
                            }
                          },
                        ),),);
          }
          if (snapshot.hasError) {
            return const Center(
              child: Text("error"),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
/*
                        widget.myRepository.insertCachedProduct(cachedProduct: CachedProduct(
                        imageUrl: productItems[index].imageUrl,
                        price: productItems[index].price,
                        count: 1,
                        name: productItems[index].name,
                        productId: productItems[index].id
                    ));
 */
