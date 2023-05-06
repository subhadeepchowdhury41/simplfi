import 'package:flutter/material.dart';
import 'package:simplfi/models/category_model.dart';

class CategorySelector extends StatefulWidget {
  final List<CategoryModel> categories;
  final Function(CategoryModel?) onCategorySelected;

  const CategorySelector({
    super.key,
    required this.categories,
    required this.onCategorySelected,
  });

  @override
  State<CategorySelector> createState() => _CategorySelectorState();
}

class _CategorySelectorState extends State<CategorySelector> {
  CategoryModel? _selectedCategory;

  @override
  void initState() {
    super.initState();
    _selectedCategory =
        widget.categories.isNotEmpty ? widget.categories[0] : null;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<CategoryModel>(
      value: _selectedCategory,
      onChanged: (CategoryModel? category) {
        setState(() {
          _selectedCategory = category;
        });
        widget.onCategorySelected(category!);
      },
      items: widget.categories.map((category) {
        return DropdownMenuItem(
          value: category,
          child: Text(category.name!),
        );
      }).toList(),
      decoration: const InputDecoration(
        labelText: 'Category',
        border: OutlineInputBorder(),
      ),
    );
  }
}
