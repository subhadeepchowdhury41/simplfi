import 'package:hive/hive.dart';
part 'category_model.g.dart';

@HiveType(typeId: 0, adapterName: "CategoryAdapter")
class CategoryModel extends HiveObject {
  CategoryModel(
      {this.budget, this.expense, this.id, this.item, this.name, this.created});

  @HiveField(4)
  String? id;

  @HiveField(6)
  DateTime? created;

  @HiveField(0)
  String? name;

  @HiveField(1, defaultValue: [])
  List<CategoryItem>? item;

  @HiveField(2)
  double? expense;

  @HiveField(3)
  double? budget;
}

@HiveType(typeId: 1, adapterName: "ItemsAdapter")
class CategoryItem {
  @HiveField(3)
  String? id;

  @HiveField(0)
  String? name;

  @HiveField(1)
  double? expense;

  @HiveField(2)
  double? budget;
}
