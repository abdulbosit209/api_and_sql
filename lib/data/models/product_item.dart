import 'package:json_annotation/json_annotation.dart';

//TODO bu satrni commentdan chiqarish esdan chiqmasin!
part 'product_item.g.dart';


@JsonSerializable()
class ProductItem {
  //TODO 3 ProductItem klasini yozib .g file generate qilinsin!

  ProductItem({
   required this.imageUrl,
   required this.id,
   required this.name,
   required this.price,
   required this.categoryId
  });

  @JsonKey(defaultValue: 0, name: 'id')
  int id;

  @JsonKey(defaultValue: 0, name: 'category_id')
  int categoryId;

  @JsonKey(defaultValue: "", name: 'name')
  String name;

  @JsonKey(defaultValue: 0, name: 'price')
  int price;

  @JsonKey(defaultValue: "", name: 'image_url')
  String imageUrl;

  factory ProductItem.fromJson(Map<String, dynamic> json) =>
      _$ProductItemFromJson(json);

  Map<String, dynamic> toJson() => _$ProductItemToJson(this);

}


/*

  {
    "id": 1,
    "category_id": 1,
    "name": "Macbook",
    "price": 1200,
    "image_url": "https://e7.pngegg.com/pngimages/765/477/png-clipart-macbook-macbook.png"
   },
 */