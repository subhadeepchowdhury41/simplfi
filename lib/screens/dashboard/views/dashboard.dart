import 'package:fl_chart/fl_chart.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:simplfi/models/expense_model.dart';
import 'package:simplfi/screens/dashboard/provider/budget_provider.dart';
import 'package:simplfi/screens/expense/provider/expense_provider.dart';
import 'package:simplfi/screens/category/views/screens/add_categories_screen.dart';
import 'package:simplfi/screens/expense/views/screens/add_expense_screen.dart';

import '../../expense/views/screens/expenses_screen.dart';

class Dashboard extends ConsumerStatefulWidget {
  const Dashboard({super.key});

  @override
  ConsumerState<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends ConsumerState<Dashboard> {
  final _expenseChartCtrl = ScrollController();
  List<Expense> getSortedExpenses(List<Expense> list) {
    list.sort((a, b) => a.dateTime!.compareTo(b.dateTime!));
    return list;
  }
  Future<void> _initializeBudget(WidgetRef ref) async {
    await ref.read(budgetProvider.notifier).initialize().then((value) {
      return;
    });
  }

  int _index = 0;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _expenseChartCtrl.animateTo(_expenseChartCtrl.position.maxScrollExtent,
          duration: const Duration(seconds: 1),
          curve: Curves.fastLinearToSlowEaseIn);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final expenseList = ref.watch(expenseProvider);
    final budget = ref.watch(budgetProvider);
    int i = 0;
    return Scaffold(
        backgroundColor: const Color.fromARGB(249, 254, 254, 254),
        body: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            Expanded(
                flex: 1,
                child: Container(
                  margin: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(13.0),
                        child: Text(
                          'SimplFi',
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.w700),
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        const AddExpenseScreen()));
                              },
                              icon: const Icon(Icons.poll_outlined)),
                          IconButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => AddCategoryScreen()));
                              },
                              icon: const Icon(
                                  Icons.dashboard_customize_outlined)),
                          IconButton(
                              onPressed: () {}, icon: const Icon(Icons.person))
                        ],
                      )
                    ],
                  ),
                )),
            Expanded(
              flex: 7,
              child: ListView(
                scrollDirection: Axis.vertical,
                children: [
                  SingleChildScrollView(
                    controller: _expenseChartCtrl,
                    scrollDirection: Axis.horizontal,
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height / 5,
                      width: MediaQuery.of(context).size.width /
                          5 *
                          expenseList.length,
                      child: BarChart(BarChartData(
                          titlesData: FlTitlesData(
                              topTitles: AxisTitles(
                                  sideTitles: SideTitles(showTitles: false)),
                              rightTitles: AxisTitles(
                                  sideTitles: SideTitles(showTitles: false)),
                              leftTitles: AxisTitles(
                                  sideTitles: SideTitles(showTitles: false)),
                              bottomTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                      interval: 1,
                                      showTitles: true,
                                      getTitlesWidget: (i, meta) {
                                        String title = DateFormat.MMMd().format(
                                            getSortedExpenses(
                                                    expenseList)[i.toInt()]
                                                .dateTime!);
                                        return Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Text(
                                            title,
                                            style: const TextStyle(fontSize: 8),
                                          ),
                                        );
                                      }))),
                          gridData: FlGridData(show: false),
                          borderData: FlBorderData(
                              border: const Border(
                            top: BorderSide.none,
                          )),
                          barGroups: getSortedExpenses(expenseList)
                              .map((exp) => BarChartGroupData(
                                  x: i++,
                                  barRods: [BarChartRodData(toY: exp.amount!)]))
                              .toList())),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 13,
                    ),
                    height: MediaQuery.of(context).size.height / 6,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: budget!.categories!.length,
                        itemBuilder: (context, index) => Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 8),
                              width: MediaQuery.of(context).size.width / 2.3,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color:
                                      const Color.fromARGB(255, 179, 254, 240)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 9, vertical: 8.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          budget.categories![index].name!,
                                          style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w700),
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Budget: ${budget.categories![index].budget!.toInt()}',
                                              style:
                                                  const TextStyle(fontSize: 10),
                                            ),
                                            Text(
                                              'Expense: ${budget.categories![index].expense!.toInt()}',
                                              style:
                                                  const TextStyle(fontSize: 10),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(18.0),
                                    child: SizedBox(
                                      height: 10,
                                      width: 10,
                                      child: CircularProgressIndicator(
                                        backgroundColor: const Color.fromARGB(
                                            239, 229, 228, 228),
                                        color: Colors.amber,
                                        strokeWidth: 10,
                                        value: budget
                                                .categories![index].expense! /
                                            budget.categories![index].budget!,
                                      ),
                                    ),
                                  ),
                                  //
                                ],
                              ),
                            )),
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 13, horizontal: 8),
                      child: Column(
                        children: [
                          LinearPercentIndicator(
                            lineHeight: 30,
                            progressColor:
                                const Color.fromARGB(255, 162, 248, 65),
                            backgroundColor:
                                const Color.fromARGB(234, 227, 222, 222),
                            percent: ((budget.expense! / 30000 * 100).round() /
                                100.0),
                            center: Text(
                              '${(budget.expense! / 30000 * 100).round()}%',
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700),
                            ),
                            barRadius: const Radius.circular(15),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Center(
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '${budget.expense!.ceil()}₹',
                                  style: const TextStyle(
                                      fontSize: 21,
                                      fontWeight: FontWeight.w600),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: Text(
                                    '/ ${budget.amount!.ceil()}₹',
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      )),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 23, horizontal: 23),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 5,
                          width: MediaQuery.of(context).size.width / 3,
                          child: PieChart(PieChartData(
                              sections: budget.categories!
                                  .map((cat) => PieChartSectionData(
                                      badgePositionPercentageOffset: 1.3,
                                      titleStyle: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 11,
                                          fontWeight: FontWeight.w400),
                                      title:
                                          '${(cat.expense! / budget.expense! * 100).ceil()}%',
                                      value:
                                          (cat.expense! / budget.expense! * 100)
                                              .ceilToDouble()))
                                  .toList())),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 6,
                          width: MediaQuery.of(context).size.width / 3,
                          child: ListView.builder(
                              itemCount: budget.categories!.length,
                              itemBuilder: (context, index) => Row(
                                    children: [
                                      Container(
                                        width: 10,
                                        height: 10,
                                        color: Colors.blueAccent,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        budget.categories![index].name!,
                                        style: const TextStyle(fontSize: 11),
                                      ),
                                    ],
                                  )),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ));
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
                    Colors.blue.shade900,
                    Colors.deepPurple.shade500,
                    Colors.white70,
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
