import 'package:flutter/material.dart';
import 'package:third_exam/data/models/category_item.dart';
import 'package:third_exam/data/my_repository.dart';
import 'package:third_exam/presentation/products/products_screen.dart';
import 'package:third_exam/presentation/tabs/categories/widgets/category_item_view.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({Key? key, required this.myRepository})
      : super(key: key);

  final MyRepository myRepository;

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Kategoryalar"),
      ),
      //TODO 8 FutureBuilder widget idan foydalanib barcha kategoriyalar chaqirilib ekranga chizilsin!
      body: FutureBuilder(
        future: widget.myRepository.getAllCategory(),
        builder: (BuildContext context, AsyncSnapshot<List<CategoryItem>> snapshot) {
          if(snapshot.hasError){
            return const Center(child: Text("error"),);
          }
          if(snapshot.hasData){
            var categories = snapshot.data!;
            return ListView.builder(
              itemCount: categories.length,
                itemBuilder: (context, index){
                  return CategoryItemView(
                    categoryItem: categories[index],
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context){
                        return ProductsScreen(categoryItem: categories[index], myRepository: widget.myRepository);
                      }));
                    },
                  );
                });
          }

          else{
            return const Center(child: CircularProgressIndicator(),);
          }
        },)
    );
  }
}
