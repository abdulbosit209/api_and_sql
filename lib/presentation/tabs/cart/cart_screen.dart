import 'package:flutter/material.dart';
import 'package:third_exam/data/local_data/db/cached_category.dart';
import 'package:third_exam/data/my_repository.dart';
import 'package:third_exam/utils/colors.dart';
import 'package:third_exam/utils/styles.dart';
import 'package:third_exam/utils/utility_functions.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key, required this.myRepository}) : super(key: key);

  final MyRepository myRepository;

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Savatcha"),
        actions: [
          TextButton(
            onPressed: () async {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text(
                          "Rostdan ham savatchadi barcha mahsulotlarni o'chirmoqchimisiz?"),
                      actions: [
                        TextButton(
                          child: const Text('Ha'),
                          onPressed: () async {
                            //TODO 11 Barcha Savatga saqlangan mahsulotlar o'chirilsin!
                            await widget.myRepository.deleteAllCachedProduct();
                            setState((){});
                            Navigator.of(context).pop();
                          },
                        ),
                        TextButton(
                          child: const Text("Yo'q"),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  });
            },
            child: Text(
              "Tozalash",
              style: MyTextStyle.interSemiBold600.copyWith(
                color: MyColors.white,
              ),
            ),
          )
        ],
      ),
      //TODO 10 FutureBuilder widgetidan foydalanib saqlangan mahsulotlar chaqirib ekranga chizilsin!
      //TODO 15 Har bir savatga saqlangan mahsulotni foydalanuvchi o'chirish imkoniga ega bo'lsin!
      //TODO 16 Savatga saqlangan mahsulotlarni umumiy narxini ekranga chiqaring!
      body: FutureBuilder(
        future: widget.myRepository.getAllCachedProducts(),
        builder: (BuildContext context, AsyncSnapshot<List<CachedProduct>> snapshot) {

          if(snapshot.hasData){
            var cachedProducts = snapshot.data!;
          return ListView(
              children: List.generate(cachedProducts.length, (index) => ListTile(
                leading: Image.network(cachedProducts[index].imageUrl),
                title: Text(cachedProducts[index].name),
                subtitle: Text("${cachedProducts[index].count} x ${cachedProducts[index].price} "),
                trailing: IconButton(icon: const Icon(Icons.delete, color: Colors.red,), onPressed: () async {
                  await widget.myRepository.deleteCachedProduct(id: cachedProducts[index].id!);
                  setState((){});
                },),
              )),
            );
          }else
          if(snapshot.hasError){
            return const Center(child: Text("error"));
          }
          else{
            return const Center(child: CircularProgressIndicator());
          }
        },),
    );
  }
}
