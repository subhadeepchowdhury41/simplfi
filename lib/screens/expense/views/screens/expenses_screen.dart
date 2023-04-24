import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simplfi/models/category_model.dart';
import 'package:simplfi/providers/budget_riverpod.dart';
import 'package:simplfi/screens/expense/repo/expense_repository.dart';

import '../../../../models/expense_model.dart';
import 'add_expense_screen.dart';

class ExpensesScreen extends ConsumerStatefulWidget {
  const ExpensesScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ExpensesScreen> createState() => _ExpensesScreenState();
}

class _ExpensesScreenState extends ConsumerState<ExpensesScreen> {
  Future<List<Expense>> _getExpensesList() async {
    List<Expense> list = [];
    await ExpenseRepository().getAllExpenses().then((value) {
      debugPrint(value.length.toString());
      list = value;
    });
    return list;
  }

  @override
  Widget build(BuildContext context) {
    List<CategoryModel> list =
        ref.read(budgetProvider.notifier).getCategoryList() ?? [];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Expenses',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 20,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const AddExpenseScreen()),
              ).then((value) {
                setState(() {});
              });
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: FutureBuilder(
        future: _getExpensesList(),
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          debugPrint('${snap.data!.length}');
          List<Expense> expenseList = [];
          if (snap.data != null) {
            expenseList = getSortedList(snap.data!);
          }
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: const [
                    Expanded(
                      child: Text(
                        'Category',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          'Budget',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          'Expense',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: list.length,
                  itemBuilder: (ctx, index) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        // Expanded(child: Text(index.toString() ?? '--')),
                        Expanded(
                          child: Text(list[index].name ?? '--'),
                        ),
                        Expanded(
                          child: Center(
                            child: Text(
                              list[index].budget.toString() ?? '0.0',
                              style: const TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.w500,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Center(
                            child: Text(
                              list[index].expense.toString() ?? '0.0',
                              style: TextStyle(
                                color: Colors.redAccent,
                                fontWeight: FontWeight.w500,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Expanded(
                      child: Text(
                        'Date',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          'Category',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          'Expense',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                if (snap.data != null)
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: snap.data!.length,
                    // itemExtent: 30,
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    itemBuilder: (ctx, index) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  getDateString(expenseList[index].dateTime!),
                                ),
                              ),
                              Expanded(
                                child: Center(
                                  child: Text(
                                    expenseList[index]
                                            .categoryName
                                            .toString() ??
                                        '--',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Center(
                                  child: Text(
                                    expenseList[index].amount.toString() ??
                                        '0.0',
                                    style: const TextStyle(
                                      color: Colors.redAccent,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                        ],
                      );
                    },
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  List<Expense> getSortedList(List<Expense> list) {
    list.sort((e1, e2) {
      DateTime d1 = e1.dateTime ?? DateTime.now();
      DateTime d2 = e2.dateTime ?? DateTime.now();

      return d2.compareTo(d1);
    });
    return list;
  }

  String getDateString(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year}\n${dateTime.hour}:${dateTime.minute}';
  }
}
