import 'package:simplfi/models/category_model.dart';
import 'package:simplfi/services/hive_db/boxes.dart';

abstract class CategoryRepositoryBluePrint {
  Future<List<Category>> getAllCategories();
  Future<Category?> getCategory(String id);
  Future<void> addCategory(Category category);
  Future<void> deleteCategory(String id);
  Future<void> updateCategory(String id, Category category);
  Future<void> addSubCategoryItem(CategoryItem item, String id);
  Future<void> updateSubCategoryItem(String id, CategoryItem item);
  Future<void> deleteCategoryItem(String categoryId, String itemId);
}

class CategoryRepository implements CategoryRepositoryBluePrint {
  final _categoryBox = Boxes.getCategoriesBox();

  @override
  Future<void> addCategory(Category category) async {
    await _categoryBox.put(category.id, category);
  }

  @override
  Future<void> addSubCategoryItem(CategoryItem item, String id) async {
    final Category? category = await getCategory(id);
    category?.item?.add(item);
    await _categoryBox.put(id, category!);
  }

  @override
  Future<void> deleteCategory(String id) async {
    await _categoryBox.delete(id);
  }

  @override
  Future<void> deleteCategoryItem(String categoryId, String itemId) async {
    final Category? category = await getCategory(categoryId);
    category?.item?.removeWhere((element) => element.id != itemId);
    await _categoryBox.put(categoryId, category!);
  }

  @override
  Future<List<Category>> getAllCategories() async {
    return _categoryBox.values.toList();
  }

  @override
  Future<Category?> getCategory(String id) async {
    return _categoryBox.get(id);
  }

  @override
  Future<void> updateCategory(String id, Category category) async {
    await _categoryBox.put(id, category);
  }

  @override
  Future<void> updateSubCategoryItem(String id, CategoryItem item) async {
    final Category? category = _categoryBox.get(id);
    category?.item?.map((e) {
      if (e.id == item.id) {
        return item;
      }
      return e;
    });
    await _categoryBox.put(id, category!);
  }
}