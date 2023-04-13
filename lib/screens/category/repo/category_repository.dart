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
    
  }

  @override
  Future<Category> addSubCategoryItem(CategoryItem item) {
    
  }

  @override
  Future<void> deleteCategory(String id) {

  }

  @override
  Future<Category> deleteCategoryItem(String id) {

  }

  @override
  Future<List<Category>> getAllCategories() {

  }

  @override
  Future<Category> getCategory(String id) {

  }

  @override
  Future<Category> updateCategory(String id, Category category) {

  }

  @override
  Future<Category> updateSubCategoryItem(String id, CategoryItem item) {
    
  }

}