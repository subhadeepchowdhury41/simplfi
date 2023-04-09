import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class BudgetExpenseCard extends StatelessWidget {
  const BudgetExpenseCard({
    super.key,
    required this.budget,
    required this.categoryName,
    required this.expense
  });

  final String categoryName;
  final double budget;
  final double expense;

  @override
  Widget build(BuildContext context) {
    return Text(categoryName);
  }
}