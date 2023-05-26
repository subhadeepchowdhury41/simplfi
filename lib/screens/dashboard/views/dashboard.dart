import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simplfi/providers/budget_riverpod.dart';
import 'package:simplfi/screens/category/views/screens/add_categories_screen.dart';
import 'package:simplfi/screens/expense/views/screens/add_expense_screen.dart';
import 'package:simplfi/widgets/budget_expense_card.dart';
import 'package:simplfi/widgets/chart.dart';

import '../../expense/views/screens/expenses_screen.dart';

class Dashboard extends ConsumerStatefulWidget {
  const Dashboard({super.key});

  @override
  ConsumerState<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends ConsumerState<Dashboard> {
  Future<void> _initializeBudget(WidgetRef ref) async {
    await ref.read(budgetProvider.notifier).initialize().then((value) {
      return;
    });
  }

  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      appBar: AppBar(
        title: Text('SimplFi'),
        actions: [],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        index: _index,
        // backgroundColor: Colors.blueAccent,
        // buttonBackgroundColor: Colors.deepPurple.shade500,
        buttonBackgroundColor: Colors.blue.shade900,
        animationDuration: const Duration(milliseconds: 200),
        backgroundColor: Colors.transparent,
        items: <Widget>[
          _getBottomItemWidget(
              index: 0, label: 'Portfolio', iconData: Icons.shopping_bag),
          _getBottomItemWidget(
            index: 1,
            label: 'Transaction',
            iconData: Icons.assistant_navigation,
          ),
          _getBottomItemWidget(
              index: 2,
              label: 'Summary',
              iconData: Icons.qr_code_scanner_rounded),
          _getBottomItemWidget(index: 3, label: 'Tools', iconData: Icons.star),
          _getBottomItemWidget(
              index: 4, label: 'Security 2.0', iconData: Icons.security),
        ],
        onTap: (index) {
          //Handle button tap
          setState(() {
            _index = index;
          });
        },
      ),
      body: FutureBuilder(
        future: _initializeBudget(ref),
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Column(
            children: [
              /// Budget Graph -------- update button(Go to update budget screen)
              /// Expenses  --------- add expenses button

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddCategoryScreen()));
                    },
                    child: const Text('Add Category'),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ExpensesScreen()));
                      },
                      child: Text('Expenses')),
                ],
              ),
              Expanded(
                flex: 7,
                child: ListView(
                  scrollDirection: Axis.vertical,
                  children: [],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _getBottomItemWidget(
      {required int index, required String label, required IconData iconData}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        if (_index == index)
          ShaderMask(
            shaderCallback: (bounds) {
              if (index == _index) {
                return LinearGradient(
                  colors: [
                    // Colors.deepPurple.shade500,
                    Colors.blue.shade900, Colors.white70,
                    Colors.white,
                  ],
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                ).createShader(bounds);
              }
              return const LinearGradient(colors: []).createShader(bounds);
            },
            child: Icon(
              iconData,
              size: 30,
              color: _index == index
                  ? Colors.white
                  : Colors.blue.shade900, //const Color(0xFF3554EF),
            ),
          ),
        if (_index != index)
          Icon(
            iconData,
            size: 30,
            color: _index == index
                ? Colors.white
                : Colors.blue.shade900, //const Color(0xFF3554EF),
          ),
        if (_index != index)
          Text(
            label,
            style: TextStyle(
              color: Colors.blue.shade900,
              fontWeight: FontWeight.w500,
            ),
          ),
      ],
    );
  }
}
