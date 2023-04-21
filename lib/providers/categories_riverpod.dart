import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simplfi/models/category_model.dart';
import 'package:simplfi/services/hive_db/hive_services.dart';
import 'package:uuid/uuid.dart';

class CategoryRiverpod extends StateNotifier<Category> {
  CategoryRiverpod()
      : super(
          Category(
            budget: 0.0,
            expense: 0.0,
            id: const Uuid().v4(),
            item: [],
            name: null,
            created: DateTime.now(),
          ),
        );

  Future<void> initializeCategory() async {
    await HiveServices.getCategory().then((cate) {
      if (cate != null) {
        state = cate;
        return;
      }
    });
  }

  Future<void> saveCategory() async {
    await HiveServices.saveCategory(state);
  }

  void addCategoryItem(CategoryItem item) {
    Category nCategory = state;
    nCategory.item?.add(item);
    state = nCategory;
  }

  void updateCategoryItem(CategoryItem item) {
    Category nCategory = state;
    int? index = nCategory.item?.indexWhere((element) => element.id == item.id);
    if (index == null) {
      return;
    }
    nCategory.item?[index] = item;
    state = nCategory;
  }

  void removeCategoryItem(CategoryItem item) {
    Category nCategory = state;
    nCategory.item?.removeWhere((element) => element.id == item.id);
    state = nCategory;
  }
}
