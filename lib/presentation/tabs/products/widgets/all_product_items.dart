


import 'package:flutter/material.dart';
import 'package:third_exam/data/my_repository.dart';

import '../../../../data/local_data/db/cached_product.dart';

class AllProductItems extends StatefulWidget {
  const AllProductItems({Key? key, required this.repository}) : super(key: key);
  final MyRepository repository;

  @override
  State<AllProductItems> createState() => _AllProductItemsState();
}

class _AllProductItemsState extends State<AllProductItems> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("barcha mahsulotlar"),
        actions: [
          IconButton(onPressed: ()async{
            await widget.repository.deleteAllCachedProductFavorite();
            setState((){});
          }, icon: const Icon(Icons.cleaning_services_outlined))
        ],
      ),
      body: FutureBuilder(
        future: widget.repository.getAllCachedProductsFavorite(),
        builder: (BuildContext context, AsyncSnapshot<List<CachedFavouriteProduct>> snapshot) {
          if(snapshot.hasData){
            var items = snapshot.data!;
            return GridView.count(
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              crossAxisCount: 2,
              children: List.generate(items.length, (index) => Container(
                height: 250,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      blurRadius: 5,
                      spreadRadius: 5,
                      offset: const Offset(1, 3),
                    )]
                ),
                child: Stack(
                  children: [
                    Positioned(
                      right: 0,
                      left: 0,
                      child: Column(
                        children: [
                          Image.network(items[index].imageUrl, height: 150, width: 150,),
                          const SizedBox(height: 15),
                          Text("USD \$ ${items[index].price}", textAlign: TextAlign.center, style: const TextStyle(fontSize: 25),)

                        ],
                      ),
                    ),
                  ],
                ),
              )),
            );
          }
          else if(snapshot.hasError){
            return const Center(child: Text("Error"));
          }
          else{
            return const Center(child: CircularProgressIndicator());
          }
        },
      )
    );
  }
}
