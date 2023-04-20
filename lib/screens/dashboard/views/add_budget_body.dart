import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddBudgetPage extends ConsumerStatefulWidget {
  const AddBudgetPage({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<AddBudgetPage> createState() => _AddBudgetPageState();
}

class _AddBudgetPageState extends ConsumerState<AddBudgetPage> {
  final TextEditingController _categoryEditingController =
      TextEditingController();

  final TextEditingController _amountEditingController =
      TextEditingController();

  String? selectedCategory = 'food';
  String? _selectedTimeRange;

  @override
  Widget build(BuildContext context) {
    final budgetObj = ref.watch(budgetProvider);
    final categories = ref.watch(budgetProvider.notifier).getCategoriesList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Budget'),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  /// Show CATEGORIES AND AMOUNTS
                  ListTile(
                    leading: const Icon(
                      Icons.tag,
                      // color: Color(0XFF004958),
                    ),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        Expanded(
                          child: Text(
                            'Category',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            'Budget',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    trailing: const Text(
                      'Remove',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  ListView.builder(
                    clipBehavior: Clip.none,
                    shrinkWrap: true,
                    itemCount: budgetObj.categoriesAndAmount.length,
                    itemBuilder: (context, catIndex) {
                      return ListTile(
                        leading: const Icon(
                          Icons.tag,
                          color: Color(0XFF004958),
                        ),
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                budgetObj.categoriesAndAmount.keys
                                    .elementAt(catIndex),
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                budgetObj.categoriesAndAmount.values
                                    .elementAt(catIndex)
                                    .toString(),
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        trailing: IconButton(
                          onPressed: () {
                            ref.read(budgetProvider.notifier).removeCategories(
                                  budgetObj.categoriesAndAmount.keys
                                      .elementAt(catIndex),
                                );
                          },
                          icon: const Icon(
                            Icons.remove,
                            color: Colors.red,
                            size: 32,
                          ),
                        ),
                      );
                    },
                  ),

                  /// Add categories and amount
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.grey.shade400),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                            child: TextField(
                              keyboardType: TextInputType.text,
                              controller: _categoryEditingController,
                              onChanged: (value) {
                                setState(() {
                                  selectedCategory =
                                      _categoryEditingController.text;
                                });
                              },
                              decoration: const InputDecoration(
                                  label: Text('categories')),
                            ),
                          ),
                          Expanded(
                            child: PopupMenuButton<String>(
                              itemBuilder: (ctx) {
                                return categories.map((e) {
                                  return PopupMenuItem<String>(
                                    value: e,
                                    child: Text(e),
                                  );
                                }).toList();
                              },
                              onSelected: (value) {
                                setState(() {
                                  _categoryEditingController.text = value;
                                  selectedCategory = value;
                                });
                              },
                              icon: const Icon(Icons.arrow_drop_down),
                            ),
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                            child: TextField(
                              keyboardType: TextInputType.number,
                              controller: _amountEditingController,
                              onChanged: (value) {},
                              decoration: const InputDecoration(
                                  label: Text('Amount(Rs.)')),
                            ),
                          ),
                          IconButton(
                            onPressed: () async {
                              if (selectedCategory != null &&
                                  selectedCategory!.isNotEmpty &&
                                  _amountEditingController.text.isNotEmpty) {
                                ref.read(budgetProvider.notifier).addCategories(
                                      selectedCategory!,
                                      _amountEditingController.text,
                                    );
                              }
                            },
                            icon: const Icon(
                              Icons.add,
                              color: Colors.green,
                              size: 32,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  /// ADD TIME RANGE
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.grey.shade400),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text(
                                'Time Range',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                _selectedTimeRange != null
                                    ? _selectedTimeRange!
                                    : 'weekly',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          PopupMenuButton<String>(
                            itemBuilder: (ctx) {
                              return [
                                const PopupMenuItem<String>(
                                  value: 'weekly',
                                  child: Text('weekly'),
                                ),
                                const PopupMenuItem<String>(
                                  value: 'monthly',
                                  child: Text('monthly'),
                                ),
                                const PopupMenuItem<String>(
                                  value: 'yearly',
                                  child: Text('yearly'),
                                )
                              ];
                            },
                            onSelected: (value) {
                              setState(() {
                                _selectedTimeRange = value;
                              });
                              ref
                                  .read(budgetProvider.notifier)
                                  .addTimeRange(_selectedTimeRange!);
                            },
                            icon: const Icon(Icons.arrow_drop_down),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              /// Save
              Container(
                width: double.infinity,
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: ElevatedButton(
                  onPressed: () async {
                    ref
                        .read(budgetProvider.notifier)
                        .addTimeRange(_selectedTimeRange ?? 'weekly');
                    await ref.read(budgetProvider.notifier).saveBudget();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0XFF004958),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    // minimumSize: Size(double.infinity, 45),
                    // maximumSize: Size(double.infinity, 40),
                  ),
                  child: const Text(
                    'Save Budget',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
