import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simplfi/models/category_model.dart';
import 'package:simplfi/utils/extensions/color_extension.dart';
import '../screens/dashboard/provider/budget_provider.dart';
import '../utils/app_colors.dart';

class BarChartSample2 extends StatefulWidget {
  final WidgetRef ref;
  BarChartSample2({
    super.key,
    required this.ref,
  });
  final Color leftBarColor = AppColors.contentColorYellow;
  final Color rightBarColor = AppColors.contentColorRed;
  final Color avgColor =
      AppColors.contentColorOrange.avg(AppColors.contentColorRed);
  @override
  State<StatefulWidget> createState() => BarChartSample2State();
}

class BarChartSample2State extends State<BarChartSample2> {
  final double width = 7;
  late List<BarChartGroupData> rawBarGroups;
  late List<BarChartGroupData> showingBarGroups;

  int touchedGroupIndex = -1;

  @override
  void initState() {
    super.initState();

    rawBarGroups = makeGroupData();
    _maxY = setMaxY();
    showingBarGroups = rawBarGroups;
  }

  String _factor = 'x 1000';
  late double _maxY;

  double setMaxY() {
    List<CategoryModel>? cats =
        widget.ref.read(budgetProvider.notifier).getCategoryList() ?? [];

    double max = 0;
    for (CategoryModel categoryModel in cats) {
      double exp = categoryModel.expense ?? 0.0;
      // debugPrint('value greater for: $val');
      double bud = categoryModel.budget ?? 0.0;
      double val = exp > bud ? exp : bud;
      if (val > max) {
        max = val;
      }
    }
    _maxY = max;
    debugPrint('maxY: $_maxY');
    return max;
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                makeTransactionsIcon(),
                Row(
                  children: const [
                    Text(
                      'Budget',
                      style: TextStyle(color: Colors.white, fontSize: 22),
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    Text(
                      'state',
                      style: TextStyle(color: Color(0xff77839a), fontSize: 16),
                    ),
                  ],
                ),
                Align(
                  alignment: AlignmentDirectional.topEnd,
                  child: IconButton(
                    onPressed: () {
                      // Navigator.of(context).push(
                      //   MaterialPageRoute(
                      //     builder: (ctx) => const AddBudgetPage(),
                      //   ),
                      // );
                    },
                    icon: const Icon(
                      Icons.edit,
                      color: Colors.lightBlueAccent,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: BarChart(
                BarChartData(
                  maxY: setMaxY(),
                  barTouchData: BarTouchData(
                    touchTooltipData: BarTouchTooltipData(
                      tooltipBgColor: Colors.grey,
                      getTooltipItem: (a, b, c, d) => null,
                    ),
                    touchCallback: (FlTouchEvent event, response) {
                      // if (response == null || response.spot == null) {
                      //   setState(() {
                      //     touchedGroupIndex = -1;
                      //     showingBarGroups = List.of(rawBarGroups);
                      //   });
                      //   return;
                      // }
                      //
                      // touchedGroupIndex = response.spot!.touchedBarGroupIndex;
                      //
                      // setState(() {
                      //   if (!event.isInterestedForInteractions) {
                      //     touchedGroupIndex = -1;
                      //     showingBarGroups = List.of(rawBarGroups);
                      //     return;
                      //   }
                      //   showingBarGroups = List.of(rawBarGroups);
                      //   if (touchedGroupIndex != -1) {
                      //     var sum = 0.0;
                      //     for (final rod
                      //         in showingBarGroups[touchedGroupIndex].barRods) {
                      //       sum += rod.toY;
                      //     }
                      //     final avg = sum /
                      //         showingBarGroups[touchedGroupIndex]
                      //             .barRods
                      //             .length;
                      //
                      //     showingBarGroups[touchedGroupIndex] =
                      //         showingBarGroups[touchedGroupIndex].copyWith(
                      //       barRods: showingBarGroups[touchedGroupIndex]
                      //           .barRods
                      //           .map((rod) {
                      //         return rod.copyWith(
                      //             toY: avg, color: widget.avgColor);
                      //       }).toList(),
                      //     );
                      //   }
                      // });
                    },
                  ),
                  titlesData: FlTitlesData(
                    show: true,
                    rightTitles:
                        AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    topTitles:
                        AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        // getTitlesWidget: bottomTitles,
                        reservedSize: 42,
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 28,
                        interval: 1,
                        getTitlesWidget: leftTitles,
                      ),
                    ),
                  ),
                  borderData: FlBorderData(show: false),
                  barGroups: showingBarGroups,
                  gridData: FlGridData(show: false),
                ),
              ),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }

  Widget leftTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff7589a2),
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    debugPrint('lefvalue: $value, meta: $meta');
    String text;
    if (_maxY / 100 == 0) {
    } else if (_maxY / 1000 == 0) {
    } else {}
    // if (value == _maxY * 0.1) {
    //   double y = _maxY * 0.001;
    //   int yi = y.toInt();
    //   text = '${yi}k';
    // } else if (value == _maxY * 0.2) {
    //   double y = _maxY * 0.002;
    //   text = '${y.toInt()}k';
    // } else if (value == _maxY * 0.3) {
    //   double y = _maxY * 0.003;
    //   text = '${y.toInt()}k';
    // } else if (value == _maxY * 0.4) {
    //   double y = _maxY * 0.004;
    //   text = '${y.toInt()}k';
    // } else if (value == _maxY * 0.5) {
    //   double y = _maxY * 0.005;
    //   text = '${y.toInt()}k';
    // } else if (value == _maxY * 0.6) {
    //   double y = _maxY * 0.006;
    //   text = '${y.toInt()}k';
    // } else if (value == _maxY * 0.7) {
    //   double y = _maxY * 0.007;
    //   text = '${y.toInt()}k';
    // } else if (value == _maxY * 0.8) {
    //   double y = _maxY * 0.008;
    //   text = '${y.toInt()}k';
    // } else if (value == _maxY * 0.9) {
    //   double y = _maxY * 0.009;
    //   text = '${y.toInt()}k';
    // } else if (value == _maxY) {
    //   double y = _maxY * 0.01;
    //   text = '${y.toInt()}k';
    // } else {
    //   return Container();
    // }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 0,
      child: Text('text', style: style),
    );
  }

  Widget bottomTitles(double value, TitleMeta meta) {
    final titles =
        widget.ref.read(budgetProvider.notifier).getCategoryList() ?? [];

    final Widget text = Text(
      titles[0].name ?? '',
      style: const TextStyle(
        color: Color(0xff7589a2),
        fontWeight: FontWeight.bold,
        fontSize: 14,
      ),
    );

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16, //margin top
      child: text,
    );
  }

  double getRodY(String value) {
    int maxRod = 500;
    double val = double.parse(value);
    return val;
    debugPrint('maxY: $_maxY');

    if (_maxY > 10000) {
      maxRod = 10000;
      setState(() {
        _factor = 'x 10000';
      });
    } else if (_maxY > 1000) {
      maxRod = 1000;
      setState(() {
        _factor = 'x 1000';
      });
    } else {
      maxRod = 100;
      setState(() {
        _factor = 'x 100';
      });
    }
    debugPrint('rod value: ${(val / maxRod)}');
    return val / maxRod;
  }

  List<BarChartGroupData> makeGroupData() {
    int ind = 0;
    List<CategoryModel> categories =
        widget.ref.read(budgetProvider.notifier).getCategoryList() ?? [];
    List<BarChartGroupData> items = [];
    debugPrint(categories.length.toString());
    for (CategoryModel categoryModel in categories) {
      items.add(
        BarChartGroupData(
          barsSpace: 4,
          x: ind++,
          barRods: [
            BarChartRodData(
              toY: getRodY(categoryModel.budget.toString()),
              color: Colors.green,
              width: width,
            ),
            BarChartRodData(
              toY: getRodY(categoryModel.expense.toString()),
              color: widget.rightBarColor,
              width: width,
            ),
          ],
        ),
      );
    }
    debugPrint('make group data: ${items.length}');

    return items;
  }

  Widget makeTransactionsIcon() {
    const width = 4.5;
    const space = 3.5;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          width: width,
          height: 10,
          color: Colors.white.withOpacity(0.4),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 28,
          color: Colors.white.withOpacity(0.8),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 42,
          color: Colors.white.withOpacity(1),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 28,
          color: Colors.white.withOpacity(0.8),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 10,
          color: Colors.white.withOpacity(0.4),
        ),
      ],
    );
  }
}
