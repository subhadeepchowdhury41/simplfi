import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'category_model.g.dart';

@HiveType(typeId: 0, adapterName: "CategoryAdapter")
class Category extends HiveObject {
  
  Category({
    this.budget,
    this.expense,
    this.id,
    this.item,
    this.name
  });

  @HiveField(4)
  String? id = const Uuid().v4();

  @HiveField(0)
  String? name;

  @HiveField(1, defaultValue: [])
  List<CategoryItem>? item;

  @HiveField(2)
  double? expense;

  @HiveField(3)
  double? budget;
}

@HiveType( typeId: 1, adapterName: "ItemsAdapter")
class CategoryItem {
  @HiveField(3)
  String? id = const Uuid().v4();

  @HiveField(0)
  String? name;

  @HiveField(1)
  double? expense;

  @HiveField(2)
  double? budget;
}