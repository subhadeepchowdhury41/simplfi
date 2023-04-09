import 'package:simplfi/models/category_model.dart';

abstract class CategoryRepositoryBluePrint {
  Future<List<Category>> getAllCategories();
  Future<Category> getCategory(String id);
  Future<Category> addCategory(Category category);
  Future<void> deleteCategory(String id);
  Future<Category> updateCategory(String id, Category category);
  Future<Category> addSubCategoryItem(CategoryItem item);
  Future<Category> updateSubCategoryItem(String id, CategoryItem item);
  Future<Category> deleteCategoryItem(String id);
}

class CategoryRepository implements CategoryRepositoryBluePrint {
  @override
  Future<Category> addCategory(Category category) {
    // TODO: implement addCategory
    throw UnimplementedError();
  }

  @override
  Future<Category> addSubCategoryItem(CategoryItem item) {
    // TODO: implement addSubCategoryItem
    throw UnimplementedError();
  }

  @override
  Future<void> deleteCategory(String id) {
    // TODO: implement deleteCategory
    throw UnimplementedError();
  }

  @override
  Future<Category> deleteCategoryItem(String id) {
    // TODO: implement deleteCategoryItem
    throw UnimplementedError();
  }

  @override
  Future<List<Category>> getAllCategories() {
    // TODO: implement getAllCategories
    throw UnimplementedError();
  }

  @override
  Future<Category> getCategory(String id) {
    // TODO: implement getCategory
    throw UnimplementedError();
  }

  @override
  Future<Category> updateCategory(String id, Category category) {
    // TODO: implement updateCategory
    throw UnimplementedError();
  }

  @override
  Future<Category> updateSubCategoryItem(String id, CategoryItem item) {
    // TODO: implement updateSubCategoryItem
    throw UnimplementedError();
  }

}