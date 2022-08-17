import 'package:json_annotation/json_annotation.dart';

//TODO bu satrni commentdan chiqarish esdan chiqmasin!
part 'category_item.g.dart';


@JsonSerializable()
class CategoryItem {
  //TODO 2 CategorItem klasini yozib .g file generate qilinsin!

  CategoryItem({required this.name, required this.id, required this.imageUrl});

  @JsonKey(defaultValue: 0, name: 'id')
  int id;

  @JsonKey(defaultValue: "", name: 'name')
  String name;

  @JsonKey(defaultValue: "", name: 'image_url')
  String imageUrl;


  factory CategoryItem.fromJson(Map<String, dynamic> json) =>
      _$CategoryItemFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryItemToJson(this);

}

/*
    {
        "id": 1,
        "name": "Computers",
        "image_url": "https://www.microsoft.com/en-us/microsoft-365/blog/wp-content/uploads/sites/2/2020/05/Dell-1.png"
    },
 */